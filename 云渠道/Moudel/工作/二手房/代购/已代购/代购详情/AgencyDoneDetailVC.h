//
//  AgencyDoneDetailVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/6/21.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^AgencyDoneDetailVCBlock)(void);

@interface AgencyDoneDetailVC : BaseViewController

@property (nonatomic, copy) AgencyDoneDetailVCBlock agencyDoneDetailVCBlock;

@property (nonatomic , strong) NSString *sub_id;
@end
