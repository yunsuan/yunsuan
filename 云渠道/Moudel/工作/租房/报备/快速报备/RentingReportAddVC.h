//
//  RentingReportAddVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/7/24.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

#import "RentingAllTableModel.h"

typedef void(^RentingRoomReportAddHouseBlock)(NSDictionary *dic);

typedef void(^RentingRoomReportAddModelBlock)(RentingAllTableModel *model);

@interface RentingReportAddVC : BaseViewController

@property (nonatomic, copy) RentingRoomReportAddHouseBlock rentingRoomReportAddHouseBlock;

@property (nonatomic, copy) RentingRoomReportAddModelBlock rentingRoomReportAddModelBlock;

@property (nonatomic, strong) NSString *status;

@end
