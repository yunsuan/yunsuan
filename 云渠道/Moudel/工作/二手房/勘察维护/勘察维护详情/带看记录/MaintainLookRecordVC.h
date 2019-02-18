//
//  MaintainLookRecordVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/6/21.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

@interface MaintainLookRecordVC : BaseViewController

@property (nonatomic, strong) NSString *houseId;

- (instancetype)initWithDataDic:(NSDictionary *)dataDic;

@end
