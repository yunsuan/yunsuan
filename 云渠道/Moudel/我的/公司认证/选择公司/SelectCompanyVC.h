//
//  SelectCompanyVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/3/23.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

@class SelectCompanyVC;

typedef void(^SelectCompanyVCBlock)(NSString *companyId, NSString *name);

@interface SelectCompanyVC : BaseViewController

@property (nonatomic, copy) SelectCompanyVCBlock selectCompanyVCBlock;

@end
