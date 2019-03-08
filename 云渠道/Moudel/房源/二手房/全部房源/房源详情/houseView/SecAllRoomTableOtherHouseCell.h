//
//  SecAllRoomTableOtherHouseCell.h
//  云渠道
//
//  Created by 谷治墙 on 2018/9/14.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SecAllRoomTableOtherHouseCellCollBlock)(NSInteger index);

@interface SecAllRoomTableOtherHouseCell : UITableViewCell

@property (nonatomic, copy) SecAllRoomTableOtherHouseCellCollBlock secAllRoomTableOtherHouseCellCollBlock;

@property (nonatomic, strong) NSString *type;

@property (nonatomic, assign) NSInteger num;

@property (nonatomic, strong) UICollectionView *cellColl;

@property (nonatomic, strong) NSMutableArray *dataArr;

@end
