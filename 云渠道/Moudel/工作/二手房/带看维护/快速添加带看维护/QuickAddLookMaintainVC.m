//
//  QuickAddLookMaintainVC.m
//  云渠道
//
//  Created by 谷治墙 on 2019/2/14.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "QuickAddLookMaintainVC.h"

#import "CustomerListVC.h"
#import "LookMaintainDetailAddFollowVC.h"

#import "BorderTF.h"
#import "DropDownBtn.h"

#import "SinglePickView.h"
#import "AdressChooseView.h"

@interface QuickAddLookMaintainVC ()
{
    
    NSString *_clientId;
    NSString *_typeId;
    NSString *_gender;
    NSString *_cardType;
    NSString *_province;
    NSString *_city;
    NSString *_district;
}
@property (nonatomic, strong) UIView *whiteView;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) BorderTF *nameTF;

@property (nonatomic, strong) UIButton *selectBtn;

@property (nonatomic, strong) UILabel *genderL;

@property (nonatomic, strong) DropDownBtn *genderBtn;

@property (nonatomic, strong) UILabel *typeL;

@property (nonatomic, strong) DropDownBtn *typeBtn;

@property (nonatomic, strong) UILabel *phoneL;

@property (nonatomic, strong) BorderTF *phoneTF;

//@property (nonatomic, strong) UIButton *addBtn;

@property (nonatomic, strong) UILabel *phoneL2;

@property (nonatomic, strong) BorderTF *phoneTF2;

@property (nonatomic, strong) UILabel *certTypeL;

@property (nonatomic, strong) DropDownBtn *certTypeBtn;

@property (nonatomic, strong) UILabel *certNumL;

@property (nonatomic, strong) BorderTF *certNumTF;

@property (nonatomic, strong) UILabel *addressL;

@property (nonatomic, strong) DropDownBtn *addressBtn;

@property (nonatomic, strong) UITextView *addressTF;

@property (nonatomic, strong) UIButton *saveBtn;

@end

@implementation QuickAddLookMaintainVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)ActionSaveBtn:(UIButton *)btn{
    
    if ([self isEmpty:_nameTF.textfield.text]) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请输入姓名"];
        return;
    }
    
    if (!_genderBtn.content.text.length) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请选择性别"];
        return;
    }
    
    if (!_typeBtn.content.text.length) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请选择物业类型"];
        return;
    }
    
    if (![self checkTel:_phoneTF.textfield.text]) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请输入正确的电话号码"];
        return;
    }
    
    if (![self isEmpty:_phoneTF2.textfield.text]) {
        
        if (![self checkTel:_phoneTF2.textfield.text]) {
            
            [self alertControllerWithNsstring:@"温馨提示" And:@"请输入正确的电话号码"];
            return;
        }
    }
    
    if ([self isEmpty:_certTypeBtn.content.text]) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请选择证件类型"];
        return;
    }
    
    if ([self isEmpty:_certNumTF.textfield.text]) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请输入证件号码"];
        return;
    }
    
    
    NSDictionary *tempDic = @{@"name":_nameTF.textfield.text,
                              @"sex":_gender,
                              @"client_property_type":_typeId,
                              @"card_type":_cardType,
                              @"card_id":_certNumTF.textfield.text,
//                              @"address":_addressTF.textfield.text,
                              @"client_type":@"185"
                              };
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:tempDic];
    NSString *tel = _phoneTF.textfield.text;
    [dic setObject:tel forKey:@"tel"];
    if (_addressBtn.content.text.length) {
        
        [dic setObject:_province forKey:@"province"];
        [dic setObject:_city forKey:@"city"];
        [dic setObject:_district forKey:@"district"];
    }
    
    if ([self isEmpty:_addressTF.text]) {
        
        [dic setObject:_addressTF.text forKey:@"address"];
    }
    
    if (_clientId.length) {
        
        [dic setObject:_clientId forKey:@"client_id"];
        
        [BaseRequest POST:UpdateClient_URL parameters:dic success:^(id resposeObject) {
            
            if ([resposeObject[@"code"] integerValue] ==200) {
                
                LookMaintainDetailAddFollowVC *nextVC = [[LookMaintainDetailAddFollowVC alloc] init];
                nextVC.lookMaintainDetailAddFollowVCBlock = ^{
                  
                    if (self.quickAddLookMaintainVCBlock) {
                        
                        self.quickAddLookMaintainVCBlock();
                    }
//                    [self.navigationController popViewControllerAnimated:YES];
                };
                nextVC.isSelect = YES;
                nextVC.property = _typeBtn.content.text;
                nextVC.clientId = _clientId;
                [self.navigationController pushViewController:nextVC animated:YES];
            }
            else{
                
                [self showContent:resposeObject[@"msg"]];
            }
        }failure:^(NSError *error) {
            
            [self showContent:@"网络出错"];
        }];
        
    }else{
        
        [BaseRequest POST:AddCustomer_URL parameters:dic success:^(id resposeObject) {
            
            
            if ([resposeObject[@"code"] integerValue] ==200) {
                
                LookMaintainDetailAddFollowVC *nextVC = [[LookMaintainDetailAddFollowVC alloc] init];
                nextVC.lookMaintainDetailAddFollowVCBlock = ^{
                    
                    if (self.quickAddLookMaintainVCBlock) {
                        
                        self.quickAddLookMaintainVCBlock();
                    }
                };
                nextVC.isSelect = YES;
                nextVC.property = _typeBtn.content.text;
                nextVC.clientId = [NSString stringWithFormat:@"%@",resposeObject[@"data"]];
                [self.navigationController pushViewController:nextVC animated:YES];
            }
            else{
                
                [self showContent:resposeObject[@"msg"]];
            }
        } failure:^(NSError *error) {
            
            [self showContent:@"网络错误"];
        }];
    }
}

- (void)ActionGenderBtn:(UIButton *)btn{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"性别" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *male = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        _genderBtn.content.text = @"男";
        _gender = @"1";
    }];
    
    UIAlertAction *female = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        _genderBtn.content.text = @"女";
        _gender = @"2";
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:male];
    [alert addAction:female];
    [alert addAction:cancel];
    [self.navigationController presentViewController:alert animated:YES completion:^{
        
    }];
}

- (void)ActionTypeBtn:(UIButton *)btn{
    
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
        _typeId = [NSString stringWithFormat:@"%@", ID];
//        _Customerinfomodel.client_property_type = [NSString stringWithFormat:@"%@",ID];
    };
    [self.view addSubview:view];
}

- (void)ActionCardTypeBtn:(UIButton *)btn{
    
    SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.frame WithData:[self getDetailConfigArrByConfigState:2]];
    SS(strongSelf);
    view.selectedBlock = ^(NSString *MC, NSString *ID) {
        
        strongSelf->_certTypeBtn.content.text = [NSString stringWithFormat:@"%@",MC];
        strongSelf->_cardType = [NSString stringWithFormat:@"%@",ID];
    };
    [self.view addSubview:view];
}

- (void)ActionAddressBtn:(UIButton *)btn{
    
    AdressChooseView *view = [[AdressChooseView alloc]initWithFrame:self.view.frame withdata:@[]];
    [self.view addSubview:view];
    view.selectedBlock = ^(NSString *province, NSString *city, NSString *area, NSString *proviceid, NSString *cityid, NSString *areaid) {
        _addressBtn.content.text = [NSString stringWithFormat:@"%@/%@/%@",province,city,area];
        _province = proviceid;
        _city = cityid;
        _district = areaid;
    };
}

- (void)ActionAddBtn:(UIButton *)btn{
    
    _phoneL2.hidden = NO;
    _phoneTF2.hidden = NO;
    [_phoneL2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(9 *SIZE);
        make.top.equalTo(_phoneTF.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_phoneTF2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(81 *SIZE);
        make.top.equalTo(_phoneTF.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_certTypeL mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(9 *SIZE);
        make.top.equalTo(_phoneTF2.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_certTypeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(81 *SIZE);
        make.top.equalTo(_phoneTF2.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
}

- (void)ActionSelectBtn:(UIButton *)btn{
    
    CustomerListVC *nextVC = [[CustomerListVC alloc] init];
    nextVC.isSelect = YES;
    nextVC.status = 1;
    nextVC.customerListVCCustomBlock = ^(CustomerTableModel * _Nonnull model) {
      
        _clientId = [NSString stringWithFormat:@"%@",model.client_id];
        _nameTF.textfield.text = model.name;
        if ([model.sex integerValue] == 1) {
            
            _genderBtn.content.text = @"男";
            _gender = @"1";
        }else if ([model.sex integerValue] == 2){
            
            _genderBtn.content.text = @"女";
            _gender = @"2";
        }else{
            
            _genderBtn.content.text = @"";
            _gender = @"";
        }
        _typeBtn.content.text = model.client_property_type;
        if ([_typeBtn.content.text isEqualToString:@"商铺"]) {
            
            _typeId = @"2";
        }else if ([_typeBtn.content.text isEqualToString:@"写字楼"]){
            
            _typeId = @"3";
        }else{
            
            _typeId = @"1";
        }
        _phoneTF.textfield.text = model.tel;
        _addressTF.text = model.address;
        if (model.region.count) {
            
            _province = model.region[0][@"province_name"];
            _city = model.region[0][@"city_name"];
            _district = model.region[0][@"district_name"];
        }
    };
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    
    self.titleLabel.text = @"添加带看维护";
    
    
    _whiteView = [[UIView alloc] init];
    _whiteView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_whiteView];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10 *SIZE, 15 *SIZE, 7 *SIZE, 13 *SIZE)];
    view.backgroundColor = YJBlueBtnColor;
    [_whiteView addSubview:view];
    
    UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(31 *SIZE, 14 *SIZE, 100 *SIZE, 15 *SIZE)];
    titleL.textColor = YJTitleLabColor;
    titleL.font = [UIFont systemFontOfSize:15 *SIZE];
    titleL.text = @"联系人信息";
    [_whiteView addSubview:titleL];
    
    _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_selectBtn addTarget:self action:@selector(ActionSelectBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_selectBtn setImage:[UIImage imageNamed:@"add_3-1"] forState:UIControlStateNormal];
    [_whiteView addSubview:_selectBtn];
    
//    _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_addBtn addTarget:self action:@selector(ActionAddBtn:) forControlEvents:UIControlEventTouchUpInside];
//    [_addBtn setImage:[UIImage imageNamed:@"add_2"] forState:UIControlStateNormal];
//    [_whiteView addSubview:_addBtn];
    
    _addressBtn = [[DropDownBtn alloc] initWithFrame:CGRectMake(81 *SIZE, 0, 257 *SIZE, 33 *SIZE)];
    [_addressBtn addTarget:self action:@selector(ActionAddressBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_whiteView addSubview:_addressBtn];
    NSArray *titleArr = @[@"主权益人：",@"性别：",@"物业类型：",@"联系电话：",@"联系电话2：",@"证件类型：",@"证件编号：",@"通讯地址："];

    for (int i = 0; i < 8; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = YJTitleLabColor;
        label.text = titleArr[i];
        label.adjustsFontSizeToFitWidth = YES;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        
        BorderTF *textField = [[BorderTF alloc] initWithFrame:CGRectMake(81 *SIZE, 0, 257 *SIZE, 33 *SIZE)];

        DropDownBtn *btn = [[DropDownBtn alloc] initWithFrame:textField.frame];
        
        switch (i) {
            case 0:
            {
                _nameL = label;
                [_whiteView addSubview:_nameL];
                _nameTF = textField;
                [_whiteView addSubview:_nameTF];
                break;
            }
            case 1:
            {
                _genderL = label;
                [_whiteView addSubview:_genderL];
                _genderBtn = btn;
//                if ([_dataDic[@"sex"] integerValue] == 2) {
//
//                    _gender = @"2";
//                    _genderBtn.content.text = @"女";
//                }else if ([_dataDic[@"sex"] integerValue] == 1){
//
//                    _gender = @"1";
//                    _genderBtn.content.text = @"男";
//                }
                [_genderBtn addTarget:self action:@selector(ActionGenderBtn:) forControlEvents:UIControlEventTouchUpInside];
                [_whiteView addSubview:_genderBtn];
                break;
            }
            case 2:
            {
                _typeL = label;
                [_whiteView addSubview:_typeL];
                _typeBtn = btn;
//                if (_dataDic.count) {
//
//                    _typeBtn.content.text = _dataDic[@"report_type"];
//                }
                [_typeBtn addTarget:self action:@selector(ActionTypeBtn:) forControlEvents:UIControlEventTouchUpInside];
                [_whiteView addSubview:_typeBtn];
                break;
            }
            case 3:
            {
                _phoneL = label;
                [_whiteView addSubview:_phoneL];
                _phoneTF = textField;
                _phoneTF.textfield.keyboardType = UIKeyboardTypeNumberPad;
                [_whiteView addSubview:_phoneTF];
                break;
            }
            case 4:
            {
                _phoneL2 = label;
                _phoneL2.hidden = YES;
                [_whiteView addSubview:_phoneL2];
                _phoneTF2 = textField;
                _phoneTF2.hidden = YES;
                [_whiteView addSubview:_phoneTF2];
                break;
            }
            case 5:
            {
                _certTypeL = label;
                [_whiteView addSubview:_certTypeL];
                _certTypeBtn = btn;
//                if ([_dataDic count]) {
//
//                    _certTypeBtn.content.text = _dataDic[@"card_type"];
//                    NSArray *arr = [self getDetailConfigArrByConfigState:2];
//                    for (int i = 0; i < arr.count; i++) {
//
//                        if ([_dataDic[@"card_type"] isEqualToString:arr[i][@"param"]]) {
//
//                            _cardType = [NSString stringWithFormat:@"%@",arr[i][@"id"]];
//                            break;
//                        }
//                    }
//                }
                [_certTypeBtn addTarget:self action:@selector(ActionCardTypeBtn:) forControlEvents:UIControlEventTouchUpInside];
                [_whiteView addSubview:_certTypeBtn];
                break;
            }
            case 6:
            {
                _certNumL = label;
                [_whiteView addSubview:_certNumL];
                _certNumTF = textField;
                [_whiteView addSubview:_certNumTF];
                break;
            }
            case 7:
            {
                _addressL = label;
                [_whiteView addSubview:_addressL];
                _addressTF = [[UITextView alloc] init];
                _addressTF.layer.cornerRadius = textField.layer.cornerRadius;
                _addressTF.clipsToBounds = YES;
                _addressTF.layer.borderColor = textField.layer.borderColor;
                _addressTF.layer.borderWidth = textField.layer.borderWidth;
                [_whiteView addSubview:_addressTF];
                break;
            }
            default:
                break;
        }
    }
    
    _saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _saveBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_saveBtn addTarget:self action:@selector(ActionSaveBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_saveBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [_saveBtn setBackgroundColor:YJBlueBtnColor];
    [self.view addSubview:_saveBtn];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(NAVIGATION_BAR_HEIGHT);
        make.width.mas_equalTo(SCREEN_Width);
    }];
    
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(9 *SIZE);
        make.top.equalTo(_whiteView).offset(61 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_nameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(81 *SIZE);
        make.top.equalTo(_whiteView).offset(51 *SIZE);
        make.width.mas_equalTo(107 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_nameTF.mas_right).offset(5 *SIZE);
        make.top.equalTo(_whiteView).offset(51 *SIZE);
        make.width.mas_equalTo(35 *SIZE);
        make.height.mas_equalTo(35 *SIZE);
    }];
    
    [_genderL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_selectBtn.mas_right).offset(5 *SIZE);
        make.top.equalTo(_whiteView).offset(61 *SIZE);
        make.width.mas_equalTo(50 *SIZE);
    }];
    
    [_genderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_genderL.mas_right).offset(-5 *SIZE);
        make.top.equalTo(_whiteView).offset(51 *SIZE);
        make.width.mas_equalTo(57 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_typeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(9 *SIZE);
        make.top.equalTo(_nameTF.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_typeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(81 *SIZE);
        make.top.equalTo(_nameTF.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_phoneL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(9 *SIZE);
        make.top.equalTo(_typeBtn.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(81 *SIZE);
        make.top.equalTo(_typeBtn.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
//    [_addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(_whiteView).offset(308 *SIZE);
//        make.top.equalTo(_typeBtn.mas_bottom).offset(21 *SIZE);
//        make.width.mas_equalTo(35 *SIZE);
//        make.height.mas_equalTo(35 *SIZE);
//    }];
    
    [_certTypeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(9 *SIZE);
        make.top.equalTo(_phoneTF.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_certTypeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(81 *SIZE);
        make.top.equalTo(_phoneTF.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_certNumL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(9 *SIZE);
        make.top.equalTo(_certTypeBtn.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_certNumTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(81 *SIZE);
        make.top.equalTo(_certTypeBtn.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_addressL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(9 *SIZE);
        make.top.equalTo(_certNumTF.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_addressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(81 *SIZE);
        make.top.equalTo(_certNumTF.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
//        make.bottom.equalTo(_whiteView).offset(-25 *SIZE);
    }];
    
    [_addressTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(81 *SIZE);
        make.top.equalTo(_addressBtn.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(88 *SIZE);
        make.bottom.equalTo(_whiteView).offset(-25 *SIZE);
    }];
    
    [_saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).offset(0 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(40 *SIZE + TAB_BAR_MORE);
        make.bottom.equalTo(self.view).offset(0 *SIZE);
    }];
}
@end
