//
//  RentingRoomAgencyAddProtocolVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/12/21.
//  Copyright © 2018 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^RentingRoomAgencyAddProtocolVCBlock)(void);

@interface RentingRoomAgencyAddProtocolVC : BaseViewController

@property (nonatomic, copy) RentingRoomAgencyAddProtocolVCBlock rentingRoomAgencyAddProtocolVCBlock;

@property (nonatomic, strong) NSMutableDictionary *handleDic;

@property (nonatomic , strong) NSMutableDictionary *housedic;

- (instancetype)initWithDataArr:(nullable NSArray *)dataArr;

@end

NS_ASSUME_NONNULL_END
