//
//  RoomSurveyingVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/6/15.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^RoomSurveyingBlock)(void);

@interface RoomSurveyingVC : BaseViewController

@property (nonatomic, strong) NSString *search;

@property (nonatomic, copy) RoomSurveyingBlock roomSurveyingBlock;

- (void)RequestMethod;
@end
