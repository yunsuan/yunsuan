//
//  RentingMaintainAddFollowVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/8/6.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^RentingMaintainAddFollowVCBlock)(void);

@interface RentingMaintainAddFollowVC : BaseViewController

@property (nonatomic, copy) RentingMaintainAddFollowVCBlock rentingMaintainAddFollowVCBlock;

@property (nonatomic, assign) NSInteger type;

- (instancetype)initWithHouseId:(NSString *)houseId dataDic:(NSDictionary *)dataDic;

@end
