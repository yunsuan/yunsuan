//
//  RentWorkSuccessVC.h
//  云渠道
//
//  Created by 谷治墙 on 2019/1/16.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^RentWorkSuccessVCBlock)(void);

@interface RentWorkSuccessVC : BaseViewController

@property (nonatomic, copy) RentWorkSuccessVCBlock rentWorkSuccessVCBlock;

- (instancetype)initWithData:(NSDictionary *)dataDic;

@end

NS_ASSUME_NONNULL_END
