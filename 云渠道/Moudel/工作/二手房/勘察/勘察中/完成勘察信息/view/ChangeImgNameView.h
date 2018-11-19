//
//  ChangeImgNameView.h
//  云渠道
//
//  Created by 谷治墙 on 2018/9/2.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ChangeImgNameViewBlock)(NSString *str);

@interface ChangeImgNameView : UIView

@property (nonatomic, copy) ChangeImgNameViewBlock changeImgNameViewBlock;

@property (nonatomic, strong) UITextField *nameTF;

@property (nonatomic, strong) UIButton *cancelBtn;

@property (nonatomic, strong) UIButton *confirmBtn;

@end
