//
//  MyShopRoomDetailVC.h
//  云渠道
//
//  Created by 谷治墙 on 2020/2/26.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^MyShopRoomDetailVCBlock)(void);

@interface MyShopRoomDetailVC : BaseViewController

@property (nonatomic, copy) MyShopRoomDetailVCBlock myShopRoomDetailVCBlock;

@property (nonatomic, strong) NSString *project_id;

@property (nonatomic, strong) NSString *projectName;

@property (nonatomic, strong) NSString *config_id;

- (instancetype)initWithHouseId:(NSString *)house_id info_id:(NSString *)info_id;
@end

NS_ASSUME_NONNULL_END
