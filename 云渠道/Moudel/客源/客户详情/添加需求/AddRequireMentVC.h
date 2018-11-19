//
//  AddRequireMentVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/4/2.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseViewController.h"
#import "CustomRequireModel.h"
#import "CustomerInfoModel.h"

@interface AddRequireMentVC : BaseViewController

@property (nonatomic, strong) NSString *status;

@property (nonatomic, strong) CustomerInfoModel *infoModel;

- (instancetype)initWithCustomRequireModel:(CustomRequireModel *)model;

@end
