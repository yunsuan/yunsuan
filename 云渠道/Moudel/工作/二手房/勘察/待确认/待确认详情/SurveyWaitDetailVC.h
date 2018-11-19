//
//  SurveyWaitDetailVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/6/15.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^SurveyWaitDetailVCBlock)(void);

@interface SurveyWaitDetailVC : BaseViewController

@property (nonatomic, copy) SurveyWaitDetailVCBlock surveyWaitDetailVCBlock;

- (instancetype)initWithSurveyId:(NSString *)surveyId;

@end
