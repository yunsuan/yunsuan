//
//  CustomLookConfirmFailVC.h
//  云渠道
//
//  Created by 谷治墙 on 2019/1/23.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^CustomLookConfirmFailVCBlock)(void);

@interface CustomLookConfirmFailVC : BaseViewController

@property (nonatomic, copy) CustomLookConfirmFailVCBlock customLookConfirmFailVCBlock;

- (instancetype)initWithData:(NSDictionary *)data;

@end

NS_ASSUME_NONNULL_END
