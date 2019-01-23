//
//  ChooseCustomerVC.h
//  云渠道
//
//  Created by xiaoq on 2019/1/22.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN


typedef void(^ChooseCustomerBlock)(NSMutableArray *arr);

@interface ChooseCustomerVC : BaseViewController

@property (nonatomic, copy) ChooseCustomerBlock ChooseCustomerblock;

@end


NS_ASSUME_NONNULL_END
