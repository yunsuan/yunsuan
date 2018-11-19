//
//  SelectCustomVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/10/11.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

#import "CustomerTableModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^SelectCustomVCBlock)(CustomerTableModel *model);

@interface SelectCustomVC : BaseViewController

@property (nonatomic, copy) SelectCustomVCBlock selectCustomVCBlock;

@end

NS_ASSUME_NONNULL_END
