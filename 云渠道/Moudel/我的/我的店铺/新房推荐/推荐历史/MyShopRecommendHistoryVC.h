//
//  MyShopRecommendHistoryVC.h
//  云渠道
//
//  Created by 谷治墙 on 2020/2/29.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^MyShopRecommendHistoryVCBlock)(void);

@interface MyShopRecommendHistoryVC : BaseViewController

@property (nonatomic, strong) MyShopRecommendHistoryVCBlock myShopRecommendHistoryVCBlock;

@property (nonatomic, strong) NSString *projectName;

@end

NS_ASSUME_NONNULL_END
