//
//  RentingInvalidApplyVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/7/26.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^RentingInvalidApplyVCBlock)(void);

@interface RentingInvalidApplyVC : BaseViewController

@property (nonatomic, copy) RentingInvalidApplyVCBlock rentingInvalidApplyVCBlock;

- (instancetype)initWithData:(NSDictionary *)data SurveyId:(NSString *)surveyId;

@end
