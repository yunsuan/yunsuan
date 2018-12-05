//
//  RentingSurveyInvalidVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/7/26.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^RentSurveyInvalidVCBlock)(void);

@interface RentingSurveyInvalidVC : BaseViewController

@property (nonatomic, copy) RentSurveyInvalidVCBlock rentSurveyInvalidVCBlock;

@property (nonatomic, strong) NSString *surveyId;

- (instancetype)initWithData:(NSDictionary *)data;

@end
