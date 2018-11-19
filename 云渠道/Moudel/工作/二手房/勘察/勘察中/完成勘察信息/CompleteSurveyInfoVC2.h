//
//  CompleteSurveyInfoVC2.h
//  云渠道
//
//  Created by 谷治墙 on 2018/6/19.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^CompleteSurveyInfoVCBlock2)(void);

@interface CompleteSurveyInfoVC2 : BaseViewController

@property (nonatomic, copy) CompleteSurveyInfoVCBlock2 completeSurveyInfoVCBlock2;

@property (nonatomic, strong) NSMutableDictionary *dic;

@end
