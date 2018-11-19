//
//  CompleteSurveyOfficeVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/9/13.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^CompleteSurveyOfficeBlock)(void);

@interface CompleteSurveyOfficeVC : BaseViewController

@property (nonatomic, copy) CompleteSurveyOfficeBlock completeSurveyOfficeBlock;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@property (nonatomic, strong) NSString *surveyId;

- (instancetype)initWithTitle:(NSString *)titleStr;

@end
