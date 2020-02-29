//
//  MyShopServeRegionVC.h
//  云渠道
//
//  Created by 谷治墙 on 2020/2/27.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^MyShopServeRegionVCBlock)(NSString *city);

@interface MyShopServeRegionVC : BaseViewController

@property (nonatomic, copy) MyShopServeRegionVCBlock myShopServeRegionVCBlock;

@end

NS_ASSUME_NONNULL_END
