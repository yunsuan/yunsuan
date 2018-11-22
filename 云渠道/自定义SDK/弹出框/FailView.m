//
//  FailView.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/10.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "FailView.h"

@implementation FailView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionBackBtn:(UIButton *)btn{
    
    [self removeFromSuperview];
}

- (void)initUI{
    
    UIView *alphaView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    alphaView.backgroundColor = [UIColor blackColor];
    alphaView.alpha = 0.4;
    [self addSubview:alphaView];
    
    _whiteView = [[UIView alloc] initWithFrame:CGRectMake(55 *SIZE, 230 *SIZE, 250 *SIZE, 197 *SIZE)];
    _whiteView.backgroundColor = [UIColor whiteColor];
    _whiteView.layer.cornerRadius = 3 *SIZE;
    _whiteView.clipsToBounds = YES;
    [self addSubview:_whiteView];
    
    _statusL = [[UILabel alloc] initWithFrame:CGRectMake(0, 18 *SIZE, 250 *SIZE, 16 *SIZE)];
    _statusL.textColor = YJTitleLabColor;
    _statusL.font = [UIFont systemFontOfSize:17 *SIZE];
    _statusL.textAlignment = NSTextAlignmentCenter;
    _statusL.text = @"推荐失败";
    [_whiteView addSubview:_statusL];
    
    for (int i = 0; i < 2; i++) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(22 *SIZE, 69 *SIZE , 196 *SIZE, 13 *SIZE)];
        label.textColor = YJContentLabColor;
        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        switch (i) {
            case 0:
            {
                _reasonL = label;
                _reasonL.textColor = YJTitleLabColor;
                [_whiteView addSubview:_reasonL];
                break;
            }
            case 1:
            {
                _timeL = label;
                _timeL.font = [UIFont systemFontOfSize:13 *SIZE];
                [_whiteView addSubview:_timeL];
                break;
            }
            default:
                break;
        }
    }
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.bounds = CGRectMake(42 *SIZE, 136 *SIZE, 167 *SIZE, 37 *SIZE);
    btn.titleLabel.font = [UIFont systemFontOfSize:13 *SIZE];
    _backBtn = btn;
    [_backBtn addTarget:self action:@selector(ActionBackBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_backBtn setBackgroundColor:YJBlueBtnColor];
    [_backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [_backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _backBtn.layer.cornerRadius = 2 *SIZE;
    _backBtn.clipsToBounds = YES;
    [_whiteView addSubview:_backBtn];
    
    [self masonryUI];
}

- (void)masonryUI{
    
    [_whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(55 *SIZE);
        make.top.equalTo(self).offset(154 *SIZE);
        make.right.equalTo(self).offset(-55 *SIZE);
    }];
    
    [_reasonL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(22 *SIZE);
        make.top.equalTo(_whiteView).offset(69 *SIZE);
        make.right.equalTo(_whiteView).offset(-22 *SIZE);
    }];
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(22 *SIZE);
        make.top.equalTo(_reasonL.mas_bottom).offset(12 *SIZE);
        make.right.equalTo(_whiteView).offset(-22 *SIZE);
    }];
    [_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(42 *SIZE);
        make.top.equalTo(_timeL.mas_bottom).offset(31 *SIZE);
        make.right.equalTo(_whiteView).offset(-42 *SIZE);
        make.height.equalTo(@(37 *SIZE));
        make.bottom.equalTo(_whiteView.mas_bottom).offset(-24 *SIZE);
    }];
}

@end
