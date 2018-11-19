//
//  CompleteSurveyInfoVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/6/15.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^CompleteSurveyInfoVCBlock)(void);

@interface CompleteSurveyInfoVC : BaseViewController

@property (nonatomic, copy) CompleteSurveyInfoVCBlock completeSurveyInfoVCBlock;

@property (nonatomic, strong) NSString *status;

@property (nonatomic, strong) NSDictionary *dataDic;

@property (nonatomic, strong) NSString *surveyId;

- (instancetype)initWithTitle:(NSString *)titleStr;

@end
