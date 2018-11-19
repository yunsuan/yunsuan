//
//  SecWorkSuccessVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/11/8.
//  Copyright © 2018 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^SecWorkSuccessVCBlock)(void);

@interface SecWorkSuccessVC : BaseViewController

@property (nonatomic, copy) SecWorkSuccessVCBlock secWorkSuccessVCBlock;

- (instancetype)initWithData:(NSDictionary *)dataDic;

@end

NS_ASSUME_NONNULL_END
