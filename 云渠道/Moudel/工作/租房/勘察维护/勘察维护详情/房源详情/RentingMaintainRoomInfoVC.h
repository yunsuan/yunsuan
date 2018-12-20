//
//  RentingMaintainRoomInfoVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/7/30.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

@interface RentingMaintainRoomInfoVC : BaseViewController

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, strong) NSMutableArray *progressArr;

- (instancetype)initWithDataDic:(NSDictionary *)data;

@end
