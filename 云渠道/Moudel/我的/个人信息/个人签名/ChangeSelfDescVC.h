//
//  ChangeSelfDescVC.h
//  云渠道
//
//  Created by 谷治墙 on 2020/3/3.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^ChangeSelfDescVCBlock)(void);

@interface ChangeSelfDescVC : BaseViewController

@property (nonatomic, copy) ChangeSelfDescVCBlock changeSelfDescVCBlock;

- (instancetype)initWithDesc:(NSString *)self_desc;

@end

NS_ASSUME_NONNULL_END
