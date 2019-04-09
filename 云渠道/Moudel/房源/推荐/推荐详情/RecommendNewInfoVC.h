//
//  RecommendNewInfoVC.h
//  云渠道
//
//  Created by 谷治墙 on 2019/4/1.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^RecommendNewInfoVCBlock)(NSString *attent);

@interface RecommendNewInfoVC : BaseViewController

@property (nonatomic, copy) RecommendNewInfoVCBlock recommendNewInfoVCBlock;

- (instancetype)initWithUrlStr:(NSString *)urlStr titleStr:(NSString *)titleStr imageUrl:(NSString *)imageUrl briefStr:(NSString *)briefStr recommendId:(NSString *)recommendId companyStr:(NSString *)companyStr;

@end

NS_ASSUME_NONNULL_END
