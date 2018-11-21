//
//  CustomListVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/5/5.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

#import "RoomDetailModel.h"

@interface CustomListVC : BaseViewController

@property (nonatomic, strong) RoomDetailModel *model;

- (instancetype)initWithProjectId:(NSString *)projectId;

@end
