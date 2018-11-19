//
//  SecProhectSearchVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/9/4.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

@interface SecProhectSearchVC : BaseViewController

@property (nonatomic, strong) NSString *status;

@property (nonatomic, strong) NSString *type;

- (instancetype)initWithTitle:(NSString *)str city:(NSString *)city;

@end
