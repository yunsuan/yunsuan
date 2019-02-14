//
//  AbandonLookMaintainVC.h
//  云渠道
//
//  Created by 谷治墙 on 2019/2/14.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^AbandonLookMaintainVCBlock)(void);

@interface AbandonLookMaintainVC : BaseViewController

@property (nonatomic, copy) AbandonLookMaintainVCBlock abandonLookMaintainVCBlock;

- (instancetype)initWithData:(NSDictionary *)data;

@end

NS_ASSUME_NONNULL_END
