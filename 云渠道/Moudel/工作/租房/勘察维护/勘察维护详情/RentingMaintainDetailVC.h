//
//  RentingMaintainDetailVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/7/30.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

#import "RoomMaintainModel.h"

typedef void(^RentingMaintainDetailVCBlock)(void);

@interface RentingMaintainDetailVC : BaseViewController

@property (nonatomic, copy) RentingMaintainDetailVCBlock rentingMaintainDetailVCBlock;

@property (nonatomic, assign) BOOL edit;

- (instancetype)initWithSurveyId:(NSString *)surveyId houseId:(NSString *)houseId type:(NSInteger )type;

@end
