//
//  CustomSelectCityVC.h
//  云渠道
//
//  Created by 谷治墙 on 2020/3/8.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^CustomSelectCityVCSaveBlock)(NSString *code, NSString *city);

@interface CustomSelectCityVC : BaseViewController

@property (nonatomic, copy) CustomSelectCityVCSaveBlock customSelectCityVCSaveBlock;

@end

NS_ASSUME_NONNULL_END
