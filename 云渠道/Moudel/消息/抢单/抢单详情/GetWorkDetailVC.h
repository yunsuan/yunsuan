//
//  GetWorkDetailVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/8/2.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^GetWorkDetailVCBlock)(void);

@interface GetWorkDetailVC : BaseViewController

@property (nonatomic, copy) GetWorkDetailVCBlock getWorkDetailVCBlock;

@property (nonatomic, strong) NSString *type;

- (instancetype)initWithRecordId:(NSString *)recordId;

@end
