//
//  AgencyEditTradeVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/10/27.
//  Copyright © 2018 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^AgencyEditTradeBlock)(void);

@interface AgencyEditTradeVC : BaseViewController

@property (nonatomic, copy) AgencyEditTradeBlock agencyEditTradeBlock;

- (instancetype)initWithData:(NSDictionary *)data;

@end

NS_ASSUME_NONNULL_END
