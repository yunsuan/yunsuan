//
//  RoomAgencyAddProtocolCell4.m
//  云渠道
//
//  Created by 谷治墙 on 2018/6/26.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RoomAgencyAddProtocolCell4.h"

@interface RoomAgencyAddProtocolCell4 ()<UITextFieldDelegate>
{
    
    NSArray *_titleArr;
}

@end

@implementation RoomAgencyAddProtocolCell4

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)TextFieldDidChange:(UITextField *)textField{
    
//    _commisionTF.textfield.text = [NSString stringWithFormat:@"%ld",[_priceTF.textfield.text integerValue] * 10000 / 100 * self.ratio];
}

- (void)ActionPayBtn:(UIButton *)btn{
    
    if (self.roomAgencyAddProtocolCell4PayBlock) {
        
        self.roomAgencyAddProtocolCell4PayBlock();
    }
}

- (void)ActionTimeBtn:(UIButton *)btn{
    
    if (self.roomAgencyAddProtocolCell4TimeBlock) {
        
        self.roomAgencyAddProtocolCell4TimeBlock();
    }
}

- (void)setTradeDic:(NSMutableDictionary *)tradeDic{
    
    _priceTF.textfield.text = tradeDic[@"total_price"];
    _sincerityTF.textfield.text = tradeDic[@"earnest_money"];
    _breachTF.textfield.text = tradeDic[@"break_money"];
    if (tradeDic[@"broker_ratio"]) {
        
        _commisionTF.textfield.text = [NSString stringWithFormat:@"%@%@",tradeDic[@"broker_ratio"],@"%"];
    }else{
        
        _commisionTF.textfield.text = @"0%";
    }
    
    
    _payWayBtn.content.text = tradeDic[@"pay_way_name"];
    _signTimeBtn.content.text = tradeDic[@"appoint_construct_time"];
    _eventTV.text = tradeDic[@""];
}

- (void)initUI{
    
    self.contentView.backgroundColor = CH_COLOR_white;
    _titleArr = @[@"交易总价：",@"诚意金：",@"违约金：",@"佣金：",@"付款方式：",@"约定签约时间：",@"约定事项："];
    
    for (int i = 0; i < 6; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = YJTitleLabColor;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        label.text = _titleArr[i];
        label.adjustsFontSizeToFitWidth = YES;
//        [self.contentView addSubview:label];
        
        BorderTF *textField = [[BorderTF alloc] initWithFrame:CGRectMake(81 *SIZE, 47 *SIZE + i * 54 *SIZE, 257 *SIZE, 33 *SIZE)];
        switch (i) {
            case 0:
            {
                _priceL = label;
                [self.contentView addSubview:_priceL];
                textField.textfield.delegate = self;
                _priceTF = textField;
                _priceTF.unitL.text = @"万";
                [self.contentView addSubview:_priceTF];
                break;
            }
            case 1:
            {
                _sincerityL = label;
                [self.contentView addSubview:_sincerityL];
                _sincerityTF = textField;
                _sincerityTF.unitL.text = @"元";
                [self.contentView addSubview:_sincerityTF];
                break;
            }
            case 2:
            {
                _breachL = label;
                [self.contentView addSubview:_breachL];
                _breachTF = textField;
                _breachTF.unitL.text = @"元";
                [self.contentView addSubview:_breachTF];
                break;
            }
            case 3:
            {
                _commisionL = label;
                [self.contentView addSubview:_commisionL];
                _commisionTF = textField;
//                _commisionTF.unitL.text = @"元";
                _commisionTF.textfield.userInteractionEnabled = NO;
//                _commisionTF.textfield.placeholder = @"自动生成";
                [self.contentView addSubview:_commisionTF];
                break;
            }
            case 4:
            {
                _payWayL = label;
                [self.contentView addSubview:_payWayL];
                _payWayBtn = [[DropDownBtn alloc] initWithFrame:textField.frame];
                [_payWayBtn addTarget:self action:@selector(ActionPayBtn:) forControlEvents:UIControlEventTouchUpInside];
                [self.contentView addSubview:_payWayBtn];
                break;
            }
            case 5:
            {
                _signTimeL = label;
                [self.contentView addSubview:_signTimeL];
                _signTimeBtn = [[DropDownBtn alloc] initWithFrame:textField.frame];
                [_signTimeBtn addTarget:self action:@selector(ActionTimeBtn:) forControlEvents:UIControlEventTouchUpInside];
                [self.contentView addSubview:_signTimeBtn];
                break;
            }
            default:
                break;
        }
    }
    
    _eventL = [[UILabel alloc] init];
    _eventL.textColor = YJTitleLabColor;
    _eventL.font = [UIFont systemFontOfSize:13 *SIZE];
    _eventL.text = @"约定事项：";
    _eventL.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:_eventL];
    
    _eventTV = [[UITextView alloc] init];
    _eventTV.layer.cornerRadius = 5 *SIZE;
    _eventTV.layer.borderColor = COLOR(219, 219, 219, 1).CGColor;
    _eventTV.layer.borderWidth = SIZE;
    _eventTV.clipsToBounds = YES;
    [self.contentView addSubview:_eventTV];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TextFieldDidChange:) name:UITextFieldTextDidChangeNotification object:_priceTF.textfield];
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(self.contentView).offset(18 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_priceTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(81 *SIZE);
        make.top.equalTo(self.contentView).offset(7 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
        //        make.bottom.equalTo(self.contentView).offset(-20 *SIZE);
    }];
    
    [_sincerityL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(_priceTF.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_sincerityTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(81 *SIZE);
        make.top.equalTo(_priceTF.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
        //        make.bottom.equalTo(self.contentView).offset(-20 *SIZE);
    }];
    
    [_breachL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(_sincerityTF.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_breachTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(81 *SIZE);
        make.top.equalTo(_sincerityTF.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
        //        make.bottom.equalTo(self.contentView).offset(-20 *SIZE);
    }];
    
    [_commisionL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(_breachTF.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_commisionTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(81 *SIZE);
        make.top.equalTo(_breachTF.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
        //        make.bottom.equalTo(self.contentView).offset(-20 *SIZE);
    }];
    
    [_payWayL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(_commisionTF.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_payWayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(81 *SIZE);
        make.top.equalTo(_commisionTF.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
        //        make.bottom.equalTo(self.contentView).offset(-20 *SIZE);
    }];
    
    [_signTimeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(_payWayBtn.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_signTimeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(81 *SIZE);
        make.top.equalTo(_payWayBtn.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
//        make.bottom.equalTo(self.contentView).offset(-20 *SIZE);
    }];
    
    [_eventL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(_signTimeBtn.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_eventTV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(81 *SIZE);
        make.top.equalTo(_signTimeBtn.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(77 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-20 *SIZE);
    }];
}

@end
