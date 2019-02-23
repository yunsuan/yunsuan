//
//  ConfirmPhoneUseDetailVC.h
//  云渠道
//
//  Created by 谷治墙 on 2019/2/22.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^ConfirmPhoneUseDetailVCBlock)(void);

@interface ConfirmPhoneUseDetailVC : BaseViewController

@property (nonatomic, copy) ConfirmPhoneUseDetailVCBlock confirmPhoneUseDetailVCBlock;

- (instancetype)initWithClientId:(NSString *)clientId;

@end

NS_ASSUME_NONNULL_END
