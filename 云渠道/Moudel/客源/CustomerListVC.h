//
//  CustomerListVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/11/21.
//  Copyright © 2018 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

#import "CustomerTableModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^CustomerListVCBlock)(void);

typedef void(^CustomerListVCCustomBlock)(CustomerTableModel *model);

@interface CustomerListVC : BaseViewController

@property (nonatomic, copy) CustomerListVCBlock customerListVCBlock;

@property (nonatomic, copy) CustomerListVCCustomBlock customerListVCCustomBlock;

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, assign) BOOL isSelect;

@property (nonatomic, assign) BOOL isMultiSelection;           /*singer和combination类型是否支持多选*/

@end

NS_ASSUME_NONNULL_END
