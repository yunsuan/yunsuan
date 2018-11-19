//
//  RoomValidApplyVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/6/15.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^RoomValidApplyVCBlock)(void);

@interface RoomValidApplyVC : BaseViewController

@property (nonatomic, copy) RoomValidApplyVCBlock roomValidApplyVCBlock;

- (instancetype)initWithData:(NSDictionary *)data SurveyId:(NSString *)surveyId;

@end
