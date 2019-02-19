//
//  SetContractVc.h
//  云渠道
//
//  Created by xiaoq on 2019/2/18.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^SetContractVcBlock)(void);

@interface SetContractVc : BaseViewController

@property (nonatomic, copy) SetContractVcBlock setContractVcBlock;

@property (nonatomic, strong) NSString *dealId;

@property (nonatomic , strong) NSMutableDictionary *tradedic;

@end

NS_ASSUME_NONNULL_END
