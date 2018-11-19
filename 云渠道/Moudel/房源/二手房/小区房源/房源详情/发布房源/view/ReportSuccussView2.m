//
//  ReportSuccussView2.m
//  云渠道
//
//  Created by 谷治墙 on 2018/9/4.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "ReportSuccussView2.h"

@implementation ReportSuccussView2

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionBackBtn:(UIButton *)btn{
    

    if (self.reportSuccussView2BackBlock) {
        
        [self removeFromSuperview];
        self.reportSuccussView2BackBlock();
    }
}



- (void)initUI{
    
    UIView *alphaView = [[UIView alloc] initWithFrame:self.bounds];
    alphaView.backgroundColor = [UIColor blackColor];
    alphaView.alpha = 0.3;
    [self addSubview:alphaView];
    
    _whiteView = [[UIView alloc] init];
    _whiteView.backgroundColor = CH_COLOR_white;
    _whiteView.layer.cornerRadius = 3 *SIZE;
    _whiteView.clipsToBounds = YES;
    [self addSubview:_whiteView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 19 *SIZE, 250 *SIZE, 15 *SIZE)];
    label.textColor = YJTitleLabColor;
    label.font = [UIFont boldSystemFontOfSize:15 *SIZE];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"报备成功";
    [_whiteView addSubview:label];
    
    for (int i = 0; i < 5; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = YJTitleLabColor;
        label.font = [UIFont systemFontOfSize:11 *SIZE];
        label.numberOfLines = 0;
        switch (i) {
            case 0:
            {
                _comName = label;
                [_whiteView addSubview:_comName];
                break;
            }
            case 1:
            {
                _houseL = label;
                [_whiteView addSubview:_houseL];
                break;
            }
            case 2:
            {
                _contactL = label;
                [_whiteView addSubview:_contactL];
                break;
            }
            case 3:
            {
                _phoneL = label;
                [_whiteView addSubview:_phoneL];
                break;
            }
            case 4:
            {
                _timeL = label;
                [_whiteView addSubview:_timeL];
                break;
            }
            default:
                break;
        }
    }
    
    _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _backBtn.titleLabel.font = [UIFont systemFontOfSize:13 *sIZE];
    [_backBtn addTarget:self action:@selector(ActionBackBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_backBtn setTitle:@"知道了" forState:UIControlStateNormal];
    [_backBtn setTitleColor:YJ86Color forState:UIControlStateNormal];
    [_backBtn setBackgroundColor:YJBackColor];
    [_whiteView addSubview:_backBtn];

    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(55 *SIZE);
        make.center.equalTo(self);
        make.width.mas_equalTo(250 *SIZE);
    }];
    
    [_comName mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(21 *SIZE);
        make.top.equalTo(_whiteView).offset(60 *SIZE);
        make.right.equalTo(_whiteView).offset(-21 *SIZE);
    }];
    
    [_houseL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(21 *SIZE);
        make.top.equalTo(_comName.mas_bottom).offset(14 *SIZE);
        make.right.equalTo(_whiteView).offset(-21 *SIZE);
    }];
    
    [_contactL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(21 *SIZE);
        make.top.equalTo(_houseL.mas_bottom).offset(14 *SIZE);
        make.right.equalTo(_whiteView).offset(-21 *SIZE);
    }];
    
    [_phoneL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(21 *SIZE);
        make.top.equalTo(_contactL.mas_bottom).offset(14 *SIZE);
        make.right.equalTo(_whiteView).offset(-21 *SIZE);
    }];
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(21 *SIZE);
        make.top.equalTo(_phoneL.mas_bottom).offset(14 *SIZE);
        make.right.equalTo(_whiteView).offset(-21 *SIZE);
    }];
    
    [_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(0 *SIZE);
        make.top.equalTo(_timeL.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(250 *SIZE);
        make.height.mas_equalTo(40 *SIZE);
        make.bottom.equalTo(_whiteView).offset(0 *SIZE);
    }];

}

@end
