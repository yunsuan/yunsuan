//
//  LookWorkConfirmDetailVC.h
//  云渠道
//
//  Created by 谷治墙 on 2019/1/8.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^LookWorkConfirmDetailVCBlock)(void);

@interface LookWorkConfirmDetailVC : BaseViewController

@property (nonatomic, copy) LookWorkConfirmDetailVCBlock lookWorkConfirmDetailVCBlock;

- (instancetype)initWithSurveyId:(NSString *)surveyId type:(NSString *)type;
@end

NS_ASSUME_NONNULL_END
