//
//  CustomLookWaitDetailVC.h
//  云渠道
//
//  Created by 谷治墙 on 2019/1/8.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^CustomLookWaitDetailVCBlock)(void);

@interface CustomLookWaitDetailVC : BaseViewController

@property (nonatomic, copy) CustomLookWaitDetailVCBlock customLookWaitDetailVCBlock;

- (instancetype)initWithSurveyId:(NSString *)surveyId;

@end

NS_ASSUME_NONNULL_END
