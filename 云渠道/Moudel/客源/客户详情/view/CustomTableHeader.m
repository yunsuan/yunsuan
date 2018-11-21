//
//  CustomTableHeader.m
//  云渠道
//
//  Created by 谷治墙 on 2018/3/22.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "CustomTableHeader.h"
//#import "CustomHeaderCollCell.h"

@interface CustomTableHeader()
{
    
    NSArray *_titleArr;
}

@end

@implementation CustomTableHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        _titleArr = @[@"需求信息",@"跟进记录",@"匹配信息"];
        [self initUI];
    }
    return self;
}

- (void)setModel:(CustomerModel *)model{
    
    if (model.client_type.length) {
        
        _typeL.text = [NSString stringWithFormat:@"需求类型：%@",model.client_type];
    }else{
        
        _typeL.text = @"需求类型：";

    }
    
    if (model.client_property_type.length) {
        
        _proTypeL.text = [NSString stringWithFormat:@"意向物业：%@",model.client_property_type];
        _proTypeL.hidden = NO;
        [_proTypeL mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentView).offset(28 *SIZE);
            make.top.equalTo(_typeL.mas_bottom).offset(18 *SIZE);
            make.right.equalTo(self.contentView).offset(-28 *SIZE);
        }];
        
        [_nameL mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentView).offset(28 *SIZE);
            make.top.equalTo(_proTypeL.mas_bottom).offset(18 *SIZE);
            make.right.equalTo(self.contentView).offset(-28 *SIZE);
        }];
    }else{
        
        _proTypeL.text = @"意向物业：";
        _proTypeL.hidden = YES;
//        [_proTypeL mas_makeConstraints:^(MASConstraintMaker *make) {
//
//            make.left.equalTo(self.contentView).offset(28 *SIZE);
//            make.top.equalTo(_typeL.mas_bottom).offset(18 *SIZE);
//            make.right.equalTo(self.contentView).offset(-28 *SIZE);
//        }];
        
        [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentView).offset(28 *SIZE);
            make.top.equalTo(_typeL.mas_bottom).offset(18 *SIZE);
            make.right.equalTo(self.contentView).offset(-28 *SIZE);
        }];
    }
    
    if (model.name) {
        
        self.nameL.text = [NSString stringWithFormat:@"姓名：%@",model.name];
    }else{
        
        self.nameL.text = @"姓名";
    }
    
    if ([model.sex integerValue] == 1) {
        
        self.genderL.text = @"性别：男";
    }else if([model.sex integerValue] == 2){
        
        self.genderL.text = @"性别：女";
    }else{
        
        self.genderL.text = @"性别：";
    }
    
    if (model.birth) {
        
        self.birthL.text = [NSString stringWithFormat:@"出生年月：%@",model.birth];
    }else{
        
        self.birthL.text = @"出生年月：";
    }
    
    if (model.tel) {
        
        self.phoneL.text = [NSString stringWithFormat:@"联系电话：%@",model.tel];
    }else{
        
        self.phoneL.text = @"联系电话：";
    }
    
    if (model.card_type.length) {
        
        self.certL.text = [NSString stringWithFormat:@"证件类型：%@",model.card_type];
    }else{
        
        self.certL.text = @"证件类型：";
    }
    
    
    if (model.card_id) {
        
        self.numL.text = [NSString stringWithFormat:@"证件号码：%@",model.card_id];
    }else{
        
        self.numL.text = @"证件号码：";
    }
    
    self.addressL.text = @"地址：";
    NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"region" ofType:@"json"]];
    
    NSError *err;
    NSArray *provice = [NSJSONSerialization JSONObjectWithData:JSONData
                                                  options:NSJSONReadingMutableContainers
                                                    error:&err];
    for (NSUInteger i = 0; i < provice.count; i++) {
        
        if([provice[i][@"code"] integerValue] == [model.province integerValue]){
            
            NSArray *city = provice[i][@"city"];
            for (NSUInteger j = 0; j < city.count; j++) {
                
                if([city[j][@"code"] integerValue] == [model.city integerValue]){
                    
                    NSArray *area = city[j][@"district"];
                    
                    for (NSUInteger k = 0; k < area.count; k++) {
                        
                        if([area[k][@"code"] integerValue] == [model.district integerValue]){
                    
                            self.addressL.text = [NSString stringWithFormat:@"地址：%@-%@-%@-%@",provice[i][@"name"],city[0][@"name"],area[k][@"name"],model.address];
                        }
                    }
                }
            }
        }
    }
}

- (void)ActionTagBtn:(UIButton *)btn{
    
    if (self.customTableHeaderTagBlock) {
        
        self.customTableHeaderTagBlock(btn.tag);
    }
}

- (void)ActionEditBtn:(UIButton *)btn{
    
    if (self.customTableHeaderEditBlock) {
        
        self.customTableHeaderEditBlock();
    }
}



- (void)initUI{
    
    self.contentView.backgroundColor = CH_COLOR_white;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10 *SIZE, 19 *SIZE, 7 *SIZE, 13 *SIZE)];
    view.backgroundColor = COLOR(27, 152, 255, 1);;
    [self.contentView addSubview:view];

    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(28 *SIZE, 19 *SIZE, 80 *SIZE, 15 *SIZE)];
    label1.textColor = YJTitleLabColor;
    label1.font = [UIFont systemFontOfSize:15 *SIZE];
    label1.text = @"客户信息";
    [self.contentView addSubview:label1];
    
    UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    editBtn.frame = CGRectMake(316 *SIZE, 16 *SIZE, 36 *SIZE, 22 *SIZE);
    editBtn.titleLabel.font = [UIFont systemFontOfSize:14 *sIZE];
    [editBtn addTarget:self action:@selector(ActionEditBtn:) forControlEvents:UIControlEventTouchUpInside];
    [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [editBtn setTitleColor:COLOR(27, 152, 255, 1) forState:UIControlStateNormal];
    [self.contentView addSubview:editBtn];
    
    for (int i = 0; i < 9; i++) {
        
        UILabel *label = [[UILabel alloc] init];//WithFrame:CGRectMake(28 *SIZE, 54 *SIZE + 31 *SIZE * i, 317 *SIZE, 31 *SIZE)];
        label.textColor = YJContentLabColor;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        
        switch (i) {
            case 0:
            {
                _typeL = label;
                [self.contentView addSubview:_typeL];
                break;
            }
            case 1:
            {
                _nameL = label;
                [self.contentView addSubview:_nameL];
                break;
            }
            case 2:
            {
                _genderL = label;
                [self.contentView addSubview:_genderL];
                break;
            }
            case 3:
            {
                _birthL = label;
                [self.contentView addSubview:_birthL];
                break;
            }
            case 4:
            {
                _phoneL = label;
                [self.contentView addSubview:_phoneL];
                break;
            }
            case 5:
            {
                _certL = label;
                [self.contentView addSubview:_certL];
                break;
            }
            case 6:
            {
                _numL = label;
                [self.contentView addSubview:_numL];
                break;
            }
            case 7:
            {
                _addressL = label;
                [self.contentView addSubview:_addressL];
                break;
            }
            case 8:
            {
                _proTypeL = label;
                [self.contentView addSubview:_proTypeL];
                break;
            }
            default:
                break;
        }
    }
    
    for (int i = 0; i < 3; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        btn.frame = CGRectMake(120 *SIZE * i, 320 *SIZE, 120 *SIZE, 47 *SIZE);
        btn.titleLabel.font = [UIFont systemFontOfSize:14 *sIZE];
        btn.tag = i;
        [btn setTitle:_titleArr[(NSUInteger) i] forState:UIControlStateNormal];
        [btn setBackgroundColor:COLOR(219, 219, 219, 1)];
        [btn addTarget:self action:@selector(ActionTagBtn:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:YJ86Color forState:UIControlStateNormal];
        if (i == 0) {
            
            _infoBtn = btn;
            [self.contentView addSubview:_infoBtn];
        }else if (i == 1){
            
            _followBtn = btn;
            [self.contentView addSubview:_followBtn];
        }else{
            
            _matchBtn = btn;
            [self.contentView addSubview:_matchBtn];
        }
    }
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_typeL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(self.contentView).offset(45 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
    }];
    
    [_proTypeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_typeL.mas_bottom).offset(18 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
    }];
    
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_proTypeL.mas_bottom).offset(18 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
    }];
    
    [_genderL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_nameL.mas_bottom).offset(18 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
    }];
    
    [_birthL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_genderL.mas_bottom).offset(18 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
    }];
    
    [_phoneL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_birthL.mas_bottom).offset(18 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
    }];
    
    [_certL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_phoneL.mas_bottom).offset(18 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
    }];
    
    [_numL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_certL.mas_bottom).offset(18 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
    }];
    
    [_addressL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_numL.mas_bottom).offset(18 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
    }];
    
    [_infoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(_addressL.mas_bottom).offset(14 *SIZE);
        make.width.mas_equalTo(119 *SIZE);
        make.height.mas_equalTo(47 *SIZE);
        make.bottom.equalTo(self.contentView).offset(0);
    }];
    
    [_followBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(120 *SIZE);
        make.top.equalTo(_addressL.mas_bottom).offset(14 *SIZE);
        make.width.mas_equalTo(119 *SIZE);
        make.height.mas_equalTo(47 *SIZE);
        make.bottom.equalTo(self.contentView).offset(0);
    }];
    
    [_matchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(240 *SIZE);
        make.top.equalTo(_addressL.mas_bottom).offset(14 *SIZE);
        make.width.mas_equalTo(120 *SIZE);
        make.height.mas_equalTo(47 *SIZE);
        make.bottom.equalTo(self.contentView).offset(0);
    }];
}

@end
