//
//  RentingAllRoomOfficeVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/12/18.
//  Copyright © 2018 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface RentingAllRoomOfficeVC : BaseViewController

@property (nonatomic, assign) NSInteger type;

- (instancetype)initWithHouseId:(NSString *)houseId city:(NSString *)city;

@end

NS_ASSUME_NONNULL_END
