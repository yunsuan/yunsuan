//
//  SurveyInvalidVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/6/15.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^SurveyInvalidVCBlock)(void);

@interface SurveyInvalidVC : BaseViewController

@property (nonatomic, copy) SurveyInvalidVCBlock surveyInvalidVCBlock;

@property (nonatomic, strong) NSString *surveyId;

- (instancetype)initWithData:(NSDictionary *)data;

@end
