//
//  HouseSearchVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/4/10.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

@interface HouseSearchVC : BaseViewController

//@property (nonatomic, strong) NSString *status;

@property (nonatomic, strong) NSString *typeId;

@property (nonatomic, strong) NSString *param;

- (instancetype)initWithTitle:(NSString *)str city:(NSString *)city;

@end
