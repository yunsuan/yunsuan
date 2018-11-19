//
//  SystemWorkConfirmDetailVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/11/1.
//  Copyright © 2018 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^SystemWorkConfirmDetailVCBlock)(void);

@interface SystemWorkConfirmDetailVC : BaseViewController

@property (nonatomic, copy) SystemWorkConfirmDetailVCBlock systemWorkConfirmDetailVCBlock;

- (instancetype)initWithSurveyId:(NSString *)surveyId;
@end

NS_ASSUME_NONNULL_END
