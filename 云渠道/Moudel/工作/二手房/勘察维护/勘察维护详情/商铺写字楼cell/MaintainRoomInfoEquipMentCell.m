//
//  MaintainRoomInfoEquipMentCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/9/19.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "MaintainRoomInfoEquipMentCell.h"

#import "StoreViewCollCell.h"

@interface MaintainRoomInfoEquipMentCell ()<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
{
    
    NSMutableArray *_matchArr;
}


@end

@implementation MaintainRoomInfoEquipMentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _matchArr = [@[] mutableCopy];
        self.dataArr = [@[] mutableCopy];
        [self initUI];
    }
    return self;
}

- (void)setDataArr:(NSMutableArray *)dataArr{
    
    _matchArr = [NSMutableArray arrayWithArray:dataArr];
    [_equipColl reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _matchArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    StoreViewCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"StoreViewCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[StoreViewCollCell alloc] initWithFrame:CGRectMake(0, 0, 72 *SIZE, 60 *SIZE)];
    }
    //    cell.titleL.text = @"客厅";
    cell.titleL.text = _matchArr[indexPath.item][@"name"];
    NSString *imageurl = _matchArr[indexPath.item][@"url"];
    if (imageurl.length>0) {
        [cell.typeImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,_matchArr[indexPath.item][@"url"]]] placeholderImage:[UIImage imageNamed:@"default_3"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            
            if (error) {
                
                cell.typeImg.image = [UIImage imageNamed:@"default_3"];
            }
        }];
    }else{
         cell.typeImg.image = [UIImage imageNamed:@"default_3"];
    }
    
    return cell;
}

- (void)initUI{
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.itemSize = CGSizeMake(72 *SIZE, 60 *SIZE);
    _flowLayout.minimumInteritemSpacing = 0;
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _equipColl = [[UICollectionView alloc] initWithFrame:CGRectMake(19 *SIZE, 0, SCREEN_Width, 60 *SIZE) collectionViewLayout:_flowLayout];
    _equipColl.backgroundColor = self.contentView.backgroundColor;
    _equipColl.showsVerticalScrollIndicator = NO;
    _equipColl.showsHorizontalScrollIndicator = NO;
    _equipColl.delegate = self;
    _equipColl.dataSource = self;
    [_equipColl registerClass:[StoreViewCollCell class] forCellWithReuseIdentifier:@"StoreViewCollCell"];
    [self.contentView addSubview:_equipColl];
    
    [_equipColl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(19 *SIZE);
        make.top.equalTo(self.contentView).offset(0);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(60 *SIZE);
        make.bottom .equalTo(self.contentView).offset(-10 *SIZE);
    }];
}
@end
