//
//  RoomDetailTableCell3.h
//  云渠道
//
//  Created by 谷治墙 on 2018/3/27.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RoomDetailTableCell3;

typedef void (^collCellBlock)(NSInteger index);

@interface RoomDetailTableCell3 : UITableViewCell

@property (nonatomic, copy) collCellBlock collCellBlock;

@property (nonatomic, assign) NSInteger num;

@property (nonatomic, strong) UICollectionView *cellColl;

@property (nonatomic, strong) NSMutableArray *dataArr;

@end
