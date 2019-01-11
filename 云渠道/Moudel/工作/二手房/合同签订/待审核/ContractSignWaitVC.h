//
//  ContractSignWaitVC.h
//  云渠道
//
//  Created by 谷治墙 on 2019/1/10.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^ContractSignWaitVCBlock)(void);

@interface ContractSignWaitVC : BaseViewController

@property (nonatomic, strong) NSString *search;

@property (nonatomic, copy) ContractSignWaitVCBlock contractSignWaitVCBlock;

-(void)postWithpage:(NSString *)page;

@end

NS_ASSUME_NONNULL_END
