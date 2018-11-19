//
//  QuickAddRequireVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/5/4.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseViewController.h"
#import "CustomerInfoModel.h"

@interface QuickAddRequireVC : BaseViewController

@property (nonatomic, strong) NSString *status;

@property (nonatomic, strong) CustomerInfoModel *infoModel;

- (instancetype)initWithProjectId:(NSString *)projectId;

@end
