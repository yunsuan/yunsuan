//
//  NewDealRuleVC.h
//  云渠道
//
//  Created by 谷治墙 on 2019/8/26.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^NewDealRuleVCBlock)(NSDictionary *dic);

@interface NewDealRuleVC : BaseViewController

@property (nonatomic, strong) NSString *project_id;

@property (nonatomic, copy) NewDealRuleVCBlock newDealRuleVCBlock;

@end

NS_ASSUME_NONNULL_END
