//
//  CustomerTableCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/3/20.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "CustomerTableCell.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wimplicit-int"
@implementation CustomerTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setModel:(CustomerTableModel *)model{
    
    _needTypeL.text = model.client_type;
    
    _typeL.text = @"意向物业：";
    if (model.client_property_type.length) {
        
        _typeL.text = [NSString stringWithFormat:@"意向物业：%@",model.client_property_type];
    }else{
        
        _typeL.text = @"意向物业：";
    }
    if ([model.client_type isEqualToString:@"新房"]) {
        
        _typeL.text = @"意向物业：";
        if (model.property_type.length) {
            
            _typeL.text = [NSString stringWithFormat:@"意向物业：%@",model.property_type];
        }else{
            
            _typeL.text = @"意向物业：";
        }
        _needTypeL.textColor = COLOR(64, 169, 255, 1);
        _needTypeL.backgroundColor = COLOR(213, 242, 255, 1);
    }else if ([model.client_type isEqualToString:@"二手房"]){
        
        _needTypeL.textColor = COLOR(255, 188, 87, 1);
        _needTypeL.backgroundColor = COLOR(255, 237, 211, 1);
    }else{
        
        _needTypeL.textColor = COLOR(36, 185, 195, 1);
        _needTypeL.backgroundColor = COLOR(208, 243, 245, 1);
    }
    if (model.name) {
        
        _nameL.text = model.name;
    }else{
        
        _nameL.text = @"";
    }


    [_nameL mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView.mas_left).offset(10 *SIZE);
        make.top.equalTo(self.contentView.mas_top).offset(14 *SIZE);
        make.width.equalTo(@(_nameL.mj_textWith + 10 *SIZE));
        make.height.equalTo(@(14 *SIZE));
    }];
    
    if (model.total_price.length) {
        
        _priceL.text = [NSString stringWithFormat:@"意向总价：%@ 万",model.total_price];
    }else{
        
        _priceL.text = @"意向总价：";
    }
    
    _areaL.text = @"意向区域：";
    
    if (model.region.count) {
        
        for (int i = 0; i < model.region.count; i++) {
            
            if (i == 0) {
                
                if ([model.region[(NSUInteger) i][@"province_name"] length]) {
                    
                    _areaL.text = [NSString stringWithFormat:@"区域：%@",model.region[(NSUInteger) i][@"province_name"]];
                    
                    if ([model.region[(NSUInteger) i][@"city_name"] length]) {
                        
                        _areaL.text = [NSString stringWithFormat:@"%@-%@",_areaL.text,model.region[(NSUInteger) i][@"city_name"]];
                        if ([model.region[(NSUInteger) i][@"district_name"] length]) {
                            
                            _areaL.text = [NSString stringWithFormat:@"%@-%@",_areaL.text,model.region[(NSUInteger) i][@"district_name"]];
                        }
                    }
                }else{
                    
                    _areaL.text = @"区域：";
                }
                
            }else{
                
                if ([model.region[(NSUInteger) i][@"province_name"] length]) {
                    
                    _areaL.text = [NSString stringWithFormat:@"%@ %@",_areaL.text,model.region[(NSUInteger) i][@"province_name"]];
                    
                    if ([model.region[(NSUInteger) i][@"city_name"] length]) {
                        
                        _areaL.text = [NSString stringWithFormat:@"%@-%@",_areaL.text,model.region[(NSUInteger) i][@"city_name"]];
                        if ([model.region[(NSUInteger) i][@"district_name"] length]) {
                            
                            _areaL.text = [NSString stringWithFormat:@"%@-%@",_areaL.text,model.region[(NSUInteger) i][@"district_name"]];
                        }
                    }
                }
            }
        }
    }else{
        
        _areaL.text = @"区域：";
    }

    
    if (model.tel) {
        
        NSArray *arr = [model.tel componentsSeparatedByString:@","];
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:arr[0]];
        NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)};
        [attr addAttributes:attribtDic range:NSMakeRange(0, attr.length)];
        [attr addAttribute:NSForegroundColorAttributeName value:YJBlueBtnColor range:NSMakeRange(0, attr.length)];
        if ([model.is_hide_tel integerValue]) {
            
            NSMutableAttributedString *Xstr = [[NSMutableAttributedString alloc] initWithString:@"XXXX"];
            [Xstr addAttributes:attribtDic range:NSMakeRange(0, Xstr.length)];
            [Xstr addAttribute:NSForegroundColorAttributeName value:YJBlueBtnColor range:NSMakeRange(0, Xstr.length)];
            [attr replaceCharactersInRange:NSMakeRange(3, 4) withAttributedString:Xstr];
            _phoneL.userInteractionEnabled = NO;
        }else{
            
            _phoneL.userInteractionEnabled = YES;
        }
        _phoneL.attributedText = attr;
    }else{
        
        _phoneL.text = [NSString stringWithFormat:@"%@",model.tel];
    }
    
    
    
    NSMutableAttributedString *intentionStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"购买意向度：%@%%",model.intent]];
    [intentionStr addAttribute:NSForegroundColorAttributeName value:COLOR(255, 165, 29, 1) range:NSMakeRange(6, intentionStr.length - 6)];
    _intentionRateL.attributedText = intentionStr;
    
    NSMutableAttributedString *urgentStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"购买紧迫度：%@%%",model.urgency]];
    [urgentStr addAttribute:NSForegroundColorAttributeName value:COLOR(255, 165, 29, 1) range:NSMakeRange(6, urgentStr.length - 6)];
    _urgentRateL.attributedText = urgentStr;
    
    if ([model.sex integerValue] == 0) {
        
        _gender.image = nil;
    }else if ([model.sex integerValue] == 1){
        
        _gender.image = [UIImage imageNamed:@"man"];
    }else{
        
        _gender.image = [UIImage imageNamed:@"girl"];
    }
}

-(void)tapGesture:(UITapGestureRecognizer *)sender{
    
    if (_phoneL.text.length) {
        
        if (self.customerTableCellPhoneTapBlock) {
            
            self.customerTableCellPhoneTapBlock(_phoneL.text);
        }
    }else{
        
//        NSLog(@"没有电话号码");
    }
}

- (void)initUI{
    
    _needTypeL = [[UILabel alloc] init];
//    _needTypeL.textColor = <#UIColor#>;
    _needTypeL.font = [UIFont systemFontOfSize:10 *SIZE];
    _needTypeL.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_needTypeL];
    
    _gender = [[UIImageView alloc] init];
//    _gender.layer.cornerRadius = 33.5 *SIZE;
//    _gender.clipsToBounds = YES;
    _gender.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_gender];
    
    _nameL = [[UILabel alloc] init];
    _nameL.textColor = YJTitleLabColor;
    _nameL.font = [UIFont systemFontOfSize:15 *SIZE];
    [self.contentView addSubview:_nameL];
    
    _priceL = [[UILabel alloc] init];
    _priceL.textColor = YJContentLabColor;
    _priceL.font = [UIFont systemFontOfSize:11 *SIZE];
    [self.contentView addSubview:_priceL];
    
    _typeL = [[UILabel alloc] init];
    _typeL.textColor = YJContentLabColor;
    _typeL.font = [UIFont systemFontOfSize:11 *SIZE];
    [self.contentView addSubview:_typeL];
    
    _areaL = [[UILabel alloc] init];
    _areaL.textColor = YJContentLabColor;
    _areaL.numberOfLines = 0;
    _areaL.font = [UIFont systemFontOfSize:11 *SIZE];
    [self.contentView addSubview:_areaL];
    
    _matchRateL = [[UILabel alloc] init];
    _matchRateL.textColor = YJContentLabColor;
    _matchRateL.textAlignment = NSTextAlignmentRight;
    _matchRateL.font = [UIFont systemFontOfSize:11 *SIZE];
    [self.contentView addSubview:_matchRateL];
    
    _phoneL = [[UILabel alloc] init];
    _phoneL.textColor = YJContentLabColor;
    _phoneL.font = [UIFont systemFontOfSize:11 *SIZE];
    _phoneL.textAlignment = NSTextAlignmentRight;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
    [_phoneL addGestureRecognizer:tap];
    [self.contentView addSubview:_phoneL];
    
    _intentionRateL = [[UILabel alloc] init];
    _intentionRateL.textColor = YJContentLabColor;
    _intentionRateL.font = [UIFont systemFontOfSize:11 *SIZE];
    _intentionRateL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_intentionRateL];
    
    _urgentRateL = [[UILabel alloc] init];
    _urgentRateL.textColor = YJContentLabColor;
    _urgentRateL.font = [UIFont systemFontOfSize:11 *SIZE];
    _urgentRateL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_urgentRateL];
    
    _line = [[UIView alloc] init];//WithFrame:CGRectMake(0, 110 *SIZE - 2 *SIZE, SCREEN_Width, 2 *SIZE)];
    _line.backgroundColor = YJBackColor;
    [self.contentView addSubview:_line];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView.mas_left).offset(10 *SIZE);
        make.top.equalTo(self.contentView.mas_top).offset(14 *SIZE);
        make.width.equalTo(@(_nameL.mj_textWith + 10 *SIZE));
        make.height.equalTo(@(14 *SIZE));
    }];
    
    [_needTypeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView.mas_left).offset(316 *SIZE);
        make.top.equalTo(self.contentView.mas_top).offset(10 *SIZE);
        make.width.mas_equalTo(33 *SIZE);
        make.height.mas_equalTo(17 *SIZE);
    }];
    
    [_gender mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_nameL.mas_right).offset(10 *SIZE);
        make.top.equalTo(self.contentView.mas_top).offset(16 *SIZE);
        make.width.equalTo(@(12 *SIZE));
        make.height.equalTo(@(12 *SIZE));
    }];
    
    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView.mas_left).offset(10 *SIZE);
        make.top.equalTo(self.contentView.mas_top).offset(36 *SIZE);
        make.width.equalTo(@(140 *SIZE));
        make.height.equalTo(@(10 *SIZE));
    }];
    
    [_typeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView.mas_left).offset(10 *SIZE);
        make.top.equalTo(self.contentView.mas_top).offset(56 *SIZE);
        make.width.equalTo(@(140 *SIZE));
        make.height.equalTo(@(10 *SIZE));
    }];
    
    [_areaL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView.mas_left).offset(10 *SIZE);
        make.top.equalTo(self.contentView.mas_top).offset(75 *SIZE);
        make.width.equalTo(@(230 *SIZE));
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-15 *SIZE);
    }];
    
    [_matchRateL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView.mas_right).offset(-10 *SIZE);
        make.top.equalTo(self.contentView.mas_top).offset(18 *SIZE);
        make.width.equalTo(@(100 *SIZE));
        make.height.equalTo(@(10 *SIZE));
    }];
    
    [_phoneL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView.mas_right).offset(-10 *SIZE);
        make.top.equalTo(self.contentView.mas_top).offset(41 *SIZE);
        make.width.equalTo(@(100 *SIZE));
        make.height.equalTo(@(10 *SIZE));
    }];
    
    [_intentionRateL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView.mas_right).offset(-10 *SIZE);
        make.top.equalTo(self.contentView.mas_top).offset(59 *SIZE);
        make.width.equalTo(@(100 *SIZE));
        make.height.equalTo(@(10 *SIZE));
    }];
    
    [_urgentRateL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView.mas_right).offset(-10 *SIZE);
        make.top.equalTo(self.contentView.mas_top).offset(80 *SIZE);
        make.width.equalTo(@(100 *SIZE));
        make.height.equalTo(@(10 *SIZE));
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
//        CGRectMake(0, 110 *SIZE - 2 *SIZE, SCREEN_Width, 2 *SIZE)
        
        make.left.equalTo(self.contentView.mas_left).offset(0 *SIZE);
        make.top.equalTo(_areaL.mas_bottom).offset(13 *SIZE);
        make.width.equalTo(@(SCREEN_Width));
        make.height.equalTo(@(2 *SIZE));
//        make.bottom.equalTo(self.contentView.mas_bottom).offset(-15 *SIZE);
    }];
}



@end

#pragma clang diagnostic pop
