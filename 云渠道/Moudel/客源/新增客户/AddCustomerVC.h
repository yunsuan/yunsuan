//
//  AddCustomerVC.h
//  云渠道
//
//  Created by xiaoq on 2018/3/28.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseViewController.h"
#import "CustomerModel.h"

@interface AddCustomerVC : BaseViewController

@property (nonatomic, assign) NSInteger status;

- (instancetype)initWithModel:(CustomerModel *)model;
@end
