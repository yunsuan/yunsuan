//
//  AddAreaCustomView.m
//  云渠道
//
//  Created by 谷治墙 on 2019/12/2.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "AddAreaCustomView.h"

@interface AddAreaCustomView ()<UITextFieldDelegate>

@end

@implementation AddAreaCustomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionTagBtn:(UIButton *)btn{
    
    if (self.addAreaCustomViewTagBlock) {
        
        self.addAreaCustomViewTagBlock(btn.tag);
    }
}

- (void)ActionTap:(UITapGestureRecognizer *)tap{
    
    if (self.addAreaCustomViewImgBlock) {
        
        self.addAreaCustomViewImgBlock(tap.view.tag);
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (textField == _phoneTF1.textfield) {
        
    }else if (textField == _phoneTF2.textfield){
        
        
    }else if (textField == _phoneTF3.textfield){
        
        
    }else if (textField == _cardNumTF.textfield){
        
        if ([_cardTypeBtn.content.text isEqualToString:@"身份证"]) {
            
            if (self.addAreaCustomViewStrBlock) {
                
                self.addAreaCustomViewStrBlock(textField.text);
            }
            if ([self validateIDCardNumber:textField.text]) {
                
                _birthBtn.content.text = [self subsIDStrToDate:textField.text];
            }else{
                
                _cardNumTF.textfield.text = @"";
            }
            if ([self genderOfIDNumber:textField.text] == 1) {
                
                _genderBtn.content.text = @"男";
                _genderBtn->str = @"1";
            }else if ([self genderOfIDNumber:textField.text] == 2){
                
                _genderBtn.content.text = @"女";
                _genderBtn->str = @"2";
            }
        }
    }
}

- (BOOL)validateIDCardNumber:(NSString *)value {
    
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSInteger length =0;
    if (!value) {
        return NO;
    }else {
        length = value.length;
        //不满足15位和18位，即身份证错误
        if (length !=15 && length !=18) {
            return NO;
        }
    }
    // 省份代码
    NSArray *areasArray = @[@"11",@"12", @"13",@"14", @"15",@"21", @"22",@"23", @"31",@"32", @"33",@"34", @"35",@"36", @"37",@"41", @"42",@"43", @"44",@"45", @"46",@"50", @"51",@"52", @"53",@"54", @"61",@"62", @"63",@"64", @"65",@"71", @"81",@"82", @"91"];
    
    // 检测省份身份行政区代码
    NSString *valueStart2 = [value substringToIndex:2];
    BOOL areaFlag =NO; //标识省份代码是否正确
    for (NSString *areaCode in areasArray) {
        if ([areaCode isEqualToString:valueStart2]) {
            areaFlag =YES;
            break;
        }
    }
    
    if (!areaFlag) {
        return NO;
    }
    
    NSRegularExpression *regularExpression;
    NSUInteger numberofMatch;
    
    int year =0;
    //分为15位、18位身份证进行校验
    switch (length) {
        case 15:
            //获取年份对应的数字
            year = [value substringWithRange:NSMakeRange(6,2)].intValue +1900;
            
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                //创建正则表达式 NSRegularExpressionCaseInsensitive：不区分字母大小写的模式
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$"
                                                                        options:NSRegularExpressionCaseInsensitive error:nil];//测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$"
                                                                        options:NSRegularExpressionCaseInsensitive error:nil];//测试出生日期的合法性
            }
            //使用正则表达式匹配字符串 NSMatchingReportProgress:找到最长的匹配字符串后调用block回调
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, value.length)];
            
            if(numberofMatch >0) {
                return YES;
            }else {
                return NO;
            }
        case 18:
            year = [value substringWithRange:NSMakeRange(6,4)].intValue;
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^((1[1-5])|(2[1-3])|(3[1-7])|(4[1-6])|(5[0-4])|(6[1-5])|71|(8[12])|91)\\d{4}(((19|20)\\d{2}(0[13-9]|1[012])(0[1-9]|[12]\\d|30))|((19|20)\\d{2}(0[13578]|1[02])31)|((19|20)\\d{2}02(0[1-9]|1\\d|2[0-8]))|((19|20)([13579][26]|[2468][048]|0[048])0229))\\d{3}(\\d|X|x)?$" options:NSRegularExpressionCaseInsensitive error:nil];//测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^((1[1-5])|(2[1-3])|(3[1-7])|(4[1-6])|(5[0-4])|(6[1-5])|71|(8[12])|91)\\d{4}(((19|20)\\d{2}(0[13-9]|1[012])(0[1-9]|[12]\\d|30))|((19|20)\\d{2}(0[13578]|1[02])31)|((19|20)\\d{2}02(0[1-9]|1\\d|2[0-8]))|((19|20)([13579][26]|[2468][048]|0[048])0229))\\d{3}(\\d|X|x)?$" options:NSRegularExpressionCaseInsensitive error:nil];//测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, value.length)];
            
            
            if(numberofMatch >0) {
                //1：校验码的计算方法 身份证号码17位数分别乘以不同的系数。从第一位到第十七位的系数分别为：7－9－10－5－8－4－2－1－6－3－7－9－10－5－8－4－2。将这17位数字和系数相乘的结果相加。
                
                int S = [value substringWithRange:NSMakeRange(0,1)].intValue*7 + [value substringWithRange:NSMakeRange(10,1)].intValue *7 + [value substringWithRange:NSMakeRange(1,1)].intValue*9 + [value substringWithRange:NSMakeRange(11,1)].intValue *9 + [value substringWithRange:NSMakeRange(2,1)].intValue*10 + [value substringWithRange:NSMakeRange(12,1)].intValue *10 + [value substringWithRange:NSMakeRange(3,1)].intValue*5 + [value substringWithRange:NSMakeRange(13,1)].intValue *5 + [value substringWithRange:NSMakeRange(4,1)].intValue*8 + [value substringWithRange:NSMakeRange(14,1)].intValue *8 + [value substringWithRange:NSMakeRange(5,1)].intValue*4 + [value substringWithRange:NSMakeRange(15,1)].intValue *4 + [value substringWithRange:NSMakeRange(6,1)].intValue*2 + [value substringWithRange:NSMakeRange(16,1)].intValue *2 + [value substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6 + [value substringWithRange:NSMakeRange(9,1)].intValue *3;
                
                //2：用加出来和除以11，看余数是多少？余数只可能有0－1－2－3－4－5－6－7－8－9－10这11个数字
                int Y = S %11;
                NSString *M =@"F";
                NSString *JYM =@"10X98765432";
                M = [JYM substringWithRange:NSMakeRange(Y,1)];// 3：获取校验位
                
                NSString *lastStr = [value substringWithRange:NSMakeRange(17,1)];
                
                NSLog(@"%@",M);
                NSLog(@"%@",[value substringWithRange:NSMakeRange(17,1)]);
                //4：检测ID的校验位
                if ([lastStr isEqualToString:@"x"]) {
                    if ([M isEqualToString:@"X"]) {
                        return YES;
                    }else{
                        
                        return NO;
                    }
                }else{
                    
                    if ([M isEqualToString:[value substringWithRange:NSMakeRange(17,1)]]) {
                        return YES;
                    }else {
                        return NO;
                    }
                    
                }
                
                
            }else {
                return NO;
            }
        default:
            return NO;
    }
}

//截取身份证的出生日期并转换为日期格式
- (NSString *)subsIDStrToDate:(NSString *)str{
    NSMutableString *result = [NSMutableString stringWithCapacity:0];
    
    NSString *dateStr = [str substringWithRange:NSMakeRange(6, 8)];
    NSString  *year = [dateStr substringWithRange:NSMakeRange(0, 4)];
    NSString  *month = [dateStr substringWithRange:NSMakeRange(4, 2)];
    NSString  *day = [dateStr substringWithRange:NSMakeRange(6,2)];
    
    [result appendString:year];
    [result appendString:@"-"];
    [result appendString:month];
    [result appendString:@"-"];
    [result appendString:day];
    
    return result;
}

//身份证号辨别男女
- (NSInteger)genderOfIDNumber:(NSString *)IDNumber
{
    //  记录校验结果：0未知，1男，2女
    NSInteger result = 0;
    NSString *fontNumer = nil;
    
    if (IDNumber.length == 15)
    { // 15位身份证号码：第15位代表性别，奇数为男，偶数为女。
        fontNumer = [IDNumber substringWithRange:NSMakeRange(14, 1)];
        
    }else if (IDNumber.length == 18)
    { // 18位身份证号码：第17位代表性别，奇数为男，偶数为女。
        fontNumer = [IDNumber substringWithRange:NSMakeRange(16, 1)];
    }else
    { //  不是15位也不是18位，则不是正常的身份证号码，直接返回
        return result;
    }
    
    NSInteger genderNumber = [fontNumer integerValue];
    
    if(genderNumber % 2 == 1)
        result = 1;
    
    else if (genderNumber % 2 == 0)
        result = 2;
    return result;
}

- (void)initUI{
    
    self.backgroundColor = CLWhiteColor;
    
    NSArray *arr = @[@"推荐区域：",@"名称：",@"性别：",@"联系电话：",@"证件类型：",@"证件号：",@"出生年月：",@"地址："];
    for (int i = 0; i < 8; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = YJTitleLabColor;
        label.adjustsFontSizeToFitWidth = YES;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        label.text = arr[i];
        
        DropDownBtn *btn = [[DropDownBtn alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
        btn.tag = i;
        [btn addTarget:self action:@selector(ActionTagBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        BorderTF *tf = [[BorderTF alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
        tf.textfield.delegate = self;
        switch (i) {
            case 0:
            {
                _regionL = label;
                NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"*%@",_regionL.text]];
                [attr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
                _regionL.attributedText = attr;
                [self addSubview:_regionL];
                
                _regionBtn = [[DropDownBtn alloc] initWithFrame:CGRectMake(0, 0, 120 *SIZE, 33 *SIZE)];
                _regionBtn.tag = i;
                [_regionBtn addTarget:self action:@selector(ActionTagBtn:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:_regionBtn];
                
                _nameTF = [[BorderTF alloc] initWithFrame:CGRectMake(0, 0, 130 *SIZE, 33 *SIZE)];
                _nameTF.textfield.delegate = self;
                [self addSubview:_nameTF];
                break;
            }
            case 1:
            {
                _nameL = label;
                NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"*%@",_nameL.text]];
                [attr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
                _nameL.attributedText = attr;
                [self addSubview:_nameL];
                
                _regionBtn1 = [[DropDownBtn alloc] initWithFrame:CGRectMake(0, 0, 120 *SIZE, 33 *SIZE)];
                _regionBtn1.tag = i;
                [_regionBtn1 addTarget:self action:@selector(ActionTagBtn:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:_regionBtn1];
                
                _phoneTF1 = tf;
                [self addSubview:_phoneTF1];
                break;
            }
            case 2:
            {
                _genderL = label;
                NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"*%@",_genderL.text]];
                [attr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
                _genderL.attributedText = attr;
                [self addSubview:_genderL];
                
                _genderBtn = [[DropDownBtn alloc] initWithFrame:CGRectMake(0, 0, 60 *SIZE, 33 *SIZE)];
                _genderBtn.tag = i;
                [_genderBtn addTarget:self action:@selector(ActionTagBtn:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:_genderBtn];
                
                _phoneTF2 = tf;
                _phoneTF2.hidden = YES;
                [self addSubview:_phoneTF2];
                break;
            }
            case 3:
            {
                _phoneL = label;
                NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"*%@",_phoneL.text]];
                [attr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
                _phoneL.attributedText = attr;
                [self addSubview:_phoneL];
                
                _cardTypeBtn = btn;
                [self addSubview:_cardTypeBtn];
                
                _phoneTF3 = tf;
                _phoneTF3.hidden = YES;
                [self addSubview:_phoneTF3];
                break;
            }
            case 4:
            {
                _cardTypeL = label;
                [self addSubview:_cardTypeL];
                
                _birthBtn = btn;
                [self addSubview:_birthBtn];
                
                _cardNumTF = tf;
                [self addSubview:_cardNumTF];
                break;
            }
            case 5:
            {
                _cardNumL = label;
                [self addSubview:_cardNumL];
                
                _addressBtn = btn;
                [self addSubview:_addressBtn];
                
                _addressTF = tf;
                [self addSubview:_addressTF];
                break;
            }
            case 6:
            {
                _birthL = label;
                [self addSubview:_birthL];
                break;
            }
            case 7:
            {
                _addressL = label;
                [self addSubview:_addressL];
                break;
            }
            default:
                break;
        }
    }
    
    for (int i = 0; i < 3; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = YJTitleLabColor;
        label.adjustsFontSizeToFitWidth = YES;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        
        UIImageView *img = [[UIImageView alloc] init];
        img.image = [UIImage imageNamed:@"banner_default_2"];
        img.clipsToBounds = YES;
        img.contentMode = UIViewContentModeScaleAspectFill;
        img.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ActionTap:)];
        [img addGestureRecognizer:tap];
        if (i == 0) {
            
            _positiveL = label;
            _positiveL.text = @"身份证正面：";
            [self addSubview:_positiveL];
            
            _positiveImg = img;
            [self addSubview:_positiveImg];
        }else if (i == 1){
            
            _backL = label;
            _backL.text = @"身份证反面：";
            [self addSubview:_backL];
            
            _backImg = img;
            [self addSubview:_backImg];
        }else{
            
            _otherL = label;
            _otherL.text = @"其他证明：";
            [self addSubview:_otherL];
            
            _otherImg = img;
            [self addSubview:_otherImg];
        }
    }
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_regionL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self).offset(10 *SIZE);
        make.top.equalTo(self).offset(14 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_regionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(self).offset(10 *SIZE);
        make.width.mas_equalTo(120 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_regionBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(218 *SIZE);
        make.top.equalTo(self).offset(10 *SIZE);
        make.width.mas_equalTo(120 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(10 *SIZE);
        make.top.equalTo(_regionBtn.mas_bottom).offset(14 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_nameTF mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(_regionBtn.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(120 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_genderL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(228 *SIZE);
        make.top.equalTo(_regionBtn.mas_bottom).offset(14 *SIZE);
        make.width.mas_equalTo(40 *SIZE);
    }];
    
    [_genderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(278 *SIZE);
        make.top.equalTo(_regionBtn.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(60 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_phoneL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(10 *SIZE);
        make.top.equalTo(_genderBtn.mas_bottom).offset(14 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_phoneTF1 mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(_genderBtn.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_phoneTF2 mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(_phoneTF1.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_phoneTF3 mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(_phoneTF2.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_cardTypeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(10 *SIZE);
        make.top.equalTo(_phoneTF1.mas_bottom).offset(14 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_cardTypeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(_phoneTF1.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_cardNumL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(10 *SIZE);
        make.top.equalTo(_cardTypeBtn.mas_bottom).offset(14 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_cardNumTF mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(_cardTypeBtn.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_birthL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(10 *SIZE);
        make.top.equalTo(_cardNumTF.mas_bottom).offset(14 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_birthBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(_cardNumTF.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_addressL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(10 *SIZE);
        make.top.equalTo(_birthBtn.mas_bottom).offset(14 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_addressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(_birthBtn.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_addressTF mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(_addressBtn.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
//        make.bottom.equalTo(self).offset(-20 *SIZE);
    }];
    
    [_positiveL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(10 *SIZE);
        make.top.equalTo(_addressTF.mas_bottom).offset(14 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
    }];
    
    [_positiveImg mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self).offset(10 *SIZE);
        make.top.equalTo(_positiveL.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(340 *SIZE);
        make.height.mas_equalTo(170 *SIZE);
    }];
    
    [_backL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(10 *SIZE);
        make.top.equalTo(_positiveImg.mas_bottom).offset(14 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
    }];
    
    [_backImg mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self).offset(10 *SIZE);
        make.top.equalTo(_backL.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(340 *SIZE);
        make.height.mas_equalTo(170 *SIZE);
        
    }];
    
    [_otherL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(10 *SIZE);
        make.top.equalTo(_backImg.mas_bottom).offset(14 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
    }];
    
    [_otherImg mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self).offset(10 *SIZE);
        make.top.equalTo(_otherL.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(340 *SIZE);
        make.height.mas_equalTo(170 *SIZE);
        make.bottom.equalTo(self).offset(-20 *SIZE);
    }];
}

@end
