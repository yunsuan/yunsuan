//
//  SurveyingDetailCell.h
//  云渠道
//
//  Created by 谷治墙 on 2018/6/29.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "SingleContentCell.h"

@class SurveyingDetailCell;

typedef void(^SurveyingDetailChangeBlock)(void);

@interface SurveyingDetailCell : SingleContentCell

@property (nonatomic, copy) SurveyingDetailChangeBlock surveyingDetailChangeBlock;

@property (nonatomic, strong) UIButton *changeBtn;

@end
