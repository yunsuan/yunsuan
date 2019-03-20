//
//  RentingAllRoomStoreDetailCell.h
//  云渠道
//
//  Created by 谷治墙 on 2018/12/25.
//  Copyright © 2018 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

//#import "TagView.h"
#import "RentingAllRoomStoreModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface RentingAllRoomStoreCell : UITableViewCell

@property (nonatomic, strong) RentingAllRoomStoreModel *model;

@property (nonatomic, strong) GZQFlowLayout *propertyFlowLayout;

@property (nonatomic, strong) UICollectionView *propertyColl;

@property (nonatomic, strong) UILabel *transferL;

@property (nonatomic, strong) UILabel *depositL;

@property (nonatomic, strong) UILabel *roomLevelL;

@property (nonatomic, strong) UILabel *rentTypeL;

@property (nonatomic, strong) UILabel *payWayL;

@property (nonatomic, strong) UILabel *minPeriodL;

@property (nonatomic, strong) UILabel *maxPeriodL;

@property (nonatomic, strong) UILabel *inTimeL;

@property (nonatomic, strong) UILabel *seeL;

@property (nonatomic, strong) UILabel *rentFreeL;

@property (nonatomic, strong) UILabel *commercailL;

@property (nonatomic, strong) UILabel *intentL;

@property (nonatomic, strong) UILabel *urgentL;

@property (nonatomic, strong) UIView *markView;

@property (nonatomic, strong) UILabel *markL;

@end

NS_ASSUME_NONNULL_END
