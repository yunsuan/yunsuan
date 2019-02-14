//
//  LookMaintainDetailAddAppointVC.h
//  云渠道
//
//  Created by 谷治墙 on 2019/1/30.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^LookMaintainDetailAddAppointVCBlock)(void);

@interface LookMaintainDetailAddAppointVC : BaseViewController

@property (nonatomic, copy) LookMaintainDetailAddAppointVCBlock lookMaintainDetailAddAppointVCBlock;

@property (nonatomic, assign) BOOL isSelect;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@property (nonatomic, strong) NSString *status;

- (instancetype)initWithTakeId:(NSString *)takeId;

@end

NS_ASSUME_NONNULL_END
