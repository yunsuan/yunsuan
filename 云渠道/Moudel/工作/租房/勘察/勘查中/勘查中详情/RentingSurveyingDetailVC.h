//
//  RentingSurveyingDetailVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/7/26.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^RentingSurveyingDetailVCBlock)(void);

@interface RentingSurveyingDetailVC : BaseViewController

@property (nonatomic, copy) RentingSurveyingDetailVCBlock rentingSurveyingDetailVCBlock;

- (instancetype)initWithSurveyId:(NSString *)surveyId;

@end
