//
//  AddAreaCustomVC.h
//  云渠道
//
//  Created by 谷治墙 on 2019/12/2.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^AddAreaCustomVCBlock)(void);

@interface AddAreaCustomVC : BaseViewController

@property (nonatomic, copy) AddAreaCustomVCBlock addAreaCustomVCBlock;

@end

NS_ASSUME_NONNULL_END
