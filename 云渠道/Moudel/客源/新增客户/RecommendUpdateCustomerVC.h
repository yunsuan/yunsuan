//
//  RecommendUpdateCustomerVC.h
//  云渠道
//
//  Created by 谷治墙 on 2019/1/15.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^RecommendUpdateCustomerVCBlock)(void);

@interface RecommendUpdateCustomerVC : BaseViewController

@property (nonatomic, copy) RecommendUpdateCustomerVCBlock recommendUpdateCustomerVCBlock;

- (instancetype)initWithClientId:(NSString *)clientId;

@end

NS_ASSUME_NONNULL_END
