//
//  RecommendMoreInfoChildVC.h
//  云渠道
//
//  Created by 谷治墙 on 2019/4/2.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^RecommendMoreInfoChildVCBlock)(NSDictionary *dataDic);

@interface RecommendMoreInfoChildVC : BaseViewController

@property (nonatomic, copy) RecommendMoreInfoChildVCBlock recommendMoreInfoChildVCBlock;

- (instancetype)initWithType:(NSInteger )type companyId:(NSString *)companyId;


@end

NS_ASSUME_NONNULL_END
