//
//  RoomDetailTableCell5.m
//  云渠道
//
//  Created by 谷治墙 on 2018/3/27.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RoomDetailTableCell5.h"

@implementation RoomDetailTableCell5

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setModel:(CustomMatchModel *)model{
    
    if (model.name) {
        
        _nameL.text = model.name;
        [_nameL mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentView.mas_left).offset(9 *SIZE);
            make.top.equalTo(self.contentView.mas_top).offset(17 *SIZE);
            make.width.equalTo(@(_nameL.mj_textWith + 5 *SIZE));
            make.height.equalTo(@(12 *SIZE));
        }];
    }
    if ([model.sex integerValue] == 1) {
        
        _gender.image = [UIImage imageNamed:@"man"];
    }else if ([model.sex integerValue] == 2){
        
        _gender.image = [UIImage imageNamed:@"girl"];
    }
    
    if (model.price) {
        
        _priceL.text = [NSString stringWithFormat:@"意向总价：%@万",model.price];
    }else{
        
        _priceL.text = @"意向总价：";
    }
    
    _typeL.text = @"";
    if (model.house_type) {
        
        NSDictionary *configdic = [UserModelArchiver unarchive].Configdic;
        NSDictionary *dic =  [configdic valueForKey:[NSString stringWithFormat:@"%d",9]];
        NSArray *tempArr = dic[@"param"];
        
        [tempArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([obj[@"id"] integerValue] == [model.house_type integerValue]) {
                
                _typeL.text = [NSString stringWithFormat:@"意向户型：%@",obj[@"param"]];
            }
        }];
        if (!_typeL.text.length) {
         
            _typeL.text = @"意向户型：";
        }
    }else{
        
        _typeL.text = @"意向户型：";
    }
    
    if (model.region.count) {
        
        for (int i = 0; i < model.region.count; i++) {
            
            if (i == 0) {
                
                if ([model.region[i][@"province_name"] length]) {
                    
                    _areaL.text = [NSString stringWithFormat:@"区域：%@",model.region[i][@"province_name"]];
                    
                    if ([model.region[i][@"city_name"] length]) {
                        
                        _areaL.text = [NSString stringWithFormat:@"%@-%@",_areaL.text,model.region[i][@"city_name"]];
                        if ([model.region[i][@"district_name"] length]) {
                            
                            _areaL.text = [NSString stringWithFormat:@"%@-%@",_areaL.text,model.region[i][@"district_name"]];
                        }
                    }
                }else{
                    
                    _areaL.text = @"区域：";
                }
                
            }else{
                
                if ([model.region[i][@"province_name"] length]) {
                    
                    _areaL.text = [NSString stringWithFormat:@"%@ %@",_areaL.text,model.region[i][@"province_name"]];
                    
                    if ([model.region[i][@"city_name"] length]) {
                        
                        _areaL.text = [NSString stringWithFormat:@"%@-%@",_areaL.text,model.region[i][@"city_name"]];
                        if ([model.region[i][@"district_name"] length]) {
                            
                            _areaL.text = [NSString stringWithFormat:@"%@-%@",_areaL.text,model.region[i][@"district_name"]];
                        }
                    }
                }
            }
        }
    }else{
        
        _areaL.text = @"区域：";
    }
    
    if (model.intent) {
        
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"购买意向度：%@",model.intent]];
        [attr setAttributes:@{NSForegroundColorAttributeName:YJContentLabColor} range:NSMakeRange(0, 6)];
        _intentionRateL.attributedText = attr;
    }else{
        
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"购买意向度："]];
        [attr setAttributes:@{NSForegroundColorAttributeName:YJContentLabColor} range:NSMakeRange(0, 6)];
        _intentionRateL.attributedText = attr;
    }
    
    if (model.urgency) {
        
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"购买紧迫度：%@",model.urgency]];
        [attr setAttributes:@{NSForegroundColorAttributeName:YJContentLabColor} range:NSMakeRange(0, 6)];
        _urgentRateL.attributedText = attr;
    }else{
        
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"购买紧迫度："]];
        [attr setAttributes:@{NSForegroundColorAttributeName:YJContentLabColor} range:NSMakeRange(0, 6)];
        _urgentRateL.attributedText = attr;
    }
    
    if (model.score) {
        
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"匹配度：%@%@",model.score,@"%"]];
        [attr setAttributes:@{NSForegroundColorAttributeName:YJContentLabColor} range:NSMakeRange(0, 4)];
        _matchRateL.attributedText = attr;
    }else{
        
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"匹配度：0%@",@"%"]];
        [attr setAttributes:@{NSForegroundColorAttributeName:YJContentLabColor} range:NSMakeRange(0, 4)];
        _matchRateL.attributedText = attr;
    }
    
    if (model.tel) {
        
        NSArray *arr = [model.tel componentsSeparatedByString:@","];
        _phoneL.text = arr[0];
    }else{
        
        _phoneL.text = @"";
    }
    
    if ([model.is_recommend integerValue] == 0) {
        
        [_recommendBtn setBackgroundColor:COLOR(27, 152, 255, 1)];
        _recommendBtn.userInteractionEnabled = YES;
    }else{
        
        [_recommendBtn setBackgroundColor:YJContentLabColor];
        _recommendBtn.userInteractionEnabled = NO;
    }
}

- (void)ActionRecommendBtn:(UIButton *)btn{
    
    if (self.recommendBtnBlock5) {
        
        self.recommendBtnBlock5(btn.tag);
    }
}

- (void)initUI{
    
    
    _nameL = [[UILabel alloc] init];
    _nameL.textColor = YJTitleLabColor;
    _nameL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_nameL];
    
    _gender = [[UIImageView alloc] init];
    [self.contentView addSubview:_gender];
    
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
    _matchRateL.textColor = YJBlueBtnColor;
    _matchRateL.textAlignment = NSTextAlignmentRight;
    _matchRateL.font = [UIFont systemFontOfSize:11 *SIZE];
    [self.contentView addSubview:_matchRateL];
    
    _phoneL = [[UILabel alloc] init];
    _phoneL.textColor = YJContentLabColor;
    _phoneL.font = [UIFont systemFontOfSize:11 *SIZE];
    _phoneL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_phoneL];
    
    _intentionRateL = [[UILabel alloc] init];
    _intentionRateL.textColor = COLOR(255, 165, 29, 1);
    _intentionRateL.font = [UIFont systemFontOfSize:11 *SIZE];
//    _intentionRateL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_intentionRateL];
    
    _urgentRateL = [[UILabel alloc] init];
    _urgentRateL.textColor = COLOR(255, 165, 29, 1);
    _urgentRateL.font = [UIFont systemFontOfSize:11 *SIZE];
//    _urgentRateL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_urgentRateL];
    
    _recommendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _recommendBtn.titleLabel.font = [UIFont systemFontOfSize:13 *sIZE];
    [_recommendBtn setBackgroundColor:COLOR(27, 152, 255, 1)];
    [_recommendBtn setTitle:@"推荐" forState:UIControlStateNormal];
    [_recommendBtn setTitleColor:CH_COLOR_white forState:UIControlStateNormal];
    [_recommendBtn addTarget:self action:@selector(ActionRecommendBtn:) forControlEvents:UIControlEventTouchUpInside];
    if ([[UserModel defaultModel].agent_identity integerValue] == 1) {
        
        [self.contentView addSubview:_recommendBtn];
    }
    
    
    _line = [[UIView alloc] init];
    _line.backgroundColor = YJBackColor;
    [self.contentView addSubview:_line];
    
    [self MasonryUI];
}

- (void)MasonryUI{

    
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView.mas_left).offset(9 *SIZE);
        make.top.equalTo(self.contentView.mas_top).offset(17 *SIZE);
        make.width.equalTo(@(_nameL.mj_textWith + 5 *SIZE));
        make.height.equalTo(@(12 *SIZE));
    }];
    
    [_gender mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_nameL.mas_right).offset(10 *SIZE);
        make.top.equalTo(self.contentView.mas_top).offset(16 *SIZE);
        make.width.equalTo(@(12 *SIZE));
        make.height.equalTo(@(12 *SIZE));
    }];
    
    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView.mas_left).offset(10 *SIZE);
        make.top.equalTo(self.contentView.mas_top).offset(40 *SIZE);
        make.width.equalTo(@(140 *SIZE));
        make.height.equalTo(@(10 *SIZE));
    }];
    
    [_typeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView.mas_left).offset(10 *SIZE);
        make.top.equalTo(self.contentView.mas_top).offset(59 *SIZE);
        make.width.equalTo(@(140 *SIZE));
        make.height.equalTo(@(10 *SIZE));
    }];
    
    [_areaL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView.mas_left).offset(10 *SIZE);
        make.top.equalTo(self.contentView.mas_top).offset(80 *SIZE);
        make.width.equalTo(@(230 *SIZE));
        make.bottom.equalTo(_intentionRateL.mas_top).offset(-11 *SIZE);

    }];
    
    [_matchRateL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView.mas_right).offset(-10 *SIZE);
        make.top.equalTo(self.contentView.mas_top).offset(18 *SIZE);
        make.width.equalTo(@(100 *SIZE));
        make.height.equalTo(@(10 *SIZE));
    }];
    
    [_phoneL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
        make.top.equalTo(self.contentView.mas_top).offset(41 *SIZE);
        make.width.equalTo(@(100 *SIZE));
        make.height.equalTo(@(10 *SIZE));
    }];
    
    [_intentionRateL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(_areaL.mas_bottom).offset(11 *SIZE);
        make.width.equalTo(@(95 *SIZE));
        make.height.equalTo(@(10 *SIZE));
        make.bottom.equalTo(_line.mas_top).offset(-15 *SIZE);
    }];
    
    [_urgentRateL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(107 *SIZE);
        make.top.equalTo(_areaL.mas_bottom).offset(11 *SIZE);
        make.width.equalTo(@(95 *SIZE));
        make.height.equalTo(@(10 *SIZE));
    }];
    
    
    if ([[UserModel defaultModel].agent_identity integerValue] == 1) {
        
        [_recommendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(- 10 *SIZE);
            make.top.equalTo(self.contentView).offset(58 *SIZE);
            make.width.equalTo(@(77 *SIZE));
            make.height.equalTo(@(30 *SIZE));
        }];
    }

    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(0);
        make.top.equalTo(_intentionRateL.mas_bottom).offset(15 *SIZE);
        make.width.equalTo(@(SCREEN_Width));
        make.height.equalTo(@(2 *SIZE));
        make.bottom.equalTo(self.contentView).offset(0);
    }];
}

@end
