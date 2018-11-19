
//
//  AgencyDoneHeader.m
//  云渠道
//
//  Created by 谷治墙 on 2018/6/21.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "AgencyDoneHeader.h"

@interface AgencyDoneHeader()
{
    
    NSArray *_titleArr;
}

@end

@implementation AgencyDoneHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionTagBtn:(UIButton *)btn{
    
    if (self.agencyDoneHeaderBlock) {
        
        self.agencyDoneHeaderBlock(btn.tag);
    }
}

- (void)ActionEditBtn:(UIButton *)btn{
    
    if (self.agencyEditHeaderBlock) {
        
        self.agencyEditHeaderBlock();
    }
}

- (void)initUI{
    
    self.contentView.backgroundColor = YJBackColor;
    
    _titleArr = @[@"客户信息",@"经办人信息",@"房源信息"];
    
    _titleView = [[UIView alloc] init];
    _titleView.backgroundColor = CH_COLOR_white;
    [self.contentView addSubview:_titleView];
    
    for (int i = 0; i < 6; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = YJ86Color;
        label.font = [UIFont systemFontOfSize:11 *SIZE];
        switch (i) {
            case 0:
            {
                label.textColor = YJTitleLabColor;
                label.font = [UIFont systemFontOfSize:13 *SIZE];
                _roomCodeL = label;
                [_titleView addSubview:_roomCodeL];
                break;
            }
            case 1:
            {
                label.textColor = YJTitleLabColor;
                label.font = [UIFont systemFontOfSize:13 *SIZE];
                _tradeCodeL = label;
                [_titleView addSubview:_tradeCodeL];
                break;
            }
            case 2:
            {
                label.textColor = CH_COLOR_white;
                label.backgroundColor = YJBlueBtnColor;
                label.layer.cornerRadius = 2 *SIZE;
                label.clipsToBounds = YES;
                label.textAlignment = NSTextAlignmentCenter;
                _validL = label;
                [_titleView addSubview:_validL];
                break;
            }
            case 3:
            {
                label.textColor = CH_COLOR_white;
                label.backgroundColor = COLOR(27, 152, 255, 0.4);
                label.layer.cornerRadius = 2 *SIZE;
                label.clipsToBounds = YES;
                label.textAlignment = NSTextAlignmentCenter;
                _auditL = label;
                [_titleView addSubview:_auditL];
                break;
            }
            case 4:
            {
                label.textColor = CH_COLOR_white;
                label.backgroundColor = COLOR(220, 220, 220, 1);
                label.layer.cornerRadius = 2 *SIZE;
                label.clipsToBounds = YES;
                label.textAlignment = NSTextAlignmentCenter;
                _payL = label;
                [_titleView addSubview:_payL];
                break;
            }
            case 5:
            {
//                _recommendL = label;
//                [_titleView addSubview:_recommendL];
                break;
            }
            default:
                break;
        }
    }
    
    _tradeView = [[UIView alloc] init];
    _tradeView.backgroundColor = CH_COLOR_white;
    [self.contentView addSubview:_tradeView];
    
    _blueView = [[UIView alloc] init];
    _blueView.backgroundColor = YJBlueBtnColor;
    [_tradeView addSubview:_blueView];
    
    _editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _editBtn.frame = CGRectMake(327 *SIZE, 11 *SIZE, 26 *SIZE, 26 *SIZE);
    [_editBtn addTarget:self action:@selector(ActionEditBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_editBtn setImage:[UIImage imageNamed:@"edit"] forState:UIControlStateNormal];
    [_tradeView addSubview:_editBtn];
    
    
    for ( int i = 0; i < 9; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = YJContentLabColor;
        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
    
        switch (i) {
            case 0:
            {
                label.textColor = YJTitleLabColor;
                label.font = [UIFont systemFontOfSize:15 *SIZE];
                _titleL = label;
                _titleL.text = @"交易信息";
                [_tradeView addSubview:_titleL];
                break;
            }
            case 1:
            {
                _priceL = label;
                [_tradeView addSubview:_priceL];
                break;
            }
            case 2:
            {
                _SincertyGoldL = label;
                [_tradeView addSubview:_SincertyGoldL];
                break;
            }
            case 3:
            {
                _breachL = label;
                [_tradeView addSubview:_breachL];
                break;
            }
            case 4:
            {
                _commissionL = label;
                [_tradeView addSubview:_commissionL];
                break;
            }
            case 5:
            {
                _payWayL = label;
                [_tradeView addSubview:_payWayL];
                break;
            }
            case 6:
            {
                _timeL = label;
                [_tradeView addSubview:_timeL];
                break;
            }
            case 7:
            {
                _reviewL = label;
                [_tradeView addSubview:_reviewL];
                break;
            }
            case 8:
            {
                _reviewTimeL = label;
                [_tradeView addSubview:_reviewTimeL];
                break;
            }
            default:
                break;
        }
    }
    
    for (int i = 0; i < 3; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.font = [UIFont systemFontOfSize:14 *sIZE];
        //        [btn addTarget:self action:@selector(<#selector#>) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
        [btn setTitle:_titleArr[i] forState:UIControlStateNormal];
        [btn setBackgroundColor:COLOR(219, 219, 219, 1)];
        //        [btn setTitleColor:CH_COLOR_white forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(ActionTagBtn:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:YJ86Color forState:UIControlStateNormal];
        if (i == 0) {
            
            _infoBtn = btn;
            [_tradeView addSubview:_infoBtn];
        }else if (i == 1){
            
            _agentBtn = btn;
            [_tradeView addSubview:_agentBtn];
        }else{
            
            _roomBtn = btn;
            [_tradeView addSubview:_roomBtn];
        }
    }
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(self.contentView).offset(0 *SIZE);
        make.right.equalTo(self.contentView).offset(0 *SIZE);
//        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
    }];
    
    [_roomCodeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_titleView).offset(10 *SIZE);
        make.top.equalTo(_titleView).offset(12 *SIZE);
        make.right.equalTo(_titleView).offset(-10 *SIZE);
    }];
    
    [_tradeCodeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_titleView).offset(10 *SIZE);
        make.top.equalTo(_roomCodeL.mas_bottom).offset(8 *SIZE);
        make.right.equalTo(_titleView).offset(-10 *SIZE);
    }];
    
//    [_recommendL mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(_titleView).offset(10 *SIZE);
//        make.top.equalTo(_tradeCodeL.mas_bottom).offset(8 *SIZE);
//        make.right.equalTo(_titleView).offset(-10 *SIZE);
//    }];
    
    [_validL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_titleView).offset(10 *SIZE);
        make.top.equalTo(_tradeCodeL.mas_bottom).offset(7 *SIZE);
        make.width.mas_equalTo(40 *SIZE);
        make.height.mas_equalTo(17 *SIZE);
        make.bottom.equalTo(_titleView).offset(-13 *SIZE);
    }];
    
    [_auditL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_validL.mas_right).offset(5 *SIZE);
        make.top.equalTo(_tradeCodeL.mas_bottom).offset(7 *SIZE);
        make.width.mas_equalTo(40 *SIZE);
        make.height.mas_equalTo(17 *SIZE);
        make.bottom.equalTo(_titleView).offset(-13 *SIZE);
    }];
    
    [_payL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_auditL.mas_right).offset(5 *SIZE);
        make.top.equalTo(_tradeCodeL.mas_bottom).offset(7 *SIZE);
        make.width.mas_equalTo(40 *SIZE);
        make.height.mas_equalTo(17 *SIZE);
        make.bottom.equalTo(_titleView).offset(-13 *SIZE);
    }];
    
    [_tradeView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(_titleView.mas_bottom).offset(4 *SIZE);
        make.right.equalTo(self.contentView).offset(0 *SIZE);
        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
    }];

    [_blueView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(_tradeView).offset(10 *SIZE);
        make.top.equalTo(_tradeView).offset(19 *SIZE);
        make.width.mas_equalTo(7 *SIZE);
        make.height.mas_equalTo(13 *SIZE);
    }];

    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(_tradeView).offset(28 *SIZE);
        make.top.equalTo(_tradeView).offset(18 *SIZE);
        make.right.equalTo(_tradeView).offset(-28 *SIZE);
    }];

    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(_tradeView).offset(28 *SIZE);
        make.top.equalTo(_titleL.mas_bottom).offset(21 *SIZE);
        make.right.equalTo(_tradeView).offset(-28 *SIZE);
    }];

    [_SincertyGoldL mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(_tradeView).offset(28 *SIZE);
        make.top.equalTo(_priceL.mas_bottom).offset(16 *SIZE);
        make.right.equalTo(_tradeView).offset(-28 *SIZE);
    }];

    [_breachL mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(_tradeView).offset(28 *SIZE);
        make.top.equalTo(_SincertyGoldL.mas_bottom).offset(16 *SIZE);
        make.right.equalTo(_tradeView).offset(-28 *SIZE);
    }];

    [_commissionL mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(_tradeView).offset(28 *SIZE);
        make.top.equalTo(_breachL.mas_bottom).offset(16 *SIZE);
        make.right.equalTo(_tradeView).offset(-28 *SIZE);
    }];

    [_payWayL mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(_tradeView).offset(28 *SIZE);
        make.top.equalTo(_commissionL.mas_bottom).offset(16 *SIZE);
        make.right.equalTo(_tradeView).offset(-28 *SIZE);
    }];

    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(_tradeView).offset(28 *SIZE);
        make.top.equalTo(_payWayL.mas_bottom).offset(16 *SIZE);
        make.right.equalTo(_tradeView).offset(-28 *SIZE);
    }];

    [_reviewL mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(_tradeView).offset(28 *SIZE);
        make.top.equalTo(_timeL.mas_bottom).offset(16 *SIZE);
        make.right.equalTo(_tradeView).offset(-28 *SIZE);
    }];

    [_reviewTimeL mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(_tradeView).offset(28 *SIZE);
        make.top.equalTo(_reviewL.mas_bottom).offset(16 *SIZE);
        make.right.equalTo(_tradeView).offset(-28 *SIZE);
    }];

    [_infoBtn mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(_tradeView).offset(0 *SIZE);
        make.top.equalTo(_reviewTimeL.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(120 *SIZE);
        make.height.mas_equalTo(47 *SIZE);
        make.bottom.equalTo(_tradeView).offset(0 *SIZE);
    }];

    [_agentBtn mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(_tradeView).offset(120 *SIZE);
        make.top.equalTo(_reviewTimeL.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(120 *SIZE);
        make.height.mas_equalTo(47 *SIZE);
        make.bottom.equalTo(_tradeView).offset(0 *SIZE);
    }];

    [_roomBtn mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(_tradeView).offset(240 *SIZE);
        make.top.equalTo(_reviewTimeL.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(120 *SIZE);
        make.height.mas_equalTo(47 *SIZE);
        make.bottom.equalTo(_tradeView).offset(0 *SIZE);
    }];
}

@end
