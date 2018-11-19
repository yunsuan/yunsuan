//
//  AddEquipmentVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/9/19.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^AddEquipmentVCBlock)(NSArray *data);

@interface AddEquipmentVC : BaseViewController

@property (nonatomic, copy) AddEquipmentVCBlock addEquipmentVCBlock;

@property (nonatomic, copy) NSString *titleStr;

@property (nonatomic, strong) NSString *houseId;

@property (nonatomic, strong) NSString *type;

@property (nonatomic, strong) NSMutableArray *data;

- (instancetype)initWithType:(NSInteger )type;

@end

NS_ASSUME_NONNULL_END
