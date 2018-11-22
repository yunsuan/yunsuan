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
    
    for (int i = 0; i < 11 ; i++) {
        
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
                _propertyL = label;
                [self.contentView addSubview:_propertyL];
                break;
            }
            case 3:
            {
                _houseTypeL = label;
                [self.contentView addSubview:_houseTypeL];
                break;
            }
            case 4:
            {
                _payWayL = label;
                [self.contentView addSubview:_payWayL];
                break;
            }
            case 5:
            {
                _typeL = label;
                [self.contentView addSubview:_typeL];
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
        make.bottom.equalTo(_codeView).offset(-19 *SIZE);
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
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
    }];
    
    [_propertyL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_priceL.mas_bottom).offset(19 *SIZE);
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
    
    [_typeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_payWayL.mas_bottom).offset(19 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
    }];
    
    [_intentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_typeL.mas_bottom).offset(19 *SIZE);
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
