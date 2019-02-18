//
//  ContractDetailMainContractVC.h
//  云渠道
//
//  Created by 谷治墙 on 2019/2/15.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^ContractDetailMainContractVCBlock)(void);

@interface ContractDetailMainContractVC : BaseViewController

@property (nonatomic, copy) ContractDetailMainContractVCBlock contractDetailMainContractVCBlock;

@property (nonatomic, strong) NSString *dealId;

- (instancetype)initWithDataArr:(NSArray *)dataArr;

@end

NS_ASSUME_NONNULL_END
