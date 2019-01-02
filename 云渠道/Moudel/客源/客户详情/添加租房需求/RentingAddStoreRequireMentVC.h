//
//  RentingAddStoreRequireMentVC.h
//  云渠道
//
//  Created by 谷治墙 on 2019/1/2.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

#import "CustomRequireModel.h"
#import "CustomerInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface RentingAddStoreRequireMentVC : BaseViewController

@property (nonatomic, strong) NSString *status;

@property (nonatomic, strong) CustomerInfoModel *infoModel;

- (instancetype)initWithCustomRequireModel:(CustomRequireModel *)model;

@end

NS_ASSUME_NONNULL_END
