//
//  BingdingExitAccountVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/6/1.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BingdingExitAccountVC.h"

@interface BingdingExitAccountVC ()<UITextFieldDelegate>
{
    
    NSMutableDictionary *_dataDic;
}
@property (nonatomic , strong) UITextField *Account;
@property (nonatomic , strong) UITextField *Code;
@property (nonatomic , strong) UITextField *PassWord;
@property (nonatomic , strong) UIButton *RegisterBtn;

@end

@implementation BingdingExitAccountVC

- (instancetype)initWithData:(NSDictionary *)dataDic;
{
    self = [super init];
    if (self) {
        
        _dataDic = [NSMutableDictionary dictionaryWithDictionary:dataDic];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBackgroundView.hidden = NO;
    self.navBackgroundView.backgroundColor = YJBackColor;
    [self InitUI];
    
}

-(void)InitUI
{
    [self.view addSubview:self.RegisterBtn];
    [self.view addSubview:self.Account];
    [self.view addSubview:self.PassWord];
    UILabel  *title = [[UILabel alloc]initWithFrame:CGRectMake(22*SIZE, STATUS_BAR_HEIGHT+53*SIZE, 200*SIZE, 22*SIZE)];
    title.text = @"绑定已有账号";
    title.font = [UIFont systemFontOfSize:21*SIZE];
    title.textColor = YJTitleLabColor;
    [self.view addSubview:title];
    
    for (int i = 0; i < 2; i++) {
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(22*SIZE, STATUS_BAR_HEIGHT+154*SIZE+47*SIZE*i, 316*SIZE, 0.5*SIZE)];
        line.backgroundColor = COLOR(180, 180, 180, 1);
        [self.view addSubview:line];
    }
}

-(void)Register
{
    
    if (![self checkTel:_Account.text]) {
        [self showContent:@"请输入正确的电话号码！"];
    }
    if (_PassWord.text.length<6) {
        [self showContent:@"密码长度至少为6位"];
        return;
    }
    if (![self checkPassword:_PassWord.text]) {
        [self showContent:@"密码格式错误,必须包含数字和字母！"];
        return;
    }
    

    [_dataDic setObject:_Account.text forKey:@"tel"];
    [_dataDic setObject:_PassWord.text forKey:@"password"];
    [BaseRequest POST:SwitchBingding_URL parameters:_dataDic success:^(id resposeObject) {
        NSLog(@"%@",resposeObject);
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [[NSUserDefaults standardUserDefaults]setValue:LOGINSUCCESS forKey:LOGINENTIFIER];
            [UserModel defaultModel].Token = resposeObject[@"data"][@"token"];
            [UserModel defaultModel].Account = _Account.text;
            [UserModel defaultModel].Password = _PassWord.text;
            [UserModel defaultModel].agent_id =resposeObject[@"data"][@"agent_id"];
            [UserModel defaultModel].agent_identity =resposeObject[@"data"][@"agent_identity"];
            [UserModelArchiver archive];
            
            [self alertControllerWithNsstring:@"系统提示" And:@"恭喜你注册成功，请妥善保管好账号" WithDefaultBlack:^{
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"goHome" object:nil];
            }];
        }
        else{
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        [self showContent:@"网络错误"];
    }];
    
}

-(UITextField *)Account{
    if (!_Account) {
        _Account = [[UITextField alloc]initWithFrame:CGRectMake(22*SIZE, STATUS_BAR_HEIGHT+124*SIZE, 314*SIZE, 15*SIZE)];
        _Account.placeholder = @"请输入手机号码";
        _Account.keyboardType = UIKeyboardTypeNumberPad;
        _Account.font = [UIFont systemFontOfSize:14*SIZE];
        [_Account addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        
    }
    return _Account;
}

-(UITextField *)PassWord
{
    if (!_PassWord) {
        _PassWord = [[UITextField alloc]initWithFrame:CGRectMake(22*SIZE, STATUS_BAR_HEIGHT+171*SIZE, 314*SIZE, 15*SIZE)];
        _PassWord.placeholder = @"请输入密码";
        _PassWord.font = [UIFont systemFontOfSize:14*SIZE];
        [_PassWord addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        _PassWord.secureTextEntry = YES;
        
    }
    return _PassWord;
}


-(UIButton *)RegisterBtn
{
    if (!_RegisterBtn) {
        _RegisterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _RegisterBtn.frame = CGRectMake(22*SIZE, 340*SIZE+STATUS_BAR_HEIGHT, 316*SIZE, 41*SIZE);
        _RegisterBtn.layer.masksToBounds = YES;
        _RegisterBtn.layer.cornerRadius = 2*SIZE;
        _RegisterBtn.backgroundColor = YJLoginBtnColor;
        [_RegisterBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_RegisterBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _RegisterBtn.titleLabel.font = [UIFont systemFontOfSize:16*SIZE];
        [_RegisterBtn addTarget:self action:@selector(Register) forControlEvents:UIControlEventTouchUpInside];
    }
    return _RegisterBtn;
}


- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField == _Account) {
        if (textField.text.length > 11) {
            textField.text = [textField.text substringToIndex:11];
        }
    }
    
    if (textField == _PassWord) {
        if (textField.text.length > 20) {
            textField.text = [textField.text substringToIndex:20];
        }
    }
}

@end
