//
//  MyShopRoomListVC.h
//  云渠道
//
//  Created by 谷治墙 on 2020/2/26.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^MyShopRoomListVCBlock)(void);

@interface MyShopRoomListVC : BaseViewController

@property (nonatomic, strong) MyShopRoomListVCBlock myShopRoomListVCBlock;

@property (nonatomic, strong) NSString *projectName;

- (instancetype)initWithProjectId:(NSString *)project_id info_id:(NSString *)info_id;

@end

NS_ASSUME_NONNULL_END
