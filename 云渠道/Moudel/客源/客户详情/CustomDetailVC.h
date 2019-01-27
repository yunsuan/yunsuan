//
//  CustomDetailVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/3/22.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseViewController.h"
#import "CustomerTableModel.h"

@interface CustomDetailVC : BaseViewController

@property (nonatomic, strong) CustomerTableModel *model;

@property (nonatomic, strong) NSString *customType;

- (instancetype)initWithClientId:(NSString *)clientId;

@end
