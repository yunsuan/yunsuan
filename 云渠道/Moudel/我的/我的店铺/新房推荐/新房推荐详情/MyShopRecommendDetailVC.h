//
//  MyShopRecommendDetailVC.h
//  云渠道
//
//  Created by 谷治墙 on 2020/2/27.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^MyShopRecommendDetailVCBlock)(void);

@interface MyShopRecommendDetailVC : BaseViewController

@property (nonatomic, copy) MyShopRecommendDetailVCBlock myShopRecommendDetailVCBlock;

@property (nonatomic, strong) NSString *project_id;

@property (nonatomic, strong) NSString *projectName;

@property (nonatomic, strong) NSString *config_id;

- (instancetype)initWithHouseId:(NSString *)house_id info_id:(NSString *)info_id;

@end

NS_ASSUME_NONNULL_END
