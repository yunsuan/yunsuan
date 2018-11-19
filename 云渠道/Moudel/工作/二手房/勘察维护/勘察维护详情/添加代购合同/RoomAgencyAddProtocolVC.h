//
//  RoomAgencyAddProtocolVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/6/21.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^RoomAgencyAddProtocolVCBlock)(void);

@interface RoomAgencyAddProtocolVC : BaseViewController

@property (nonatomic, copy) RoomAgencyAddProtocolVCBlock roomAgencyAddProtocolVCBlock;

@property (nonatomic, strong) NSMutableDictionary *handleDic;

@property (nonatomic , strong) NSMutableDictionary *housedic;

- (instancetype)initWithDataArr:(nullable NSArray *)dataArr;

@end
