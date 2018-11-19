//
//  ModifyTimeVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/6/29.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^ModifyTimeVCBlock)(void);

@interface ModifyTimeVC : BaseViewController

@property (nonatomic, copy) ModifyTimeVCBlock modifyTimeVCBlock;

@property (nonatomic, strong) NSDictionary *dataDic;

- (instancetype)initWithSurveyId:(NSString *)surveyId;

@end
