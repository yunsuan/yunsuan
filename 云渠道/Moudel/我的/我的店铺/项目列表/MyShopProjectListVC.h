//
//  MyShopProjectListVC.h
//  云渠道
//
//  Created by 谷治墙 on 2020/2/26.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^MyShopProjectListVCBlock)(void);

@interface MyShopProjectListVC : BaseViewController

@property (nonatomic, strong) MyShopProjectListVCBlock myShopProjectListVCBlock;

@end

NS_ASSUME_NONNULL_END
