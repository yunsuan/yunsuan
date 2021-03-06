//
//  RoomMaintainCell.h
//  云渠道
//
//  Created by 谷治墙 on 2018/6/20.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RoomMaintainModel.h"

@class RoomMaintainCell;

typedef void(^RoomMaintainPhoneBlock)(NSInteger index);

@interface RoomMaintainCell : UITableViewCell

@property (nonatomic, strong) RoomMaintainModel *model;

@property (nonatomic, copy) RoomMaintainPhoneBlock roomMaintainPhoneBlock;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UIImageView *sexImg;

@property (nonatomic, strong) UILabel *roomL;

@property (nonatomic, strong) UILabel *codeL;

@property (nonatomic, strong) UILabel *numL;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UILabel *phoneL;

@property (nonatomic, strong) UIView *lineView;

@end
