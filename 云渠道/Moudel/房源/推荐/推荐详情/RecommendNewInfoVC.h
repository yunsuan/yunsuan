//
//  RecommendNewInfoVC.h
//  云渠道
//
//  Created by 谷治墙 on 2019/4/1.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface RecommendNewInfoVC : BaseViewController

- (instancetype)initWithUrlStr:(NSString *)urlStr titleStr:(NSString *)titleStr imageUrl:(NSString *)imageUrl briefStr:(NSString *)briefStr recommendId:(NSString *)recommendId;

@end

NS_ASSUME_NONNULL_END
