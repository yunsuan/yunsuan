//
//  SelectStoreVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/9/28.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^SelectStoreVCBlock)(NSString *storeId,NSString *storeName);

@interface SelectStoreVC : BaseViewController

@property (nonatomic, copy) SelectStoreVCBlock selectStoreVCBlock;

@end

NS_ASSUME_NONNULL_END
