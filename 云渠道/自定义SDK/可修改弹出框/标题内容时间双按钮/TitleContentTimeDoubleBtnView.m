//
//  TitleContentTimeDoubleBtnView.m
//  云渠道
//
//  Created by 谷治墙 on 2018/6/20.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "TitleContentTimeDoubleBtnView.h"

@implementation TitleContentTimeDoubleBtnView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionCancelBtn:(UIButton *)btn{
    
    if (self.titleContentTimeBtnCancelBlock) {
        
        self.titleContentTimeBtnCancelBlock();
    }
    [self removeFromSuperview];
}

- (void)ActionConfirmBtn:(UIButton *)btn{
    
    if (self.titleContentTimeBtnConfirmBlock) {
        
        self.titleContentTimeBtnConfirmBlock();
    }
    [self removeFromSuperview];
}

- (void)initUI{
    
    UIView *alphaView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    alphaView.backgroundColor = [UIColor blackColor];
    alphaView.alpha = 0.4;
    [self addSubview:alphaView];
    
    _whiteView = [[UIView alloc] initWithFrame:CGRectMake(55 *SIZE, 154 *SIZE, 250 *SIZE, 331 *SIZE)];
    _whiteView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_whiteView];
    
    _titleL = [[UILabel alloc] init];
    _titleL.textColor = YJTitleLabColor;
    _titleL.font = [UIFont systemFontOfSize:17 *SIZE];
    _titleL.textAlignment = NSTextAlignmentCenter;
    [_whiteView addSubview:_titleL];
    
    for (int i = 0; i < 2; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = YJ86Color;
        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:12 *SIZE];
        switch (i) {
            case 0:
            {
                _contentL = label;
                [_whiteView addSubview:_contentL];
                break;
            }
            case 1:
            {
                _timeL = label;
                _timeL.textColor = YJContentLabColor;
                _timeL.font = [UIFont systemFontOfSize:11 *SIZE];
                [_whiteView addSubview:_timeL];
                break;
            }
            default:
                break;
        }
        
        if (i < 2) {
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.bounds = CGRectMake(0, 0, 125 *SIZE, 40 *SIZE);
            btn.titleLabel.font = [UIFont systemFontOfSize:13 *SIZE];
            if (i == 1) {
                
                _confirmBtn = btn;
                [_confirmBtn addTarget:self action:@selector(ActionConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
                [_confirmBtn setBackgroundColor:COLOR(238, 238, 238, 1)];
                [_confirmBtn setTitle:@"确认下架" forState:UIControlStateNormal];
                [_confirmBtn setTitleColor:YJTitleLabColor forState:UIControlStateNormal];
                [_whiteView addSubview:_confirmBtn];
            }else{
                
                _cancelBtn = btn;
                [_cancelBtn addTarget:self action:@selector(ActionCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
                [_cancelBtn setBackgroundColor:YJBlueBtnColor];
                [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
                [_cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [_whiteView addSubview:_cancelBtn];
            }
        }
    }
    
    [self masonryUI];
}

- (void)masonryUI{
    
    [_whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(55 *SIZE);
        make.top.equalTo(self).offset(154 *SIZE);
        make.right.equalTo(self).offset(-55 *SIZE);
    }];
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(0 *SIZE);
        make.top.equalTo(_whiteView).offset(19 *SIZE);
        make.right.equalTo(_whiteView).offset(-0 *SIZE);
    }];
    [_contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(21 *SIZE);
        make.top.equalTo(_titleL.mas_bottom).offset(19 *SIZE);
        make.right.equalTo(_whiteView).offset(-29 *SIZE);
    }];

    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(28 *SIZE);
        make.top.equalTo(_contentL.mas_bottom).offset(20 *SIZE);
        make.right.equalTo(_whiteView).offset(-29 *SIZE);
    }];
    
    [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(125 *SIZE);
        make.top.equalTo(_timeL.mas_bottom).offset(17 *SIZE);
        make.width.equalTo(@(125 *SIZE));
        make.height.equalTo(@(40 *SIZE));
        make.bottom.equalTo(_whiteView).offset(0);
    }];
    [_confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(0 *SIZE);
        make.top.equalTo(_timeL.mas_bottom).offset(17 *SIZE);
        make.width.equalTo(@(125 *SIZE));
        make.height.equalTo(@(40 *SIZE));
        make.bottom.equalTo(_whiteView).offset(0);
    }];
}

@end
