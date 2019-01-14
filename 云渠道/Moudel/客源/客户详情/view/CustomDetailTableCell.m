//
//  CustomDetailTableCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/3/22.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "CustomDetailTableCell.h"

@implementation CustomDetailTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setModel:(CustomRequireModel *)model{
    
    _addressL.text = @"";
    _houseTypeL.text = @"";
    _priceL.text = @"";
    _areaL.text = @"";
    _typeL.text = @"";
    _floorL.text = @"";
    _standardL.text = @"";
    _purposeL.text = @"";
    _payWayL.text = @"";
    _intentionL.text = @"";
    _urgentL.text = @"";
    
    
    if (model.region.count) {
        
        for (NSUInteger i = 0; i < model.region.count; i++) {
            
            if (i == 0) {
                
                if ([model.region[i][@"province_name"] length]) {
                    
                    _addressL.text = [NSString stringWithFormat:@"区域：%@",model.region[i][@"province_name"]];
                    
                    if ([model.region[i][@"city_name"] length]) {
                        
                        _addressL.text = [NSString stringWithFormat:@"%@-%@",_addressL.text,model.region[i][@"city_name"]];
                        if ([model.region[i][@"district_name"] length]) {
                            
                            _addressL.text = [NSString stringWithFormat:@"%@-%@",_addressL.text,model.region[i][@"district_name"]];
                        }
                    }
                }else{
                    
                    _addressL.text = @"区域：";
                }
                
            }else{
                
                if ([model.region[i][@"province_name"] length]) {
                    
                    _addressL.text = [NSString stringWithFormat:@"%@ %@",_addressL.text,model.region[i][@"province_name"]];
                    
                    if ([model.region[i][@"city_name"] length]) {
                        
                        _addressL.text = [NSString stringWithFormat:@"%@-%@",_addressL.text,model.region[i][@"city_name"]];
                        if ([model.region[i][@"district_name"] length]) {
                            
                            _addressL.text = [NSString stringWithFormat:@"%@-%@",_addressL.text,model.region[i][@"district_name"]];
                        }
                    }
                }
            }
        }
    }else{
        
        _addressL.text = @"区域：";
    }
    
    
    if (model.total_price.length) {
        
        _priceL.text = [NSString stringWithFormat:@"总价：%@万",model.total_price];
        
    }else{
        
        _priceL.text = @"总价：";
    }
    
    if ([model.area length]) {
        
        _areaL.text = [NSString stringWithFormat:@"面积：%@ ㎡",model.area];
        
    }else{
        
        _areaL.text = @"面积：";
    }
    
    if (model.buy_purpose.length) {
        
        _purposeL.text = [NSString stringWithFormat:@"置业目的：%@",model.buy_purpose];
    }else{
        
        _purposeL.text = @"置业目的：";
    }
    
    if ([self.proType isEqualToString:@"商铺"]) {
        
        if (model.buy_use.length) {
            
            _purposeL.text = [NSString stringWithFormat:@"置业目的：%@",model.buy_use];
        }else{
            
            _purposeL.text = @"置业目的：";
        }
        [_purposeL mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentView).offset(28 *SIZE);
            make.top.equalTo(_typeL.mas_bottom).offset(18 *SIZE);
            make.right.equalTo(self.contentView).offset(-28 *SIZE);
            //            make.bottom.equalTo(_payWayL.mas_top).offset(-18 *SIZE);
        }];
        
        
        if (model.shop_type.count) {
            
            _typeL.text = [NSString stringWithFormat:@"商铺类型：%@",[model.shop_type componentsJoinedByString:@","]];
        }else{
            
            _typeL.text = @"商铺类型：";
        }
        
        
        if (model.pay_type.length) {
            
            _payWayL.text = model.pay_type;
            
        }else{
            
            _payWayL.text = @"付款方式：";
        }
        
        if ([model.intent integerValue]) {
            
            _intentionL.text = [NSString stringWithFormat:@"购房意向度：%@",model.intent];
        }else{
            
            _intentionL.text = @"购房意向度：";
        }
        
        if ([model.urgency integerValue]) {
            
            _urgentL.text = [NSString stringWithFormat:@"购房紧迫度：%@",model.urgency];
        }else{
            
            _urgentL.text = @"购房紧迫度：";
        }
    }else if ([self.proType isEqualToString:@"写字楼"]){
        
        if (model.buy_use.length) {
            
            _purposeL.text = [NSString stringWithFormat:@"置业目的：%@",model.buy_use];
        }else{
            
            _purposeL.text = @"置业目的：";
        }
        
        [_standardL mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentView).offset(28 *SIZE);
            make.top.equalTo(_areaL.mas_bottom).offset(18 *SIZE);
            make.right.equalTo(self.contentView).offset(-28 *SIZE);
        }];
        
        
        if (model.office_level.length) {
            
            _standardL.text = [NSString stringWithFormat:@"级别：%@",model.office_level];
        }else{
            
            _standardL.text = @"级别：";
        }
        
        [_floorL mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentView).offset(28 *SIZE);
            make.top.equalTo(_standardL.mas_bottom).offset(18 *SIZE);
            make.right.equalTo(self.contentView).offset(-28 *SIZE);
        }];
        
        if ([model.used_years integerValue]) {
            
            _floorL.text = [NSString stringWithFormat:@"已使用年限：%@年",model.used_years];
        }else{
            
            _floorL.text = @"已使用年限：";
        }
        
        [_purposeL mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentView).offset(28 *SIZE);
            make.top.equalTo(_floorL.mas_bottom).offset(18 *SIZE);
            make.right.equalTo(self.contentView).offset(-28 *SIZE);
        }];
    }else{
        
        if (model.house_type.length) {
            
            _typeL.text = [NSString stringWithFormat:@"户型：%@",model.house_type];
            
        }else{
            
            _typeL.text = @"户型：";
        }
        
        if ([model.floor_max integerValue] && [model.floor_min integerValue]) {
            
            _floorL.text = [NSString stringWithFormat:@"楼层：%@层-%@层",model.floor_min,model.floor_max];
        }else if (model.floor_min && !model.floor_max){
            
            _floorL.text = [NSString stringWithFormat:@"楼层：%@层以上",model.floor_min];
        }else if (model.floor_max && !model.floor_min){
            
            _floorL.text = [NSString stringWithFormat:@"楼层：%@层以上",model.floor_max];
        }else{
            
            _floorL.text = @"楼层：";
        }
        
        if (model.decorate.length) {
            
            _standardL.text = [NSString stringWithFormat:@"装修标准：%@",model.decorate];
        }else{
            
            _standardL.text = @"装修标准：";
        }
    }
    
    if (model.pay_type.length) {
        
        _payWayL.text = [NSString stringWithFormat:@"付款方式：%@",model.pay_type];
    }else{
        
        _payWayL.text = @"付款方式：";
    }
    
    if ([model.intent integerValue]) {
        
        _intentionL.text = [NSString stringWithFormat:@"购房意向度：%@",model.intent];
    }else{
        
        _intentionL.text = @"购房意向度：";
    }
    
    if ([model.urgency integerValue]) {
        
        _urgentL.text = [NSString stringWithFormat:@"购房紧迫度：%@",model.urgency];
    }else{
        
        _urgentL.text = @"购房紧迫度：";
    }

}

- (void)ActionEditBtn:(UIButton *)btn{
    
    if (self.editBlock) {
        
        self.editBlock(self.tag);
    }
}

- (void)initUI{
    
    for (int i = 0 ; i < 12; i++) {
        
        if (i < 2) {
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(316 *SIZE, 16 *SIZE, 36 *SIZE, 22 *SIZE);
            
            if (i == 0) {
                
                
            }else{
                
                btn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
                [btn setTitle:@"编辑" forState:UIControlStateNormal];
                [btn setTitleColor:COLOR(27, 152, 255, 1) forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(ActionEditBtn:) forControlEvents:UIControlEventTouchUpInside];
                _editBtn = btn;
                [self addSubview:_editBtn];
            }
        }
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = YJTitleLabColor;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        switch (i) {
            case 0:
            {
                _addressL = label;
                _addressL.numberOfLines = 0;
                [self.contentView addSubview:_addressL];
                break;
            }
            case 1:
            {
                _priceL = label;
                [self.contentView addSubview:_priceL];
                break;
            }
            case 2:
            {
                _areaL = label;
                [self.contentView addSubview:_areaL];
                break;
            }
            case 3:
            {
                _typeL = label;
                [self.contentView addSubview:_typeL];
                break;
            }
            case 4:
            {
                _floorL = label;
                [self.contentView addSubview:_floorL];
                break;
            }
            case 5:
            {
                _standardL = label;
                [self.contentView addSubview:_standardL];
                break;
            }
            case 6:
            {
                _purposeL = label;
                [self.contentView addSubview:_purposeL];
                break;
            }
            case 7:
            {
                _payWayL = label;
                [self.contentView addSubview:_payWayL];
                break;
            }
            case 8:
            {
                _intentionL = label;
                [self.contentView addSubview:_intentionL];
                break;
            }
            case 9:
            {
                _urgentL = label;
                [self.contentView addSubview:_urgentL];
                break;
            }
            case 10:
            {
                _houseTypeL = label;
                [self.contentView addSubview:_houseTypeL];
                break;
            }
            default:
                break;
        }
    }
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_addressL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(self.contentView).offset(32 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
    }];

    [_houseTypeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_addressL.mas_bottom).offset(18 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
        make.bottom.equalTo(_priceL.mas_top).offset(-18 *SIZE);
    }];
    
    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_houseTypeL.mas_bottom).offset(18 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
    }];
    
    [_areaL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_priceL.mas_bottom).offset(18 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
    }];
    
    [_typeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_areaL.mas_bottom).offset(18 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
    }];
    
    [_floorL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_typeL.mas_bottom).offset(18 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
    }];
    
    [_standardL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_floorL.mas_bottom).offset(18 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
    }];
    
    [_purposeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_standardL.mas_bottom).offset(18 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
    }];
    
    [_payWayL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_purposeL.mas_bottom).offset(18 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
    }];
    
    [_intentionL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_payWayL.mas_bottom).offset(18 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
    }];
    
    [_urgentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_intentionL.mas_bottom).offset(18 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-17 *SIZE);
    }];
}

@end
