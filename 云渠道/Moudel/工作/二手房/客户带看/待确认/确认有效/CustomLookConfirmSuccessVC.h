//
//  CustomLookConfirmSuccessVC.h
//  云渠道
//
//  Created by 谷治墙 on 2019/1/30.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^CustomLookConfirmSuccessVCBlock)(void);

@interface CustomLookConfirmSuccessVC : BaseViewController

@property (nonatomic, assign) BOOL isSelect;

@property (nonatomic, copy) CustomLookConfirmSuccessVCBlock customLookConfirmSuccessVCBlock;

- (instancetype)initWithDataDic:(NSDictionary *)dataDic;

@end

NS_ASSUME_NONNULL_END
