//
//  PriceSetView.m
//  云渠道
//
//  Created by 谷治墙 on 2019/1/31.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "PriceSetView.h"

@interface PriceSetView ()
{
    
    NSString *_min;
    NSString *_max;
}

@end

@implementation PriceSetView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionConfirmBtn:(UIButton *)btn{
    
    if (self.priceSetViewConfirmBtnBlock) {
        
        if (_minTF.textfield.text.length) {
            
            _min = _minTF.textfield.text;
        }else{
            
            _min = @"0";
        }
        
        if (_maxTF.textfield.text.length) {
            
            _max = _maxTF.textfield.text;
        }else{
            
            _max = @"0";
        }
        self.priceSetViewConfirmBtnBlock(_min, _max);
    }
}

- (void)ActionCancelBtn:(UIButton *)btn{
    
    if (self.priceSetViewCancelBtnBlock) {
        
        self.priceSetViewCancelBtnBlock();
        [self removeFromSuperview];
    }
}

- (void)initUI{
    
    UIView *backView = [[UIView alloc] initWithFrame:self.bounds];
    backView.backgroundColor = [UIColor blackColor];
    backView.alpha = 0.3;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ActionTap)];
    [backView addGestureRecognizer:tap];
    [self addSubview:backView];
    
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 125 *SIZE)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self addSubview:whiteView];
    
    for (int i = 0; i < 2; i++) {
        
        BorderTF *tf = [[BorderTF alloc] initWithFrame:CGRectMake(15 *SIZE + i * 180 *SIZE, 10 *SIZE, 150 *SIZE, 33 *SIZE)];
        tf.unitL.text = @"万";
        tf.textfield.keyboardType = UIKeyboardTypeNumberPad;
        if (i == 0) {
            
            _minTF = tf;
            _minTF.textfield.textAlignment = NSTextAlignmentCenter;
            _minTF.textfield.placeholder = @"最低价";
            [whiteView addSubview:_minTF];
        }else{
            
            _maxTF = tf;
            _maxTF.textfield.textAlignment = NSTextAlignmentCenter;
            _maxTF.textfield.placeholder = @"最高价";
            [whiteView addSubview:_maxTF];
        }
    }
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 50 *SIZE, 340 *SIZE, 13 *SIZE)];
    label.textColor = YJContentLabColor;
    label.font = [UIFont systemFontOfSize:12 *SIZE];
    label.text = @"如不输入，代表不做限制";
    [whiteView addSubview:label];
    
    for (int i = 0; i < 2; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(66 *SIZE + i * 125 *SIZE, 80 *SIZE, 100 *SIZE, 33 *SIZE);
        if (i == 0) {
            
            
            [btn addTarget:self action:@selector(ActionCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTitle:@"取消" forState:UIControlStateNormal];
            [btn setTitleColor:YJ86Color forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:13 *SIZE];
            btn.layer.cornerRadius = 2 *SIZE;
            btn.layer.borderColor = COLOR(170, 170, 170, 1).CGColor;
            btn.clipsToBounds = YES;
            btn.layer.borderWidth = SIZE;
            [whiteView addSubview:btn];
        }else{
            
            [btn setTitle:@"确定" forState:UIControlStateNormal];
            [btn setBackgroundColor:COLOR(130, 200, 255, 1)];
            btn.titleLabel.font = [UIFont systemFontOfSize:13 *SIZE];
            btn.layer.cornerRadius = 2 *SIZE;
            btn.clipsToBounds = YES;
            [btn addTarget:self action:@selector(ActionConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
            [whiteView addSubview:btn];
        }
    }
}

- (void)ActionTap{
    if (self.priceSetViewCancelBtnBlock) {
        
        self.priceSetViewCancelBtnBlock();
    }
    
    if (self.superview) {
        [self removeFromSuperview];
    }
}

@end
