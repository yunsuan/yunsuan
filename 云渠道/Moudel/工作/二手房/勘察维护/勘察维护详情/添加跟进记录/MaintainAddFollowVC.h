//
//  MaintainAddFollowVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/6/20.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^MaintainAddFollowVCBlock)(void);

@interface MaintainAddFollowVC : BaseViewController

@property (nonatomic, copy) MaintainAddFollowVCBlock maintainAddFollowVCBlock;

- (instancetype)initWithHouseId:(NSString *)houseId dataDic:(NSDictionary *)dataDic;

@end
