//
//  AddCustomerVC.m
//  云渠道
//
//  Created by xiaoq on 2018/3/28.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "AddCustomerVC.h"
#import "AddRequireMentVC.h"

#import "AddHouseRequireMentVC.h"
#import "AddStoreRequireMentVC.h"
#import "AddOfficeRequireMentVC.h"
#import "RentingAddRequireMentVC.h"
#import "RentingAddStoreRequireMentVC.h"
#import "RentingAddOfficeRequireMentVC.h"

#import "SinglePickView.h"
#import "DropDownBtn.h"
#import "BorderTF.h"
#import "DateChooseView.h"
#import "AdressChooseView.h"
//#import "CustomerModel.h"


@interface AddCustomerVC ()<UITextFieldDelegate>
{
    NSInteger _numAdd;
    CustomerModel *_model;
    BOOL _isHide;
    NSString *_tel4;
    NSString *_tel5;
    NSString *_tel6;
    NSString *_tel7;
}
@property (nonatomic , strong) UIScrollView *scrollview;
@property (nonatomic, strong) UILabel *nameL;
@property (nonatomic, strong) UILabel *numclasslab;
@property (nonatomic, strong) UILabel *numlab;
@property (nonatomic, strong) UILabel *adresslab;
@property (nonatomic , strong) UILabel *sexL;
@property (nonatomic , strong) DropDownBtn *sex;
@property (nonatomic , strong) BorderTF *name;
@property (nonatomic , strong) UILabel *birthL;
@property (nonatomic , strong) DropDownBtn *birth;
@property (nonatomic , strong) UILabel *telL;

@property (nonatomic, strong) UITextField *phoneTF1;

@property (nonatomic, strong) UITextField *phoneTF2;

@property (nonatomic, strong) UITextField *phoneTF3;

@property (nonatomic, strong) UITextField *phoneTF4;

@property (nonatomic, strong) UITextField *phoneTF5;

@property (nonatomic, strong) UITextField *phoneTF6;

@property (nonatomic, strong) UITextField *phoneTF7;

@property (nonatomic, strong) UITextField *phoneTF8;

@property (nonatomic, strong) UITextField *phoneTF9;

@property (nonatomic, strong) UITextField *phoneTF10;

@property (nonatomic, strong) UITextField *phoneTF11;

@property (nonatomic, strong) UILabel *hideL;

@property (nonatomic, strong) UIImageView *hideImg;

@property (nonatomic, strong) UILabel *hideReportL;

@property (nonatomic, strong) UIButton *hideBtn;

@property (nonatomic , strong) DropDownBtn *numclass;
@property (nonatomic , strong) BorderTF *num;
@property (nonatomic , strong) DropDownBtn *adress;
@property (nonatomic , strong) UITextView *detailadress;
@property (nonatomic, strong) UILabel *needL;
@property (nonatomic , strong) DropDownBtn *needBtn;

@property (nonatomic, strong) DropDownBtn *typeBtn;

@property (nonatomic, strong) UILabel *typeL;

@property (nonatomic , strong) UIButton *surebtn;
@property (nonatomic , strong) CustomerInfoModel *Customerinfomodel;

-(void)initUI;

-(void)initDataSouce;

- (void)ActionAddBtn;
@end

@implementation AddCustomerVC

- (instancetype)initWithModel:(CustomerModel *)model
{
    self = [super init];
    if (self) {
        
        _model = [[CustomerModel alloc] init];
        _model = model;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navBackgroundView.hidden = NO;

    if (_model.client_id) {
        
        self.titleLabel.text = @"修改信息";
        _isHide = [_model.is_hide_tel boolValue];
        if (_isHide) {
            
            _hideReportL.text = @"当前隐号报备";
            _phoneTF4.userInteractionEnabled = NO;
            _phoneTF5.userInteractionEnabled = NO;
            _phoneTF6.userInteractionEnabled = NO;
            _phoneTF7.userInteractionEnabled = NO;
        }
    }else{
        
        _hideReportL.text = @"当前显号报备";
        _hideL.text = @"需要补全电话号码";
        _hideImg.image = [UIImage imageNamed:@"eye_2"];
        self.titleLabel.text = @"添加客户";
        _isHide = NO;
    }
    [self initDataSouce];
    [self initUI];
}

-(void)initDataSouce
{
    _Customerinfomodel = [[CustomerInfoModel alloc]init];
    _Customerinfomodel.sex = @"0";
}

- (void)ActionAddBtn {
    
}


- (void)ActionNeedBtn:(UIButton *)btn{
    
    if (btn.tag == 2) {
        
        SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:@[@{@"param":@"住宅",
            @"id":@"1"
                                                                                                   },@{@"param":@"商铺",
                                                                                                       @"id":@"2"
                                                                                                       },@{@"param":@"写字楼",
                                                                                                           @"id":@"3"
                                                                                                           }]];
        view.selectedBlock = ^(NSString *MC, NSString *ID) {
            
            _typeBtn.content.text = [NSString stringWithFormat:@"%@",MC];
            _typeBtn->str = [NSString stringWithFormat:@"%@", ID];
            _Customerinfomodel.client_property_type = [NSString stringWithFormat:@"%@",ID];

        };
        [self.view addSubview:view];
    }else{
        
        SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:[self getDetailConfigArrByConfigState:SYSTEM_FUNC]];
        view.selectedBlock = ^(NSString *MC, NSString *ID) {
            
            _needBtn.content.text = [NSString stringWithFormat:@"%@",MC];
            _needBtn->str = [NSString stringWithFormat:@"%@", ID];
            if ([_needBtn.content.text isEqualToString:@"二手房"]) {
                
                _typeL.hidden = NO;
                _typeBtn.hidden = NO;
                [_typeL mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.left.equalTo(_scrollview).offset(10 *SIZE);
                    make.top.equalTo(_needBtn.mas_bottom).offset(30 *SIZE);
                    make.width.equalTo(@(65 *SIZE));
                    make.height.equalTo(@(14 *SIZE));
                }];
                
                [_typeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.left.equalTo(_scrollview).offset(80 *SIZE);
                    make.top.equalTo(_needBtn.mas_bottom).offset(19 *SIZE);
                    make.width.equalTo(@(258 *SIZE));
                    make.height.equalTo(@(33 *SIZE));
                }];
                
                [_nameL mas_remakeConstraints:^(MASConstraintMaker *make) {
                    
                    make.left.equalTo(_scrollview).offset(10 *SIZE);
                    make.top.equalTo(_typeBtn.mas_bottom).offset(30 *SIZE);
                    make.width.equalTo(@(65 *SIZE));
                    make.height.equalTo(@(14 *SIZE));
                }];
                
                [_name mas_remakeConstraints:^(MASConstraintMaker *make) {
                    
                    make.left.equalTo(_scrollview).offset(80 *SIZE);
                    make.top.equalTo(_typeBtn.mas_bottom).offset(19 *SIZE);
                    make.width.equalTo(@(117 *SIZE));
                    make.height.equalTo(@(33 *SIZE));
                }];
                
                [_sexL mas_remakeConstraints:^(MASConstraintMaker *make) {
                    
                    make.left.equalTo(_scrollview).offset(208 *SIZE);
                    make.top.equalTo(_typeBtn.mas_bottom).offset(30 *SIZE);
                    make.width.equalTo(@(100 *SIZE));
                    make.height.equalTo(@(14 *SIZE));
                }];
                
                [_sex mas_remakeConstraints:^(MASConstraintMaker *make) {
                    
                    make.left.equalTo(_scrollview).offset(251 *SIZE);
                    make.top.equalTo(_typeBtn.mas_bottom).offset(19 *SIZE);
                    make.width.equalTo(@(86 *SIZE));
                    make.height.equalTo(@(33 *SIZE));
                }];
            }else{
                
                _typeL.hidden = YES;
                _typeBtn.hidden = YES;
                [_nameL mas_remakeConstraints:^(MASConstraintMaker *make) {
                    
                    make.left.equalTo(_scrollview).offset(10 *SIZE);
                    make.top.equalTo(_needBtn.mas_bottom).offset(30 *SIZE);
                    make.width.equalTo(@(65 *SIZE));
                    make.height.equalTo(@(14 *SIZE));
                }];
                
                [_name mas_remakeConstraints:^(MASConstraintMaker *make) {
                    
                    make.left.equalTo(_scrollview).offset(80 *SIZE);
                    make.top.equalTo(_needBtn.mas_bottom).offset(19 *SIZE);
                    make.width.equalTo(@(117 *SIZE));
                    make.height.equalTo(@(33 *SIZE));
                }];
                
                [_sexL mas_remakeConstraints:^(MASConstraintMaker *make) {
                    
                    make.left.equalTo(_scrollview).offset(208 *SIZE);
                    make.top.equalTo(_needBtn.mas_bottom).offset(30 *SIZE);
                    make.width.equalTo(@(100 *SIZE));
                    make.height.equalTo(@(14 *SIZE));
                }];
                
                [_sex mas_remakeConstraints:^(MASConstraintMaker *make) {
                    
                    make.left.equalTo(_scrollview).offset(251 *SIZE);
                    make.top.equalTo(_needBtn.mas_bottom).offset(19 *SIZE);
                    make.width.equalTo(@(86 *SIZE));
                    make.height.equalTo(@(33 *SIZE));
                }];
            }
        };
        [self.view addSubview:view];
    }
}

- (void)ActionHideBtn:(UIButton *)btn{
    
    _isHide = !_isHide;
    if (!_isHide) {
        
        _phoneTF4.userInteractionEnabled = YES;
        _phoneTF5.userInteractionEnabled = YES;
        _phoneTF6.userInteractionEnabled = YES;
        _phoneTF7.userInteractionEnabled = YES;
        
        _phoneTF4.text = _tel4;
        _phoneTF5.text = _tel5;
        _phoneTF6.text = _tel6;
        _phoneTF7.text = _tel7;
        _hideReportL.text = @"当前显号报备";
        _hideImg.image = [UIImage imageNamed:@"eye_2"];
        _hideL.text = @"需要补全电话号码";
    }else{
        
        _phoneTF4.userInteractionEnabled = NO;
        _phoneTF5.userInteractionEnabled = NO;
        _phoneTF6.userInteractionEnabled = NO;
        _phoneTF7.userInteractionEnabled = NO;
        
        _phoneTF4.text = @"*";
        _phoneTF5.text = @"*";
        _phoneTF6.text = @"*";
        _phoneTF7.text = @"*";
        _hideReportL.text = @"当前隐号报备";
        _hideL.text = @"只需输入手机号前三位后四位";
        _hideImg.image = [UIImage imageNamed:@"eye"];
    }
}

#pragma mark -- TextFieldDelegate

- (void)textFieldDidChange:(UITextField *)textField{
    
    NSLog(@"%@",textField);
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField.text.length) {
        
        if ([string isEqualToString:@""]) {
            
            if (textField == _phoneTF1) {
                
                [_phoneTF1 becomeFirstResponder];
            }else if (textField == _phoneTF2) {
                
                if (_phoneTF2.text.length) {
                    
                    
                }else{
                    
                    [_phoneTF1 becomeFirstResponder];
                }
            }else if (textField == _phoneTF3) {
                
                if (_phoneTF3.text.length) {
                    
                    
                }else{
                    
                    [_phoneTF2 becomeFirstResponder];
                }
            }
            else if (textField == _phoneTF4) {
                
                if (_phoneTF4.text.length) {
                    
                    
                }else{
                    
                    [_phoneTF3 becomeFirstResponder];
                }
            }
            else if (textField == _phoneTF5) {
                
                if (_phoneTF5.text.length) {
                    
                    
                }else{
                    
                    [_phoneTF4 becomeFirstResponder];
                }
            }
            else if (textField == _phoneTF6) {
                
                if (_phoneTF6.text.length) {
                    
                    
                }else{
                    
                    [_phoneTF5 becomeFirstResponder];
                }
            }
            else if (textField == _phoneTF7) {
                
                if (_phoneTF7.text.length) {
                    
                    
                }else{
                    
                    [_phoneTF6 becomeFirstResponder];
                }
            }
            else if (textField == _phoneTF8) {
                
                if (_phoneTF8.text.length) {
                    
                    
                }else{
                    
                    [_phoneTF7 becomeFirstResponder];
                }
            }
            else if (textField == _phoneTF9) {
                
                if (_phoneTF9.text.length) {
                    
                    
                }else{
                    
                    [_phoneTF8 becomeFirstResponder];
                }
            }
            else if (textField == _phoneTF10) {
                
                if (_phoneTF10.text.length) {
                    
                    
                }else{
                    
                    [_phoneTF9 becomeFirstResponder];
                }
            }else if (textField == _phoneTF11) {
                
                if (_phoneTF11.text.length) {
                    
                    
                }else{
                    
                    [_phoneTF10 becomeFirstResponder];
                }
            }
        }else{
            
            if (textField == _phoneTF1) {
                
                _phoneTF1.text = string;
                [_phoneTF2 becomeFirstResponder];
            }else if (textField == _phoneTF2) {
                
                _phoneTF2.text = string;
                [_phoneTF3 becomeFirstResponder];
            }else if (textField == _phoneTF3) {
                
                _phoneTF3.text = string;
                if (_isHide) {
                    
                    [_phoneTF8 becomeFirstResponder];
                }else{
                    
                    [_phoneTF4 becomeFirstResponder];
                }
            }
            else if (textField == _phoneTF4) {
                
                _phoneTF4.text = string;
                _tel4 = string;
                [_phoneTF5 becomeFirstResponder];
            }
            else if (textField == _phoneTF5) {
                
                _phoneTF5.text = string;
                _tel5 = string;
                [_phoneTF6 becomeFirstResponder];
            }
            else if (textField == _phoneTF6) {
                
                _phoneTF6.text = string;
                _tel6 = string;
                [_phoneTF7 becomeFirstResponder];
            }
            else if (textField == _phoneTF7) {
                
                _phoneTF7.text = string;
                _tel7 = string;
                [_phoneTF8 becomeFirstResponder];
            }
            else if (textField == _phoneTF8) {
                
                _phoneTF8.text = string;
                [_phoneTF9 becomeFirstResponder];
            }
            else if (textField == _phoneTF9) {
                
                _phoneTF9.text = string;
                [_phoneTF10 becomeFirstResponder];
            }
            else if (textField == _phoneTF10) {
                
                _phoneTF10.text = string;
                [_phoneTF11 becomeFirstResponder];
            }else if (textField == _phoneTF11) {
                
                _phoneTF11.text = string;
                [_phoneTF11 endEditing:YES];
            }
        }
    }else{
        
        if ([string isEqualToString:@""]) {
            
            if (textField == _phoneTF1) {
                
                [_phoneTF1 becomeFirstResponder];
            }else if (textField == _phoneTF2) {
                
                if (_phoneTF2.text.length) {
                    
                    
                }else{
                    
                    [_phoneTF1 becomeFirstResponder];
                }
            }else if (textField == _phoneTF3) {
                
                if (_phoneTF3.text.length) {
                    
                    
                }else{
                    
                    [_phoneTF2 becomeFirstResponder];
                }
            }
            else if (textField == _phoneTF4) {
                
                if (_phoneTF4.text.length) {
                    
                    
                }else{
                    
                    [_phoneTF3 becomeFirstResponder];
                }
            }
            else if (textField == _phoneTF5) {
                
                if (_phoneTF5.text.length) {
                    
                    
                }else{
                    
                    [_phoneTF4 becomeFirstResponder];
                }
            }
            else if (textField == _phoneTF6) {
                
                if (_phoneTF6.text.length) {
                    
                    
                }else{
                    
                    [_phoneTF5 becomeFirstResponder];
                }
            }
            else if (textField == _phoneTF7) {
                
                if (_phoneTF7.text.length) {
                    
                    
                }else{
                    
                    [_phoneTF6 becomeFirstResponder];
                }
            }
            else if (textField == _phoneTF8) {
                
                if (_phoneTF8.text.length) {
                    
                    
                }else{
                    
                    [_phoneTF7 becomeFirstResponder];
                }
            }
            else if (textField == _phoneTF9) {
                
                if (_phoneTF9.text.length) {
                    
                    
                }else{
                    
                    [_phoneTF8 becomeFirstResponder];
                }
            }
            else if (textField == _phoneTF10) {
                
                if (_phoneTF10.text.length) {
                    
                    
                }else{
                    
                    [_phoneTF9 becomeFirstResponder];
                }
            }else if (textField == _phoneTF11) {
                
                if (_phoneTF11.text.length) {
                    
                    
                }else{
                    
                    [_phoneTF10 becomeFirstResponder];
                }
            }
        }else{
            
            if (textField == _phoneTF1) {
                
                _phoneTF1.text = string;
                [_phoneTF2 becomeFirstResponder];
            }else if (textField == _phoneTF2) {
                
                _phoneTF2.text = string;
                [_phoneTF3 becomeFirstResponder];
            }else if (textField == _phoneTF3) {
                
                _phoneTF3.text = string;
                if (_isHide) {
                    
                    [_phoneTF8 becomeFirstResponder];
                }else{
                    
                    [_phoneTF4 becomeFirstResponder];
                }
            }
            else if (textField == _phoneTF4) {
                
                _phoneTF4.text = string;
                _tel4 = string;
                [_phoneTF5 becomeFirstResponder];
            }
            else if (textField == _phoneTF5) {
                
                _phoneTF5.text = string;
                _tel5 = string;
                [_phoneTF6 becomeFirstResponder];
            }
            else if (textField == _phoneTF6) {
                
                _phoneTF6.text = string;
                _tel6 = string;
                [_phoneTF7 becomeFirstResponder];
            }
            else if (textField == _phoneTF7) {
                
                _phoneTF7.text = string;
                _tel7 = string;
                [_phoneTF8 becomeFirstResponder];
            }
            else if (textField == _phoneTF8) {
                
                _phoneTF8.text = string;
                [_phoneTF9 becomeFirstResponder];
            }
            else if (textField == _phoneTF9) {
                
                _phoneTF9.text = string;
                [_phoneTF10 becomeFirstResponder];
            }
            else if (textField == _phoneTF10) {
                
                _phoneTF10.text = string;
                [_phoneTF11 becomeFirstResponder];
            }else if (textField == _phoneTF11) {
                
                _phoneTF11.text = string;
                [_phoneTF11 endEditing:YES];
            }
        }
    }
    
    return YES;
}


-(void)initUI
{
    
    _scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, 360*SIZE,SCREEN_Height - NAVIGATION_BAR_HEIGHT)];
    _scrollview.contentSize = CGSizeMake(360*SIZE, 680*SIZE);
    _scrollview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_scrollview];
    
    UIView *backview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 360*SIZE, 53*SIZE)];
    // 顶部
    UIView * header = [[UIView alloc]initWithFrame:CGRectMake(10*SIZE , 19*SIZE, (CGFloat) (6.7*SIZE),(CGFloat)  13.3*SIZE)];
    header.backgroundColor = YJBlueBtnColor;
    [backview addSubview:header];
    UILabel * title = [[UILabel alloc]initWithFrame:CGRectMake((CGFloat) 27.3*SIZE, 19*SIZE, 300*SIZE, 16*SIZE)];
    title.font = [UIFont systemFontOfSize:(CGFloat) 15.3*SIZE];
    title.textColor = YJTitleLabColor;
    title.text = @"客户信息";
    [backview addSubview:title];
    [_scrollview addSubview:backview];
    
    _needL = [[UILabel alloc]initWithFrame:CGRectMake(10*SIZE, 56*SIZE, 100*SIZE, 14*SIZE)];
    _needL.text = @"类型:";
    _needL.font = [UIFont systemFontOfSize:(CGFloat) 13.3*SIZE];
    _needL.textColor = YJTitleLabColor;
    [_scrollview addSubview:_needL];
    
    _needBtn = [[DropDownBtn alloc]initWithFrame:CGRectMake((CGFloat) 80.3*SIZE, 46*SIZE, 257 *SIZE,(CGFloat)  33.3*SIZE)];
    if (self.status == 1) {
        
        _needBtn.content.text = @"新房";
        _needBtn->str = @"184";
    }else if (self.status == 2){
        
        _needBtn.content.text = @"二手房";
        _needBtn->str = @"185";
    }else{
        
        _needBtn.content.text = @"租房";
        _needBtn->str = @"186";
    }
    [_needBtn addTarget:self action:@selector(ActionNeedBtn:) forControlEvents:UIControlEventTouchUpInside];
    if (_model.client_type) {
        
        _needBtn.content.text = _model.client_type;
        
        NSArray *typeArr = [self getDetailConfigArrByConfigState:SYSTEM_FUNC];
        for (NSUInteger i = 0; i < typeArr.count; i++) {
            
            if ([typeArr[i][@"param"] isEqualToString:_model.client_type]) {
                
                _needBtn->str = [NSString stringWithFormat:@"%@", typeArr[i][@"id"]];
                break;
            }
        }
    }else{
        
        _needBtn.backgroundColor = YJBackColor;
        _needBtn.userInteractionEnabled = NO;
    }
    [_scrollview addSubview:_needBtn];
    
    _typeL = [[UILabel alloc]initWithFrame:CGRectMake(10*SIZE, 56*SIZE, 100*SIZE, 14*SIZE)];
    _typeL.text = @"物业类型:";
    _typeL.font = [UIFont systemFontOfSize:(CGFloat) 13.3*SIZE];
    _typeL.textColor = YJTitleLabColor;
    _typeL.hidden = YES;
    [_scrollview addSubview:_typeL];
    
    _typeBtn = [[DropDownBtn alloc]initWithFrame:CGRectMake((CGFloat) 80.3*SIZE, 46*SIZE, 257 *SIZE,(CGFloat)  33.3*SIZE)];
    _typeBtn.tag = 2;
    _typeBtn.hidden = YES;
    [_typeBtn addTarget:self action:@selector(ActionNeedBtn:) forControlEvents:UIControlEventTouchUpInside];
    if (_model.client_property_type) {
        
        _typeBtn.content.text = _model.client_property_type;
        if ([_model.client_property_type isEqualToString:@"商铺"]) {
            
            _Customerinfomodel.client_property_type = @"2";
        }else if ([_model.client_property_type isEqualToString:@"写字楼"]){
            
            _Customerinfomodel.client_property_type = @"3";
        }else{
            
            _Customerinfomodel.client_property_type = @"1";
        }
    }
    [_scrollview addSubview:_typeBtn];
    
    if ([_needBtn.content.text isEqualToString:@"二手房"] || [_needBtn.content.text isEqualToString:@"租房"]) {
        
        _typeBtn.hidden = NO;
        _typeL.hidden = NO;
    }
    
    //姓名
    _nameL = [[UILabel alloc]initWithFrame:CGRectMake(10*SIZE, 56*SIZE, 100*SIZE, 14*SIZE)];
    _nameL.text = @"姓名:";
    _nameL.font = [UIFont systemFontOfSize:(CGFloat) 13.3*SIZE];
    _nameL.textColor = YJTitleLabColor;
    [_scrollview addSubview:_nameL];
    _name = [[BorderTF alloc]initWithFrame:CGRectMake((CGFloat) 80.3*SIZE, 46*SIZE, (CGFloat) 116.7*SIZE, (CGFloat) 33.3*SIZE)];
    _name.textfield.placeholder = @"必填(少于5字)";
    _name.textfield.text = _model.name;
//    _name.textfield.delegate = self;
    [_scrollview addSubview:_name];
    
    //性别
    _sexL = [[UILabel alloc]initWithFrame:CGRectMake((CGFloat) 208.7*SIZE, 56*SIZE, 100*SIZE, 14*SIZE)];
    _sexL.text = @"性别:";
    _sexL.font = [UIFont systemFontOfSize:(CGFloat) 13.3*SIZE];
    _sexL.textColor = YJTitleLabColor;
    [_scrollview addSubview:_sexL];
    
    _sex = [[DropDownBtn alloc]initWithFrame:CGRectMake((CGFloat) 251.3*SIZE,  46*SIZE, (CGFloat) 86.7*SIZE, (CGFloat) 33.3*SIZE)];
    if ([_model.sex integerValue] == 1) {
        
        _sex.content.text = @"男";
        _Customerinfomodel.sex = _model.sex;
    }else if ([_model.sex integerValue] == 2){
        
        _Customerinfomodel.sex = _model.sex;
        _sex.content.text = @"女";
    }
    [_sex addTarget:self action:@selector(action_sex) forControlEvents:UIControlEventTouchUpInside];
    [_scrollview addSubview:_sex];
    
    //出生日期
    _birthL = [[UILabel alloc]initWithFrame:CGRectMake(10*SIZE, 106*SIZE, 100*SIZE, 14*SIZE)];
    _birthL.text = @"出生日期:";
    _birthL.font = [UIFont systemFontOfSize:(CGFloat) (13.3 * SIZE)];
    _birthL.textColor = YJTitleLabColor;
    [_scrollview addSubview:_birthL];
    
    _birth = [[DropDownBtn alloc]initWithFrame:CGRectMake((CGFloat)80.3*SIZE, 96*SIZE,(CGFloat) 257.7*SIZE, (CGFloat)33.3*SIZE)];
    if (_model.birth) {
        
        _birth.content.text = _model.birth;
    }
    [_birth addTarget:self action:@selector(action_brith) forControlEvents:UIControlEventTouchUpInside];
    [_scrollview addSubview:_birth];
    
    NSArray *telArr = [_model.tel componentsSeparatedByString:@","];
    //电话
    _telL = [[UILabel alloc]initWithFrame:CGRectMake(10*SIZE, 169*SIZE, 100*SIZE, 14*SIZE)];
    _telL.text = @"联系号码:";
    _telL.font = [UIFont systemFontOfSize:(CGFloat)13.3*SIZE];
    _telL.textColor = YJTitleLabColor;
    [_scrollview addSubview:_telL];
    
    for (int i = 0; i < 11; i++) {
        
        UITextField *borderTF = [[UITextField alloc] initWithFrame:CGRectMake(80 *SIZE, 75 *SIZE, 19 *SIZE, 24 *SIZE)];
        borderTF.textColor = YJContentLabColor;
        borderTF.keyboardType = UIKeyboardTypePhonePad;
        borderTF.font = [UIFont systemFontOfSize:13.3*SIZE];
        borderTF.layer.cornerRadius = 5*SIZE;
        borderTF.layer.borderColor = COLOR(219, 219, 219, 1).CGColor;
        borderTF.layer.borderWidth = 1*SIZE;
        borderTF.returnKeyType = UIReturnKeyNext;
        [borderTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        borderTF.textAlignment = NSTextAlignmentCenter;
        switch (i) {
            case 0:
            {
                _phoneTF1 = borderTF;
                _phoneTF1.delegate = self;
                if (telArr.count) {
                    
                    _phoneTF1.text = [telArr[0] substringWithRange:NSMakeRange(0, 1)];
                }
                
                [_scrollview addSubview:_phoneTF1];
                break;
            }
            case 1:
            {
                _phoneTF2 = borderTF;
                _phoneTF2.delegate = self;
                if (telArr.count) {
                    
                    _phoneTF2.text = [telArr[0] substringWithRange:NSMakeRange(1, 1)];
                }
                
                [_scrollview addSubview:_phoneTF2];
                break;
            }
            case 2:
            {
                _phoneTF3 = borderTF;
                _phoneTF3.delegate = self;
                if (telArr.count) {
                    
                    _phoneTF3.text = [telArr[0] substringWithRange:NSMakeRange(2, 1)];
                }
                
                [_scrollview addSubview:_phoneTF3];
                break;
            }
            case 3:
            {
                borderTF.layer.borderColor = COLOR(169, 219, 255, 1).CGColor;
                _phoneTF4 = borderTF;
                _phoneTF4.delegate = self;
                if (telArr.count) {
                    
                    _tel4 = [telArr[0] substringWithRange:NSMakeRange(3, 1)];
//                    _phoneTF4.text = [telArr[0] substringWithRange:NSMakeRange(3, 1)];
                    if (_isHide) {
                        
                        _phoneTF4.text = @"*";
                    }else{
                        
                        _phoneTF4.text = _tel4;
                    }
                }else{
                    
                    if (_isHide) {
                        
                        _phoneTF4.text = @"*";
                    }else{
                        
                        _phoneTF4.text = _tel4;
                    }
                }
                
                [_scrollview addSubview:_phoneTF4];
                break;
            }
            case 4:
            {
                borderTF.layer.borderColor = COLOR(169, 219, 255, 1).CGColor;
                _phoneTF5 = borderTF;
                _phoneTF5.delegate = self;
                if (telArr.count) {
                    
                    _tel5 = [telArr[0] substringWithRange:NSMakeRange(4, 1)];
                    //                    _phoneTF4.text = [telArr[0] substringWithRange:NSMakeRange(3, 1)];
                    if (_isHide) {
                        
                        _phoneTF5.text = @"*";
                    }else{
                        
                        _phoneTF5.text = _tel5;
                    }
                }else{
                    
                    if (_isHide) {
                        
                        _phoneTF5.text = @"*";
                    }else{
                        
                        _phoneTF5.text = _tel5;
                    }
                }
                
                [_scrollview addSubview:_phoneTF5];
                break;
            }
            case 5:
            {
                borderTF.layer.borderColor = COLOR(169, 219, 255, 1).CGColor;
                _phoneTF6 = borderTF;
                _phoneTF6.delegate = self;
                if (telArr.count) {
                    
                    _tel6 = [telArr[0] substringWithRange:NSMakeRange(5, 1)];
                    //                    _phoneTF4.text = [telArr[0] substringWithRange:NSMakeRange(3, 1)];
                    if (_isHide) {
                        
                        _phoneTF6.text = @"*";
                    }else{
                        
                        _phoneTF6.text = _tel6;
                    }
                }else{
                    
                    if (_isHide) {
                        
                        _phoneTF6.text = @"*";
                    }else{
                        
                        _phoneTF6.text = _tel6;
                    }
                }
                
                [_scrollview addSubview:_phoneTF6];
                break;
            }
            case 6:
            {
                borderTF.layer.borderColor = COLOR(169, 219, 255, 1).CGColor;
                _phoneTF7 = borderTF;
                _phoneTF7.delegate = self;
                if (telArr.count) {
                    
                    _tel7 = [telArr[0] substringWithRange:NSMakeRange(6, 1)];
                    //                    _phoneTF4.text = [telArr[0] substringWithRange:NSMakeRange(3, 1)];
                    if (_isHide) {
                        
                        _phoneTF7.text = @"*";
                    }else{
                        
                        _phoneTF7.text = _tel7;
                    }
                }else{
                    
                    if (_isHide) {
                        
                        _phoneTF7.text = @"*";
                    }else{
                        
                        _phoneTF7.text = _tel7;
                    }
                }
                
                [_scrollview addSubview:_phoneTF7];
                break;
            }
            case 7:
            {
                _phoneTF8 = borderTF;
                _phoneTF8.delegate = self;
                if (telArr.count) {
                    
                    _phoneTF8.text = [telArr[0] substringWithRange:NSMakeRange(7, 1)];
                }
                
                [_scrollview addSubview:_phoneTF8];
                break;
            }
            case 8:
            {
                _phoneTF9 = borderTF;
                _phoneTF9.delegate = self;
                if (telArr.count) {
                    
                    _phoneTF9.text = [telArr[0] substringWithRange:NSMakeRange(8, 1)];
                }
                
                [_scrollview addSubview:_phoneTF9];
                break;
            }
            case 9:
            {
                _phoneTF10 = borderTF;
                _phoneTF10.delegate = self;
                if (telArr.count) {
                    
                    _phoneTF10.text = [telArr[0] substringWithRange:NSMakeRange(9, 1)];
                }
                
                [_scrollview addSubview:_phoneTF10];
                break;
            }
            case 10:
            {
                _phoneTF11 = borderTF;
                _phoneTF11.delegate = self;
                if (telArr.count) {
                    
                    _phoneTF11.text = [telArr[0] substringWithRange:NSMakeRange(10, 1)];
                }
                
                [_scrollview addSubview:_phoneTF11];
                break;
            }
            default:
                break;
        }
    }
    
    for(int i = 0; i < 2; i++){
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = YJTitleLabColor;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        switch (i) {
            case 0:
            {
                
                _hideL = label;
                _hideL.font = [UIFont systemFontOfSize:11 *SIZE];
                _hideL.textColor = YJ170Color;
                if (_isHide) {
                    
                    _hideL.text = @"只需输入手机号前三位后四位";
                }else{
                    
                    _hideL.text = @"需要补全电话号码";
                }
                [_scrollview addSubview:_hideL];
                break;
            }
            case 1:
            {
                _hideReportL = label;
                _hideReportL.font = [UIFont systemFontOfSize:10 *SIZE];
                _hideReportL.textColor = COLOR(255, 165, 29, 1);
                if (_isHide) {
                    
                    _hideReportL.text = @"当前隐号报备";
                }else{
                    
                    _hideReportL.text = @"当前显号报备";
                }
                [_scrollview addSubview:_hideReportL];
                break;
            }
        }
    }
    
    _hideImg = [[UIImageView alloc] init];
    if (_isHide) {
        
        _hideImg.image = [UIImage imageNamed:@"eye"];
    }else{
        
        _hideImg.image = [UIImage imageNamed:@"eye_2"];
    }
    [_scrollview addSubview:_hideImg];
    
    
    _hideBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_hideBtn addTarget:self action:@selector(ActionHideBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollview addSubview:_hideBtn];
    
//    _tel1 = [[BorderTF alloc]initWithFrame:CGRectMake((CGFloat)80.3*SIZE, 146*SIZE,(CGFloat) 257.7*SIZE, (CGFloat)33.3*SIZE)];
//    _tel1.textfield.placeholder = @"必填";
//    if (telArr.count) {
//
//        _tel1.textfield.text = telArr[0];
//    }
//    _tel1.textfield.keyboardType = UIKeyboardTypePhonePad;
//    [_scrollview addSubview:_tel1];
//
//    _tel2 = [[BorderTF alloc]initWithFrame:CGRectMake((CGFloat)80.3*SIZE, 196*SIZE, (CGFloat)257.7*SIZE,(CGFloat) 33.3*SIZE)];
//    _tel2.textfield.placeholder = @"选填";
//    _tel2.hidden = YES;
//    _tel2.textfield.keyboardType = UIKeyboardTypePhonePad;
//    [_scrollview addSubview:_tel2];
    

//    _tel3 = [[BorderTF alloc]initWithFrame:CGRectMake((CGFloat)80.3*SIZE, 246*SIZE,(CGFloat) 257.7*SIZE,(CGFloat) 33.3*SIZE)];
//    _tel3.textfield.placeholder = @"选填";
//    _tel3.hidden = YES;
//    _tel3.textfield.keyboardType = UIKeyboardTypePhonePad;
//    [_scrollview addSubview:_tel3];
    
    
    //证件类型
    _numclasslab = [[UILabel alloc]initWithFrame:CGRectMake(10*SIZE, 306*SIZE, 100*SIZE, 14*SIZE)];
    _numclasslab.text = @"证件类型:";
    _numclasslab.font = [UIFont systemFontOfSize:(CGFloat)13.3*SIZE];
    _numclasslab.textColor = YJTitleLabColor;
    [_scrollview addSubview:_numclasslab];
    
    _numclass = [[DropDownBtn alloc]initWithFrame:CGRectMake((CGFloat)80.3*SIZE, 296*SIZE,(CGFloat) 257.7*SIZE,(CGFloat) 33.3*SIZE)];
    [_numclass addTarget:self action:@selector(action_numclass) forControlEvents:UIControlEventTouchUpInside];
    if (_model.card_type.length) {
        
        NSDictionary *configdic = [UserModelArchiver unarchive].Configdic;
        NSDictionary *dic =  [configdic valueForKey:[NSString stringWithFormat:@"%d",2]];
        NSArray *typeArr = dic[@"param"];
        for (NSUInteger i = 0; i < typeArr.count; i++) {
            
            if ([typeArr[i][@"param"] isEqualToString:_model.card_type]) {
                
                _Customerinfomodel.card_type = typeArr[i][@"id"];
                _numclass.content.text = typeArr[i][@"param"];
                break;
            }
        }
    }
    [_scrollview addSubview:_numclass];
    
    //证件号
    _numlab = [[UILabel alloc]initWithFrame:CGRectMake(10*SIZE, 356*SIZE, 100*SIZE, 14*SIZE)];
    
    _numlab.text = @"证件号:";
    _numlab.font = [UIFont systemFontOfSize:(CGFloat)13.3*SIZE];
    _numlab.textColor = YJTitleLabColor;
    [_scrollview addSubview:_numlab];
    
    _num = [[BorderTF alloc]initWithFrame:CGRectMake((CGFloat)80.3*SIZE, 346*SIZE, (CGFloat)257.7*SIZE,(CGFloat) 33.3*SIZE)];
    
    _num.textfield.keyboardType = UIKeyboardTypeDefault;
    if (_model.card_id) {
        
        _num.textfield.text = _model.card_id;
    }
    [_scrollview addSubview:_num];
    
    //地址
    _adresslab = [[UILabel alloc]initWithFrame:CGRectMake(10*SIZE, 406*SIZE, 100*SIZE, 14*SIZE)];
    _adresslab.text = @"地址:";
    _adresslab.font = [UIFont systemFontOfSize:(CGFloat)13.3*SIZE];
    _adresslab.textColor = YJTitleLabColor;
    [_scrollview addSubview:_adresslab];
    
    _adress = [[DropDownBtn alloc]initWithFrame:CGRectMake((CGFloat)80.3*SIZE, 396*SIZE, (CGFloat)257.7*SIZE,(CGFloat) 33.3*SIZE)];
    [_adress addTarget:self action:@selector(action_address) forControlEvents:UIControlEventTouchUpInside];
    
    NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"region" ofType:@"json"]];
    
    NSError *err;
    NSArray *provice = [NSJSONSerialization JSONObjectWithData:JSONData
                                                       options:NSJSONReadingMutableContainers
                                                         error:&err];
    
    if (_model.province && _model.city && _model.district) {
        
        for (NSUInteger i = 0; i < provice.count; i++) {
            
            if([provice[i][@"code"] integerValue] == [_model.province integerValue]){
                
                NSArray *city = provice[i][@"city"];
                for (NSUInteger j = 0; j < city.count; j++) {
                    
                    if([city[j][@"code"] integerValue] == [_model.city integerValue]){
                        
                        NSArray *area = city[j][@"district"];
                        
                        for (NSUInteger k = 0; k < area.count; k++) {
                            
                            if([area[k][@"code"] integerValue] == [_model.district integerValue]){
                                
                                _adress.content.text = [NSString stringWithFormat:@"%@-%@-%@",provice[i][@"name"],city[j][@"name"],area[k][@"name"]];
                                _Customerinfomodel.province = _model.province;
                                _Customerinfomodel.city = _model.city;
                                _Customerinfomodel.district = _model.district;
                            }
                        }
                    }
                }
            }
        }
    }else if (_model.province && _model.city){
        
        for (NSUInteger i = 0; i < provice.count; i++) {
            
            if([provice[i][@"code"] integerValue] == [_model.province integerValue]){
                
                NSArray *city = provice[i][@"city"];
                for (NSUInteger j = 0; j < city.count; j++) {
                    
                    if([city[j][@"code"] integerValue] == [_model.city integerValue]){
                        
                        _adress.content.text = [NSString stringWithFormat:@"%@-%@",provice[i][@"name"],city[j][@"name"]];
                        _Customerinfomodel.province = _model.province;
                        _Customerinfomodel.city = _model.city;
                    }
                }
            }
        }
    }else if (_model.province){
        
        for (NSUInteger i = 0; i < provice.count; i++) {
            
            if([provice[i][@"code"] integerValue] == [_model.province integerValue]){
                
                _adress.content.text = [NSString stringWithFormat:@"%@",provice[i][@"name"]];
                _Customerinfomodel.province = _model.province;
            }
        }
    }else{
        
        
    }
    [_scrollview addSubview:_adress];

    
    _detailadress = [[UITextView alloc]initWithFrame:CGRectMake((CGFloat) (90.3*SIZE),456*SIZE,(CGFloat) 237.7*SIZE,(CGFloat) 66.7*SIZE)];
    _detailadress.textColor = YJTitleLabColor;
    _detailadress.layer.cornerRadius = 5 *SIZE;
    _detailadress.clipsToBounds = YES;
    _detailadress.layer.borderWidth = SIZE;
    _detailadress.layer.borderColor = COLOR(219, 219, 219, 1).CGColor;
    _detailadress.font = [UIFont systemFontOfSize:(CGFloat)13.3*SIZE];
    if (_model.address) {
        
        _detailadress.text = _model.address;
    }
    [_scrollview addSubview:_detailadress];
    
    [_scrollview addSubview:self.surebtn];
    
    [self masonryUI];
    
}

- (void)masonryUI{
    
    [_scrollview mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(NAVIGATION_BAR_HEIGHT);
        make.right.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view).offset(0);
    }];
    
    [_needL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrollview).offset(10  *SIZE);
        make.top.equalTo(_scrollview).offset(56 *SIZE);
        make.width.equalTo(@(100 *SIZE));
        make.height.equalTo(@(14 *SIZE));
    }];
    
    [_needBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_scrollview).offset(80 *SIZE);
        make.top.equalTo(_scrollview).offset(46 *SIZE);
        make.width.equalTo(@(257 *SIZE));
        make.height.equalTo(@(33 *SIZE));
    }];
    
    if ([_needBtn.content.text isEqualToString:@"二手房"] || [_needBtn.content.text isEqualToString:@"租房"]) {
        
        [_typeL mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(_scrollview).offset(10 *SIZE);
            make.top.equalTo(_needBtn.mas_bottom).offset(30 *SIZE);
            make.width.equalTo(@(65 *SIZE));
            make.height.equalTo(@(14 *SIZE));
        }];
        
        [_typeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(_scrollview).offset(80 *SIZE);
            make.top.equalTo(_needBtn.mas_bottom).offset(19 *SIZE);
            make.width.equalTo(@(258 *SIZE));
            make.height.equalTo(@(33 *SIZE));
        }];

        [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(_scrollview).offset(10 *SIZE);
            make.top.equalTo(_typeBtn.mas_bottom).offset(30 *SIZE);
            make.width.equalTo(@(65 *SIZE));
            make.height.equalTo(@(14 *SIZE));
        }];
        
        [_name mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(_scrollview).offset(80 *SIZE);
            make.top.equalTo(_typeBtn.mas_bottom).offset(19 *SIZE);
            make.width.equalTo(@(117 *SIZE));
            make.height.equalTo(@(33 *SIZE));
        }];
        
        [_sexL mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(_scrollview).offset(208 *SIZE);
            make.top.equalTo(_typeBtn.mas_bottom).offset(30 *SIZE);
            make.width.equalTo(@(100 *SIZE));
            make.height.equalTo(@(14 *SIZE));
        }];
        
        [_sex mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(_scrollview).offset(251 *SIZE);
            make.top.equalTo(_typeBtn.mas_bottom).offset(19 *SIZE);
            make.width.equalTo(@(86 *SIZE));
            make.height.equalTo(@(33 *SIZE));
        }];
    }else{
        
        [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(_scrollview).offset(10 *SIZE);
            make.top.equalTo(_needBtn.mas_bottom).offset(30 *SIZE);
            make.width.equalTo(@(65 *SIZE));
            make.height.equalTo(@(14 *SIZE));
        }];
        
        [_name mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(_scrollview).offset(80 *SIZE);
            make.top.equalTo(_needBtn.mas_bottom).offset(19 *SIZE);
            make.width.equalTo(@(117 *SIZE));
            make.height.equalTo(@(33 *SIZE));
        }];
        
        [_sexL mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(_scrollview).offset(208 *SIZE);
            make.top.equalTo(_needBtn.mas_bottom).offset(30 *SIZE);
            make.width.equalTo(@(100 *SIZE));
            make.height.equalTo(@(14 *SIZE));
        }];
        
        [_sex mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(_scrollview).offset(251 *SIZE);
            make.top.equalTo(_needBtn.mas_bottom).offset(19 *SIZE);
            make.width.equalTo(@(86 *SIZE));
            make.height.equalTo(@(33 *SIZE));
        }];
    }
    
    
    
    [_birthL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrollview).offset(10 *SIZE);
        make.top.equalTo(_name.mas_bottom).offset(30 *SIZE);
        make.width.equalTo(@(100 *SIZE));
        make.height.equalTo(@(14 *SIZE));
    }];
    
    [_birth mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrollview).offset(80 *SIZE);
        make.top.equalTo(_name.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(257 *SIZE));
        make.height.equalTo(@(33 *SIZE));
    }];
    
    [_telL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrollview).offset(10 *SIZE);
        make.top.equalTo(_birth.mas_bottom).offset(30 *SIZE);
        make.width.equalTo(@(100 *SIZE));
        make.height.equalTo(@(14 *SIZE));
    }];
    
    [_phoneTF1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrollview).offset(81 *SIZE);
        make.top.equalTo(_birth.mas_bottom).offset(29 *SIZE);
        make.width.equalTo(@(19 *SIZE));
        make.height.equalTo(@(24 *SIZE));
    }];
    
    [_phoneTF2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_phoneTF1.mas_right).offset(4 *SIZE);
        make.top.equalTo(_birth.mas_bottom).offset(29 *SIZE);
        make.width.equalTo(@(19 *SIZE));
        make.height.equalTo(@(24 *SIZE));
    }];
    
    [_phoneTF3 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_phoneTF2.mas_right).offset(4 *SIZE);
        make.top.equalTo(_birth.mas_bottom).offset(29 *SIZE);
        make.width.equalTo(@(19 *SIZE));
        make.height.equalTo(@(24 *SIZE));
    }];
    
    [_phoneTF4 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_phoneTF3.mas_right).offset(4 *SIZE);
        make.top.equalTo(_birth.mas_bottom).offset(29 *SIZE);
        make.width.equalTo(@(19 *SIZE));
        make.height.equalTo(@(24 *SIZE));
    }];
    
    [_phoneTF5 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_phoneTF4.mas_right).offset(4 *SIZE);
        make.top.equalTo(_birth.mas_bottom).offset(29 *SIZE);
        make.width.equalTo(@(19 *SIZE));
        make.height.equalTo(@(24 *SIZE));
    }];
    
    [_phoneTF6 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_phoneTF5.mas_right).offset(4 *SIZE);
        make.top.equalTo(_birth.mas_bottom).offset(29 *SIZE);
        make.width.equalTo(@(19 *SIZE));
        make.height.equalTo(@(24 *SIZE));
    }];
    
    [_phoneTF7 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_phoneTF6.mas_right).offset(4 *SIZE);
        make.top.equalTo(_birth.mas_bottom).offset(29 *SIZE);
        make.width.equalTo(@(19 *SIZE));
        make.height.equalTo(@(24 *SIZE));
    }];
    
    [_phoneTF8 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_phoneTF7.mas_right).offset(4 *SIZE);
        make.top.equalTo(_birth.mas_bottom).offset(29 *SIZE);
        make.width.equalTo(@(19 *SIZE));
        make.height.equalTo(@(24 *SIZE));
    }];
    
    [_phoneTF9 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_phoneTF8.mas_right).offset(4 *SIZE);
        make.top.equalTo(_birth.mas_bottom).offset(29 *SIZE);
        make.width.equalTo(@(19 *SIZE));
        make.height.equalTo(@(24 *SIZE));
    }];
    
    [_phoneTF10 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_phoneTF9.mas_right).offset(4 *SIZE);
        make.top.equalTo(_birth.mas_bottom).offset(29 *SIZE);
        make.width.equalTo(@(19 *SIZE));
        make.height.equalTo(@(24 *SIZE));
    }];
    
    [_phoneTF11 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_phoneTF10.mas_right).offset(4 *SIZE);
        make.top.equalTo(_birth.mas_bottom).offset(29 *SIZE);
        make.width.equalTo(@(19 *SIZE));
        make.height.equalTo(@(24 *SIZE));
    }];
    
    [_hideL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrollview).offset(80 *SIZE);
        make.top.equalTo(_telL.mas_bottom).offset(18 *SIZE);
        make.width.mas_equalTo(150 *SIZE);
        make.height.mas_equalTo(10 *SIZE);
    }];
    
    [_hideImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrollview).offset(251 *SIZE);
        make.top.equalTo(_telL.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(14 *SIZE);
        make.height.mas_equalTo(6 *SIZE);
    }];
    
    [_hideReportL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrollview).offset(279 *SIZE);
        make.top.equalTo(_telL.mas_bottom).offset(18 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
        make.height.mas_equalTo(10 *SIZE);
    }];
    
    [_hideBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrollview).offset(266 *SIZE);
        make.top.equalTo(_phoneTF1.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(90 *SIZE);
        make.height.mas_equalTo(20 *SIZE);
    }];
    
    [_numclasslab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_scrollview).offset(9 *SIZE);
        make.top.equalTo(_hideReportL.mas_bottom).offset(30 *SIZE);
        make.width.equalTo(@(65 *SIZE));
        make.height.equalTo(@(13 *SIZE));
    }];
    
    [_numclass mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrollview).offset(80 *SIZE);
        make.top.equalTo(_hideReportL.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(257 *SIZE));
        make.height.equalTo(@(33 *SIZE));
    }];
    
    [_numlab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrollview).offset(9 *SIZE);
        make.top.equalTo(_numclass.mas_bottom).offset(30 *SIZE);
        make.width.equalTo(@(65 *SIZE));
        make.height.equalTo(@(13 *SIZE));
    }];
    
    [_num mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrollview).offset(80 *SIZE);
        make.top.equalTo(_numclass.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(257 *SIZE));
        make.height.equalTo(@(33 *SIZE));
    }];
    
    [_adresslab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrollview).offset(9 *SIZE);
        make.top.equalTo(_num.mas_bottom).offset(30 *SIZE);
        make.width.equalTo(@(65 *SIZE));
        make.height.equalTo(@(13 *SIZE));
    }];
    
    [_adress mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrollview).offset(80 *SIZE);
        make.top.equalTo(_num.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(257 *SIZE));
        make.height.equalTo(@(33 *SIZE));
    }];
    
    [_detailadress mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrollview).offset(80 *SIZE);
        make.top.equalTo(_adress.mas_bottom).offset(24 *SIZE);
        make.width.equalTo(@(257 *SIZE));
        make.height.equalTo(@(77 *SIZE));
    }];
    
    [self.surebtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrollview).offset(22 *SIZE);
        make.top.equalTo(_detailadress.mas_bottom).offset(43 *SIZE);
        make.width.equalTo(@(317 *SIZE));
        make.height.equalTo(@(40 *SIZE));
        make.bottom.equalTo(_scrollview.mas_bottom).offset(-53 *SIZE);
    }];
}

-(void)action_sex
{

//    [_tel1.textfield endEditing:YES];
//    [_tel2.textfield endEditing:YES];
//    [_tel3.textfield endEditing:YES];
    [_name.textfield endEditing:YES];
//    [_tel2.textfield endEditing:YES];
    [_num.textfield endEditing:YES];
    [_detailadress endEditing:YES];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"性别" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *male = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        _sex.content.text = @"男";
        _Customerinfomodel.sex = @"1";
    }];
    
    UIAlertAction *female = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        _sex.content.text = @"女";
        _Customerinfomodel.sex =@"2";
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:male];
    [alert addAction:female];
    [alert addAction:cancel];
    [self.navigationController presentViewController:alert animated:YES completion:^{
        
    }];
}

-(void)action_brith
{
//    [_tel1.textfield endEditing:YES];
//    [_tel2.textfield endEditing:YES];
//    [_tel3.textfield endEditing:YES];
    [_name.textfield endEditing:YES];
//    [_tel2.textfield endEditing:YES];
    [_num.textfield endEditing:YES];
    [_detailadress endEditing:YES];
    DateChooseView *view = [[DateChooseView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    view.dateblock = ^(NSDate *date) {
//        NSLog(@"%@",[self gettime:date]);
        _birth.content.text = [self gettime:date];
        _Customerinfomodel.birth = _birth.content.text;
    };
    [self.view addSubview:view];
}

-(void)action_numclass
{
//    [_tel1.textfield endEditing:YES];
//    [_tel2.textfield endEditing:YES];
//    [_tel3.textfield endEditing:YES];
    [_name.textfield endEditing:YES];
//    [_tel2.textfield endEditing:YES];
    [_num.textfield endEditing:YES];
    [_detailadress endEditing:YES];
    SinglePickView *view = [[SinglePickView alloc]initWithFrame:self.view.frame WithData:[self getDetailConfigArrByConfigState:CARD_TYPE]];
    
    view.selectedBlock = ^(NSString *MC, NSString *ID) {
    
        _numclass.content.text = MC;
        _Customerinfomodel.card_type = ID;
    };
    [self.view addSubview:view];
}

-(void)action_address
{
    [_name.textfield endEditing:YES];
    [_num.textfield endEditing:YES];
    [_detailadress endEditing:YES];
    AdressChooseView *view = [[AdressChooseView alloc]initWithFrame:self.view.frame withdata:@[]];
    [self.view addSubview:view];
    view.selectedBlock = ^(NSString *province, NSString *city, NSString *area, NSString *proviceid, NSString *cityid, NSString *areaid) {
        self.adress.content.text = [NSString stringWithFormat:@"%@/%@/%@",province,city,area];
        _Customerinfomodel.province = proviceid;
        _Customerinfomodel.city = cityid;
        _Customerinfomodel.district = areaid;
    };
}

-(void)action_sure
{
    [_name.textfield endEditing:YES];
    [_num.textfield endEditing:YES];
    [_detailadress endEditing:YES];
    
    if (!_needBtn->str.length) {
        
        [self showContent:@"请选择客户类型"];
        return;
    }else{
        
        _Customerinfomodel.client_type = _needBtn->str;
    }
    
    if ([_needBtn.content.text isEqualToString:@"二手房"]) {
        
        if (!_typeBtn.content.text.length) {
            
            [self showContent:@"请选择物业类型"];
            return;
        }
    }
    
    if (_name.textfield.text.length == 0 || [self isEmpty:_name.textfield.text]) {
        
        [self showContent:@"请输入姓名！"];
        return;
    }
    
    
    if (_name.textfield.text.length > 5) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"姓名不能超过5个字" WithDefaultBlack:^{
            
            return ;
        }];
    }
    
    
    NSString *tel;
    
    if (_isHide) {
        
        if (!_phoneTF1.text.length || !_phoneTF2.text.length || !_phoneTF3.text.length || !_phoneTF8.text.length || !_phoneTF9.text.length || !_phoneTF10.text.length || !_phoneTF11.text.length) {
            
            [self alertControllerWithNsstring:@"温馨提示" And:@"电话号码不完整"];
        }else{
            
            if (!_phoneTF4.text.length) {
                
                _phoneTF4.text = @"*";
            }
            if (!_phoneTF5.text.length){
                
                _phoneTF5.text = @"*";
            }
            if (!_phoneTF6.text.length){
                
                _phoneTF6.text = @"*";
            }
            if (!_phoneTF7.text.length){
                
                _phoneTF7.text = @"*";
            }
            
            if ([_phoneTF4.text isEqualToString:@"*"] || [_phoneTF5.text isEqualToString:@"*"] || [_phoneTF6.text isEqualToString:@"*"] || [_phoneTF7.text isEqualToString:@"*"]) {
                
                _phoneTF4.text = @"*";
                _phoneTF5.text = @"*";
                _phoneTF6.text = @"*";
                _phoneTF7.text = @"*";
                if (!_tel4.length) {
                    
                    _tel4 = @"0";
                }
                if (!_tel5.length) {
                    
                    _tel5 = @"0";
                }
                if (!_tel6.length) {
                    
                    _tel6 = @"0";
                }
                if (!_tel7.length) {
                    
                    _tel7 = @"0";
                }
            }
            
            tel = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@",_phoneTF1.text,_phoneTF2.text,_phoneTF3.text,_tel4,_tel5,_tel6,_tel7,_phoneTF8.text,_phoneTF9.text,_phoneTF10.text,_phoneTF11.text];
        }
    }else{
        
        tel = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@",_phoneTF1.text,_phoneTF2.text,_phoneTF3.text,_phoneTF4.text,_phoneTF5.text,_phoneTF6.text,_phoneTF7.text,_phoneTF8.text,_phoneTF9.text,_phoneTF10.text,_phoneTF11.text];
        if (![self checkTel:tel]) {
            
            [self alertControllerWithNsstring:@"温馨提示" And:@"请输入正确的电话号码"];
            return;
        }
    }

    
    if (_model.client_id) {
        
        _Customerinfomodel.name = _name.textfield.text;
        
        if (tel) {
            
            _Customerinfomodel.tel = tel;
        }
        
        if (![self isEmpty:_num.textfield.text]) {
            
            _Customerinfomodel.card_id = _num.textfield.text;
        }
        
        if (![self isEmpty:_detailadress.text]) {
            
            _Customerinfomodel.address = _detailadress.text;
        }

        _Customerinfomodel.is_hide_tel = [NSString stringWithFormat:@"%ld",[[NSNumber numberWithBool:_isHide] integerValue]];
        NSMutableDictionary *dic;
        dic = _Customerinfomodel.modeltodic;
        dic[@"client_id"] = _model.client_id;
        
//        [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
//           
//            if ([[NSString stringWithFormat:@"%@",obj] isEqualToString:@""]) {
//                
//                [dic removeObjectForKey:key];
//            }
//        }];
        
        [BaseRequest POST:UpdateClient_URL parameters:dic success:^(id resposeObject) {
           
            if ([resposeObject[@"code"] integerValue] ==200) {
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadCustom" object:nil];
                [self.navigationController popViewControllerAnimated:YES];
            }
            else{
         
                [self showContent:resposeObject[@"msg"]];
            }
        }failure:^(NSError *error) {
            
            [self showContent:@"网络出错"];
        }];
    }else{
        
        _Customerinfomodel.name = _name.textfield.text;
        if (tel) {
            
            _Customerinfomodel.tel = tel;
        }
        
        _Customerinfomodel.card_id = _num.textfield.text;
        _Customerinfomodel.address = _detailadress.text;
        _Customerinfomodel.is_hide_tel = [NSString stringWithFormat:@"%ld",[[NSNumber numberWithBool:_isHide] integerValue]];
        
        if ([_needBtn.content.text isEqualToString:@"新房"]) {
            
            AddRequireMentVC *nextVC = [[AddRequireMentVC alloc] init];
            nextVC.status = @"addCustom";
            nextVC.infoModel = _Customerinfomodel;
            [self.navigationController pushViewController:nextVC animated:YES];
        }else if([_needBtn.content.text isEqualToString:@"二手房"]){
            
            if ([_typeBtn.content.text isEqualToString:@"商铺"]) {
                
                AddStoreRequireMentVC *nextVC = [[AddStoreRequireMentVC alloc] init];
                nextVC.status = @"addCustom";
                nextVC.infoModel = _Customerinfomodel;
                [self.navigationController pushViewController:nextVC animated:YES];
                
            }else if ([_typeBtn.content.text isEqualToString:@"写字楼"]){
                
                AddOfficeRequireMentVC *nextVC = [[AddOfficeRequireMentVC alloc] init];
                nextVC.status = @"addCustom";
                nextVC.infoModel = _Customerinfomodel;
                [self.navigationController pushViewController:nextVC animated:YES];
            }else{
                
                AddHouseRequireMentVC *nextVC = [[AddHouseRequireMentVC alloc] init];
                nextVC.status = @"addCustom";
                nextVC.infoModel = _Customerinfomodel;
                [self.navigationController pushViewController:nextVC animated:YES];
            }
        }else{
            
            if ([_typeBtn.content.text isEqualToString:@"商铺"]) {
                
                RentingAddStoreRequireMentVC *nextVC = [[RentingAddStoreRequireMentVC alloc] init];
                nextVC.status = @"addCustom";
                nextVC.infoModel = _Customerinfomodel;
                [self.navigationController pushViewController:nextVC animated:YES];
                
            }else if ([_typeBtn.content.text isEqualToString:@"写字楼"]){
                
                RentingAddOfficeRequireMentVC *nextVC = [[RentingAddOfficeRequireMentVC alloc] init];
                nextVC.status = @"addCustom";
                nextVC.infoModel = _Customerinfomodel;
                [self.navigationController pushViewController:nextVC animated:YES];
            }else{
                
                RentingAddRequireMentVC *nextVC = [[RentingAddRequireMentVC alloc] init];
                nextVC.status = @"addCustom";
                nextVC.infoModel = _Customerinfomodel;
                [self.navigationController pushViewController:nextVC animated:YES];
            }
        }
    }
}


-(UIButton *)surebtn
{
    if (!_surebtn) {
        _surebtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _surebtn.frame =  CGRectMake(20*SIZE, 566*SIZE, 320*SIZE, 40*SIZE);
        _surebtn.backgroundColor = YJBlueBtnColor;
        _surebtn.layer.masksToBounds = YES;
        _surebtn.layer.cornerRadius = (CGFloat)1.7*SIZE;
        
        if (_model.name) {
            
            [_surebtn setTitle:@"确定" forState:UIControlStateNormal];
        }else{
            [_surebtn setTitle:@"下一步" forState:UIControlStateNormal];
        }
        [_surebtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _surebtn.titleLabel.font = [UIFont systemFontOfSize:(CGFloat) (15.3 * SIZE)];
        [_surebtn addTarget:self action:@selector(action_sure) forControlEvents:UIControlEventTouchUpInside];
    }
    return _surebtn;
}


@end
