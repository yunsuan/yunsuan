//
//  RentingCompleteSurveyInfoVC2.h
//  云渠道
//
//  Created by 谷治墙 on 2018/7/31.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^RentCompleteSurveyInfoVCBlock2)(void);

@interface RentingCompleteSurveyInfoVC2 : BaseViewController

@property (nonatomic, copy) RentCompleteSurveyInfoVCBlock2 rentCompleteSurveyInfoVCBlock2;

@property (nonatomic, strong) NSMutableDictionary *dic;

@end
