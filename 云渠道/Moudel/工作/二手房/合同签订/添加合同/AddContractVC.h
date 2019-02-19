//
//  AddContractVC.h
//  云渠道
//
//  Created by 谷治墙 on 2019/1/10.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^AddContractVCBlock)(void);

@interface AddContractVC : BaseViewController
@property (nonatomic , strong)  NSMutableDictionary *tradedic;
@property (nonatomic , strong)  NSMutableArray *buyarr;
@property (nonatomic , strong)  NSMutableArray *sellarr;
@property (nonatomic, copy) AddContractVCBlock addContractVCBlock;

@end

NS_ASSUME_NONNULL_END
