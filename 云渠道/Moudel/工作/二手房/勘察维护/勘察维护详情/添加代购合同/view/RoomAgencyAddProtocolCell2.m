//
//  RoomAgencyAddProtocolCell2.m
//  云渠道
//
//  Created by 谷治墙 on 2018/6/26.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RoomAgencyAddProtocolCell2.h"

@interface RoomAgencyAddProtocolCell2()
{
    
    NSArray *_titleArr;
}


@end

@implementation RoomAgencyAddProtocolCell2

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionSexBtn:(UIButton *)btn{
    
    if (self.roomAgencyAddProtocolCell2SexBlock) {
        
        self.roomAgencyAddProtocolCell2SexBlock(self.tag);
    }
}

- (void)ActionTimeBtn:(UIButton *)btn{
    
    if (self.roomAgencyAddProtocolCell2TimeBlock) {
        
        self.roomAgencyAddProtocolCell2TimeBlock(self.tag);
    }
}

-(void)setDataByDic:(NSDictionary *)dic
{
    
    if (dic.count) {
        
        _nameTF.textfield.text = dic[@"agent_name"];
//        _nameTF.textfield.text = dic[@"name"];
        if ([dic[@"sex"] integerValue] == 1) {
            
            _genderTF.content.text = @"男";
        }else if ([dic[@"sex"] integerValue] == 2){
            
            _genderTF.content.text = @"女";
        }else{
            
            _genderTF.content.text = @"";
        }
        _phoneTF.textfield.text = dic[@"agent_tel"];
        _conpanyTF.textfield.text = dic[@"company_name"];
        _storeTF.textfield.text = dic[@"store_name"];
        _addressTF.textfield.text = dic[@"address"];
        _timeBtn.content.text = dic[@"regist_time"];
        _timeBtn->str = dic[@"regist_time"];
    }else{
        
        _nameTF.textfield.text = @"";
        _phoneTF.textfield.text = @"";
        _genderTF.content.text = @"";
        _conpanyTF.textfield.text = @"";
        _storeTF.textfield.text = @"";
        _addressTF.textfield.text = @"";
    }
}

- (void)initUI{
    
    self.contentView.backgroundColor = CH_COLOR_white;
    
    _titleArr = @[@"经办人名称：",@"联系电话",@"门店名称：",@"门店地址：",@"登记日期：",@"性别：",@"公司名称："];
    
    for (int i = 0; i < 7; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = YJTitleLabColor;
        label.text = _titleArr[i];
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        label.adjustsFontSizeToFitWidth = YES;
        //        [self.contentView addSubview:label];
        
        BorderTF *textField = [[BorderTF alloc] initWithFrame:CGRectMake(81 *SIZE, 47 *SIZE, 257 *SIZE, 33 *SIZE)];
//        textField.userInteractionEnabled = NO;
        switch (i) {
            case 0:
            {
                _nameL = label;
                [self.contentView addSubview:_nameL];
                _nameTF = textField;
                [self.contentView addSubview:_nameTF];
                break;
            }
            case 1:
            {
                _phoneL = label;
                [self.contentView addSubview:_phoneL];
                _phoneTF = textField;
                [self.contentView addSubview:_phoneTF];
                break;
            }
            case 2:
            {
                _storeL = label;
                [self.contentView addSubview:_storeL];
                _storeTF = textField;
                _storeTF.backgroundColor = YJBackColor;
                _storeTF.userInteractionEnabled = NO;
                [self.contentView addSubview:_storeTF];
                break;
            }
            case 3:
            {
                _addressL = label;
                [self.contentView addSubview:_addressL];
                _addressTF = textField;
                _addressTF.backgroundColor = YJBackColor;
                _addressTF.userInteractionEnabled = NO;
                [self.contentView addSubview:_addressTF];
                break;
            }
            case 4:
            {
                _timeL = label;
                [self.contentView addSubview:_timeL];
                _timeBtn = [[DropDownBtn alloc] initWithFrame:textField.frame];
                [_timeBtn addTarget:self action:@selector(ActionTimeBtn:) forControlEvents:UIControlEventTouchUpInside];
//                _timeBtn.userInteractionEnabled = NO;
//                _timeBtn.backgroundColor = YJBackColor;
//                _addressTF.userInteractionEnabled = NO;
                [self.contentView addSubview:_timeBtn];
                break;
            }
            case 5:
            {
                _genderL = label;
                [self.contentView addSubview:_genderL];
                _genderTF = [[DropDownBtn alloc] initWithFrame:textField.frame];
                [_genderTF addTarget:self action:@selector(ActionSexBtn:) forControlEvents:UIControlEventTouchUpInside];
                [self.contentView addSubview:_genderTF];
                break;
            }
            case 6:
            {
                _companyL = label;
                [self.contentView addSubview:_companyL];
                _conpanyTF = textField;
                _conpanyTF.backgroundColor = YJBackColor;
                _conpanyTF.userInteractionEnabled = NO;
                [self.contentView addSubview:_conpanyTF];
                break;
            }
            default:
                break;
        }
    }
    
    [self masonryUI];
}


- (void)masonryUI{
    
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(self.contentView).offset(18 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_nameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(81 *SIZE);
        make.top.equalTo(self.contentView).offset(7 *SIZE);
        make.width.mas_equalTo(117 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_genderL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(208 *SIZE);
        make.top.equalTo(self.contentView).offset(18 *SIZE);
        make.width.mas_equalTo(50 *SIZE);
    }];
    
    [_genderTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(251 *SIZE);
        make.top.equalTo(self.contentView).offset(7 *SIZE);
        make.width.mas_equalTo(87 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_phoneL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(_nameTF.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(81 *SIZE);
        make.top.equalTo(_nameTF.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_companyL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(_phoneTF.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_conpanyTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(81 *SIZE);
        make.top.equalTo(_phoneTF.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_storeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(_conpanyTF.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_storeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(81 *SIZE);
        make.top.equalTo(_conpanyTF.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
        //        make.bottom.equalTo(self.contentView).offset(-20 *SIZE);
    }];
    
    [_addressL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(_storeTF.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_addressTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(81 *SIZE);
        make.top.equalTo(_storeTF.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
        //        make.bottom.equalTo(self.contentView).offset(-20 *SIZE);
    }];
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(_addressTF.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_timeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(81 *SIZE);
        make.top.equalTo(_addressTF.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-21 *SIZE);
    }];
}


@end
