//
//  LookMaintainCustomDetailVC.h
//  云渠道
//
//  Created by 谷治墙 on 2019/1/25.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^LookMaintainCustomDetailVCBlock)(void);

@interface LookMaintainCustomDetailVC : BaseViewController

@property (nonatomic, copy) LookMaintainCustomDetailVCBlock lookMaintainCustomDetailVCBlock;

- (instancetype)initWithDataDic:(NSDictionary *)dataDic;

@end

NS_ASSUME_NONNULL_END
