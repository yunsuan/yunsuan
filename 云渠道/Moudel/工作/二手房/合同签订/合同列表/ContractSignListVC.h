//
//  ContractSignListVC.h
//  云渠道
//
//  Created by 谷治墙 on 2019/1/10.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^ContractSignListVCBlock)(void);

@interface ContractSignListVC : BaseViewController

@property (nonatomic, strong) NSString *search;

@property (nonatomic, copy) ContractSignListVCBlock contractSignListVCBlock;

-(void)postWithpage:(NSString *)page;

@end

NS_ASSUME_NONNULL_END
