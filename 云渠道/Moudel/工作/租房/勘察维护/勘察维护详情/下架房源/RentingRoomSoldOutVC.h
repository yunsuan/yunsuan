//
//  RentingRoomSoldOutVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/12/20.
//  Copyright © 2018 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface RentingRoomSoldOutVC : BaseViewController

@property (nonatomic, strong) NSDictionary *dataDic;

- (instancetype)initWithHouseId:(NSString *)houseId;

@end

NS_ASSUME_NONNULL_END
