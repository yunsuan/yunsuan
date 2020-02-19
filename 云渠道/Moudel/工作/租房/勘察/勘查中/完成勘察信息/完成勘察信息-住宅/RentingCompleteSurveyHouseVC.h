//
//  RentingCompleteSurveyHouseVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/12/4.
//  Copyright © 2018 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^RentingCompleteSurveyHouseVCBlock)(void);

@interface RentingCompleteSurveyHouseVC : BaseViewController

@property (nonatomic, copy) RentingCompleteSurveyHouseVCBlock rentingCompleteSurveyHouseVCBlock;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@property (nonatomic, strong) NSString *surveyId;

@property (nonatomic, strong) NSMutableDictionary *columnDic;

- (instancetype)initWithTitle:(NSString *)titleStr;

@end

NS_ASSUME_NONNULL_END
