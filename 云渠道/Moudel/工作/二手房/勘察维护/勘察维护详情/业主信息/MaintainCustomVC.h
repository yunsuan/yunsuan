//
//  MaintainCustomVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/7/19.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^MaintainCustomVCBlock)(void);

@interface MaintainCustomVC : BaseViewController

@property (nonatomic, assign) BOOL edit;

@property (nonatomic, copy) MaintainCustomVCBlock maintainCustomVCBlock;

- (instancetype)initWithDataDic:(NSDictionary *)dataDic;

@end
