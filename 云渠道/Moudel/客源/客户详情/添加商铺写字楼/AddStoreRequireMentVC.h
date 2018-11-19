//
//  AddStoreRequireMentVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/9/20.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

#import "CustomRequireModel.h"
#import "CustomerInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddStoreRequireMentVC : BaseViewController

@property (nonatomic, strong) NSString *status;

@property (nonatomic, strong) CustomerInfoModel *infoModel;

- (instancetype)initWithCustomRequireModel:(CustomRequireModel *)model;

@end

NS_ASSUME_NONNULL_END
