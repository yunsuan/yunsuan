//
//  UpgradeTipsView.m
//  云渠道
//
//  Created by 谷治墙 on 2019/12/9.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "UpgradeTipsView.h"

@implementation UpgradeTipsView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionComfirmBtn:(UIButton *)btn{
    
    if (self.upgradeTipsViewBlock) {
        
        self.upgradeTipsViewBlock();
    }
//    [self removeFromSuperview];
}

- (void)ActionCancelBtn:(UIButton *)btn{
    
    [self removeFromSuperview];
}

- (void)initUI{
    
    UIView *alphaView = [[UIView alloc] initWithFrame:self.bounds];
    alphaView.backgroundColor = [UIColor blackColor];
    alphaView.alpha = 0.4;
    [self addSubview:alphaView];
    
    _whiteView = [[UIView alloc] init];
    _whiteView.backgroundColor = CLWhiteColor;
    _whiteView.layer.cornerRadius = 10 *SIZE;
    _whiteView.clipsToBounds = YES;
    [self addSubview:_whiteView];
    
    _img = [[UIImageView alloc] init];
    _img.image = [UIImage imageNamed:@"1"];
    [_whiteView addSubview:_img];
    
    _titleL = [[UILabel alloc] init];
    _titleL.textColor = YJTitleLabColor;
    _titleL.adjustsFontSizeToFitWidth = YES;
    _titleL.font = [UIFont boldSystemFontOfSize:16 *SIZE];
    _titleL.textAlignment = NSTextAlignmentCenter;
    _titleL.text = @"发现新版本";
    [_whiteView addSubview:_titleL];
    
    _scroll = [[UIScrollView alloc] init];
    [_whiteView addSubview:_scroll];
    
    _contentL = [[UILabel alloc] init];
    _contentL.textColor = YJContentLabColor;
    _contentL.adjustsFontSizeToFitWidth = YES;
    _contentL.font = [UIFont systemFontOfSize:11 *SIZE];
    _contentL.numberOfLines = 0;
    [_scroll addSubview:_contentL];
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_confirmBtn setBackgroundColor:YJBlueBtnColor];
    [_confirmBtn setTitle:@"立即更新" forState:UIControlStateNormal];
    [_confirmBtn setTitleColor:CLWhiteColor forState:UIControlStateNormal];
    _confirmBtn.layer.cornerRadius = 5 *SIZE;
    _confirmBtn.clipsToBounds = YES;
    [_confirmBtn addTarget:self action:@selector(ActionComfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_whiteView addSubview:_confirmBtn];
    
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cancelBtn setImage:[UIImage imageNamed:@"updateCancel"] forState:UIControlStateNormal];
    [_cancelBtn addTarget:self action:@selector(ActionCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_cancelBtn];
    
    [_whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self).offset(30 *SIZE);
        make.top.equalTo(self).offset(170 *SIZE);
        make.width.mas_equalTo(300 *SIZE);
        make.height.mas_equalTo(260 *SIZE);
    }];
    
    [_img mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_whiteView).offset(116.5 *SIZE);
        make.top.equalTo(_whiteView).offset(15 *SIZE);
        make.width.mas_equalTo(67 *SIZE);
        make.height.mas_equalTo(43 *SIZE);
    }];
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_whiteView).offset(10 *SIZE);
        make.top.equalTo(_whiteView).offset(70 *SIZE);
        make.width.mas_equalTo(280 *SIZE);
    }];
    
    [_scroll mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(45 *SIZE);
        make.top.equalTo(_whiteView).offset(90 *SIZE);
        make.width.mas_equalTo(200 *SIZE);
        make.height.mas_equalTo(80 *SIZE);
    }];
    
    [_contentL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_scroll).offset(0 *SIZE);
        make.top.equalTo(_scroll).offset(10 *SIZE);
        make.width.mas_equalTo(200 *SIZE);
        make.bottom.equalTo(_scroll.mas_bottom).offset(-10 *SIZE);
    }];
    
    [_confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(50 *SIZE);
        make.top.equalTo(_whiteView).offset(200 *SIZE);
        make.width.mas_equalTo(200 *SIZE);
        make.height.mas_equalTo(40 *SIZE);
    }];
    
    [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(160 *SIZE);
        make.top.equalTo(self).offset(450 *SIZE);
        make.width.mas_equalTo(40 *SIZE);
        make.height.mas_equalTo(40 *SIZE);
    }];
}

@end
