//
//  QuickAddCustomVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/5/4.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

@interface QuickAddCustomVC : BaseViewController

@property (nonatomic, strong) NSString *projectName;

- (instancetype)initWithProjectId:(NSString *)projectId;

@end
