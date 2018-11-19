//
//  MaintainRoomInfoEquipMentCell.h
//  云渠道
//
//  Created by 谷治墙 on 2018/9/19.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MaintainRoomInfoEquipMentCell : UITableViewCell

@property (nonatomic, strong) UICollectionView *equipColl;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) NSMutableArray *dataArr;

@end

NS_ASSUME_NONNULL_END
