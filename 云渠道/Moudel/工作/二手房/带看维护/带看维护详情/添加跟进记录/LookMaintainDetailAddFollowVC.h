//
//  LookMaintainDetailAddFollowVC.h
//  云渠道
//
//  Created by 谷治墙 on 2019/1/25.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^LookMaintainDetailAddFollowVCBlock)(void);

@interface LookMaintainDetailAddFollowVC : BaseViewController

@property (nonatomic, copy) LookMaintainDetailAddFollowVCBlock lookMaintainDetailAddFollowVCBlock;

@property (nonatomic, strong) NSString *property;

@property (nonatomic, strong) NSString *status;

@property (nonatomic, strong) NSDictionary *dic;

- (instancetype)initWithTakeId:(NSString *)takeId;

@end

NS_ASSUME_NONNULL_END
