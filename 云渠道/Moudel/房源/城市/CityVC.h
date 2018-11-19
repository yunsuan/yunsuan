//
//  CityVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/5/14.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

@class CityVC;

typedef void(^CityVCSaveBlock)(NSString *code, NSString *city);

@interface CityVC : BaseViewController

@property (nonatomic, copy) CityVCSaveBlock cityVCSaveBlock;

- (instancetype)initWithLabel:(NSString *)label;

@end
