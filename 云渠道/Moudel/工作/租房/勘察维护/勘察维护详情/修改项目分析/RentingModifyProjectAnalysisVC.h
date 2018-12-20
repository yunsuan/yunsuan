//
//  RentingModifyProjectAnalysisVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/8/2.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^RentingModifyProjectAnalysisVCBlock)(void);

@interface RentingModifyProjectAnalysisVC : BaseViewController

@property (nonatomic, copy) RentingModifyProjectAnalysisVCBlock rentingModifyProjectAnalysisVCBlock;

@property (nonatomic, strong) NSString *houseId;

@property (nonatomic, strong) NSString *typeId;

- (instancetype)initWithData:(NSDictionary *)dic;

@end
