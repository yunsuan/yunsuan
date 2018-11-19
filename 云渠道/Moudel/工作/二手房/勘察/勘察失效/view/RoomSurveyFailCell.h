//
//  RoomSurveyFailCell.h
//  云渠道
//
//  Created by 谷治墙 on 2018/6/15.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RoomSurveyFailCell;

typedef void(^RoomSurveyFailPhoneBlock)(NSInteger index);

@interface RoomSurveyFailCell : UITableViewCell

@property (nonatomic, copy) RoomSurveyFailPhoneBlock roomSurveyFailPhoneBlock;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UIImageView *sexImg;

@property (nonatomic, strong) UILabel *roomL;

@property (nonatomic, strong) UILabel *codeL;

@property (nonatomic, strong) UILabel *typeL;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UILabel *statusL;

@property (nonatomic, strong) UILabel *phoneL;

@property (nonatomic, strong) UIView *lineView;

@end
