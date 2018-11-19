//
//  WorkMessageVC.h
//  云渠道
//
//  Created by xiaoq on 2018/3/23.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^WorkMessageVCBlock)(void);

@interface WorkMessageVC : BaseViewController

@property (nonatomic, copy) WorkMessageVCBlock workMessageVCBlock;

@end
