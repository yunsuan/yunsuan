//
//  RentAgencyEditCustomerDetailVC.h
//  云渠道
//
//  Created by 谷治墙 on 2019/1/15.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^RentAgencyEditCustomerDetailVCBlock)(NSDictionary *dic);

typedef void(^RentAgencyAddCustomerDetailVCBlock)(void);

@interface RentAgencyEditCustomerDetailVC : BaseViewController

@property (nonatomic, copy) RentAgencyEditCustomerDetailVCBlock rentAgencyEditCustomerDetailVCBlock;

@property (nonatomic, copy) RentAgencyAddCustomerDetailVCBlock rentAgencyAddCustomerDetailVCBlock;

@property (nonatomic, strong) NSString *status;;

@property (nonatomic, strong) NSString *subId;

- (instancetype)initWithData:(NSDictionary *)data;

@end

NS_ASSUME_NONNULL_END
