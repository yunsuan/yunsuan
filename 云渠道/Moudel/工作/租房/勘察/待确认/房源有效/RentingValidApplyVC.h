//
//  RentingValidApplyVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/7/26.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^RentingValidApplyVCBlock)(void);

@interface RentingValidApplyVC : BaseViewController

@property (nonatomic, copy) RentingValidApplyVCBlock rentingValidApplyVCBlock;

- (instancetype)initWithData:(NSDictionary *)data SurveyId:(NSString *)surveyId;

@end
