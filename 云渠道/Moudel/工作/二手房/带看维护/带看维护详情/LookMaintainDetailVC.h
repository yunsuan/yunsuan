//
//  LookMaintainDetailVC.h
//  云渠道
//
//  Created by 谷治墙 on 2019/1/23.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LookMaintainDetailVC : BaseViewController

@property (nonatomic, strong) NSString *edit;

- (instancetype)initWithTakeId:(NSString *)takeId;

@end

NS_ASSUME_NONNULL_END
