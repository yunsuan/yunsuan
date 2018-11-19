//
//  RoomSurveyWaitCell.h
//  云渠道
//
//  Created by 谷治墙 on 2018/6/15.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RoomSurveyWaitCell;

typedef void(^RoomSurveyWaitPhoneBlock)(NSInteger index);

typedef void(^RoomSyrveyWaitComfirmBlock)(NSInteger index);

@interface RoomSurveyWaitCell : UITableViewCell

@property (nonatomic, copy) RoomSurveyWaitPhoneBlock roomSurveyWaitPhoneBlock;

@property (nonatomic, copy) RoomSyrveyWaitComfirmBlock roomSyrveyWaitComfirmBlock;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UIImageView *sexImg;

@property (nonatomic, strong) UILabel *roomL;

@property (nonatomic, strong) UILabel *codeL;

@property (nonatomic, strong) UILabel *countDownL;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UILabel *phoneL;

@property (nonatomic, strong) UIButton *confirmBtn;

@property (nonatomic, strong) UIView *lineView;

@end
