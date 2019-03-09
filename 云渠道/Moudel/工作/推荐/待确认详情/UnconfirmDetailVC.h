//
//  UnconfirmDetailVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/4/9.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

@interface UnconfirmDetailVC : BaseViewController

@property (nonatomic, strong) NSString *needConfirm;

- (instancetype)initWithString:(NSString *)str;

@end
