//
//  PerformanceContractVC.h
//  云渠道
//
//  Created by 谷治墙 on 2019/12/27.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface PerformanceContractVC : BaseViewController

@property (nonatomic, strong) NSString *money;

- (instancetype)initWithDataArr:(NSArray *)dataArr;

@end

NS_ASSUME_NONNULL_END
