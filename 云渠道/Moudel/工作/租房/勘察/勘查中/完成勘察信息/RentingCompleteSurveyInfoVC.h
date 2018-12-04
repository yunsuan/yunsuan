//
//  RentingCompleteSurveyInfoVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/7/31.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^RentingCompleteSurveyInfoVCBlock)(void);

@interface RentingCompleteSurveyInfoVC : BaseViewController

@property (nonatomic, copy) RentingCompleteSurveyInfoVCBlock rentingCompleteSurveyInfoVCBlock;

@property (nonatomic, strong) NSString *status;

@property (nonatomic, strong) NSDictionary *dataDic;

@property (nonatomic, strong) NSString *surveyId;

@property (nonatomic, strong) NSString *projectID;

@property (nonatomic, strong) NSString *buildId;

@property (nonatomic, strong) NSString *unitId;

@property (nonatomic, strong) NSString *comName;;

- (instancetype)initWithTitle:(NSString *)titleStr;

@end
