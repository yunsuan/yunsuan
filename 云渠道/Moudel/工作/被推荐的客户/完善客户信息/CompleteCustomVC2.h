//
//  CompleteCustomVC2.h
//  云渠道
//
//  Created by 谷治墙 on 2018/4/9.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

@interface CompleteCustomVC2 : BaseViewController
@property (nonatomic , strong) NSDictionary *datadic;
@property (nonatomic, strong) NSMutableDictionary *consulDic;

- (instancetype)initWithData:(NSDictionary *)dic;

@end
