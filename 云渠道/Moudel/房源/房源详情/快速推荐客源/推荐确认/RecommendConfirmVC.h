//
//  RecommendConfirmVC.h
//  云渠道
//
//  Created by 谷治墙 on 2019/3/8.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface RecommendConfirmVC : BaseViewController

@property (nonatomic, strong) NSMutableDictionary *consulDic;

- (instancetype)initWithData:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
