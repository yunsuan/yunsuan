//
//  MessageTelConfirmVC.h
//  云渠道
//
//  Created by 谷治墙 on 2019/5/12.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^MessageTelConfirmVCBlock)(void);

@interface MessageTelConfirmVC : BaseViewController

@property (nonatomic, copy) MessageTelConfirmVCBlock messageTelConfirmVCBlock;

- (instancetype)initWithClientId:(NSString *)clientId messageId:(NSString *)messageId;

@end

NS_ASSUME_NONNULL_END
