//
//  CompleteSurveyInfoVC4.h
//  云渠道
//
//  Created by 谷治墙 on 2018/6/20.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^CompleteSurveyInfoVCBlock4)(void);

@interface CompleteSurveyInfoVC4 : BaseViewController

@property (nonatomic, copy) CompleteSurveyInfoVCBlock4 completeSurveyInfoVCBlock4;

@property (nonatomic, strong) NSMutableDictionary *dic;
@end
