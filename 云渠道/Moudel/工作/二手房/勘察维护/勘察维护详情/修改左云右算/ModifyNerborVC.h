//
//  ModifyNerborVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/10/28.
//  Copyright © 2018 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^ModifyNerborVCBlock)(void);

@interface ModifyNerborVC : BaseViewController

@property (nonatomic, copy) ModifyNerborVCBlock modifyNerborVCBlock;

@property (nonatomic, strong) NSString *type;

@property (nonatomic, strong) NSString *seeWay;

@property (nonatomic, strong) NSString *houseId;

- (instancetype)initWithData:(NSDictionary *)data;

@end

NS_ASSUME_NONNULL_END
