//
//  AgencyDoneCustomerDetailVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/7/18.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^AgencyDoneCustomerDetailVCBlock)(void);

@interface AgencyDoneCustomerDetailVC : BaseViewController

@property (nonatomic, copy) AgencyDoneCustomerDetailVCBlock agencyDoneCustomerDetailVCBlock;

@property (nonatomic, strong) NSString *status;

@property (nonatomic , strong) NSDictionary *customerDic;
@end
