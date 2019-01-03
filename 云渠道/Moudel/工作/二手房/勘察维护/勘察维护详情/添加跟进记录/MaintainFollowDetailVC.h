//
//  MaintainFollowDetailVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/10/19.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MaintainFollowDetailVC : BaseViewController

@property (nonatomic, strong) NSString *levelStr;

- (instancetype)initWithDataDic:(NSDictionary *)dataDic;

@end

NS_ASSUME_NONNULL_END
