//
//  GetAgencyProtocolVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/6/21.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^GetAgencyProtocolVCBlock)(void);

@interface GetAgencyProtocolVC : BaseViewController

@property (nonatomic, copy) GetAgencyProtocolVCBlock getAgencyProtocolVCBlock;

@property (nonatomic , strong) NSString *sub_id;
@property (nonatomic , strong) NSArray *infoArr;
@property (nonatomic , strong) NSString *broker;//违约金
@end
