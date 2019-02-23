//
//  ConfirmPhoneFailDetailVC.h
//  云渠道
//
//  Created by 谷治墙 on 2019/2/22.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^ConfirmPhoneFailDetailVCVCBlock)(void);

@interface ConfirmPhoneFailDetailVC : BaseViewController

@property (nonatomic, copy) ConfirmPhoneFailDetailVCVCBlock confirmPhoneFailDetailVCVCBlock;

- (instancetype)initWithClientId:(NSString *)clientId;

@end

NS_ASSUME_NONNULL_END
