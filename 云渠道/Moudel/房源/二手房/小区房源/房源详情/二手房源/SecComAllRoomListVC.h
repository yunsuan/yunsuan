//
//  SecComAllRoomListVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/9/4.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

#import "SecdaryAllTableModel.h"

typedef void(^SecComAllRoomListVCBlock)(SecdaryAllTableModel *model);

@interface SecComAllRoomListVC : BaseViewController

@property (nonatomic, copy) SecComAllRoomListVCBlock secComAllRoomListVCBlock;

@property (nonatomic, copy) NSString *status;

- (instancetype)initWithProjectId:(NSString *)projectId city:(NSString *)city;

@end
