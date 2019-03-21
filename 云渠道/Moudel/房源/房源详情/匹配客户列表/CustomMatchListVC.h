//
//  CustomMatchListVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/4/8.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

#import "RoomDetailModel.h"

@interface CustomMatchListVC : BaseViewController

@property (nonatomic, strong) NSString *isRecommend;

@property (nonatomic, strong) RoomDetailModel *model;

- (instancetype)initWithDataArr:(NSArray *)dataArr projectId:(NSString *)projectId;

@end

