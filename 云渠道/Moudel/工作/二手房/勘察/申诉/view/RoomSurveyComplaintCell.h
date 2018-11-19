//
//  RoomSurveyComplaintCell.h
//  云渠道
//
//  Created by 谷治墙 on 2018/6/18.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RoomSurveyComplaintCell;

typedef void(^RoomSurveyComplaintPhoneBlock)(NSInteger index);

@interface RoomSurveyComplaintCell : UITableViewCell

@property (nonatomic, copy) RoomSurveyComplaintPhoneBlock roomSurveyComplaintPhoneBlock;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UIImageView *sexImg;

@property (nonatomic, strong) UILabel *roomL;

@property (nonatomic, strong) UILabel *codeL;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UILabel *statusL;

@property (nonatomic, strong) UILabel *phoneL;

@property (nonatomic, strong) UIView *lineView;

@end
