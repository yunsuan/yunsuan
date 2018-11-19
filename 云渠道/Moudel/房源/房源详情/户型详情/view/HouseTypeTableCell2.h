//
//  HouseTypeTableCell2.h
//  云渠道
//
//  Created by 谷治墙 on 2018/4/4.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HouseTypeTableCell2;

typedef void (^collCellBlock)(NSInteger index);

@interface HouseTypeTableCell2 : UITableViewCell

@property (nonatomic, copy) collCellBlock collCellBlock;

@property (nonatomic, assign) NSInteger num;

@property (nonatomic, strong) UICollectionView *cellColl;

@property (nonatomic, strong) NSMutableArray *dataArr;
@end
