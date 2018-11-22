//
//  ReportView.m
//  云渠道
//
//  Created by 谷治墙 on 2018/6/12.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "ReportView.h"

@implementation ReportView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionAddBtn:(UIButton *)btn{
    
    if (self.reportViewAddBlock) {
        
        self.reportViewAddBlock();
    }
}

- (void)ActionSexBtn:(UIButton *)btn{
    
    if (self.reportViewSexBlock) {
        
        self.reportViewSexBlock();
    }
}

- (void)ActionTypeBtn:(UIButton *)btn{
    
    if (self.reportViewTypeBlock) {
        
        self.reportViewTypeBlock();
    }
}

- (void)ActionRelationshipBtn:(UIButton *)btn{
    
    if (self.reportViewRelationshipBlock) {
        
        self.reportViewRelationshipBlock();
    }
}

- (void)ActionAddressBtn:(UIButton *)btn{
    
    if (self.reportViewAddressBlock) {
        
        self.reportViewAddressBlock();
    }
}

- (void)initUI{
    
    self.backgroundColor = [UIColor whiteColor];
    
    _comL = [[UILabel alloc] init];
    _comL.textColor = YJTitleLabColor;
    _comL.numberOfLines = 0;
    _comL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self addSubview:_comL];
    
    _roomL = [[UILabel alloc] init];
    _roomL.textColor = YJTitleLabColor;
    _roomL.numberOfLines = 0;
    _roomL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self addSubview:_roomL];
    
    _nameL = [[UILabel alloc] init];
    _nameL.textColor = YJTitleLabColor;
    _nameL.text = @"联系人：";
    _nameL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self addSubview:_nameL];
    
    _nameTF = [[BorderTF alloc] initWithFrame:CGRectMake(80 *SIZE, 84 *SIZE, 117 *SIZE, 33 *SIZE)];
    [self addSubview:_nameTF];
    
    _sexL = [[UILabel alloc] init];
    _sexL.textColor = YJTitleLabColor;
    _sexL.text = @"性别：";
    _sexL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self addSubview:_sexL];
    
    _sexBtn = [[DropDownBtn alloc] initWithFrame:CGRectMake(251 *SIZE, 84 *SIZE, 87 *SIZE, 33 *SIZE)];
    [_sexBtn addTarget:self action:@selector(ActionSexBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_sexBtn];
    
    _telL = [[UILabel alloc] init];
    _telL.textColor = YJTitleLabColor;
    _telL.text = @"联系电话：";
    _telL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self addSubview:_telL];
    
    _tel1 = [[BorderTF alloc] initWithFrame:CGRectMake(80 *SIZE, 136 *SIZE, 217 *SIZE, 33 *SIZE)];
    _tel1.textfield.keyboardType = UIKeyboardTypePhonePad;
    [self addSubview:_tel1];
    
    _tel2 = [[BorderTF alloc] initWithFrame:CGRectMake(80 *SIZE, 136 *SIZE, 217 *SIZE, 33 *SIZE)];
    _tel2.textfield.keyboardType = UIKeyboardTypePhonePad;
    _tel2.hidden = YES;
    [self addSubview:_tel2];
    
    _tel3 = [[BorderTF alloc] initWithFrame:CGRectMake(80 *SIZE, 136 *SIZE, 258 *SIZE, 33 *SIZE)];
    _tel3.textfield.keyboardType = UIKeyboardTypePhonePad;
    _tel3.hidden = YES;
    [self addSubview:_tel3];
    
    _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _addBtn.frame = CGRectMake(308 *SIZE, 141 *SIZE, 35 *SIZE, 35 *SIZE);
    [_addBtn addTarget:self action:@selector(ActionAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_addBtn setImage:[UIImage imageNamed:@"add_2"] forState:UIControlStateNormal];
    [self addSubview:_addBtn];
    
    _typeL = [[UILabel alloc] init];
    _typeL.textColor = YJTitleLabColor;
    _typeL.text = @"证件类型：";
    _typeL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self addSubview:_typeL];
    
    _typeBtn = [[DropDownBtn alloc] initWithFrame:CGRectMake(80 *SIZE, 186 *SIZE, 258 *SIZE, 33 *SIZE)];
    [_typeBtn addTarget:self action:@selector(ActionTypeBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_typeBtn];
    
    _numL = [[UILabel alloc] init];
    _numL.textColor = YJTitleLabColor;
    _numL.text = @"证件编号：";
    _numL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self addSubview:_numL];
    
    _numTF = [[BorderTF alloc] initWithFrame:CGRectMake(80 *SIZE, 186 *SIZE, 258 *SIZE, 33 *SIZE)];
    [self addSubview:_numTF];
    
    _relationL = [[UILabel alloc] init];
    _relationL.textColor = YJTitleLabColor;
    _relationL.text = @"与业主的关系：";
    _relationL.adjustsFontSizeToFitWidth = YES;
    _relationL.font = [UIFont systemFontOfSize:11 *SIZE];
    [self addSubview:_relationL];
    
    _relationBtn = [[DropDownBtn alloc] initWithFrame:CGRectMake(251 *SIZE, 240 *SIZE, 258 *SIZE, 33 *SIZE)];
    [_relationBtn addTarget:self action:@selector(ActionRelationshipBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_relationBtn];
    
    _addressL = [[UILabel alloc] init];
    _addressL.textColor = YJTitleLabColor;
    _addressL.text = @"通讯地址：";
    _addressL.adjustsFontSizeToFitWidth = YES;
    _addressL.font = [UIFont systemFontOfSize:11 *SIZE];
    [self addSubview:_addressL];
    
    _addressBtn = [[DropDownBtn alloc] initWithFrame:CGRectMake(251 *SIZE, 240 *SIZE, 258 *SIZE, 33 *SIZE)];
    [_addressBtn addTarget:self action:@selector(ActionAddressBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_addressBtn];
    
    
    _addressTV = [[UITextView alloc] init];
    _addressTV.layer.cornerRadius = 5 *SIZE;
    _addressTV.clipsToBounds = YES;
    _addressTV.layer.borderWidth = SIZE;
    _addressTV.layer.borderColor = COLOR(219, 219, 219, 1).CGColor;
    [self addSubview:_addressTV];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_comL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self).offset(10 *SIZE);
        make.top.equalTo(self).offset(17 *SIZE);
        make.right.equalTo(self).offset(-10 *SIZE);
    }];
    
    [_roomL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(10 *SIZE);
        make.top.equalTo(_comL.mas_bottom).offset(15 *SIZE);
        make.right.equalTo(self).offset(-10 *SIZE);
    }];
    
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(10 *SIZE);
        make.top.equalTo(_roomL.mas_bottom).offset(37 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_nameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(_roomL.mas_bottom).offset(27 *SIZE);
        make.width.mas_equalTo(117 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_sexL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(209 *SIZE);
        make.top.equalTo(_roomL.mas_bottom).offset(37 *SIZE);
        make.width.mas_equalTo(40 *SIZE);
    }];
    
    [_sexBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(251 *SIZE);
        make.top.equalTo(_roomL.mas_bottom).offset(27 *SIZE);
        make.width.mas_equalTo(87 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    
    [_telL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(10 *SIZE);
        make.top.equalTo(_nameTF.mas_bottom).offset(29 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_tel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(81 *SIZE);
        make.top.equalTo(_nameTF.mas_bottom).offset(19 *SIZE);
        make.width.mas_equalTo(217 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_typeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(10 *SIZE);
        make.top.equalTo(_tel1.mas_bottom).offset(29 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_typeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(81 *SIZE);
        make.top.equalTo(_tel1.mas_bottom).offset(19 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_numL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(10 *SIZE);
        make.top.equalTo(_typeBtn.mas_bottom).offset(29 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_numTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(81 *SIZE);
        make.top.equalTo(_typeBtn.mas_bottom).offset(19 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_relationL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(10 *SIZE);
        make.top.equalTo(_numTF.mas_bottom).offset(29 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_relationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(81 *SIZE);
        make.top.equalTo(_numTF.mas_bottom).offset(19 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
//        make.bottom.equalTo(self).offset(-24 *SIZE);
    }];
    
    [_addressL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(10 *SIZE);
        make.top.equalTo(_relationBtn.mas_bottom).offset(29 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_addressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(81 *SIZE);
        make.top.equalTo(_relationBtn.mas_bottom).offset(19 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
//        make.bottom.equalTo(self).offset(-24 *SIZE);
    }];
    
    [_addressTV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(81 *SIZE);
        make.top.equalTo(_addressBtn.mas_bottom).offset(19 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(50 *SIZE);
        make.bottom.equalTo(self).offset(-24 *SIZE);
    }];
}


@end
