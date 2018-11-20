//
//  AddBankCardVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/3/22.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

@class AddBankCardVC;

typedef void(^AddBankCardBlock)(void);

@interface AddBankCardVC : BaseViewController

@property (nonatomic, copy) AddBankCardBlock addBankCardBlock;

@end
