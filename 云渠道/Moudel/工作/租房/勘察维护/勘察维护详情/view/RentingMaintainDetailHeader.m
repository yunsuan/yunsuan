//
//  RentingMaintainDetailHeader.m
//  云渠道
//
//  Created by 谷治墙 on 2018/7/30.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RentingMaintainDetailHeader.h"

@interface RentingMaintainDetailHeader()
{
    
    NSArray *_titleArr;
}

@end

@implementation RentingMaintainDetailHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}


- (void)ActionTagBtn:(UIButton *)btn{
    
    if (self.rentingMaintainTagHeaderBlock) {
        
        self.rentingMaintainTagHeaderBlock(btn.tag);
    }
}

- (void)ActionEditBtn:(UIButton *)btn{
    
    if (self.rentingMaintainDetailHeaderBlock) {
        
        self.rentingMaintainDetailHeaderBlock();
    }
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
    
    
    if (dataDic[@"title"]) {
        
        _titleL.text = [NSString stringWithFormat:@"挂牌标题:%@",dataDic[@"title"]];
    }else{
        
        _titleL.text = [NSString stringWithFormat:@"挂牌标题:暂无数据"];
    }
    
    if (dataDic[@"price"]) {
        
        _priceL.text = [NSString stringWithFormat:@"出租价格:%@元",dataDic[@"price"]];
    }else{
        
        _priceL.text = [NSString stringWithFormat:@"出租价格:暂无数据"];
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
    
//    if (dataDic[@"property_belong"]) {
//        
//        _propertyL.text = [NSString stringWithFormat:@"物业类型:%@",dataDic[@"property_belong"]];
//    }else{
//        
//        _propertyL.text = [NSString stringWithFormat:@"物业类型:暂无数据"];
//    }
    
    if (dataDic[@"property_belong"]) {
        
        _houseTypeL.text = [NSString stringWithFormat:@"户型:%@",dataDic[@"property_belong"]];
    }else{
        
        _houseTypeL.text = [NSString stringWithFormat:@"户型:暂无数据"];
    }
    
    if (dataDic[@"property_belong"]) {
        
        _rentTypeL.text = [NSString stringWithFormat:@"类型:%@",dataDic[@"property_belong"]];
    }else{
        
        _rentTypeL.text = [NSString stringWithFormat:@"类型:暂无数据"];
    }
    
    if (dataDic[@"rent_max_comment"]) {
        
        _maxRent.text = [NSString stringWithFormat:@"最长租期:%@",dataDic[@"rent_max_comment"]];
    }else{
        
        _maxRent.text = [NSString stringWithFormat:@"最长租期:暂无数据"];
    }
    
    if (dataDic[@"rent_min_comment"]) {
        
        _minRent.text = [NSString stringWithFormat:@"最短租期:%@",dataDic[@"rent_min_comment"]];
    }else{
        
        _minRent.text = [NSString stringWithFormat:@"最短租期:暂无数据"];
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
        
        _RePriceL.text = [NSString stringWithFormat:@"参考价格:%@元/月",dataDic[@"suggest_price"]];
    }else{
        
        _RePriceL.text = [NSString stringWithFormat:@"参考价格:暂无数据"];
    }
    
    if (dataDic[@"focus_num"]) {
        
        _attentL.text = [NSString stringWithFormat:@"关注人数:%@",dataDic[@"focus_num"]];
    }else{
        
        _attentL.text = [NSString stringWithFormat:@"关注人数:暂无数据"];
    }
    
    _periodL.text = [NSString stringWithFormat:@"预估卖出周期:暂无数据"];
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

    
    _projectL =  [[UILabel alloc] init];
    _projectL.textColor = YJ86Color;
    _projectL.font = [UIFont systemFontOfSize:13 *SIZE];
    [_codeView addSubview:_projectL];
    
    _editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_editBtn addTarget:self action:@selector(ActionEditBtn:) forControlEvents:UIControlEventTouchUpInside];
    //    [_editBtn setImage:[UIImage imageNamed:@"edit"] forState:UIControlStateNormal];
    [_codeView addSubview:_editBtn];
    
    
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
                _houseTypeL = label;
                [self.contentView addSubview:_houseTypeL];
                break;
            }
            case 5:
            {
                _rentTypeL = label;
                [self.contentView addSubview:_rentTypeL];
                break;
            }
            case 6:
            {
                _intentL = label;
                [self.contentView addSubview:_intentL];
                break;
            }
            case 7:
            {
                _urgentL = label;
                [self.contentView addSubview:_urgentL];
                break;
            }
            case 8:
            {
                _RePriceL = label;
                [self.contentView addSubview:_RePriceL];
                break;
            }
            case 9:
            {
                _attentL = label;
                [self.contentView addSubview:_attentL];
                break;
            }
            case 10:
            {
                _periodL = label;
                [self.contentView addSubview:_periodL];
                break;
            }
            case 11:
            {
                _maxRent = label;
                [self.contentView addSubview:_maxRent];
                break;
            }
            case 12:
            {
                _minRent = label;
                [self.contentView addSubview:_minRent];
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
        if (i == 0) {
            
            _infoBtn = btn;
            [self.contentView addSubview:_infoBtn];
        }else if (i == 1){
            
            _advantageBtn = btn;
            [self.contentView addSubview:_advantageBtn];
        }else{
            
            _followBtn = btn;
            [self.contentView addSubview:_followBtn];
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
    
//    [_typeL mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(_codeView).offset(317 *SIZE);
//        make.top.equalTo(_codeView).offset(53 *SIZE);
//        make.right.equalTo(_codeView).offset(-10 *SIZE);
//        make.height.mas_equalTo(17 *SIZE);
//    }];
    
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
    
    [_roomLevelL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_priceL.mas_bottom).offset(19 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
    }];
    
    [_propertyL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_roomLevelL.mas_bottom).offset(19 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
    }];
    
    [_houseTypeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_propertyL.mas_bottom).offset(19 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
    }];
    
    [_payWayL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_houseTypeL.mas_bottom).offset(19 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
    }];
    
    [_rentTypeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_payWayL.mas_bottom).offset(19 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
    }];
    
    [_maxRent mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_rentTypeL.mas_bottom).offset(19 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
    }];
    
    [_minRent mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_maxRent.mas_bottom).offset(19 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
    }];
    
    [_intentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_minRent.mas_bottom).offset(19 *SIZE);
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
    
    [_RePriceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_dashesLine.mas_bottom).offset(16 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
    }];
    
    [_attentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_RePriceL.mas_bottom).offset(19 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
    }];
    
    [_periodL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_attentL.mas_bottom).offset(19 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
    }];
    
    [_infoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(_periodL.mas_bottom).offset(22 *SIZE);
        make.width.mas_equalTo(120 *SIZE);
        make.height.mas_equalTo(47 *SIZE);
        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
    }];
    
    [_advantageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(120 *SIZE);
        make.top.equalTo(_periodL.mas_bottom).offset(22 *SIZE);
        make.width.mas_equalTo(120 *SIZE);
        make.height.mas_equalTo(47 *SIZE);
        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
    }];
    
    [_followBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(240 *SIZE);
        make.top.equalTo(_periodL.mas_bottom).offset(22 *SIZE);
        make.width.mas_equalTo(120 *SIZE);
        make.height.mas_equalTo(47 *SIZE);
        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
    }];
}

@end
