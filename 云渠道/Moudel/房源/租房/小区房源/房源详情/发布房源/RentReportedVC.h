//
//  RentReportedVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/12/17.
//  Copyright © 2018 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface RentReportedVC : BaseViewController

@property (nonatomic, strong) NSString *projectId;

@property (nonatomic, strong) NSString *comName;

@property (nonatomic, strong) NSString *status;

- (instancetype)initWithData:(NSDictionary *)data buildId:(NSString *)buildId unitId:(NSString *)unitId;

@end

NS_ASSUME_NONNULL_END
