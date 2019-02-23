//
//  ContractAddAgentVC.h
//  云渠道
//
//  Created by 谷治墙 on 2019/2/19.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^ContractAddAgentVCBlock)(void);

@interface ContractAddAgentVC : BaseViewController

@property (nonatomic, copy) ContractAddAgentVCBlock contractAddAgentVCBlock;

@property (nonatomic, strong) NSString *dealId;

@end

NS_ASSUME_NONNULL_END
