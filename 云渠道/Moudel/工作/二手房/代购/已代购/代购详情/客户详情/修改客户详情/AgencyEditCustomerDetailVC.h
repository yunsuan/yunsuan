//
//  AgencyEditCustomerDetailVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/10/27.
//  Copyright © 2018 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^AgencyEditCustomerDetailVCBlock)(NSDictionary *dic);

typedef void(^AgencyAddCustomerDetailVCBlock)(void);

@interface AgencyEditCustomerDetailVC : BaseViewController

@property (nonatomic, copy) AgencyEditCustomerDetailVCBlock agencyEditCustomerDetailVCBlock;

@property (nonatomic, copy) AgencyAddCustomerDetailVCBlock agencyAddCustomerDetailVCBlock;

@property (nonatomic, strong) NSString *status;;

@property (nonatomic, strong) NSString *subId;

- (instancetype)initWithData:(NSDictionary *)data;

@end

NS_ASSUME_NONNULL_END
