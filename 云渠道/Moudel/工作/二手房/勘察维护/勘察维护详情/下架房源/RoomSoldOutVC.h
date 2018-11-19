//
//  RoomSoldOutVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/6/20.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

@interface RoomSoldOutVC : BaseViewController

@property (nonatomic, strong) NSDictionary *dataDic;

- (instancetype)initWithHouseId:(NSString *)houseId;

@end
