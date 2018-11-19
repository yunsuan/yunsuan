//
//  RoomBrokerageVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/4/17.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseViewController.h"
#import "RoomListModel.h"

@interface RoomBrokerageVC : BaseViewController

//@property (nonatomic, strong) RoomListModel *model;
@property (nonatomic, strong) NSString *brokerage;

- (instancetype)initWithModel:(RoomListModel *)model;


@end
