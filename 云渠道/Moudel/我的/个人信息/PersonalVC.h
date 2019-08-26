//
//  PersonalVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/3/28.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^PersonalVCBlock)(void);

@interface PersonalVC : BaseViewController

@property (nonatomic, copy) PersonalVCBlock personalVCBlock;

@end
