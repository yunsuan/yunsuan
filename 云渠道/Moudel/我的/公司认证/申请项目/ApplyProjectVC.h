//
//  ApplyProjectVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/5/15.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

@class ApplyProjectVC;

typedef void(^ApplyProjectVCBlock)(NSString *projectId, NSString *name);

@interface ApplyProjectVC : BaseViewController

@property (nonatomic, copy) ApplyProjectVCBlock applyProjectVCBlock;

- (instancetype)initWithCompanyId:(NSString *)companyId;

@end
