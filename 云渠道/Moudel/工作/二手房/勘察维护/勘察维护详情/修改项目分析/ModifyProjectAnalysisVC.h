//
//  ModifyProjectAnalysisVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/7/20.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^ModifyProjectAnalysisVCBlock)(void);

@interface ModifyProjectAnalysisVC : BaseViewController

@property (nonatomic, copy) ModifyProjectAnalysisVCBlock modifyProjectAnalysisVCBlock;

@property (nonatomic, strong) NSString *houseId;

@property (nonatomic, strong) NSString *typeId;

- (instancetype)initWithData:(NSDictionary *)dic;

@end
