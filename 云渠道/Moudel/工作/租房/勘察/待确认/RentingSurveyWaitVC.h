//
//  RentingSurveyWaitVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/7/26.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^RentingSurveyWaitVCBlock)(void);

@interface RentingSurveyWaitVC : BaseViewController

@property (nonatomic, strong) NSString *search;

@property (nonatomic, copy) RentingSurveyWaitVCBlock rentingSurveyWaitVCBlock;

- (void)RequestMethod;

@end
