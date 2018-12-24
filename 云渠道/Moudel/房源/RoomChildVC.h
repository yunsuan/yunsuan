//
//  RoomChildVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/9/11.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseViewController.h"
#import "LDetailViewController.h"

#import "RoomListModel.h"
#import "SecdaryAllTableModel.h"
#import "SecdaryComModel.h"


typedef void(^RoomChildVCSecModelBlock)(SecdaryAllTableModel *model);

typedef void(^RoomChildVCSecComModelBlock)(SecdaryComModel *model);

typedef void(^RoomChildVCRoomModelBlock)(RoomListModel *model);

typedef void(^RoomChildVCRoomVCBlock)(LDetailViewController *vc);

//typedef void(^RoomChildVC)(<#arguments#>);
@interface RoomChildVC : BaseViewController

@property (nonatomic, copy) RoomChildVCRoomVCBlock roomChildVCRoomVCBlock;

@property (nonatomic, copy) RoomChildVCRoomModelBlock roomChildVCRoomModelBlock;

@property (nonatomic, copy) RoomChildVCSecModelBlock roomChildVCSecModelBlock;

@property (nonatomic, copy) RoomChildVCSecComModelBlock roomChildVCSecComModelBlock;

@property (nonatomic, strong) NSString *status;

@property (nonatomic, strong) NSString *city;

@property (nonatomic, strong) NSString *typeId;

@property (nonatomic, strong) NSString *param;

@property (nonatomic, assign) BOOL isFirstLoading;

- (instancetype)initWithType:(NSInteger )type;

- (void)RequestMethod;

@end
