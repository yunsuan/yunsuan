//
//  ContentTimeBtnBaseView.m
//  云渠道
//
//  Created by 谷治墙 on 2018/6/15.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "ContentTimeBtnBaseView.h"

@implementation ContentTimeBtnBaseView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionTagBtn:(UIButton *)btn{
    
    [self removeFromSuperview];
}

- (void)initUI{
    
    UIView *alphaView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    alphaView.backgroundColor = [UIColor blackColor];
    alphaView.alpha = 0.4;
    [self addSubview:alphaView];
    
    _whiteView = [[UIView alloc] init];
    _whiteView.backgroundColor = CH_COLOR_white;
    [self addSubview:_whiteView];
    
    for (int i = 0; i < 3; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = YJTitleLabColor;
        label.font = [UIFont systemFontOfSize:15 *SIZE];
        if (i == 0) {
            
            _titleL = label;
            _titleL.textAlignment = NSTextAlignmentCenter;
            [_whiteView addSubview:_titleL];
        }else if (i == 1){
            
            _contentL = label;
            _contentL.textColor = YJ86Color;
            _contentL.numberOfLines = 0;
            _contentL.font = [UIFont systemFontOfSize:13 *SIZE];
            [_whiteView addSubview:_contentL];
        }else{
            
            _timeL = label;
            _timeL.textColor = YJContentLabColor;
            _timeL.numberOfLines = 0;
            _timeL.font = [UIFont systemFontOfSize:11 *SIZE];
            [_whiteView addSubview:_timeL];
        }
        
        if (i != 0) {
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.titleLabel.font = [UIFont systemFontOfSize:14 *sIZE];
            [btn addTarget:self action:@selector(ActionTagBtn:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = i;
            if (i == 1) {
                
                _backBtn = btn;
                [_backBtn setTitle:@"返回" forState:UIControlStateNormal];
                [_backBtn setTitleColor:YJ86Color forState:UIControlStateNormal];
                [_backBtn setBackgroundColor:YJBackColor];
                [_whiteView addSubview:_backBtn];
            }else{
                
                _nextBtn = btn;
                [_nextBtn setTitle:@"继续报备" forState:UIControlStateNormal];
                [_nextBtn setBackgroundColor:YJBlueBtnColor];
                [_whiteView addSubview:_nextBtn];
            }
        }
    }
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self).offset(55 *SIZE);
        make.top.equalTo(self).offset(209 *SIZE);
        make.right.equalTo(self).offset(-55 *SIZE);
//        make.width.mas_equalTo(SCREEN_Width);
//        make.height.mas_equalTo(SIZE);
//        make.bottom.equalTo(self.contentView).offset(0);
    }];
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(22 *SIZE);
        make.top.equalTo(_whiteView).offset(19 *SIZE);
        make.right.equalTo(_whiteView).offset(-22 *SIZE);
    }];
    
    [_contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(22 *SIZE);
        make.top.equalTo(_titleL.mas_bottom).offset(36 *SIZE);
        make.right.equalTo(_whiteView).offset(-22 *SIZE);
    }];
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(22 *SIZE);
        make.top.equalTo(_contentL.mas_bottom).offset(19 *SIZE);
        make.right.equalTo(_whiteView).offset(-22 *SIZE);
    }];
    
    [_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(0 *SIZE);
        make.top.equalTo(_timeL.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(125 *SIZE);
        make.height.mas_equalTo(40 *SIZE);
        make.bottom.equalTo(_whiteView).offset(0);
    }];
    
    [_nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(125 *SIZE);
        make.top.equalTo(_timeL.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(125 *SIZE);
        make.height.mas_equalTo(40 *SIZE);
        make.bottom.equalTo(_whiteView).offset(0);
    }];
}

@end
