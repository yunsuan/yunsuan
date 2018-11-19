//
//  SecAllRoomDetailVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/6/11.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

@interface SecAllRoomDetailVC : BaseViewController

@property (nonatomic, assign) NSInteger type;

- (instancetype)initWithHouseId:(NSString *)houseId city:(NSString *)city;

@end
