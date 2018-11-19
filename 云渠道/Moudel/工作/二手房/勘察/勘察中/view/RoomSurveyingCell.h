//
//  RoomSurveyingCell.h
//  云渠道
//
//  Created by 谷治墙 on 2018/6/15.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RoomSurveyingCell;

typedef void(^RoomSurveyingPhoneBlock)(NSInteger index);

typedef void(^RoomSyrveyingConfirmBlock)(NSInteger index);

@interface RoomSurveyingCell : UITableViewCell

@property (nonatomic, copy) RoomSurveyingPhoneBlock roomSurveyingPhoneBlock;

@property (nonatomic, copy) RoomSyrveyingConfirmBlock roomSyrveyingConfirmBlock;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UIImageView *sexImg;

@property (nonatomic, strong) UILabel *roomL;

@property (nonatomic, strong) UILabel *codeL;

@property (nonatomic, strong) UILabel *countDownL;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UILabel *appointTimeL;

@property (nonatomic, strong) UILabel *statusL;

@property (nonatomic, strong) UILabel *phoneL;

@property (nonatomic, strong) UIButton *confirmBtn;

@property (nonatomic, strong) UIView *lineView;


@end
