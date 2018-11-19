
//
//  ChangeImgNameView.m
//  云渠道
//
//  Created by 谷治墙 on 2018/9/2.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "ChangeImgNameView.h"

@implementation ChangeImgNameView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionCancelBtn:(UIButton *)btn{
    
    [self removeFromSuperview];
}

- (void)ActionConfirmBtn:(UIButton *)btn{
    
    if (self.changeImgNameViewBlock) {
        
        if (_nameTF.text.length) {
            
            self.changeImgNameViewBlock(_nameTF.text);
            [self removeFromSuperview];
        }else{
        
        }
    }
    
}

- (void)initUI{
    
    UIView *alphaView = [[UIView alloc] initWithFrame:self.bounds];
    alphaView.backgroundColor = [UIColor blackColor];
    alphaView.alpha = 0.3;
    [self addSubview:alphaView];
    
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(55 *SIZE, 226 *SIZE, 250 *SIZE, 167 *SIZE)];
    whiteView.backgroundColor = CH_COLOR_white;
    [self addSubview:whiteView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 17 *SIZE, 250 *SIZE, 13 *SIZE)];
    label.textColor = YJTitleLabColor;
    label.font = [UIFont systemFontOfSize:14 *SIZE];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"修改图片名称";
    [whiteView addSubview:label];
    
    _nameTF = [[UITextField alloc] initWithFrame:CGRectMake(25 *SIZE, 59 *SIZE, 200 *SIZE, 33 *SIZE)];
    _nameTF.backgroundColor = COLOR(238, 238, 238, 1);
    _nameTF.font = [UIFont systemFontOfSize:12 *SIZE];
    _nameTF.placeholder = @"输入图片名称";
    [whiteView addSubview:_nameTF];
    
    for (int i = 0; i < 2; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(125 *SIZE * i , 127 *SIZE, 125 *SIZE, 40 *SIZE);
        btn.titleLabel.font = [UIFont systemFontOfSize:13 *sIZE];
        if (i == 0) {

            
            [btn addTarget:self action:@selector(ActionCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTitle:@"取消" forState:UIControlStateNormal];
            [btn setTitleColor:YJ86Color forState:UIControlStateNormal];
            [btn setBackgroundColor:COLOR(238, 238, 238, 1)];
            _cancelBtn = btn;
            [whiteView addSubview:_cancelBtn];
        }else{
            
            [btn addTarget:self action:@selector(ActionConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTitle:@"确定" forState:UIControlStateNormal];
            [btn setBackgroundColor:YJBlueBtnColor];
            _confirmBtn = btn;
            [whiteView addSubview:_confirmBtn];
        }
    }
}

@end
