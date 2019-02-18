//
//  MaintainDetailHeader.m
//  云渠道
//
//  Created by 谷治墙 on 2018/6/20.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "MaintainDetailHeader.h"


@interface MaintainDetailHeader()
{
    
    NSArray *_titleArr;
}

@end

@implementation MaintainDetailHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionTagBtn:(UIButton *)btn{
    
    if (self.maintainTagHeaderBlock) {
        
        self.maintainTagHeaderBlock(btn.tag);
    }
}

- (void)ActionEditBtn:(UIButton *)btn{
    
    if (self.maintainDetailHeaderBlock) {
        
        self.maintainDetailHeaderBlock();
    }
}

- (void)ActionTap{
    
    if (self.maintainPriceHeaderBlock) {
        
        self.maintainPriceHeaderBlock();
    }
}

- (void)setTakeDic:(NSMutableDictionary *)takeDic{
    
    _seeView.daysL.text = [NSString stringWithFormat:@"%@",takeDic[@"range_take"]];
    _seeView.allL.text = [NSString stringWithFormat:@"%@",takeDic[@"total_take"]];
    _seeView.intentL.text = [NSString stringWithFormat:@"%@",takeDic[@"last_price"]];
    
    _priceView.daysL.text = [NSString stringWithFormat:@"%@",takeDic[@"highest_price"]];
    _priceView.allL.text = [NSString stringWithFormat:@"%@",takeDic[@"lowest_price"]];
    _priceView.intentL.text = [NSString stringWithFormat:@"%@",takeDic[@"price_person_count"]];
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    if (dataDic[@"house_code"]) {
        
        _codeL.text = [NSString stringWithFormat:@"房源编号:%@",dataDic[@"house_code"]];
    }else{
        
        _codeL.text = [NSString stringWithFormat:@"房源编号:暂无数据"];
    }
    
    if (dataDic[@"project_name"]|| dataDic[@"house"]) {
        
        _projectL.text = [NSString stringWithFormat:@"%@ %@",dataDic[@"project_name"],dataDic[@"house"]];
    }else{
        
        _projectL.text = @"暂无数据";
    }
    
    if (dataDic[@"unit_minimum"]) {
        
        _singleMinPriceL.text = [NSString stringWithFormat:@"(%@元/㎡)",dataDic[@"unit_minimum"]];
    }else{
        
        _singleMinPriceL.text = [NSString stringWithFormat:@"(0元/㎡)"];
    }
    
    if (dataDic[@"unit_price"]) {
        
        _singlePriceL.text = [NSString stringWithFormat:@"(%@元/㎡)",dataDic[@"unit_price"]];
    }else{
        
        _singlePriceL.text = [NSString stringWithFormat:@"(0元/㎡)"];
    }
    
    if (dataDic[@"title"]) {
        
        _titleL.text = [NSString stringWithFormat:@"挂牌标题:%@",dataDic[@"title"]];
    }else{
        
        _titleL.text = [NSString stringWithFormat:@"挂牌标题:暂无数据"];
    }
    
    if (dataDic[@"price"]) {
        
        _priceL.text = [NSString stringWithFormat:@"挂牌价格:%@万",dataDic[@"price"]];
    }else{
        
        _priceL.text = [NSString stringWithFormat:@"挂牌价格:暂无数据"];
    }
    
    if (dataDic[@"minimum"]) {
        
        _minPriceL.text = [NSString stringWithFormat:@"出售底价:%@万",dataDic[@"minimum"]];
    }else{
        
        _minPriceL.text = [NSString stringWithFormat:@"出售底价:暂无数据"];
    }
    
    if (dataDic[@"level"]) {
        
        _roomLevelL.text = [NSString stringWithFormat:@"房源等级:%@",dataDic[@"level"]];
    }else{
        
        _roomLevelL.text = [NSString stringWithFormat:@"房源等级:暂无数据"];
    }
    
    if (dataDic[@"pay_way"]) {
        
        _payWayL.text = [NSString stringWithFormat:@"收款方式:%@",[dataDic[@"pay_way"] componentsJoinedByString:@","]];
    }else{
        
        _payWayL.text = [NSString stringWithFormat:@"收款方式:暂无数据"];
    }
    
    if (dataDic[@"property_belong"]) {
        
        _propertyL.text = [NSString stringWithFormat:@"产权所属:%@",dataDic[@"property_belong"]];
    }else{
        
        _propertyL.text = [NSString stringWithFormat:@"产权所属:暂无数据"];
    }
    
    if (dataDic[@"is_mortgage"]) {
        
        _mortgageL.text = [NSString stringWithFormat:@"抵押信息:%@",dataDic[@"is_mortgage"]];
    }else{
        
        _mortgageL.text = [NSString stringWithFormat:@"抵押信息:暂无数据"];
    }
    
    if (dataDic[@"check_way"]) {
        
        _seeWayL.text = [NSString stringWithFormat:@"看房方式:%@",dataDic[@"check_way"]];
    }else{
        
        _seeWayL.text = [NSString stringWithFormat:@"看房方式:暂无数据"];
    }

    if (dataDic[@"property_limit"]) {
        
        _yearL.text = [NSString stringWithFormat:@"产权年限:%@年",dataDic[@"property_limit"]];
    }else{
        
        _yearL.text = [NSString stringWithFormat:@"产权年限:暂无数据"];
    }

    if (dataDic[@"intent"]) {
        
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"卖房意愿度:%@",dataDic[@"intent"]]];
        [attr addAttribute:NSForegroundColorAttributeName value:YJBlueBtnColor range:NSMakeRange(6, attr.length - 6)];
        _intentL.attributedText = attr;
    }else{
        
        _intentL.text = [NSString stringWithFormat:@"卖房意愿度:暂无数据"];
    }
    
    if (dataDic[@"urgency"]) {
        
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"卖房急迫度:%@",dataDic[@"urgency"]]];
        [attr addAttribute:NSForegroundColorAttributeName value:YJBlueBtnColor range:NSMakeRange(6, attr.length - 6)];
        _urgentL.attributedText = attr;
    }else{
        
        _urgentL.text = [NSString stringWithFormat:@"卖房急迫度:暂无数据"];
    }
    
    if (dataDic[@"suggest_price"]) {
        
        _partView.daysL.text = [NSString stringWithFormat:@"%@元/㎡",dataDic[@"suggest_price"]];
//        _RePriceL.text = [NSString stringWithFormat:@"参考价格:%@元/㎡",dataDic[@"suggest_price"]];
    }else{
        
        _partView.daysL.text = [NSString stringWithFormat:@"0"];
    }
    
    if (dataDic[@"focus_num"]) {
        
        _partView.allL.text = [NSString stringWithFormat:@"%@",dataDic[@"focus_num"]];
    }else{
        
        _partView.allL.text = [NSString stringWithFormat:@"0"];
    }
    
    _partView.intentL.text = [NSString stringWithFormat:@"暂无数据"];
}


- (void)initUI{
    
    self.contentView.backgroundColor = YJBackColor;
    
    _titleArr = @[@"联系人信息",@"房源信息",@"跟进记录"];
    
    _codeView = [[UIView alloc] init];
    _codeView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_codeView];
    
    _blueView = [[UIView alloc] init];
    _blueView.backgroundColor = YJBlueBtnColor;
    [_codeView addSubview:_blueView];
    
    _codeL =  [[UILabel alloc] init];
    _codeL.textColor = YJTitleLabColor;
    _codeL.font = [UIFont systemFontOfSize:15 *SIZE];
    [_codeView addSubview:_codeL];
    
    _typeL =  [[UILabel alloc] init];
    _typeL.layer.cornerRadius = 2 *SIZE;
    _typeL.clipsToBounds = YES;
    _typeL.backgroundColor = COLOR(213, 242, 255, 1);
    _typeL.textColor = COLOR(64, 169, 255, 1);
    _typeL.font = [UIFont systemFontOfSize:10 *SIZE];
    _typeL.textAlignment = NSTextAlignmentCenter;
    [_codeView addSubview:_typeL];
    
    _projectL =  [[UILabel alloc] init];
    _projectL.textColor = YJ86Color;
    _projectL.font = [UIFont systemFontOfSize:13 *SIZE];
    [_codeView addSubview:_projectL];
    
    _editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_editBtn addTarget:self action:@selector(ActionEditBtn:) forControlEvents:UIControlEventTouchUpInside];
//    [_editBtn setImage:[UIImage imageNamed:@"edit"] forState:UIControlStateNormal];
    [_codeView addSubview:_editBtn];
    
    _singlePriceL = [[UILabel alloc] init];
    _singlePriceL.textColor = COLOR(153, 153, 153, 1);
    _singlePriceL.font = [UIFont systemFontOfSize:13 *SIZE];
    _singlePriceL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_singlePriceL];
    
    _singleMinPriceL = [[UILabel alloc] init];
    _singleMinPriceL.textColor = COLOR(153, 153, 153, 1);
    _singleMinPriceL.font = [UIFont systemFontOfSize:13 *SIZE];
    _singleMinPriceL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_singleMinPriceL];
    
    _roomLevelL = [[UILabel alloc] init];
    _roomLevelL.textColor = YJ86Color;
    _roomLevelL.numberOfLines = 0;
    _roomLevelL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_roomLevelL];
    
    for (int i = 0; i < 13 ; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = YJ86Color;
        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        switch (i) {
            case 0:
            {
                _titleL = label;
                [self.contentView addSubview:_titleL];
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
                _payWayL = label;
                [self.contentView addSubview:_payWayL];
                break;
            }
            case 3:
            {
                _propertyL = label;
                [self.contentView addSubview:_propertyL];
                break;
            }
            case 4:
            {
                _mortgageL = label;
                [self.contentView addSubview:_mortgageL];
                break;
            }
            case 5:
            {
                _yearL = label;
                [self.contentView addSubview:_yearL];
                break;
            }
            case 6:
            {
                _seeWayL = label;
                [self.contentView addSubview:_seeWayL];
                break;
            }
            case 7:
            {
                _intentL = label;
                [self.contentView addSubview:_intentL];
                break;
            }
            case 8:
            {
                _urgentL = label;
                [self.contentView addSubview:_urgentL];
                break;
            }
            case 9:
            {
                _minPriceL = label;
                [self.contentView addSubview:_minPriceL];
                break;
            }
            case 10:
            {
//                _RePriceL = label;
//                [self.contentView addSubview:_RePriceL];
                break;
            }
            case 11:
            {
//                _attentL = label;
//                [self.contentView addSubview:_attentL];
                break;
            }
            case 12:
            {
//                _periodL = label;
//                [self.contentView addSubview:_periodL];
                break;
            }
            default:
                break;
        }
    }
    
    _dashesLine = [[DashesLineView alloc] initWithFrame:CGRectMake(10 *SIZE, 395 *SIZE, 340 *SIZE, 2 *SIZE)];
    [self.contentView addSubview:_dashesLine];
    
    for (int i = 0; i < 3; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
//        [btn addTarget:self action:@selector(<#selector#>) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
        [btn setTitle:_titleArr[i] forState:UIControlStateNormal];
        [btn setBackgroundColor:COLOR(219, 219, 219, 1)];
//        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(ActionTagBtn:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:YJ86Color forState:UIControlStateNormal];
        
        ThreePartView *part = [[ThreePartView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 75 *SIZE)];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ActionTap)];
        part.userInteractionEnabled = YES;
        [part addGestureRecognizer:tap];
        if (i == 0) {
            
            _infoBtn = btn;
            [self.contentView addSubview:_infoBtn];
            
            _partView = part;
            _partView.daysLabel.text = @"参考价格";
            _partView.allLabel.text = @"关注人数";
            _partView.intentLabel.text = @"预估卖出周期";
            
            [self.contentView addSubview:_partView];
        }else if (i == 1){
            
            _advantageBtn = btn;
            [self.contentView addSubview:_advantageBtn];
            
            _seeView = part;
//            _seeView.daysLabel.text = @"参考价格";
//            _seeView.allLabel.text = @"关注人数";
            _seeView.intentLabel.text = @"最新出价";
            [self.contentView addSubview:_seeView];
        }else{
            
            _followBtn = btn;
            [self.contentView addSubview:_followBtn];
            
            _priceView = part;
            _priceView.daysLabel.text = @"最高出价";
            _priceView.allLabel.text = @"最低出价";
            _priceView.intentLabel.text = @"出价人数";
            [self.contentView addSubview:_priceView];
        }
    }
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_codeView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(self.contentView).offset(0 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(87 *SIZE);
    }];
    
    [_blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_codeView).offset(10 *SIZE);
        make.top.equalTo(_codeView).offset(20 *SIZE);
        make.width.mas_equalTo(7 *SIZE);
        make.height.mas_equalTo(13 *SIZE);
    }];
    
    [_codeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_codeView).offset(28 *SIZE);
        make.top.equalTo(_codeView).offset(20 *SIZE);
        make.right.equalTo(_codeView).offset(-50 *SIZE);
    }];
    
    [_projectL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_codeView).offset(28 *SIZE);
        make.top.equalTo(_codeL.mas_bottom).offset(19 *SIZE);
        make.right.equalTo(_codeView).offset(-50 *SIZE);
    }];
    
    [_typeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_codeView).offset(317 *SIZE);
        make.top.equalTo(_codeView).offset(53 *SIZE);
        make.right.equalTo(_codeView).offset(-10 *SIZE);
        make.height.mas_equalTo(17 *SIZE);
    }];
    
    [_editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_codeView).offset(0 *SIZE);
        make.top.equalTo(_codeView).offset(0 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(86 *SIZE);
    }];
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_codeView.mas_bottom).offset(10 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
    }];
    
    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_titleL.mas_bottom).offset(19 *SIZE);
        make.right.equalTo(self.contentView).offset(-120 *SIZE);
    }];
    
    [_singlePriceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(120 *SIZE);
        make.top.equalTo(_titleL.mas_bottom).offset(19 *SIZE);
        make.right.equalTo(self.contentView).offset(-11 *SIZE);
    }];
    
    [_singleMinPriceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(120 *SIZE);
        make.top.equalTo(_priceL.mas_bottom).offset(19 *SIZE);
        make.right.equalTo(self.contentView).offset(-11 *SIZE);
    }];
    
    [_minPriceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_priceL.mas_bottom).offset(19 *SIZE);
        make.right.equalTo(self.contentView).offset(-120 *SIZE);
    }];
    
    [_roomLevelL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_minPriceL.mas_bottom).offset(19 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
    }];
    
    [_payWayL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_roomLevelL.mas_bottom).offset(19 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
    }];
    
    [_propertyL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_payWayL.mas_bottom).offset(19 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
    }];
    
    [_mortgageL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_propertyL.mas_bottom).offset(19 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
    }];
    
    [_yearL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_mortgageL.mas_bottom).offset(19 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
    }];
    
    [_seeWayL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_yearL.mas_bottom).offset(19 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
    }];
    
    [_intentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_seeWayL.mas_bottom).offset(19 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
    }];
    
    [_urgentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_intentL.mas_bottom).offset(19 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
    }];
    
    [_dashesLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(_urgentL.mas_bottom).offset(16 *SIZE);
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
        make.height.mas_equalTo(2 *SIZE);
    }];
    
    [_partView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(_dashesLine.mas_bottom).offset(0 *SIZE);
        make.right.equalTo(self.contentView).offset(0 *SIZE);
        make.height.mas_equalTo(75 *SIZE);
    }];
    
    [_seeView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(_partView.mas_bottom).offset(0 *SIZE);
        make.right.equalTo(self.contentView).offset(0 *SIZE);
        make.height.mas_equalTo(75 *SIZE);
    }];
    
    [_priceView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(_seeView.mas_bottom).offset(0 *SIZE);
        make.right.equalTo(self.contentView).offset(0 *SIZE);
        make.height.mas_equalTo(75 *SIZE);
    }];
    
    [_infoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(_priceView.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(120 *SIZE);
        make.height.mas_equalTo(47 *SIZE);
        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
    }];
    
    [_advantageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(120 *SIZE);
        make.top.equalTo(_priceView.mas_bottom).offset(22 *SIZE);
        make.width.mas_equalTo(120 *SIZE);
        make.height.mas_equalTo(47 *SIZE);
        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
    }];
    
    [_followBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(240 *SIZE);
        make.top.equalTo(_priceView.mas_bottom).offset(22 *SIZE);
        make.width.mas_equalTo(120 *SIZE);
        make.height.mas_equalTo(47 *SIZE);
        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
    }];
}

@end
