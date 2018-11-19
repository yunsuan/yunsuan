//
//  AddBankCardVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/3/22.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "AddBankCardVC.h"
#import "DropDownBtn.h"
#import "SinglePickView.h"

@interface AddBankCardVC ()<UITextFieldDelegate>
{
    NSInteger surplusTime;//重新发送短信的倒计时时间
    NSTimer *time;
    NSString *_cardType;
}

@property (nonatomic, strong) UITextField *peopleTF;

@property (nonatomic, strong) UITextField *cardNumTF;

@property (nonatomic, strong) DropDownBtn *cardTypeTF;

@property (nonatomic, strong) UITextField *phoneTF;

@property (nonatomic, strong) UITextField *codeTF;

@property (nonatomic, strong) UIButton *GetCodeBtn;

@property (nonatomic, strong) UIButton *addBtn;

@property (nonatomic, strong) UILabel *timeLabel;

@end

@implementation AddBankCardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField == self.cardNumTF) {
        
        if (string.length == 0) return YES;
        
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 20) {
            return NO;
        }
    }else if (textField == self.codeTF){
        
        if (string.length == 0) return YES;
        
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 4) {
            return NO;
        }
    }else if (textField == self.phoneTF){
        
        if (string.length == 0) return YES;
        
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 11) {
            return NO;
        }
    }
    return YES;
}

- (void)ActionAddBtn:(UIButton *)btn{
    
    if ([self isEmpty:_peopleTF.text]) {
        
        [self showContent:@"请输入持卡人姓名"];
        return;
    }
    if ([self isEmpty:_cardNumTF.text]) {
        
        [self showContent:@"请输入银行卡账号"];
        return;
    }
    if (!_cardType.length) {
        
        [self showContent:@"请选择卡类型"];
        return;
    }
    if (![self checkTel:_phoneTF.text]) {
        
        [self showContent:@"请输入正确的电话号码"];
        return;
    }
    if ([self isEmpty:_codeTF.text]) {
        
        [self showContent:@"请输入验证码"];
        return;
    }
    NSDictionary *dic = @{@"card_owner":_peopleTF.text,
                          @"bank_card":_cardNumTF.text,
                          @"bank":_cardType,
                          @"tel":_phoneTF.text,
                          @"captcha":_codeTF.text
                          };
    [BaseRequest POST:BindingBankCard_URL parameters:dic success:^(id resposeObject) {
        
//        NSLog(@"%@",resposeObject);
        [self showContent:resposeObject[@"msg"]];
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            
        }
    } failure:^(NSError *error) {
       
//        NSLog(@"%@",error);
        [self showContent:@"网络错误"];
    }];
}

-(void)ActionGetBtn:(UIButton *)btn{
    //获取验证码
    
    if (![self checkTel:_phoneTF.text]) {
        
        [self showContent:@"请输入正确的电话号码"];
        return;
    }
    _GetCodeBtn.userInteractionEnabled = NO;
    if([self checkTel:_phoneTF.text]) {
        

        NSDictionary *dic = @{@"tel":_phoneTF.text};
        [BaseRequest GET:SendCaptcha_URL parameters:dic success:^(id resposeObject) {
            _GetCodeBtn.userInteractionEnabled = YES;
         
            if ([resposeObject[@"code"] integerValue] == 200) {

                surplusTime = 60;

                [_GetCodeBtn setTitle:[NSString stringWithFormat:@"%ldS", (long)surplusTime] forState:UIControlStateNormal];
                //倒计时
                time = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
                _GetCodeBtn.userInteractionEnabled = YES;
            }else{
                
                [self showContent:resposeObject[@"msg"]];
            }
        } failure:^(NSError *error) {
           
            _GetCodeBtn.userInteractionEnabled = YES;
//            NSLog(@"%@",error);
            [self showContent:@"网络错误"];
        }];
        
    }
    else
    {
        [self showContent:@"请输入正确的电话号码"];
    }
}

- (void)updateTime {
    surplusTime--;
//    _timeLabel.text = [NSString stringWithFormat:@"%ldS", (long)surplusTime];
    [_GetCodeBtn setTitle:[NSString stringWithFormat:@"%ldS", (long)surplusTime] forState:UIControlStateNormal];
    if (surplusTime == 0) {
        [time invalidate];
        time = nil;
        [_GetCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
//        _timeLabel.hidden = YES;
//        _GetCodeBtn.hidden = NO;
    }
}

- (void)ActionBankTypeBtn:(UIButton *)btn{
    
    [_peopleTF endEditing:YES];
    [_cardNumTF endEditing:YES];
    [_codeTF endEditing:YES];
    SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:[self getDetailConfigArrByConfigState:BANK_TYPE]];
    
    view.selectedBlock = ^(NSString *MC, NSString *ID) {
        
        _cardTypeTF.content.text = MC;
        _cardType = [NSString stringWithFormat:@"%@",ID];
        
    };
    [self.view addSubview:view];
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"添加银行卡";
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 13 *SIZE + NAVIGATION_BAR_HEIGHT, 200 *SIZE, 13 *SIZE)];
    label.textColor = YJContentLabColor;
    label.font = [UIFont systemFontOfSize:13 *SIZE];
    label.text = @"请绑定持卡人本人的银行卡";
    [self.view addSubview:label];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT + 40 *SIZE, SCREEN_Width, 260 *SIZE)];
    view.backgroundColor = CH_COLOR_white;
    [self.view addSubview:view];
    
    NSArray *titleArr = @[@"持卡人",@"卡号",@"卡类型",@"手机号",@"验证码"];
    
    for (int i = 0; i < 5; i++) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(9 *SIZE, 19 *SIZE + i * 52 *SIZE, 50 *SIZE, 12 *SIZE)];
        label.textColor = YJContentLabColor;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        label.text = titleArr[i];
        [view addSubview:label];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 52 *SIZE * (i + 1) - 2 *SIZE, SCREEN_Width, 2 *SIZE)];
        line.backgroundColor = YJBackColor;
        [view addSubview:line];
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(87 *SIZE, i * 52 *SIZE, 200 *SIZE, 52 *SIZE)];
        textField.font = [UIFont systemFontOfSize:13 *SIZE];
        textField.delegate = self;
        switch (i) {
            case 0:
            {
                _peopleTF = textField;
                [view addSubview:_peopleTF];
                break;
            }
            case 1:
            {
                _cardNumTF = textField;
                _cardNumTF.keyboardType = UIKeyboardTypeNumberPad;
                [view addSubview:_cardNumTF];
                break;
            }
            case 2:
            {
                _cardTypeTF = [[DropDownBtn alloc] initWithFrame:CGRectMake(77 *SIZE, i * 52 *SIZE + 8 *SIZE, 200 *SIZE, 44 *SIZE)];
                _cardTypeTF.dropimg.hidden = YES;
                _cardTypeTF.layer.borderWidth = 0;
                [_cardTypeTF addTarget:self action:@selector(ActionBankTypeBtn:) forControlEvents:UIControlEventTouchUpInside];
                [view addSubview:_cardTypeTF];
                break;
            }
            case 3:
            {
                _phoneTF = textField;
                _phoneTF.keyboardType = UIKeyboardTypePhonePad;
                _phoneTF.text = [UserModel defaultModel].Account;
                _phoneTF.userInteractionEnabled = NO;
                [view addSubview:_phoneTF];
                
                _GetCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                _GetCodeBtn.frame =  CGRectMake(274*SIZE, 14 *SIZE + i * 52 *SIZE, 72*SIZE, 21*SIZE);
                [_GetCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                [_GetCodeBtn setTitleColor:YJLoginBtnColor forState:UIControlStateNormal];
                _GetCodeBtn.titleLabel.font = [UIFont systemFontOfSize:14*SIZE];
                [_GetCodeBtn addTarget:self action:@selector(ActionGetBtn:) forControlEvents:UIControlEventTouchUpInside];
                _GetCodeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
                [view addSubview:_GetCodeBtn];
                break;
            }
            case 4:
            {
                _codeTF = textField;
                _codeTF.keyboardType = UIKeyboardTypeNumberPad;
                [view addSubview:_codeTF];
                break;
            }
            default:
                break;
        }
    }
    
    _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _addBtn.frame = CGRectMake(22 *SIZE, 473*SIZE + NAVIGATION_BAR_HEIGHT, 316 *SIZE, 41 *SIZE);
    _addBtn.layer.masksToBounds = YES;
    _addBtn.layer.cornerRadius = 2 *SIZE;
    _addBtn.backgroundColor = YJLoginBtnColor;
    [_addBtn setTitle:@"确认" forState:UIControlStateNormal];
    [_addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _addBtn.titleLabel.font = [UIFont systemFontOfSize:16*SIZE];
    [_addBtn addTarget:self action:@selector(ActionAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_addBtn];
}

@end
