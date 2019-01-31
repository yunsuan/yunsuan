//
//  LookMaintainAddLookVC.h
//  云渠道
//
//  Created by 谷治墙 on 2019/1/25.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

#import "LookMaintainDetailAddAppointRoomModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^LookMaintainAddLookVCBlock)(void);

@interface LookMaintainAddLookVC : BaseViewController

@property (nonatomic, copy) LookMaintainAddLookVCBlock lookMaintainAddLookVCBlock;

@property (nonatomic, strong) NSDictionary *dataDic;

- (instancetype)initWithModel:(LookMaintainDetailAddAppointRoomModel *)model;

@end

NS_ASSUME_NONNULL_END
