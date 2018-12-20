//
//  RentingComAllRoomListVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/12/19.
//  Copyright © 2018 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

#import "RentingAllTableModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^RentingComAllRoomListVCBlock)(RentingAllTableModel *model);

@interface RentingComAllRoomListVC : BaseViewController

@property (nonatomic, copy) RentingComAllRoomListVCBlock rentingComAllRoomListVCBlock;

@property (nonatomic, copy) NSString *status;

- (instancetype)initWithProjectId:(NSString *)projectId city:(NSString *)city;

@end

NS_ASSUME_NONNULL_END
