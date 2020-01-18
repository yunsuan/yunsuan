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

@property (nonatomic, strong) NSString *projectID;

@property (nonatomic, strong) NSString *buildId;

@property (nonatomic, strong) NSString *unitId;

@property (nonatomic, strong) NSString *comName;;

@property (nonatomic, strong) NSDictionary *homeDic;

- (instancetype)initWithTitle:(NSString *)titleStr;

@end
