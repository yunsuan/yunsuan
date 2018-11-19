//
//  ModifyTagVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/7/20.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

@class ModifyTagVC;

typedef void(^ModifyTagSaveBtnBlock)(NSArray *array);

@interface ModifyTagVC : BaseViewController

@property (nonatomic, copy) ModifyTagSaveBtnBlock modifyTagSaveBtnBlock;

@property (nonatomic, strong) NSString *houseId;

@property (nonatomic, strong) NSString *typeId;

- (instancetype)initWithArray:(NSArray *)array;
@end
