//
//  CompanyDetailVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/3/28.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseViewController.h"
#import "CompanyModel.h"

@class CompanyDetailVC;

typedef void(^CompanyDetailVCBlock)(NSString *companyId, NSString *name);

@interface CompanyDetailVC : BaseViewController

@property (nonatomic, copy) CompanyDetailVCBlock companyDetailVCBlock;

- (instancetype)initWithModel:(CompanyModel *)model;;

@end
