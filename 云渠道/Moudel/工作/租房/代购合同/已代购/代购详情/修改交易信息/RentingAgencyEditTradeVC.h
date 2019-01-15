//
//  RentingAgencyEditTradeVC.h
//  云渠道
//
//  Created by 谷治墙 on 2019/1/15.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^RentingAgencyEditTradeVCBlock)(void);

@interface RentingAgencyEditTradeVC : BaseViewController

@property (nonatomic, copy) RentingAgencyEditTradeVCBlock rentingAgencyEditTradeVCBlock;

- (instancetype)initWithData:(NSDictionary *)data;

@end

NS_ASSUME_NONNULL_END
