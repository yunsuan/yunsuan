//
//  QuickSearchVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/5/5.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseViewController.h"
#import "CustomRequireModel.h"
#import "CustomerTableModel.h"

@interface QuickSearchVC : BaseViewController
@property (nonatomic, strong) CustomerTableModel *customerTableModel;

- (instancetype)initWithTitle:(NSString *)str city:(NSString *)city model:(CustomRequireModel *)model;

@end
