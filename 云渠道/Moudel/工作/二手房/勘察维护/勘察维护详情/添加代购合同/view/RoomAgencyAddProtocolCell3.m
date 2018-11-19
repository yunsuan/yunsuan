//
//  RoomAgencyAddProtocolCell3.m
//  云渠道
//
//  Created by 谷治墙 on 2018/6/26.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RoomAgencyAddProtocolCell3.h"

@interface RoomAgencyAddProtocolCell3()
{
    
    NSArray *_titleArr;
}

@end

@implementation RoomAgencyAddProtocolCell3

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    self.contentView.backgroundColor = CH_COLOR_white;
    
    _titleArr = @[@"房源编号：",@"所属小区：",@"房号：",@"产权面积：",@"产权编号：",@"国土使用证号：",@"物业类型：",@"户型："];
    
    for (int i = 0; i < 8; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = YJTitleLabColor;
        label.text = _titleArr[i];
        label.adjustsFontSizeToFitWidth = YES;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        
        BorderTF *textField = [[BorderTF alloc] initWithFrame:CGRectMake(81 *SIZE, 47 *SIZE, 257 *SIZE, 33 *SIZE)];
        textField.userInteractionEnabled = NO;
        textField.backgroundColor = COLOR(238, 238, 238, 1);
        textField.textfield.placeholder = @"自动生成";
        switch (i) {
            case 0:
            {
                _codeL = label;
                [self.contentView addSubview:_codeL];
                _codeTF = textField;
                [self.contentView addSubview:_codeTF];
                break;
            }
            case 1:
            {
                _addressL = label;
                [self.contentView addSubview:_addressL];
                _addressTF = textField;
                [self.contentView addSubview:_addressTF];
                break;
            }
            case 2:
            {
                _roomNumL = label;
                [self.contentView addSubview:_roomNumL];
                _roomNumTF = textField;
                [self.contentView addSubview:_roomNumTF];
                break;
            }
            case 3:
            {
                _areaL = label;
                [self.contentView addSubview:_areaL];
                _areaTF = textField;
                [self.contentView addSubview:_areaTF];
                break;
            }
            case 4:
            {
                _certNumL = label;
                [self.contentView addSubview:_certNumL];
                _certNumTF = textField;
                _certNumTF.backgroundColor = CH_COLOR_white;
                _certNumTF.textfield.placeholder = @"";
                [self.contentView addSubview:_certNumTF];
                break;
            }
            case 5:
            {
                _homelandL = label;
                [self.contentView addSubview:_homelandL];
                _homelandTF = textField;
                _homelandTF.userInteractionEnabled = YES;
                _homelandTF.backgroundColor = CH_COLOR_white;
                _homelandTF.textfield.placeholder = @"";
                [self.contentView addSubview:_homelandTF];
                break;
            }
            case 6:
            {
                _propertyL = label;
                [self.contentView addSubview:_propertyL];
                _propertyTF = textField;
                [self.contentView addSubview:_propertyTF];
                break;
            }
            case 7:
            {
                _houseTypeL = label;
                [self.contentView addSubview:_houseTypeL];
                _houseTypeTF = textField;
                [self.contentView addSubview:_houseTypeTF];
                break;
            }
            default:
                break;
        }
    }
    
    _addressTV = [[UITextView alloc] init];
    _addressTV.layer.cornerRadius = 5 *SIZE;
    _addressTV.layer.borderColor = COLOR(219, 219, 219, 1).CGColor;
    _addressTV.layer.borderWidth = SIZE;
    _addressTV.userInteractionEnabled = NO;
    _addressTV.clipsToBounds = YES;
    _addressTV.backgroundColor = COLOR(238, 238, 238, 1);
    [self.contentView addSubview:_addressTV];
    
    _changeRoom = [UIButton buttonWithType:UIButtonTypeCustom];
    _changeRoom.layer.cornerRadius = 5*SIZE;
    [_changeRoom setImage:[UIImage imageNamed:@"add_2"] forState:UIControlStateNormal];
    [_changeRoom addTarget:self action:@selector(action_change) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_changeRoom];
    [self masonryUI];
}

- (void)masonryUI{

    [_changeRoom mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-22 *SIZE);
        make.top.equalTo(self.contentView).offset(7 *SIZE);
        make.width.mas_equalTo(33 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_codeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(self.contentView).offset(18 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_codeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(81 *SIZE);
        make.top.equalTo(self.contentView).offset(7 *SIZE);
        make.width.mas_equalTo(224 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
        //        make.bottom.equalTo(self.contentView).offset(-20 *SIZE);
    }];
    
    [_addressL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(_codeTF.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_addressTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(81 *SIZE);
        make.top.equalTo(_codeTF.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
        //        make.bottom.equalTo(self.contentView).offset(-20   *SIZE);
    }];
    
    [_addressTV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(81 *SIZE);
        make.top.equalTo(_addressTF.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(77 *SIZE);
        //        make.bottom.equalTo(self.contentView).offset(-20 *SIZE);
    }];
    
    [_propertyL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(_addressTV.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_propertyTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(81 *SIZE);
        make.top.equalTo(_addressTV.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
        //        make.bottom.equalTo(self.contentView).offset(-20 *SIZE);
    }];
    
    [_roomNumL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(_propertyTF.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_roomNumTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(81 *SIZE);
        make.top.equalTo(_propertyTF.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
        //        make.bottom.equalTo(self.contentView).offset(-20 *SIZE);
    }];
    
    [_houseTypeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(_roomNumTF.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_houseTypeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(81 *SIZE);
        make.top.equalTo(_roomNumTF.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
        //        make.bottom.equalTo(self.contentView).offset(-20 *SIZE);
    }];
    
    [_areaL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(_houseTypeTF.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_areaTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(81 *SIZE);
        make.top.equalTo(_houseTypeTF.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
        //        make.bottom.equalTo(self.contentView).offset(-20 *SIZE);
    }];
    
    [_certNumL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(_areaTF.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_certNumTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(81 *SIZE);
        make.top.equalTo(_areaTF.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
        //        make.bottom.equalTo(self.contentView).offset(-20 *SIZE);
    }];
    
    [_homelandL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(_certNumTF.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_homelandTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(81 *SIZE);
        make.top.equalTo(_certNumTF.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-21 *SIZE);
    }];
//    [_changeRoom mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self.contentView).offset(80 *SIZE);
//        make.top.equalTo(_homelandTF.mas_bottom).offset(20 *SIZE);
//        make.width.mas_equalTo(200 *SIZE);
//        make.height.mas_equalTo(33 *SIZE);
//        make.bottom.equalTo(self.contentView).offset(-21 *SIZE);
//    }];
}

-(void)action_change
{
    if (self.changeblock) {
        self.changeblock();
    }
}

-(void)setDataByDic:(NSDictionary *)dic
{
    if (dic.count>0) {
        
        _codeTF.textfield.text = dic[@"house_code"];
        _addressTF.textfield.text = dic[@"project_name"];
        _addressTV.text = dic[@"absolute_address"];
        _propertyTF.textfield.text = dic[@"property_type"];
        _roomNumTF.textfield.text = dic[@"house_name"];
        _houseTypeTF.textfield.text = dic[@"house_type"];
        _areaTF.textfield.text = [NSString stringWithFormat:@"%@",dic[@"build_area"]];
        _certNumTF.textfield.text = [NSString stringWithFormat:@"%@",dic[@"permit_code"]];
        if (dic[@"land_use_permit_code"]) {
            
            _homelandTF.textfield.text = [NSString stringWithFormat:@"%@",dic[@"land_use_permit_code"]];
        }
    }else{
        
        _codeTF.textfield.text = @"";
        _addressTF.textfield.text = @"";
        _addressTV.text = @"";
        _houseTypeTF.textfield.text = @"";
        _propertyTF.textfield.text = @"";
        _roomNumTF.textfield.text = @"";
        _areaTF.textfield.text = @"";
        _certNumTF.textfield.text = @"";
        _homelandTF.textfield.text = @"";
    }
}

@end
