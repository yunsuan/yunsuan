//
//  LookMaintainDetailHeader.m
//  云渠道
//
//  Created by 谷治墙 on 2019/1/23.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "LookMaintainDetailHeader.h"

@implementation LookMaintainDetailHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}


- (void)ActionTagBtn:(UIButton *)btn{
    
    if (self.lookMaintainDetailHeaderBlock) {
        
        self.lookMaintainDetailHeaderBlock(btn.tag);
    }
}

- (void)setNeedDic:(NSMutableDictionary *)needDic{
    
    _needHeader.titleL.text = @"需求信息";
    
    _propertyL.text = @"";
    _purposeL.text = @"";
    _typeL.text = @"";
    _decorateL.text = @"";
    _priceL.text = @"";
    _areaL.text = @"";
    _houseTypeL.text = @"";
    _payWayL.text = @"";
    _markL.text = @"";
    _markL2.text = @"";
    
    if ([needDic[@"property_type"] isEqualToString:@"商铺"]) {
        
        _propertyL.text = [NSString stringWithFormat:@"意向物业：%@",@"商铺"];
        _purposeL.text = [NSString stringWithFormat:@"意向价格：%@元",needDic[@"total_price"]];
        _typeL.text = [NSString stringWithFormat:@"意向面积：%@㎡",needDic[@"area"]];
        _decorateL.text = [NSString stringWithFormat:@"商铺类型：%@",[needDic[@"shop_type"] componentsJoinedByString:@","]];
        _priceL.text = [NSString stringWithFormat:@"购买用途：%@",needDic[@"buy_use"]];
        _areaL.text = [NSString stringWithFormat:@"付款方式：%@",[needDic[@"pay_type"] componentsJoinedByString:@","]];
        NSString *str = @"";
        for (NSDictionary *dic in needDic[@"match_tags"]) {
            
            if (str.length) {
                
                str = [NSString stringWithFormat:@"%@,%@",str,dic[@"name"]];
            }else{
                
                str = dic[@"name"];
            }
        }
        _houseTypeL.text = [NSString stringWithFormat:@"配套设施：%@",str];
        _payWayL.text = [NSString stringWithFormat:@"备注：%@",needDic[@"comment"]];
        _markL.text = @"";
    }else if ([needDic[@"property_type"] isEqualToString:@"写字楼"]){
        
        _propertyL.text = [NSString stringWithFormat:@"意向物业：%@",@"写字楼"];
        _purposeL.text = [NSString stringWithFormat:@"意向价格：%@元",needDic[@"total_price"]];
        _typeL.text = [NSString stringWithFormat:@"意向面积：%@㎡",needDic[@"area"]];
        _decorateL.text = [NSString stringWithFormat:@"写字楼等级：%@",needDic[@"office_level"]];
        _priceL.text = [NSString stringWithFormat:@"购买用途：%@",needDic[@"buy_use"]];
        _areaL.text = [NSString stringWithFormat:@"已使用年限：%@年",needDic[@"used_years"]];
        _houseTypeL.text = [NSString stringWithFormat:@"付款方式：%@",[needDic[@"pay_type"] componentsJoinedByString:@","]];
        NSString *str = @"";
        for (NSDictionary *dic in needDic[@"match_tags"]) {
            
            if (str.length) {
                
                str = [NSString stringWithFormat:@"%@,%@",str,dic[@"name"]];
            }else{
                
                str = dic[@"name"];
            }
        }
        _payWayL.text = [NSString stringWithFormat:@"配套设施：%@",str];
        _markL.text = [NSString stringWithFormat:@"备注：%@",needDic[@"comment"]];
    }else{
        
        _propertyL.text = [NSString stringWithFormat:@"意向物业：%@",@"住宅"];
        _purposeL.text = [NSString stringWithFormat:@"意向价格：%@元",needDic[@"total_price"]];
        _typeL.text = [NSString stringWithFormat:@"意向面积：%@㎡",needDic[@"area"]];
        _decorateL.text = [NSString stringWithFormat:@"意向户型：%@",needDic[@"house_type"]];
        _priceL.text = [NSString stringWithFormat:@"意向楼层：%@层-%@层",needDic[@"floor_min"],needDic[@"floor_max"]];
        _areaL.text = [NSString stringWithFormat:@"装修标准：%@",needDic[@"decorate"]];
        _houseTypeL.text = [NSString stringWithFormat:@"置业目的：%@",needDic[@"buy_purpose"]];
        _payWayL.text = [NSString stringWithFormat:@"付款方式：%@",[needDic[@"pay_type"] componentsJoinedByString:@","]];
        NSArray *arr = [needDic[@"need_tags"] componentsSeparatedByString:@","];
        NSMutableArray *tempArr = [@[] mutableCopy];
        NSArray *tagArr = [UserModelArchiver unarchive].Configdic[@"15"][@"param"];

        for (int i = 0; i < arr.count; i++) {
            
            [tagArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if ([obj[@"id"] integerValue] == [arr[i] integerValue]) {
                    [tempArr addObject:obj[@"param"]];
                    *stop = YES;
                }
            }];
        }
        _markL.text = [NSString stringWithFormat:@"需求标签：%@",[tempArr componentsJoinedByString:@","]];
        _markL2.text = [NSString stringWithFormat:@"备注：%@",needDic[@"comment"]];
    }
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    _customHeader.titleL.text = [NSString stringWithFormat:@"客户编号：%@",dataDic[@"take_code"]];
    _sourceL.text = [NSString stringWithFormat:@"来源：%@",dataDic[@"source"]];
    _wayL.text = [NSString stringWithFormat:@"方式：%@",dataDic[@"get_way"]];
    _timeL.text = [NSString stringWithFormat:@"接单时间：%@",dataDic[@"accept_time"]];
    
    _nameL.text = dataDic[@"client_name"];
    _phoneL.text = [NSString stringWithFormat:@"联系方式：%@",dataDic[@"client_tel"]];
    _followTimeL.text = [NSString stringWithFormat:@"上次跟进时间：%@",dataDic[@"last_follow_time"]];
    _customLevelL.text = [NSString stringWithFormat:@"客户等级：%@",dataDic[@"client_level"]];
//    _matchL.text = [NSString stringWithFormat:@"匹配套数：%@套",dataDic[@""]];
    _progressL.text = [NSString stringWithFormat:@"进度：%@",dataDic[@"take_num"]];
}

- (void)initUI{
    
    self.backgroundColor = YJBackColor;
    
    _systemView = [[UIView alloc] init];
    _systemView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_systemView];
    
    _customHeader = [[BaseHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
    [_systemView addSubview:_customHeader];
    
    for (int i = 0 ; i < 3; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = YJContentLabColor;
//        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
//        label.textAlignment = <#NSTextAlignment#>;
        if (i == 0) {
            
            _sourceL = label;
            [_systemView addSubview:_sourceL];
        }else if (i == 1){
            
            _wayL = label;
            _wayL.textAlignment = NSTextAlignmentRight;
            [_systemView addSubview:_wayL];
        }else{
            
            _timeL = label;
            [_systemView addSubview:_timeL];
        }
    }
    
    _customView = [[UIView alloc] init];
    _customView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_customView];
    
    for (int i = 0 ; i < 6; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = YJContentLabColor;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        switch (i) {
            case 0:
            {
                _nameL = label;
                [_customView addSubview:_nameL];
                break;
            }
            case 1:
            {
                _phoneL = label;
                [_customView addSubview:_phoneL];
                break;
            }
            case 2:
            {
                _followTimeL = label;
                [_customView addSubview:_followTimeL];
                break;
            }
            case 3:
            {
                _customLevelL = label;
                _customLevelL.textAlignment = NSTextAlignmentRight;
                [_customView addSubview:_customLevelL];
                break;
            }
            case 4:
            {
                _matchL = label;
//                [_customView addSubview:_matchL];
                break;
            }
            case 5:
            {
                _progressL = label;
//                _progressL.textAignment = NSTextAlignmentRight;
                [_customView addSubview:_progressL];
                break;
            }
            default:
                break;
        }
    }
    
    _needView = [[UIView alloc] init];
    _needView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_needView];
    
    _needHeader = [[BaseHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
    [_needView addSubview:_needHeader];
    
    for (int i = 0; i < 10 ; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = YJContentLabColor;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        switch (i) {
            case 0:
            {
                _purposeL = label;
                [_needView addSubview:_purposeL];
                break;
            }
            case 1:
            {
                _typeL = label;
                [_needView addSubview:_typeL];
                break;
            }
            case 2:
            {
                _decorateL = label;
                [_needView addSubview:_decorateL];
                break;
            }
            case 3:
            {
                _priceL = label;
                [_needView addSubview:_priceL];
                break;
            }
            case 4:
            {
                _areaL = label;
                [_needView addSubview:_areaL];
                break;
            }
            case 5:
            {
                _houseTypeL = label;
                [_needView addSubview:_houseTypeL];
                break;
            }
            case 6:
            {
                _payWayL = label;
                [_needView addSubview:_payWayL];
                break;
            }
            case 7:
            {
                _markL = label;
                [_needView addSubview:_markL];
                break;
            }
            case 8:
            {
                _propertyL = label;
                [_needView addSubview:_propertyL];
                break;
            }
            case 9:
            {
                _markL2 = label;
                [_needView addSubview:_markL2];
                break;
            }
            default:
                break;
        }
    }
    
    for (int i = 0; i < 3; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
        btn.tag = i;
        [btn addTarget:self action:@selector(ActionTagBtn:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0) {
            
            _roomBtn = btn;
            [_needView addSubview:_roomBtn];
        }else if (i == 1){
            
            _contactBtn = btn;
            [_needView addSubview:_contactBtn];
        }else{
            
            _followBtn = btn;
            [_needView addSubview:_followBtn];
        }
    }
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_systemView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self).offset(0);
        make.top.equalTo(self).offset(0);
        make.width.mas_equalTo(SCREEN_Width);
    }];
    
    [_sourceL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_systemView).offset(28 *SIZE);
        make.top.equalTo(_systemView).offset(51 *SIZE);
        make.width.mas_equalTo(150 *SIZE);
    }];
    
    [_wayL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_systemView).offset(180 *SIZE);
        make.top.equalTo(_systemView).offset(51 *SIZE);
        make.width.mas_equalTo(166 *SIZE);
    }];
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_systemView).offset(28 *SIZE);
        make.top.equalTo(_sourceL.mas_bottom).offset(14 *SIZE);
        make.width.mas_equalTo(300 *SIZE);
        make.bottom.equalTo(_systemView).offset(-17 *SIZE);
    }];
    
    [_customView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(0);
        make.top.equalTo(_systemView.mas_bottom).offset(5 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
    }];
    
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_customView).offset(28 *SIZE);
        make.top.equalTo(_customView).offset(16 *SIZE);
        make.width.mas_equalTo(300 *SIZE);
    }];
    
    [_phoneL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_customView).offset(28 *SIZE);
        make.top.equalTo(_nameL.mas_bottom).offset(11 *SIZE);
        make.width.mas_equalTo(300 *SIZE);
    }];
    
    [_followTimeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_customView).offset(28 *SIZE);
        make.top.equalTo(_phoneL.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(200 *SIZE);
    }];
    
    [_customLevelL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_customView).offset(210 *SIZE);
        make.top.equalTo(_phoneL.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(140 *SIZE);
    }];
    
//    [_matchL mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(_customView).offset(28 *SIZE);
//        make.top.equalTo(_followTimeL.mas_bottom).offset(10 *SIZE);
//        make.width.mas_equalTo(180 *SIZE);
//        make.bottom.equalTo(_customView).offset(-17 *SIZE);
//    }];
    
    [_progressL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_customView).offset(28 *SIZE);
        make.top.equalTo(_followTimeL.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(140 *SIZE);
        make.bottom.equalTo(_customView).offset(-17 *SIZE);
    }];
    
    [_needView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(0);
        make.top.equalTo(_customView.mas_bottom).offset(5 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.bottom.equalTo(self).offset(0);
    }];
    
    [_propertyL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_needView).offset(28 *SIZE);
        make.top.equalTo(_needView).offset(52 *SIZE);
        make.width.mas_equalTo(300 *SIZE);
    }];
    
    [_purposeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_needView).offset(28 *SIZE);
        make.top.equalTo(_propertyL.mas_bottom).offset(19 *SIZE);
        make.width.mas_equalTo(300 *SIZE);
    }];
    
    [_typeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_needView).offset(28 *SIZE);
        make.top.equalTo(_purposeL.mas_bottom).offset(19 *SIZE);
        make.width.mas_equalTo(300 *SIZE);
    }];
    
    [_decorateL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_needView).offset(28 *SIZE);
        make.top.equalTo(_typeL.mas_bottom).offset(19 *SIZE);
        make.width.mas_equalTo(300 *SIZE);
    }];
    
    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_needView).offset(28 *SIZE);
        make.top.equalTo(_decorateL.mas_bottom).offset(19 *SIZE);
        make.width.mas_equalTo(300 *SIZE);
    }];
    
    [_areaL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_needView).offset(28 *SIZE);
        make.top.equalTo(_priceL.mas_bottom).offset(19 *SIZE);
        make.width.mas_equalTo(300 *SIZE);
    }];
    
    [_houseTypeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_needView).offset(28 *SIZE);
        make.top.equalTo(_areaL.mas_bottom).offset(19 *SIZE);
        make.width.mas_equalTo(300 *SIZE);
    }];
    
    [_payWayL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_needView).offset(28 *SIZE);
        make.top.equalTo(_houseTypeL.mas_bottom).offset(19 *SIZE);
        make.width.mas_equalTo(300 *SIZE);
    }];
    
    [_markL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_needView).offset(28 *SIZE);
        make.top.equalTo(_payWayL.mas_bottom).offset(19 *SIZE);
        make.width.mas_equalTo(300 *SIZE);
    }];
    
    [_markL2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_needView).offset(28 *SIZE);
        make.top.equalTo(_markL.mas_bottom).offset(19 *SIZE);
        make.width.mas_equalTo(300 *SIZE);
    }];
    
    [_roomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_needView).offset(0);
        make.top.equalTo(_markL2.mas_bottom).offset(18 *SIZE);
        make.bottom.equalTo(_needView.mas_bottom).offset(0 *SIZE);
        make.width.mas_equalTo(119 *SIZE);
        make.height.mas_equalTo(47 *SIZE);
    }];
    
    [_contactBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_needView).offset(120 *SIZE);
        make.top.equalTo(_markL2.mas_bottom).offset(18 *SIZE);
        make.bottom.equalTo(_needView.mas_bottom).offset(0 *SIZE);
        make.width.mas_equalTo(119 *SIZE);
        make.height.mas_equalTo(47 *SIZE);
    }];
    
    [_followBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_needView).offset(240 *SIZE);
        make.top.equalTo(_markL2.mas_bottom).offset(18 *SIZE);
        make.bottom.equalTo(_needView.mas_bottom).offset(0 *SIZE);
        make.width.mas_equalTo(119 *SIZE);
        make.height.mas_equalTo(47 *SIZE);
    }];
}



@end
