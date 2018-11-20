//
//  QuickRoomVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/5/5.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseViewController.h"
#import "CustomRequireModel.h"
#import "CustomerTableModel.h"
#import "RoomListModel.h"

@class QuickRoomVC;

typedef void(^QuickRoomVCSelectBlock)(NSString *projectId,NSString *projectName);


@interface QuickRoomVC : BaseViewController


@property (nonatomic, copy) QuickRoomVCSelectBlock quickRoomVCSelectBlock;

@property (nonatomic, strong) CustomerTableModel *customerTableModel;

@property (nonatomic, strong) NSString *ways;

- (instancetype)initWithModel:(CustomRequireModel *)model;

@end

