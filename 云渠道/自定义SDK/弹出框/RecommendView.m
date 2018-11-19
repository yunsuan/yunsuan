//
//  RecommendView.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/10.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RecommendView.h"

@implementation RecommendView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionTranmitBtn:(UIButton *)btn{
    
    if (self.tranmitBtnBlock) {
        
        self.tranmitBtnBlock();
    }
}

- (void)ActionConfirmBtn:(UIButton *)btn{
    
    if (self.recommendViewConfirmBlock) {
        
        self.recommendViewConfirmBlock();
    }
    [self removeFromSuperview];
}

- (void)initUI{
    
    UIView *alphaView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    alphaView.backgroundColor = [UIColor blackColor];
    alphaView.alpha = 0.4;
    [self addSubview:alphaView];
    
    _whiteView = [[UIView alloc] initWithFrame:CGRectMake(55 *SIZE, 154 *SIZE, 250 *SIZE, 331 *SIZE)];
    _whiteView.backgroundColor = CH_COLOR_white;
    [self addSubview:_whiteView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 18 *SIZE, 250 *SIZE, 16 *SIZE)];
    label.textColor = YJTitleLabColor;
    label.font = [UIFont systemFontOfSize:17 *SIZE];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"推荐成功";
    [_whiteView addSubview:label];
    
    for (int i = 0; i < 7; i++) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(28 *SIZE, 62 *SIZE + i * 32 *SIZE, 204 *SIZE, 13 *SIZE)];
        label.textColor = YJContentLabColor;
        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        switch (i) {
            case 0:
            {
                _codeL = label;
                [_whiteView addSubview:_codeL];
                break;
            }
            case 1:
            {
                _nameL = label;
                [_whiteView addSubview:_nameL];
                break;
            }
            case 2:
            {
                _projectL = label;
                [_whiteView addSubview:_projectL];
                break;
            }
            case 3:
            {
                _addressL = label;
                [_whiteView addSubview:_addressL];
                break;
            }
            case 4:
            {
//                _contactL = label;
//                [_whiteView addSubview:_contactL];
                break;
            }
            case 5:
            {
//                _phoneL = label;
//                [_whiteView addSubview:_phoneL];
                break;
            }
            case 6:
            {
                _timeL = label;
                _timeL.textColor = COLOR(255, 165, 29, 1);
                [_whiteView addSubview:_timeL];
                break;
            }
            default:
                break;
        }
        
        if (i < 2) {
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.bounds = CGRectMake(0, 0, 125 *SIZE, 40 *SIZE);
            btn.titleLabel.font = [UIFont systemFontOfSize:13 *sIZE];
            if (i == 0) {
                
                _tranmitBtn = btn;
                [_tranmitBtn addTarget:self action:@selector(ActionTranmitBtn:) forControlEvents:UIControlEventTouchUpInside];
                [_tranmitBtn setBackgroundColor:COLOR(238, 238, 238, 1)];
                [_tranmitBtn setTitle:@"转发" forState:UIControlStateNormal];
                [_tranmitBtn setTitleColor:YJTitleLabColor forState:UIControlStateNormal];
                [_whiteView addSubview:_tranmitBtn];
            }else{
                
                _confirmBtn = btn;
                [_confirmBtn addTarget:self action:@selector(ActionConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
                [_confirmBtn setBackgroundColor:YJBlueBtnColor];
                [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
                [_confirmBtn setTitleColor:CH_COLOR_white forState:UIControlStateNormal];
                [_whiteView addSubview:_confirmBtn];
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
    
    [_codeL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_whiteView).offset(28 *SIZE);
        make.top.equalTo(_whiteView).offset(62 *SIZE);
        make.right.equalTo(_whiteView).offset(-15 *SIZE);
    }];
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(28 *SIZE);
        make.top.equalTo(_codeL.mas_bottom).offset(19 *SIZE);
        make.right.equalTo(_whiteView).offset(-15 *SIZE);
    }];
    [_projectL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(28 *SIZE);
        make.top.equalTo(_nameL.mas_bottom).offset(19 *SIZE);
        make.right.equalTo(_whiteView).offset(-15 *SIZE);
    }];
    [_addressL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(28 *SIZE);
        make.top.equalTo(_projectL.mas_bottom).offset(19 *SIZE);
        make.right.equalTo(_whiteView).offset(-15 *SIZE);
    }];

    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(28 *SIZE);
        make.top.equalTo(_addressL.mas_bottom).offset(19 *SIZE);
        make.right.equalTo(_whiteView).offset(-15 *SIZE);
    }];
    [_tranmitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(0 *SIZE);
        make.top.equalTo(_timeL.mas_bottom).offset(28 *SIZE);
        make.width.equalTo(@(125 *SIZE));
        make.height.equalTo(@(40 *SIZE));
        make.bottom.equalTo(_whiteView).offset(0);
    }];
    [_confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(125 *SIZE);
        make.top.equalTo(_timeL.mas_bottom).offset(28 *SIZE);
        make.width.equalTo(@(125 *SIZE));
        make.height.equalTo(@(40 *SIZE));
        make.bottom.equalTo(_whiteView).offset(0);
    }];
}

@end
