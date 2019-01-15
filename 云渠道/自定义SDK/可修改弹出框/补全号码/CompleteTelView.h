//
//  CompleteTelView.h
//  云渠道
//
//  Created by 谷治墙 on 2019/1/15.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DashesLineView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CompleteTelView : UIView

@property (nonatomic, strong) DashesLineView *lineView;

@property (nonatomic, strong) UIView *whiteView;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UITextField *phoneTF4;

@property (nonatomic, strong) UITextField *phoneTF5;

@property (nonatomic, strong) UITextField *phoneTF6;

@property (nonatomic, strong) UITextField *phoneTF7;

@end

NS_ASSUME_NONNULL_END
