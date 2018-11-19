//
//  RoomReportAddVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/6/25.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseViewController.h"
#import "SecdaryAllTableModel.h"

typedef void(^RoomReportAddHouseBlock)(NSDictionary *dic);

typedef void(^RoomReportAddModelBlock)(SecdaryAllTableModel *model);

@interface RoomReportAddVC : BaseViewController

@property (nonatomic, copy) RoomReportAddModelBlock roomReportAddModelBlock;

@property (nonatomic, copy) RoomReportAddHouseBlock roomReportAddHouseBlock;

@property (nonatomic, strong) NSString *status;

@end
