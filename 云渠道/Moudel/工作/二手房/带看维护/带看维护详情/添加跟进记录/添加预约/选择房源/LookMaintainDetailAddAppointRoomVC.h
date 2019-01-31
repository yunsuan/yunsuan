//
//  LookMaintainDetailAddAppointRoomVC.h
//  云渠道
//
//  Created by 谷治墙 on 2019/1/30.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^LookMaintainDetailAddAppointRoomVCBlock)(NSDictionary *dic);

@interface LookMaintainDetailAddAppointRoomVC : BaseViewController

@property (nonatomic, copy) LookMaintainDetailAddAppointRoomVCBlock lookMaintainDetailAddAppointRoomVCBlock;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@property (nonatomic, strong) NSString *status;

- (instancetype)initWithTakeId:(NSString *)takeId dataArr:(NSArray *)dataArr;

@end

NS_ASSUME_NONNULL_END
