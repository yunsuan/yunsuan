//
//  RentingAddEquipmentVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/12/28.
//  Copyright © 2018 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^RentingAddEquipmentVCBlock)(NSArray *data);

NS_ASSUME_NONNULL_BEGIN

@interface RentingAddEquipmentVC : BaseViewController

@property (nonatomic, copy) RentingAddEquipmentVCBlock rentingAddEquipmentVCBlock;

@property (nonatomic, copy) NSString *titleStr;

@property (nonatomic, strong) NSString *houseId;

@property (nonatomic, strong) NSString *type;

@property (nonatomic, strong) NSMutableArray *data;

- (instancetype)initWithType:(NSInteger )type;

@end

NS_ASSUME_NONNULL_END
