//
//  NewCustomDetailVC.h
//  云渠道
//
//  Created by 谷治墙 on 2020/2/26.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "BaseViewController.h"
#import "CustomerTableModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface NewCustomDetailVC : BaseViewController

@property (nonatomic, strong) CustomerTableModel *model;

- (instancetype)initWithClientId:(NSString *)clientId;

@end

NS_ASSUME_NONNULL_END
