//
//  NewDealVC.h
//  云渠道
//
//  Created by 谷治墙 on 2019/8/26.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^NewDealVCBlock)(void);

@interface NewDealVC : BaseViewController

@property (nonatomic, copy) NewDealVCBlock newDealVCBlock;

@property (nonatomic, strong) NSString *project_id;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
