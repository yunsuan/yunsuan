//
//  NewDealVC.m
//  云渠道
//
//  Created by 谷治墙 on 2019/8/26.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "NewDealVC.h"
#import "NewDealRuleVC.h"

#import "BaseHeader.h"

#import "DropDownBtn.h"
#import "BorderTF.h"

#import "SinglePickView.h"
#import "DateChooseView.h"

@interface NewDealVC ()<UITextFieldDelegate>
{
    
    //    NSString *_project_id;
    //    NSString *_company_id;
    
    NSDictionary *_dic;
    
    NSArray *_ruleArr;
    
    NSMutableArray *_ruleMArr;
    
    NSDateFormatter *_formatter;
}
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) BorderTF *nameTF;

@property (nonatomic, strong) UILabel *genderL;

@property (nonatomic, strong) UIButton *maleBtn;

@property (nonatomic, strong) UIButton *femaleBtn;

@property (nonatomic, strong) UILabel *phoneL;

@property (nonatomic, strong) BorderTF *phoneTF;

@property (nonatomic, strong) UILabel *certTypeL;

@property (nonatomic, strong) DropDownBtn *certTypeBtn;

@property (nonatomic, strong) UILabel *certNumL;

@property (nonatomic, strong) BorderTF *certNumTF;

@property (nonatomic, strong) UILabel *addressL;

@property (nonatomic, strong) DropDownBtn *addressBtn;

@property (nonatomic, strong) UILabel *recommendL;

@property (nonatomic, strong) BorderTF *recommendTF;

@property (nonatomic, strong) UILabel *projectL;

@property (nonatomic, strong) BorderTF *projectTF;

@property (nonatomic, strong) UIButton *nextBtn;

@property (nonatomic, strong) BaseHeader *dealHeader;

@property (nonatomic, strong) UILabel *codeL;

@property (nonatomic, strong) BorderTF *codeTF;

@property (nonatomic, strong) UILabel *roomNumL;

@property (nonatomic, strong) BorderTF *roomNumTF;

@property (nonatomic, strong) UILabel *propertyL;

@property (nonatomic, strong) DropDownBtn *propertyBtn;

@property (nonatomic, strong) UILabel *areaL;

@property (nonatomic, strong) BorderTF *areaTF;

@property (nonatomic, strong) UILabel *innerL;

@property (nonatomic, strong) BorderTF *innerTF;

@property (nonatomic, strong) UILabel *priceL;

@property (nonatomic, strong) BorderTF *priceTF;

@property (nonatomic, strong) UILabel *payWayL;

@property (nonatomic, strong) DropDownBtn *payWayBtn;

@property (nonatomic, strong) UILabel *paymentL;

@property (nonatomic, strong) BorderTF *paymentTF;

@property (nonatomic, strong) UILabel *loanL;

@property (nonatomic, strong) BorderTF *loanTF;

@property (nonatomic, strong) UILabel *ruleL;

@property (nonatomic, strong) DropDownBtn *ruleBtn;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) DropDownBtn *timeBtn;

@end

@implementation NewDealVC

- (instancetype)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        
        _dic = dic;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
    [self RequestMethod];
}

- (void)initDataSource{
    
    _formatter = [[NSDateFormatter alloc] init];
    [_formatter setDateFormat:@"YYYY-MM-dd"];
    _ruleMArr = [@[] mutableCopy];
}

- (void)RequestMethod{
    
//        [BaseRequest GET:DealRuleList_URL parameters:@{@"project_id":self.project_id,@"company_id":[UserModel defaultModel].company_id} success:^(id resposeObject) {
//
//            if ([resposeObject[@"code"] integerValue] == 200) {
//
//                self->_ruleArr = resposeObject[@"data"];
//                for (int i = 0; i < self->_ruleArr.count; i++) {
//
//                    [self->_ruleMArr addObject:@{@"param":self->_ruleArr[i][@"rule_type"],
//                                                 @"id":self->_ruleArr[i][@"rule_id"]
//                                                 }];
//                }
//            }else{
//
//    //            [self showContent:resposeObject[@"msg"]];
//            }
//        } failure:^(NSError *error) {
//
//    //        self showContent:@""
//        }];
}

- (void)ActionTagBtn:(UIButton *)btn{
    
    
}

- (void)ActionDropBtn:(UIButton *)btn{
    
    switch (btn.tag) {
        case 2:
        {
            SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:[self getDetailConfigArrByConfigState:PROPERTY_TYPE]];
            view.selectedBlock = ^(NSString *MC, NSString *ID) {
                
                self->_propertyBtn.placeL.text = @"";
                self->_propertyBtn.content.text = MC;
                self->_propertyBtn->str = [NSString stringWithFormat:@"%@",ID];
            };
            [self.view addSubview:view];
            break;
        }
        case 3:
        {
            SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:[self getDetailConfigArrByConfigState:PAY_WAY]];
            view.selectedBlock = ^(NSString *MC, NSString *ID) {
                
                self->_payWayBtn.placeL.text = @"";
                self->_payWayBtn.content.text = MC;
                self->_payWayBtn->str = [NSString stringWithFormat:@"%@",ID];
            };
            [self.view addSubview:view];
            break;
        }
        case 4:
        {
            
            NewDealRuleVC *nextVC = [[NewDealRuleVC alloc] init];
            nextVC.project_id = self.project_id;
            nextVC.newDealRuleVCBlock = ^(NSDictionary * _Nonnull dic) {
                
                self->_ruleBtn.placeL.text = @"";
                self->_ruleBtn.content.text = dic[@"rule_type"];
                self->_ruleBtn->str = [NSString stringWithFormat:@"%@",dic[@"rule_id"]];
            };
            [self.navigationController pushViewController:nextVC animated:YES];
            //            if (self->_ruleMArr.count) {
            //
            //                SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:_ruleMArr];
            //                view.selectedBlock = ^(NSString *MC, NSString *ID) {
            //
            //                    self->_ruleBtn.placeL.text = @"";
            //                    self->_ruleBtn.content.text = MC;
            //                    self->_ruleBtn->str = [NSString stringWithFormat:@"%@",ID];
            //                };
            //                [self.view addSubview:view];
            //            }else{
            //
            //                [BaseRequest GET:DealRuleList_URL parameters:@{@"project_id":self.project_id,@"company_id":[UserModel defaultModel].company_id} success:^(id resposeObject) {
            //
            //                    if ([resposeObject[@"code"] integerValue] == 200) {
            //
            //                        self->_ruleArr = resposeObject[@"data"];
            //                        for (int i = 0; i < self->_ruleArr.count; i++) {
            //
            //                            [self->_ruleMArr addObject:@{@"param":self->_ruleArr[i][@"rule_type"],
            //                                                         @"id":self->_ruleArr[i][@"rule_id"]
            //                                                         }];
            //                        }
            //                        SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:self->_ruleMArr];
            //                        view.selectedBlock = ^(NSString *MC, NSString *ID) {
            //
            //                            self->_ruleBtn.placeL.text = @"";
            //                            self->_ruleBtn.content.text = MC;
            //                            self->_ruleBtn->str = [NSString stringWithFormat:@"%@",ID];
            //                        };
            //                        [self.view addSubview:view];
            //                    }else{
            //
            //                        [self showContent:resposeObject[@"msg"]];
            //                    }
            //                } failure:^(NSError *error) {
            //
            //                    [self showContent:@"获取规则失败"];
            //                }];
            //            }
            break;
        }
        case 5:
        {
            DateChooseView *view = [[DateChooseView alloc] initWithFrame:self.view.bounds];
            view.dateblock = ^(NSDate *date) {
                
                self->_timeBtn.content.text = [self->_formatter stringFromDate:date];
                self->_timeBtn->str = [self->_formatter stringFromDate:date];
            };
            [self.view addSubview:view];
            break;
        }
        default:
            break;
    }
}

- (void)ActionNextBtn:(UIButton *)btn{
    
    if ([self isEmpty:_codeTF.textfield.text]) {
        
        [self showContent:@"请输入合同编号"];
        return;
    }
    
    if ([self isEmpty:_roomNumTF.textfield.text]) {
        
        [self showContent:@"请输入房号"];
        return;
    }
    
    if (!_propertyBtn.content.text.length) {
        
        [self showContent:@"请选择物业类型"];
        return;
    }
    
    if ([self isEmpty:_areaTF.textfield.text]) {
        
        [self showContent:@"请输入建筑面积"];
        return;
    }
    if ([self isEmpty:_innerTF.textfield.text]) {
        
        [self showContent:@"请输入套内面积"];
        return;
    }
    
    if ([self isEmpty:_priceTF.textfield.text]) {
        
        [self showContent:@"请输入成交价格"];
        return;
    }
    
    if (!_payWayBtn.content.text.length) {
        
        [self showContent:@"请选择付款方式"];
        return;
    }
    
    if (!_ruleBtn.content.text.length) {
        
        [self showContent:@"请选择佣金规则"];
        return;
    }
    
    if (!_timeBtn.content.text.length) {
        
        [self showContent:@"请选择成交时间"];
        return;
    }
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"client_id":[NSString stringWithFormat:@"%@",_dic[@"client_id"]]}];
    [dic setObject:_timeBtn.content.text forKey:@"time"];
    [dic setObject:_roomNumTF.textfield.text forKey:@"house_info"];
    [dic setObject:_codeTF.textfield.text forKey:@"contract_num"];
    [dic setObject:_payWayBtn.content.text forKey:@"pay_way"];
    [dic setObject:_loanTF.textfield.text forKey:@"loan_money"];
    [dic setObject:[NSString stringWithFormat:@"%.2f",[_priceTF.textfield.text floatValue] / [_areaTF.textfield.text floatValue]] forKey:@"build_deal_money"];
    [dic setObject:[NSString stringWithFormat:@"%.2f",[_priceTF.textfield.text floatValue] / [_innerTF.textfield.text floatValue]] forKey:@"inner_deal_money"];
    [dic setObject:_priceTF.textfield.text forKey:@"total_money"];
    [dic setObject:[NSString stringWithFormat:@"%.2f",[_priceTF.textfield.text floatValue] - [_paymentTF.textfield.text floatValue]] forKey:@"unpaid_money"];
    [dic setObject:_innerTF.textfield.text forKey:@"inner_area"];
    [dic setObject:_areaTF.textfield.text forKey:@"build_area"];
    [dic setObject:@"" forKey:@"designer"];
    [dic setObject:[_formatter stringFromDate:[NSDate date]] forKey:@"design_time"];
    [dic setObject:_propertyBtn.content.text forKey:@"property"];
    [dic setObject:_ruleBtn->str forKey:@"rule_id"];
    if (![self isEmpty:_paymentTF.textfield.text]) {
        
        [dic setObject:_paymentTF.textfield.text forKey:@"already_pay_money"];
    }
    
    if (![self isEmpty:_loanTF.textfield.text]) {
        
        [dic setObject:_paymentTF.textfield.text forKey:@"loan_money"];
    }
    
    
    [BaseRequest POST:@"agent/work/deal" parameters:dic success:^(id resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if (self.newDealVCBlock) {
                
                self.newDealVCBlock();
            }
            [self showContent:resposeObject[@"msg"]];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [self.navigationController popViewControllerAnimated:YES];
            });
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [self showContent:@"网络错误"];
    }];
}

- (void)textFieldDidChange:(UITextField *)textfield{
    
    if (textfield == _phoneTF.textfield) {
        
        if (textfield.text.length > 11) {
            
            textfield.text = [textfield.text substringToIndex:11];
        }
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField == _phoneTF.textfield || textField == _areaTF.textfield || textField == _innerTF.textfield || textField == _priceTF.textfield || textField == _paymentTF.textfield || textField == _loanTF.textfield) {
        
        return [self validateNumber:string];
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (textField == _phoneTF.textfield) {
        
        if ([self checkTel:textField.text]) {
            
            [self RequestMethod];
        }else{
            
            [self showContent:@"请输入正确的电话号码"];
        }
    }
    return YES;
}

- (void)initUI{
    
    self.titleLabel.text = @"新增成交";
    
    self.navBackgroundView.hidden = NO;
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.backgroundColor = CLWhiteColor;
    [self.view addSubview:_scrollView];
    
    BaseHeader *header = [[BaseHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
    header.titleL.text = @"客户信息";
    [_scrollView addSubview:header];
    
    _dealHeader = [[BaseHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
    _dealHeader.titleL.text = @"成交信息";
    [_scrollView addSubview:_dealHeader];
    
    NSArray *btnArr = @[@"男",@"女"];
    for (int i = 0; i < 2; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
        btn.tag = i;
        [btn addTarget:self action:@selector(ActionTagBtn:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:btnArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:YJContentLabColor forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"default"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"default"] forState:UIControlStateSelected];
        
        switch (i) {
            case 0:
            {
                _maleBtn = btn;
                //                [_scrollView addSubview:_maleBtn];
                
                break;
            }
            case 1:
            {
                _femaleBtn = btn;
                //                [_scrollView addSubview:_femaleBtn];
                
                break;
            }
            default:
                break;
        }
    }
    
    for (int i = 0; i < 12; i++) {
        
        BorderTF *tf = [[BorderTF alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
        switch (i) {
            case 0:
            {
                _nameTF = tf;
                _nameTF.textfield.delegate = self;
                _nameTF.textfield.placeholder = @"姓名";
                _nameTF.userInteractionEnabled = NO;
                _nameTF.backgroundColor = CLBackColor;
                _nameTF.textfield.text = _dic[@"name"];
                [_scrollView addSubview:_nameTF];
                break;
            }
            case 1:
            {
                _phoneTF = [[BorderTF alloc] initWithFrame:CGRectMake(0, 0, 217 *SIZE, 33 *SIZE)];
                _phoneTF.textfield.placeholder = @"请输入手机号码";
                _phoneTF.textfield.delegate = self;
                _phoneTF.textfield.keyboardType = UIKeyboardTypePhonePad;
                [_phoneTF.textfield addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
                _phoneTF.userInteractionEnabled = NO;
                _phoneTF.backgroundColor = CLBackColor;
                _phoneTF.textfield.text = _dic[@"tel"];
                _phoneTF.textfield.keyboardType = UIKeyboardTypeNumberPad;
                [_scrollView addSubview:_phoneTF];
                break;
            }
            case 2:
            {
                _certNumTF = tf;
                _certNumTF.textfield.placeholder = @"请输入证件号";
                _certNumTF.textfield.keyboardType = UIKeyboardTypeNumberPad;
                _certNumTF.textfield.delegate = self;
                
                //                [_scrollView addSubview:_certNumTF];
                break;
            }
            case 3:
            {
                _recommendTF = tf;
                //                _recommendTF.textField.placeholder = @"请输入邮政编码";
                //                _recommendTF.textField.keyboardType = UIKeyboardTypeNumberPad;
                _recommendTF.userInteractionEnabled = NO;
                _recommendTF.backgroundColor = CLBackColor;
                _recommendTF.textfield.text = _dic[@"agent_name"];
                [_scrollView addSubview:_recommendTF];
                break;
            }
            case 4:
            {
                
                _codeTF = tf;
                _codeTF.textfield.placeholder = @"请输入合同编号";
                [_scrollView addSubview:_codeTF];
                break;
            }
            case 5:
            {
                
                _roomNumTF = tf;
                _roomNumTF.textfield.placeholder = @"请输入房号";
                [_scrollView addSubview:_roomNumTF];
                break;
            }
            case 6:
            {
                
                _areaTF = tf;
                _areaTF.textfield.placeholder = @"请输入建筑面积";
                _areaTF.textfield.keyboardType = UIKeyboardTypeNumberPad;
                [_scrollView addSubview:_areaTF];
                break;
            }
            case 7:
            {
                
                _innerTF = tf;
                _innerTF.textfield.placeholder = @"请输入套内面积";
                _innerTF.textfield.keyboardType = UIKeyboardTypeNumberPad;
                [_scrollView addSubview:_innerTF];
                break;
            }
            case 8:
            {
                
                _priceTF = tf;
                _priceTF.textfield.placeholder = @"请输入成交价格";
                _priceTF.textfield.keyboardType = UIKeyboardTypeNumberPad;
                [_scrollView addSubview:_priceTF];
                break;
            }
            case 9:
            {
                
                _paymentTF = tf;
                _paymentTF.textfield.placeholder = @"请输入首付金额";
                _paymentTF.textfield.keyboardType = UIKeyboardTypeNumberPad;
                [_scrollView addSubview:_paymentTF];
                break;
            }
            case 10:
            {
                
                _loanTF = tf;
                _loanTF.textfield.placeholder = @"请输入贷款金额";
                _loanTF.textfield.keyboardType = UIKeyboardTypeNumberPad;
                [_scrollView addSubview:_loanTF];
                break;
            }
            case 11:
            {
                
                _projectTF = tf;
                _projectTF.textfield.placeholder = @"推荐项目";
                _projectTF.userInteractionEnabled = NO;
                _projectTF.backgroundColor = CLBackColor;
                _projectTF.textfield.text = _dic[@"project_name"];
                [_scrollView addSubview:_projectTF];
                break;
            }
            default:
                break;
        }
    }
    
    NSArray *titleArr = @[@"客户姓名：",@"客户性别：",@"联系号码：",@"证件类型：",@"证件号：",@"地址：",@"推荐人：",@"合同编号：",@"房号：",@"物业类型：",@"建筑面积：",@"套内面积：",@"成交价格：",@"付款方式：",@"首付金额：",@"贷款金额：",@"佣金规则：",@"成交时间：",@"推荐项目："];
    
    for (int i = 0; i < 19; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = YJTitleLabColor;
        label.text = titleArr[i];
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        label.adjustsFontSizeToFitWidth = YES;
        switch (i) {
            case 0:
            {
                _nameL = label;
                
                //                NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"*%@",_nameL.text]];
                //                [attr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
                //                _nameL.attributedText = attr;
                [_scrollView addSubview:_nameL];
                break;
            }
                
            case 1:
            {
                _genderL = label;
                
                NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"*%@",_genderL.text]];
                [attr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
                _genderL.attributedText = attr;
                //                [_scrollView addSubview:_genderL];
                break;
            }
                
            case 2:
            {
                _phoneL = label;
                
                //                NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"*%@",_phoneL.text]];
                //                [attr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
                //                _phoneL.attributedText = attr;
                [_scrollView addSubview:_phoneL];
                break;
            }
                
            case 3:
            {
                _certTypeL = label;
                //                [_scrollView addSubview:_certTypeL];
                break;
            }
                
            case 4:
            {
                _certNumL = label;
                //                [_scrollView addSubview:_certNumL];
                break;
            }
                
            case 5:
            {
                _addressL = label;
                //                if ([_configDic[@"birth"] integerValue] == 1) {
                //
                //                    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"*%@",_birthL.text]];
                //                    [attr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
                //                    _birthL.attributedText = attr;
                //                }
                //                [_scrollView addSubview:_addressL];
                break;
            }
                
            case 6:
            {
                _recommendL = label;
                //                if ([_configDic[@"mail"] integerValue] == 1) {
                //
                //                    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"*%@",_mailCodeL.text]];
                //                    [attr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
                //                    _mailCodeL.attributedText = attr;
                //                }
                [_scrollView addSubview:_recommendL];
                break;
            }
                
            case 7:
            {
                _codeL = label;
                [_scrollView addSubview:_codeL];
                break;
            }
            case 8:
            {
                _roomNumL = label;
                //                NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"*%@",_approachL.text]];
                //                [attr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
                //                _approachL.attributedText = attr;
                [_scrollView addSubview:_roomNumL];
                break;
            }
            case 9:
            {
                _propertyL = label;
                [_scrollView addSubview:_propertyL];
                break;
            }
            case 10:
            {
                _areaL = label;
                //                if ([_configDic[@"address"] integerValue] == 1) {
                //
                //                    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"*%@",_addressL.text]];
                //                    [attr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
                //                    _addressL.attributedText = attr;
                //                }
                [_scrollView addSubview:_areaL];
                break;
            }
            case 11:
            {
                _innerL = label;
                [_scrollView addSubview:_innerL];
                break;
            }
            case 12:
            {
                _priceL = label;
                [_scrollView addSubview:_priceL];
                break;
            }
            case 13:
            {
                _payWayL = label;
                [_scrollView addSubview:_payWayL];
                break;
            }
            case 14:
            {
                _paymentL = label;
                [_scrollView addSubview:_paymentL];
                break;
            }
            case 15:
            {
                _loanL = label;
                [_scrollView addSubview:_loanL];
                break;
            }
            case 16:
            {
                _ruleL = label;
                [_scrollView addSubview:_ruleL];
                break;
            }
            case 17:
            {
                _timeL = label;
                [_scrollView addSubview:_timeL];
                break;
            }
            case 18:
            {
                _projectL = label;
                [_scrollView addSubview:_projectL];
                break;
            }
            default:
                break;
        }
    }
    
    for (int i = 0; i < 6; i++) {
        
        DropDownBtn *btn = [[DropDownBtn alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
        btn.tag = i;
        [btn addTarget:self action:@selector(ActionDropBtn:) forControlEvents:UIControlEventTouchUpInside];
        switch (i) {
            case 0:
            {
                
                _certTypeBtn = btn;
                _certTypeBtn.placeL.text = @"请选择证件类型";
                //                [_scrollView addSubview:_certTypeBtn];
                break;
            }
            case 1:
            {
                
                _addressBtn = btn;
                _addressBtn.placeL.text = @"请选择出生年月";
                //                [_scrollView addSubview:_addressBtn];
                break;
            }
            case 2:
            {
                
                _propertyBtn = btn;
                _propertyBtn.placeL.text = @"请选择物业类型";
                [_scrollView addSubview:_propertyBtn];
                break;
            }
            case 3:
            {
                
                _payWayBtn = btn;
                _payWayBtn.placeL.text = @"请选择认知途径";
                [_scrollView addSubview:_payWayBtn];
                break;
            }
            case 4:
            {
                
                _ruleBtn = btn;
                _ruleBtn.placeL.text = @"请选择佣金规则";
                //                _ruleBtn.dropimg.hidden = YES;
                //                _ruleBtn.backgroundColor = CLLineColor;
                [_scrollView addSubview:_ruleBtn];
                break;
            }
            case 5:{
                
                _timeBtn = btn;
                _timeBtn.placeL.text = @"请选择成交时间";
                [_scrollView addSubview:_timeBtn];
                break;
            }
            default:
                break;
        }
    }
    
    
    _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _nextBtn.frame = CGRectMake(0, SCREEN_Height - 43 *SIZE - TAB_BAR_MORE, SCREEN_Width, 43 *SIZE + TAB_BAR_MORE);
    _nextBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_nextBtn addTarget:self action:@selector(ActionNextBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_nextBtn setTitle:@"转成交" forState:UIControlStateNormal];
    [_nextBtn setBackgroundColor:YJBlueBtnColor];
    [self.view addSubview:_nextBtn];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(NAVIGATION_BAR_HEIGHT);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(SCREEN_Height - NAVIGATION_BAR_HEIGHT - 43 *SIZE - TAB_BAR_MORE);
    }];
    
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_scrollView).offset(50 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_nameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_scrollView).offset(46 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    //    [_genderL mas_makeConstraints:^(MASConstraintMaker *make) {
    //
    //        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
    //        make.top.equalTo(self->_nameTF.mas_bottom).offset(22 *SIZE);
    //        make.width.mas_equalTo(70 *SIZE);
    //    }];
    //
    //    [_maleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    //
    //        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
    //        make.top.equalTo(self->_nameTF.mas_bottom).offset(22 *SIZE);
    //        make.width.mas_equalTo(60 *SIZE);
    //        make.height.mas_equalTo(25 *SIZE);
    //    }];
    //
    //    [_femaleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    //
    //        make.left.equalTo(self->_scrollView).offset(150 *SIZE);
    //        make.top.equalTo(self->_nameTF.mas_bottom).offset(22 *SIZE);
    //        make.width.mas_equalTo(60 *SIZE);
    //        make.height.mas_equalTo(25 *SIZE);
    //    }];
    
    [_phoneL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_nameTF.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_nameTF.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    //    [_certTypeL mas_makeConstraints:^(MASConstraintMaker *make) {
    //
    //        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
    //        make.top.equalTo(self->_phoneTF.mas_bottom).offset(31 *SIZE);
    //        make.width.mas_equalTo(70 *SIZE);
    //    }];
    //
    //    [_certTypeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    //
    //        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
    //        make.top.equalTo(self->_phoneTF.mas_bottom).offset(21 *SIZE);
    //        make.width.mas_equalTo(258 *SIZE);
    //        make.height.mas_equalTo(33 *SIZE);
    //    }];
    //
    //    [_certNumL mas_makeConstraints:^(MASConstraintMaker *make) {
    //
    //        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
    //        make.top.equalTo(self->_certTypeBtn.mas_bottom).offset(31 *SIZE);
    //        make.width.mas_equalTo(70 *SIZE);
    //    }];
    //
    //    [_certNumTF mas_makeConstraints:^(MASConstraintMaker *make) {
    //
    //        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
    //        make.top.equalTo(self->_certTypeBtn.mas_bottom).offset(21 *SIZE);
    //        make.width.mas_equalTo(258 *SIZE);
    //        make.height.mas_equalTo(33 *SIZE);
    //    }];
    //
    //    [_addressL mas_makeConstraints:^(MASConstraintMaker *make) {
    //
    //        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
    //        make.top.equalTo(self->_certNumTF.mas_bottom).offset(31 *SIZE);
    //        make.width.mas_equalTo(70 *SIZE);
    //    }];
    //
    //    [_addressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    //
    //        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
    //        make.top.equalTo(self->_certNumTF.mas_bottom).offset(21 *SIZE);
    //        make.width.mas_equalTo(258 *SIZE);
    //        make.height.mas_equalTo(33 *SIZE);
    //    }];
    //
    [_recommendL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_phoneTF.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_recommendTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_phoneTF.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_projectL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_recommendTF.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_projectTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_recommendTF.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_dealHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(0 *SIZE);
        make.top.equalTo(self->_projectTF.mas_bottom).offset(15 *SIZE);
        make.width.mas_equalTo(360 *SIZE);
        make.height.mas_equalTo(40 *SIZE);
    }];
    
    [_codeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_dealHeader.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_codeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_dealHeader.mas_bottom).offset(6 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_roomNumL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_codeTF.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_roomNumTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_codeTF.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_propertyL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_roomNumTF.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_propertyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_roomNumTF.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_areaL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_propertyBtn.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_areaTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_propertyBtn.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_innerL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_areaTF.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_innerTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_areaTF.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_innerTF.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_priceTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_innerTF.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_payWayL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_priceTF.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_payWayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_priceTF.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_paymentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_payWayBtn.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_paymentTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_payWayBtn.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_loanL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_paymentTF.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_loanTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_paymentTF.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_ruleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_loanTF.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_ruleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_loanTF.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_ruleBtn.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_timeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_ruleBtn.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
        make.bottom.equalTo(self->_scrollView).offset(-20 *SIZE);
    }];
}

@end
