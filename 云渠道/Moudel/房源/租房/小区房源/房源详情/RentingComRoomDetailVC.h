//
//  RentingComRoomDetailVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/7/23.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

@interface RentingComRoomDetailVC : BaseViewController

@property (nonatomic, strong) NSString *type;

- (instancetype)initWithProjectId:(NSString *)projectId infoid:(NSString *)infoid city:(NSString *)city;

@end
