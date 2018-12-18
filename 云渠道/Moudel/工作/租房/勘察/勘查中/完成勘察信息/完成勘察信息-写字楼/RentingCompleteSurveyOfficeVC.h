//
//  RentingCompleteSurveyOfficeVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/12/18.
//  Copyright © 2018 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^RentingCompleteSurveyOfficeBlock)(void);

@interface RentingCompleteSurveyOfficeVC : BaseViewController

@property (nonatomic, copy) RentingCompleteSurveyOfficeBlock rentingCompleteSurveyOfficeBlock;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@property (nonatomic, strong) NSString *surveyId;

- (instancetype)initWithTitle:(NSString *)titleStr;

@end

NS_ASSUME_NONNULL_END
