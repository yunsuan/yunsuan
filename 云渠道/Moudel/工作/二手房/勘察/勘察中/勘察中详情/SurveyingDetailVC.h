//
//  SurveyingDetailVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/6/15.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^SurveyingDetailVCBlock)(void);

@interface SurveyingDetailVC : BaseViewController

@property (nonatomic, copy) SurveyingDetailVCBlock surveyingDetailVCBlock;

- (instancetype)initWithSurveyId:(NSString *)surveyId;

@end
