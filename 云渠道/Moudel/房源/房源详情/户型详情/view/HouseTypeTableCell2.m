//
//  HouseTypeTableCell2.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/4.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "HouseTypeTableCell2.h"
#import "RoomCellCollCell.h"

@interface HouseTypeTableCell2()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@end

@implementation HouseTypeTableCell2

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.num;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    RoomCellCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RoomCellCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[RoomCellCollCell alloc] initWithFrame:CGRectMake(0, 0, 120 *SIZE, 220 *SIZE)];
    }
    
    if (self.dataArr.count > indexPath.item) {
        NSString *imgname = self.dataArr[indexPath.item][@"img_url"];
        if (imgname.length>0) {
            [cell.typeImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,self.dataArr[indexPath.item][@"img_url"]]] placeholderImage:[UIImage imageNamed:@"default_3"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                
                if (error) {
                    
                    cell.typeImg.image = [UIImage imageNamed:@"default_3"];
                }
            }];
        }else{
            cell.typeImg.image = [UIImage imageNamed:@"default_3"];
        }
        
        cell.letterL.text = self.dataArr[indexPath.item][@"house_type_name"];
        cell.areaL.text = [NSString stringWithFormat:@"%@㎡",self.dataArr[indexPath.item][@"property_area_min"]];
        cell.typeL.text = self.dataArr[indexPath.item][@"house_type"];
        cell.statusL.text = self.dataArr[indexPath.item][@"sale_state"];
        
    }else{
        
        cell.typeImg.image = [UIImage imageNamed:@"default_3"];
        cell.letterL.text = @"暂无户型";
        cell.areaL.text = @"";
        cell.typeL.text = @"";
        cell.statusL.text = @"";
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.collCellBlock) {
        
        self.collCellBlock(indexPath.item);
    }
}

- (void)initUI{
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.itemSize = CGSizeMake(120 *SIZE, 220 *SIZE);
    _flowLayout.minimumLineSpacing = 0;
    _flowLayout.minimumInteritemSpacing = 0;
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _cellColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0 *SIZE, SCREEN_Width, 220 *SIZE) collectionViewLayout:_flowLayout];
    _cellColl.backgroundColor = self.contentView.backgroundColor;
    _cellColl.delegate = self;
    _cellColl.dataSource = self;
    
    [_cellColl registerClass:[RoomCellCollCell class] forCellWithReuseIdentifier:@"RoomCellCollCell"];
    [self.contentView addSubview:_cellColl];
    
    [_cellColl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.contentView).offset(0);
        make.left.equalTo(self.contentView).offset(0);
        make.right.equalTo(self.contentView).offset(0);
        make.bottom.equalTo(self.contentView).offset(0);
        make.width.offset(360 *SIZE);
        make.height.offset(220 *SIZE);
    }];
}

@end
