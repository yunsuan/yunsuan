//
//  RentingMaintainCustomVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/12/20.
//  Copyright © 2018 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^RentingMaintainCustomVCBlock)(void);

@interface RentingMaintainCustomVC : BaseViewController

@property (nonatomic, assign) BOOL edit;

@property (nonatomic, copy) RentingMaintainCustomVCBlock rentingMaintainCustomVCBlock;

- (instancetype)initWithDataDic:(NSDictionary *)dataDic;

@end

NS_ASSUME_NONNULL_END
