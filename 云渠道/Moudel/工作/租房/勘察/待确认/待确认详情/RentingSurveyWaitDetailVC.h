//
//  RentingSurveyWaitDetailVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/7/26.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^RentingSurveyWaitDetailVCBlock)(void);

@interface RentingSurveyWaitDetailVC : BaseViewController

@property (nonatomic, copy) RentingSurveyWaitDetailVCBlock rentingSurveyWaitDetailVCBlock;

- (instancetype)initWithSurveyId:(NSString *)surveyId;

@end
