//
//  AddTagVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/4/19.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

@class AddTagVC;

typedef void(^SaveBtnBlock)(NSArray *array);

@interface AddTagVC : BaseViewController

@property (nonatomic, copy) SaveBtnBlock saveBtnBlock;

- (instancetype)initWithArray:(NSArray *)array;

@end
