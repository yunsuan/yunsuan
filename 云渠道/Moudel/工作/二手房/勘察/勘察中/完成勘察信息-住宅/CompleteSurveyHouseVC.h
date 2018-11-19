//
//  CompleteSurveyHouseVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/9/13.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseViewController.h"


typedef void(^CompleteSurveyHouseVCBlock)(void);

@interface CompleteSurveyHouseVC : BaseViewController

@property (nonatomic, copy) CompleteSurveyHouseVCBlock completeSurveyHouseVCBlock;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@property (nonatomic, strong) NSString *surveyId;

- (instancetype)initWithTitle:(NSString *)titleStr;
@end
