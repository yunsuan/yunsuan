//
//  SecAllRoomStoreEquipCell.h
//  云渠道
//
//  Created by 谷治墙 on 2018/9/19.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SecAllRoomStoreEquipCell : UITableViewCell

@property (nonatomic, strong) UIView *whiteView;

@property (nonatomic, strong) UICollectionView *coll;

@property (nonatomic, strong) UICollectionViewFlowLayout *layout;

@property (nonatomic, strong) NSMutableArray *dataArr;

@end

NS_ASSUME_NONNULL_END
