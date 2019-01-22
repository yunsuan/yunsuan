//
//  HouseTypeTableHeader.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/4.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "HouseTypeTableHeader.h"
//#import "HouseHeaderCollCell.h"
#import "BuildingAlbumCollCell.h"

@interface HouseTypeTableHeader() <UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
{
    
    NSInteger _num;
    NSInteger _nowNum;
    NSMutableArray *_allArr;
    NSInteger _total;
//    NSInteger _current;
}

@end

@implementation HouseTypeTableHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _num = 1;
        _allArr = [@[] mutableCopy];
        [self initUI];
    }
    return self;
}

- (void)setImgArr:(NSMutableArray *)imgArr{
    
    
    if (!imgArr.count) {
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:_scrollView.frame];
        img.contentMode = UIViewContentModeScaleAspectFill;
        img.image = [UIImage imageNamed:@"default_3"];
        img.clipsToBounds = YES;
        [self.contentView addSubview:img];
    }
    _imgArr = [NSMutableArray arrayWithArray:imgArr];
    for ( int i = 0; i < imgArr.count; i++) {
        
        if ([imgArr[i] isKindOfClass:[NSDictionary class]]) {
            
            NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:imgArr[i]];
            
            if ([tempDic[@"list"] count]) {
                for (int j = 0; j < [tempDic[@"list"] count]; j++) {
                    
                    _total = _total + 1;
                    [_allArr addObject:tempDic[@"list"][j]];
                }
            }else{
                
                _total += 1;
                [_allArr addObject:@{@"img_url":@"default_3"}];
            }
        }
    }
    [_scrollView setContentSize:CGSizeMake(SCREEN_Width * _total, _scrollView.frame.size.height)];
    
    for (int i = 0; i < _total; i++) {
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_Width * i, 0, SCREEN_Width, _scrollView.frame.size.height)];
        img.backgroundColor = YJTitleLabColor;
        img.contentMode = UIViewContentModeScaleAspectFill;
        img.clipsToBounds = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ActionImgBtn)];
        [img addGestureRecognizer:tap];
        img.userInteractionEnabled = YES;
        [_scrollView addSubview:img];
        
        if ([_allArr[i][@"img_url"] isEqualToString:@"default_3"]) {
            
            img.image = [UIImage imageNamed:@"default_3"];
        }else{
            
            [img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,_allArr[i][@"img_url"]]] placeholderImage:[UIImage imageNamed:@"default_3"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                
                if (error) {
                    
                    img.image = [UIImage imageNamed:@"default_3"];
                }
            }];
            if ([_allArr[i][@"img_url_3d"] length]) {
                
                UIImageView *img2 = [[UIImageView alloc] init];
                img2.bounds = CGRectMake(0, 0, 60 *SIZE, 60 *SIZE);
                img2.center = _scrollView.center;
                img2.image = [UIImage imageNamed:@"3D"];
                [img addSubview:img2];
            }
        }
        
    }
    [_imgColl reloadData];
    [_imgColl selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:NO scrollPosition:0];
    
}


- (void)ActionImgBtn{
    
    if (self.houseTypeImgBtnBlock) {
        
        if (_imgArr.count) {
            
            self.houseTypeImgBtnBlock(_nowNum, _imgArr);
            
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    _num = (scrollView.contentOffset.x / SCREEN_Width) + 1;
    _nowNum = scrollView.contentOffset.x / SCREEN_Width;
    NSInteger count = 0;
    for (int i = 0; i < _imgArr.count; i++) {
        
        
        if ([_imgArr[i][@"list"] count]) {
            
            if (([_imgArr[i][@"list"] count]  + count)< _num) {
                
                count = count + [_imgArr[i][@"list"] count];
            }else{
                
                [_imgColl selectItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0] animated:NO scrollPosition:0];
                break;
            }
        }else{
            
            if ((1  + count)< _num) {
                
                count = count + 1;
            }else{
                
                [_imgColl selectItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0] animated:NO scrollPosition:0];
                break;
            }
        }
    }
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _imgArr.count;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    NSInteger numberOfItems = [collectionView numberOfItemsInSection:0];
    
    CGFloat combinedItemWidth = (numberOfItems * _flowLayout.itemSize.width) + ((numberOfItems - 1) * _flowLayout.minimumInteritemSpacing);
    
    CGFloat padding = (collectionView.frame.size.width - combinedItemWidth) / 2;
    
    padding = padding > 0 ? padding :0 ;
    
    return UIEdgeInsetsMake(0, padding + 5 *SIZE,0, padding - 5 *SIZE);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    BuildingAlbumCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BuildingAlbumCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[BuildingAlbumCollCell alloc] initWithFrame:CGRectMake(0, 0, 50 *SIZE, 27 *SIZE)];
    }
    
    cell.contentL.text = _imgArr[indexPath.item][@"type"];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger count = 0;
    for (int i = 0; i < _imgArr.count; i++) {
        
        if (i < indexPath.item) {
            
            if ([_imgArr[i][@"list"] count]) {
                
                count = count + [_imgArr[i][@"list"] count];
            }else{
                
                count = count + 1;
            }
        }
    }
    [_scrollView setContentOffset:CGPointMake(count * SCREEN_Width, 0) animated:NO];
    
}

- (void)initUI{
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 202.5 *SIZE)];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    [self.contentView addSubview:_scrollView];
    
    
    UIView *alphaView = [[UIView alloc] initWithFrame:CGRectMake(0, 162.5 *SIZE, SCREEN_Width, 40 *SIZE)];
    alphaView.backgroundColor = [UIColor blackColor];
    alphaView.alpha = 0.2;
    [self.contentView addSubview:alphaView];
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.itemSize = CGSizeMake(50 *SIZE, 27 *SIZE);
    _flowLayout.minimumInteritemSpacing = 17 *SIZE;
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    
    _imgColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 162.5 *SIZE , SCREEN_Width, 40 *SIZE) collectionViewLayout:_flowLayout];
    _imgColl.backgroundColor = [UIColor clearColor];
    _imgColl.delegate = self;
    _imgColl.dataSource = self;
    
    [_imgColl registerClass:[BuildingAlbumCollCell class] forCellWithReuseIdentifier:@"BuildingAlbumCollCell"];
    [self.contentView addSubview:_imgColl];
}

@end
