//
//  RoomDetailVC1.h
//  云渠道
//
//  Created by 谷治墙 on 2018/4/17.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseViewController.h"
#import "RoomProjectVC.h"
#import "RoomListModel.h"

@interface RoomDetailVC1 : BaseViewController

@property (nonatomic, strong) NSString *brokerage;

- (instancetype)initWithModel:(RoomListModel *)model;

@end
