//
//  RentingCompleteSurveyInfoVC3.h
//  云渠道
//
//  Created by 谷治墙 on 2018/7/31.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^RentCompleteSurveyInfoVCBlock3)(void);

@interface RentingCompleteSurveyInfoVC3 : BaseViewController

@property (nonatomic, copy) RentCompleteSurveyInfoVCBlock3 rentCompleteSurveyInfoVCBlock3;

@property (nonatomic, strong) NSMutableDictionary *dic;

@end
