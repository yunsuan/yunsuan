//
//  RentingAgencyDoneDetailVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/7/30.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^RentingAgencyDoneDetailVCBlock)(void);

@interface RentingAgencyDoneDetailVC : BaseViewController

@property (nonatomic, copy) RentingAgencyDoneDetailVCBlock rentingAgencyDoneDetailVCBlock;

@property (nonatomic , strong) NSString *sub_id;

@end
