//
//  AddAreaNeedVC.h
//  云渠道
//
//  Created by 谷治墙 on 2019/12/3.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^AddAreaNeedVCBlock)(void);

@interface AddAreaNeedVC : BaseViewController

@property (nonatomic, copy) AddAreaNeedVCBlock addAreaNeedVCBlock;

- (instancetype)initWithDataDic:(NSDictionary *)dataDic;

@end

NS_ASSUME_NONNULL_END
