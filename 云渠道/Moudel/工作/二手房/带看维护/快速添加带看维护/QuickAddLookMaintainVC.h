//
//  QuickAddLookMaintainVC.h
//  云渠道
//
//  Created by 谷治墙 on 2019/2/14.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^QuickAddLookMaintainVCBlock)(void);

@interface QuickAddLookMaintainVC : BaseViewController

@property (nonatomic, copy) QuickAddLookMaintainVCBlock quickAddLookMaintainVCBlock;

@end

NS_ASSUME_NONNULL_END
