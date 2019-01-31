//
//  MakeDateLookVC.h
//  云渠道
//
//  Created by 谷治墙 on 2019/1/29.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

#import "LookMaintainDetailAddAppointRoomModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^MakeDateLookVCBlock)(NSDictionary *dic);

@interface MakeDateLookVC : BaseViewController

@property (nonatomic, copy) MakeDateLookVCBlock makeDateLookVCBlock;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

- (instancetype)initWithModel:(LookMaintainDetailAddAppointRoomModel *)model;

@end

NS_ASSUME_NONNULL_END
