//
//  RentAgencyDoneCustomerDetailVC.h
//  云渠道
//
//  Created by 谷治墙 on 2019/1/15.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^RentAgencyDoneCustomerDetailVCBlock)(void);

@interface RentAgencyDoneCustomerDetailVC : BaseViewController

@property (nonatomic, copy) RentAgencyDoneCustomerDetailVCBlock rentAgencyDoneCustomerDetailVCBlock;

@property (nonatomic, strong) NSString *status;

@property (nonatomic , strong) NSDictionary *customerDic;

@end

NS_ASSUME_NONNULL_END
