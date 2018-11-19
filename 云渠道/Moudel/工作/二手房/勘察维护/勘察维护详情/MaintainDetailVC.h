//
//  MaintainDetailVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/6/20.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

#import "RoomMaintainModel.h"

typedef void(^MaintainDetailVCBlock)(void);

@interface MaintainDetailVC : BaseViewController

@property (nonatomic, copy) MaintainDetailVCBlock maintainDetailVCBlock;

@property (nonatomic, assign) BOOL edit;

- (instancetype)initWithSurveyId:(NSString *)surveyId houseId:(NSString *)houseId type:(NSInteger )type;

@end
