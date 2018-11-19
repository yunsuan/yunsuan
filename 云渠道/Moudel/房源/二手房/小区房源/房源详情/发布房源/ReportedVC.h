//
//  ReportedVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/6/12.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

@interface ReportedVC : BaseViewController

@property (nonatomic, strong) NSString *projectId;

@property (nonatomic, strong) NSString *comName;

- (instancetype)initWithData:(NSDictionary *)data buildId:(NSString *)buildId unitId:(NSString *)unitId;

@end
