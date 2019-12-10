//
//  AddPeopleVC.m
//  云渠道
//
//  Created by xiaoq on 2019/1/22.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "AddPeopleVC.h"
#import "BorderTF.h"
#import "DropDownBtn.h"
#import "SinglePickView.h"

@interface AddPeopleVC ()
{
    NSString *_typeId;
    NSString *_gender;
    NSString *_cardType;
    
}
@property (nonatomic, strong) UIView *whiteView;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) BorderTF *nameTF;

@property (nonatomic, strong) UILabel *genderL;

@property (nonatomic, strong) DropDownBtn *genderBtn;

@property (nonatomic, strong) UILabel *typeL;

@property (nonatomic, strong) DropDownBtn *typeBtn;

@property (nonatomic, strong) UILabel *phoneL;

@property (nonatomic, strong) BorderTF *phoneTF;

@property (nonatomic, strong) UIButton *addBtn;

@property (nonatomic, strong) UILabel *phoneL2;

@property (nonatomic, strong) BorderTF *phoneTF2;

@property (nonatomic, strong) UILabel *certTypeL;

@property (nonatomic, strong) DropDownBtn *certTypeBtn;

@property (nonatomic, strong) UILabel *certNumL;

@property (nonatomic, strong) BorderTF *certNumTF;

@property (nonatomic, strong) UILabel *addressL;

@property (nonatomic, strong) BorderTF *addressTF;

@property (nonatomic, strong) UIButton *saveBtn;

@end

@implementation AddPeopleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    if (!_dataDic) {
        _dataDic =[NSMutableDictionary dictionaryWithDictionary:
                   @{@"name":@"",
                     @"tel":@"",
                     @"card_type":@"",
                     @"card_id":@"",
                     @"address":@"",
                     @"sex":@""
                     }];
    }
    
    [self initUI];
}

- (void)ActionSaveBtn:(UIButton *)btn{
    
    if ([self isEmpty:_nameTF.textfield.text]) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请输入姓名"];
        return;
    }
    
    if (!_genderBtn->str.length) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请选择性别"];
        return;
    }
    
    
    if (![self checkTel:_phoneTF.textfield.text]) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请输入正确的电话号码"];
        return;
    }
    
    if (!_certTypeBtn->str.length) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请选择证件编号"];
        return;
    }
    

    _dataDic =[NSMutableDictionary dictionaryWithDictionary:
               @{@"name":_nameTF.textfield.text,
                 @"tel":_phoneTF.textfield.text,
                 @"card_type":_certTypeBtn->str,
                 @"card_type_name":_certTypeBtn.content.text,
                 @"card_id":_certNumTF.textfield.text,
                 @"address":_addressTF.textfield.text,
                 @"sex":_genderBtn->str
                 }];
    
    [self.navigationController popViewControllerAnimated:YES];
    if (self.AddPeopleblock != nil) {
        
        self.AddPeopleblock(_dataDic);
    }
}

- (void)ActionGenderBtn:(UIButton *)btn{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"性别" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *male = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        _genderBtn.content.text = @"男";
        _genderBtn->str = @"1";
    }];
    
    UIAlertAction *female = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        _genderBtn.content.text = @"女";
        _genderBtn->str = @"2";
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:male];
    [alert addAction:female];
    [alert addAction:cancel];
    [self.navigationController presentViewController:alert animated:YES completion:^{
        
    }];
}

//- (void)ActionTypeBtn:(UIButton *)btn{
//
//    SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.frame WithData:@[@{@"param":@"主权益人",
//                        @"id":@"1"
//                    },
//                    @{@"param":@"副权益人",
//                         @"id":@"2"
//                      }
//                    ]];
//    SS(strongSelf);
//    view.selectedBlock = ^(NSString *MC, NSString *ID) {
//
//        strongSelf->_typeBtn.content.text = [NSString stringWithFormat:@"%@",MC];
//        strongSelf->_typeBtn->str = [NSString stringWithFormat:@"%@",ID];
//    };
//    [self.view addSubview:view];
//}

- (void)ActionCardTypeBtn:(UIButton *)btn{
    
    SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.frame WithData:[self getDetailConfigArrByConfigState:2]];
    SS(strongSelf);
    view.selectedBlock = ^(NSString *MC, NSString *ID) {
        
        strongSelf->_certTypeBtn.content.text = [NSString stringWithFormat:@"%@",MC];
        strongSelf->_certTypeBtn->str = [NSString stringWithFormat:@"%@",ID];
    };
    [self.view addSubview:view];
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

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"添加权益人";
    _whiteView = [[UIView alloc] init];
    _whiteView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_whiteView];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10 *SIZE, 15 *SIZE, 7 *SIZE, 13 *SIZE)];
    view.backgroundColor = YJBlueBtnColor;
    [_whiteView addSubview:view];
    
    UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(31 *SIZE, 14 *SIZE, 100 *SIZE, 15 *SIZE)];
    titleL.textColor = YJTitleLabColor;
    titleL.font = [UIFont systemFontOfSize:15 *SIZE];
    titleL.text = @"权益人信息";
    [_whiteView addSubview:titleL];
    
//    _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_addBtn addTarget:self action:@selector(ActionAddBtn:) forControlEvents:UIControlEventTouchUpInside];
//    [_addBtn setImage:[UIImage imageNamed:@"add_2"] forState:UIControlStateNormal];
//    [_whiteView addSubview:_addBtn];
    
    NSArray *titleArr = @[@"姓名：",@"性别：",@"联系电话：",@"证件类型：",@"证件编号：",@"通讯地址："];
    

    
    for (int i = 0; i < 6; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = YJTitleLabColor;
        label.text = titleArr[i];
        label.adjustsFontSizeToFitWidth = YES;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        
        BorderTF *textField = [[BorderTF alloc] initWithFrame:CGRectMake(81 *SIZE, 0, 257 *SIZE, 33 *SIZE)];
        if (self.dataDic.count) {
            
//            textField.textfield.text = contentArr[i];
        }
        DropDownBtn *btn = [[DropDownBtn alloc] initWithFrame:textField.frame];
        
        switch (i) {
            case 0:
            {
                _nameL = label;
                [_whiteView addSubview:_nameL];
                _nameTF = textField;
                if (_dataDic[@"name"]) {
                    _nameTF.textfield.text = _dataDic[@"name"];
                }
                [_whiteView addSubview:_nameTF];
                break;
            }
            case 1:
            {
                _genderL = label;
                [_whiteView addSubview:_genderL];
                _genderBtn = btn;
                if ([self.dataDic[@"sex"] integerValue] == 2) {
                    
                    _genderBtn->str = @"2";
                    _genderBtn.content.text = @"女";
                }else if ([self.dataDic[@"sex"] integerValue] == 1){
                    
                    _genderBtn->str = @"1";
                    _genderBtn.content.text = @"男";
                }
                [_genderBtn addTarget:self action:@selector(ActionGenderBtn:) forControlEvents:UIControlEventTouchUpInside];
                [_whiteView addSubview:_genderBtn];
                break;
            }
           
            case 2:
            {
                _phoneL = label;
                [_whiteView addSubview:_phoneL];
                _phoneTF = textField;
                if (_dataDic[@"tel"]) {
                    _phoneTF.textfield.text = _dataDic[@"tel"];
                }
                [_whiteView addSubview:_phoneTF];
                break;
            }
            case 3:
            {
                _certTypeL = label;
                [_whiteView addSubview:_certTypeL];
                _certTypeBtn = btn;
                if (_dataDic[@"card_type"]) {
                    
                    _certTypeBtn.content.text = _dataDic[@"card_type_name"];
                    _certTypeBtn->str = _dataDic[@"card_type"];
                }
                else{
                    _certTypeBtn.content.text = @"";
                    _certTypeBtn->str = @"";
                }
                [_certTypeBtn addTarget:self action:@selector(ActionCardTypeBtn:) forControlEvents:UIControlEventTouchUpInside];
                [_whiteView addSubview:_certTypeBtn];
                break;
            }
            case 4:
            {
                _certNumL = label;
                [_whiteView addSubview:_certNumL];
                _certNumTF = textField;
                if (_dataDic[@"card_id"]) {
                    _certNumTF.textfield.text = [NSString stringWithFormat:@"%@",_dataDic[@"card_id"]];
                }
                [_whiteView addSubview:_certNumTF];
                break;
            }
            case 5:
            {
                _addressL = label;
                [_whiteView addSubview:_addressL];
                _addressTF = textField;
                if (_dataDic[@"address"]) {
                    _addressTF.textfield.text =_dataDic[@"address"];
                }
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
    [_saveBtn setTitle:@"确定" forState:UIControlStateNormal];
    [_saveBtn setBackgroundColor:YJBlueBtnColor];
    [self.view addSubview:_saveBtn];
    
    [self MasonryUI];
    if (self.dataDic.count) {
//
//        if ([self.dataDic[@"tel"] count] == 2) {
//
//            [self ActionAddBtn:_addBtn];
//        }
    }
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
        make.width.mas_equalTo(117 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_genderL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(208 *SIZE);
        make.top.equalTo(_whiteView).offset(61 *SIZE);
        make.width.mas_equalTo(50 *SIZE);
    }];
    
    [_genderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(251 *SIZE);
        make.top.equalTo(_whiteView).offset(51 *SIZE);
        make.width.mas_equalTo(87 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
//    [_typeL mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(_whiteView).offset(9 *SIZE);
//        make.top.equalTo(_nameTF.mas_bottom).offset(31 *SIZE);
//        make.width.mas_equalTo(70 *SIZE);
//    }];
//
//    [_typeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(_whiteView).offset(81 *SIZE);
//        make.top.equalTo(_nameTF.mas_bottom).offset(20 *SIZE);
//        make.width.mas_equalTo(257 *SIZE);
//        make.height.mas_equalTo(33 *SIZE);
//    }];
    
    [_phoneL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(9 *SIZE);
        make.top.equalTo(_nameTF.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(81 *SIZE);
        make.top.equalTo(_nameTF.mas_bottom).offset(20 *SIZE);
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
//
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
    
    [_addressTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(81 *SIZE);
        make.top.equalTo(_certNumTF.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
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

