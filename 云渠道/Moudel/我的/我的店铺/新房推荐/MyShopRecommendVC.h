//
//  MyShopRecommendVC.h
//  云渠道
//
//  Created by 谷治墙 on 2020/2/27.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^MyShopRecommendVCBlock)(void);

@interface MyShopRecommendVC : BaseViewController

@property (nonatomic, strong) MyShopRecommendVCBlock myShopRecommendVCBlock;

@property (nonatomic, strong) NSString *projectName;

@end

NS_ASSUME_NONNULL_END
