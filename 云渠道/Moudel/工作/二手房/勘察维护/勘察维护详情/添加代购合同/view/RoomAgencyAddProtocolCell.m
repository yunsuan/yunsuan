//
//  RoomAgencyAddProtocolCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/6/21.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RoomAgencyAddProtocolCell.h"

@interface RoomAgencyAddProtocolCell()
{

    NSArray *_titleArr;
}

@end

@implementation RoomAgencyAddProtocolCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setDic:(NSMutableDictionary *)dic{
    
    _nameTF.textfield.text = dic[@"name"];
    if ([dic[@"sex"] integerValue] == 1) {
        
        _genderBtn.content.text = @"男";
    }else if ([dic[@"sex"] integerValue] == 2){
        
        _genderBtn.content.text = @"女";
    }else{
        
        _genderBtn.content.text = @"";
    }

    _phoneTF.textfield.text = @"";
    _phoneTF2.textfield.text = @"";
    if ([dic[@"tel"] count]) {
        
        if ([dic[@"tel"] count] == 1) {
            
            _phoneTF.textfield.text = dic[@"tel"][0];
        }else{
            
            _phoneTF.textfield.text = dic[@"tel"][0];
            _phoneTF2.textfield.text = dic[@"tel"][1];
        }
    }
    
    NSDictionary *configdic = [UserModelArchiver unarchive].Configdic;
    NSDictionary *tempDic =  [configdic valueForKey:[NSString stringWithFormat:@"%d",2]];
    NSArray *typeArr = tempDic[@"param"];
    _certTypeBtn.content.text = @"";
    for (int i = 0; i < typeArr.count; i++) {
        
        if ([typeArr[i][@"id"] integerValue] == [dic[@"card_type"] integerValue]) {
            
            _certTypeBtn.content.text = [NSString stringWithFormat:@"%@",typeArr[i][@"param"]];
            break;
        }
    }
    
    if ([dic[@"card_id"] length]) {
        
        _certNumTF.textfield.text = [NSString stringWithFormat:@"%@",dic[@"card_id"]];
    }else{
        
        _certNumTF.textfield.text = @"";
    }
    
    if ([dic[@"address"] length]) {
        
        _addressTF.textfield.text = [NSString stringWithFormat:@"%@",dic[@"address"]];
    }else{
        
        _addressTF.textfield.text = @"";
    }
}

-(void)textChange:(UITextField *)textField{
    if (!self.data) {
        self.data = [NSMutableDictionary dictionary];
    }
    if (textField.tag ==1001) {
         [self.data setValue:textField.text forKey:@"name"];
    }else if (textField.tag == 1002)
    {
        [self.data setValue:textField.text forKey:@"card_id"];
    }else if (textField.tag == 1003)
    {
        [self.data setValue:textField.text forKey:@"address"];
    }
    else if(textField.tag == 1004){
        [self.data setValue:textField.text forKey:@"tel1"];
    }
    else{
        [self.data setValue:textField.text forKey:@"tel2"];
    }
    if (self.RoomAgencyBlock) {
        self.RoomAgencyBlock(self.tag,self.data);
    }
}



- (void)ActionAddBtn:(UIButton *)btn{
    
    if (self.roomAgencyAddProtocolCellBlock) {
        
        self.roomAgencyAddProtocolCellBlock(self.tag);
    }
}

- (void)ActionSexBtn:(UIButton *)btn{
    
    if (self.roomAgencyAddProtocolCellSexBlock) {
        
        self.roomAgencyAddProtocolCellSexBlock(self.tag);
    }
}

- (void)ActionCardBtn:(UIButton *)btn{
    
    if (self.roomAgencyAddProtocolCellCardBlock) {
        
        self.roomAgencyAddProtocolCellCardBlock(self.tag);
    }
}



- (void)initUI{
    
    _titleArr = @[@"性别:",@"主权益人名称：",@"联系电话：",@"联系电话2：",@"证件类型：",@"证件编号：",@"通讯地址："];
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    for (int i = 0; i < 7; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = YJTitleLabColor;
        label.text = _titleArr[i];
        label.adjustsFontSizeToFitWidth = YES;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        
        BorderTF *textField = [[BorderTF alloc] initWithFrame:CGRectMake(81 *SIZE, 17 *SIZE, 257 *SIZE, 33 *SIZE)];
//        textField.textfield.delegate = self;
        switch (i) {
            case 0:
            {
                _genderL = label;
                [self.contentView addSubview:_genderL];
                _genderBtn = [[DropDownBtn alloc] initWithFrame:CGRectMake(251 *SIZE, 17 *SIZE, 67 *SIZE, 33 *SIZE)];
                [_genderBtn addTarget:self action:@selector(ActionSexBtn:) forControlEvents:UIControlEventTouchUpInside];
                [self.contentView addSubview:_genderBtn];
                break;
            }
            case 1:
            {
                _nameL = label;
                [self.contentView addSubview:_nameL];
//                textField.frame = CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
                _nameTF = textField;
                _nameTF.textfield.tag = 1001;
                [_nameTF.textfield addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingDidEnd];
                [self.contentView addSubview:_nameTF];
                break;
            }
            case 2:
            {
                _phoneL = label;
                [self.contentView addSubview:_phoneL];
                _phoneTF = textField;
                _phoneTF.textfield.tag =1004;
                [_phoneTF.textfield addTarget:self action:@selector(textChange:)
                 forControlEvents:UIControlEventEditingDidEnd];
                _phoneTF.textfield.keyboardType = UIKeyboardTypePhonePad;
                [self.contentView addSubview:_phoneTF];
                break;
            }
            case 3:
            {
                _phoneL2 = label;
//                [self.contentView addSubview:_phoneL2];
                _phoneTF2 = textField;
                _phoneTF2.textfield.tag =1005;
                [_phoneTF2.textfield addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingDidEnd];
                _phoneTF.textfield.keyboardType = UIKeyboardTypePhonePad;
//                [self.contentView addSubview:_phoneTF2];
                break;
            }
            case 4:
            {
                _certTypeL = label;
                [self.contentView addSubview:_certTypeL];
                _certTypeBtn = [[DropDownBtn alloc] initWithFrame:textField.frame];
                [_certTypeBtn addTarget:self action:@selector(ActionCardBtn:) forControlEvents:UIControlEventTouchUpInside];
                [self.contentView addSubview:_certTypeBtn];
                break;
            }
            case 5:
            {
                _certNumL = label;
                [self.contentView addSubview:_certNumL];
                _certNumTF = textField;
                _certNumTF.textfield.keyboardType = UIKeyboardTypeNumberPad;
                _certNumTF.textfield.tag =1002;
                [_certNumTF.textfield addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingDidEnd];
//                _certNumTF.userInteractionEnabled = NO;
//                _certNumTF.textfield.placeholder = @"自动生成";
                [self.contentView addSubview:_certNumTF];
                break;
            }
            case 6:
            {
                _addressL = label;
                [self.contentView addSubview:_addressL];
                _addressTF = textField;
                _addressTF.textfield.tag =1003;
                [_addressTF.textfield addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingDidEnd];
//                _addressTF.userInteractionEnabled = NO;
//                _addressTF.textfield.placeholder = @"自动生成";
                [self.contentView addSubview:_addressTF];
                break;
            }
            default:
                break;
        }
    }
    
    _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_addBtn addTarget:self action:@selector(ActionAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_addBtn setImage:[UIImage imageNamed:@"add_3-1"] forState:UIControlStateNormal];
    [self.contentView addSubview:_addBtn];
    
    
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = YJBackColor;
    [self.contentView addSubview:_lineView];
    
    [self masonryUI];
}

- (void)masonryUI{
    
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(self.contentView).offset(30 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_nameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(81 *SIZE);
        make.top.equalTo(self.contentView).offset(17 *SIZE);
        make.width.mas_equalTo(107 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
//        make.bottom.equalTo(self.contentView).offset(-20 *SIZE);
    }];
    
    [_addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(190 *SIZE);
        make.top.equalTo(self.contentView).offset(20 *SIZE);
        make.width.mas_equalTo(25 *SIZE);
        make.height.mas_equalTo(25 *SIZE);
    }];
    
    [_genderL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(228 *SIZE);
        make.top.equalTo(self.contentView).offset(30 *SIZE);
        make.width.mas_equalTo(50 *SIZE);
    }];
    
    [_genderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(271 *SIZE);
        make.top.equalTo(self.contentView).offset(17 *SIZE);
        make.width.mas_equalTo(67 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
        //        make.bottom.equalTo(self.contentView).offset(-20 *SIZE);
    }];
    
    [_phoneL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(_nameTF.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(81 *SIZE);
        make.top.equalTo(_nameTF.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
        //        make.bottom.equalTo(self.contentView).offset(-20 *SIZE);
    }];
    
//    [_phoneL2 mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self.contentView).offset(9 *SIZE);
//        make.top.equalTo(_phoneTF.mas_bottom).offset(31 *SIZE);
//        make.width.mas_equalTo(70 *SIZE);
//    }];
//
//    [_phoneTF2 mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self.contentView).offset(81 *SIZE);
//        make.top.equalTo(_phoneTF.mas_bottom).offset(20 *SIZE);
//        make.width.mas_equalTo(257 *SIZE);
//        make.height.mas_equalTo(33 *SIZE);
//        //        make.bottom.equalTo(self.contentView).offset(-20 *SIZE);
//    }];
    
    [_certTypeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(_phoneTF.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_certTypeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(81 *SIZE);
        make.top.equalTo(_phoneTF.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
        //        make.bottom.equalTo(self.contentView).offset(-20 *SIZE);
    }];
    
    [_certNumL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(_certTypeBtn.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_certNumTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(81 *SIZE);
        make.top.equalTo(_certTypeBtn.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
        //        make.bottom.equalTo(self.contentView).offset(-20 *SIZE);
    }];
    
    [_addressL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(_certNumTF.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_addressTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(81 *SIZE);
        make.top.equalTo(_certNumTF.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
//        make.bottom.equalTo(self.contentView).offset(-20 *SIZE);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0);
        make.top.equalTo(_addressTF.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(2 *SIZE);
        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
    }];
}

@end
