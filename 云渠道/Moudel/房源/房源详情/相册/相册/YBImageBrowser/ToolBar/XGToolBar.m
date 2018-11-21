//
//  XGToolBar.m
//  云渠道
//
//  Created by 谷治墙 on 2018/7/3.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "XGToolBar.h"
//#import "BuildingAlbumCollCell.h"
#import "AlbumCollCell.h"

@interface XGToolBar()<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
{
    
    NSInteger _total;
    NSMutableArray *_imgArr;
    NSString *_projectId;
}

@end

@implementation XGToolBar

- (instancetype)initWithFrame:(CGRect)frame projectId:(NSString *)projectId albumArr:(NSArray *)albumArr
{
    self = [super initWithFrame:frame];
    if (self) {
        
//        _imgArr = [@[] mutableCopy];
        _imgArr = [NSMutableArray arrayWithArray:albumArr];
        _projectId = projectId;
        [self initUI];
        [self SetData:_imgArr];
//        [self RequestMethod];
    }
    return self;
}

- (void)RequestMethod{
    
    [BaseRequest GET:GetImg_URL parameters:@{@"project_id":_projectId} success:^(id resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if (![resposeObject[@"data"] isKindOfClass:[NSNull class]]) {
                
                [self SetData:resposeObject[@"data"]];
            }else{
                
            }
        }
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
    }];
}

- (void)SetData:(NSArray *)data{
    
    for ( int i = 0; i < data.count; i++) {
        
        if ([data[i] isKindOfClass:[NSDictionary class]]) {
            
            NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:data[i]];
            
//            [_imgArr addObject:tempDic];
            
            
            for (int j = 0; j < [tempDic[@"data"] count]; j++) {
                
                _total = _total + 1;
//                [_allArr addObject:tempDic[@"data"][j]];
            }
        }
    }
    
    [_XGColl reloadData];
    [_XGColl selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:NO scrollPosition:0];
    //    [_scrollView setContentOffset:CGPointMake(_num *SCREEN_Width, 0)];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _imgArr.count;
//    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    AlbumCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AlbumCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[AlbumCollCell alloc] initWithFrame:CGRectMake(0, 0, 78 *SIZE, 27 *SIZE)];
    }
    
//    cell.contentL.text = @"123";
    cell.contentL.text = _imgArr[indexPath.item][@"name"];
    
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    NSInteger numberOfItems = [collectionView numberOfItemsInSection:0];
    
    CGFloat combinedItemWidth = (numberOfItems * _flowLayout.itemSize.width) + ((numberOfItems - 1) * _flowLayout.minimumInteritemSpacing);
    
    CGFloat padding = (collectionView.frame.size.width - combinedItemWidth) / 2;
    
    padding = padding > 0 ? padding :0 ;
    
    return UIEdgeInsetsMake(0, padding + 5 *SIZE,0, padding - 5 *SIZE);
}

- (void)setTitleLabelWithCurrentIndex:(NSUInteger)index totalCount:(NSUInteger)totalCount {
    if (!totalCount) return;
    
    _allL.text = [NSString stringWithFormat:@"全部%ld/%ld",index,totalCount];
    NSInteger count = 0;
    for (int i = 0; i < _imgArr.count; i++) {
        
        
        if (([_imgArr[i][@"data"] count]  + count)< index) {
            
            count = count + [_imgArr[i][@"data"] count];
        }else{
            
            [_XGColl selectItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0] animated:NO scrollPosition:0];
            _currentL.text = [NSString stringWithFormat:@"%@%ld/%lu",_imgArr[i][@"name"],index - count,[_imgArr[i][@"data"] count]];
            break;
        }
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger count = 0;
    for (int i = 0; i < _imgArr.count; i++) {
        
        if (i < indexPath.item) {
            
            count = count + [_imgArr[i][@"data"] count];
        }
    }
//    [_scrollView setContentOffset:CGPointMake(count * SCREEN_Width, 0) animated:NO];
    
    _currentL.text = [NSString stringWithFormat:@"%@1/%d",_imgArr[indexPath.item][@"name"],[_imgArr[indexPath.item][@"data"] count]];
    if (_delegate && [_delegate respondsToSelector:@selector(XGBarScrollToIndex:)]) {
        
        [_delegate XGBarScrollToIndex:(count + 1)];
    }
}

- (void)initUI{
    
    self.backgroundColor = [UIColor clearColor];
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.itemSize = CGSizeMake(78 *SIZE, 27 *SIZE);
    _flowLayout.minimumInteritemSpacing = 7 *SIZE;
//    _flowLayout.sectionInset = UIEdgeInsetsMake(SIZE, 10 *SIZE, 27 *SIZE, 10 *SIZE);
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _currentL = [[UILabel alloc] initWithFrame:CGRectMake(9 *SIZE, 5 *SIZE, 100 *SIZE, 12 *SIZE)];
    _currentL.textColor = YJContentLabColor;
    _currentL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self addSubview:_currentL];
    
    _allL = [[UILabel alloc] initWithFrame:CGRectMake(250 *SIZE, 5 *SIZE, 100 *SIZE, 12 *SIZE)];
    _allL.textColor = YJContentLabColor;
    _allL.font = [UIFont systemFontOfSize:12 *SIZE];
    _allL.textAlignment = NSTextAlignmentRight;
    [self addSubview:_allL];
    
    _XGColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 20 *SIZE, SCREEN_Width, 55 *SIZE) collectionViewLayout:_flowLayout];
    _XGColl.backgroundColor = [UIColor clearColor];
    _XGColl.delegate = self;
    _XGColl.dataSource = self;
    [_XGColl registerClass:[AlbumCollCell class] forCellWithReuseIdentifier:@"AlbumCollCell"];
    [self addSubview:_XGColl];
}

@end
