//
//  SecAllRoomTableCell2.h
//  云渠道
//
//  Created by 谷治墙 on 2018/6/11.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SecAllRoomTableCell2;

typedef void(^LookRecordBlock)(void);

@interface SecAllRoomTableCell2 : UITableViewCell

@property (nonatomic, copy) LookRecordBlock lookRecordBlock;

@property (nonatomic, strong) UILabel *daysL;

@property (nonatomic, strong) UILabel *daysLabel;

@property (nonatomic, strong) UILabel *allL;

@property (nonatomic, strong) UILabel *allLabel;

@property (nonatomic, strong) UILabel *intentL;

@property (nonatomic, strong) UILabel *intentLabel;

@property (nonatomic, strong) UILabel *recentL;

@end
