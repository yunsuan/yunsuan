//
//  LoginVC.m
//  云渠道
//
//  Created by xiaoq on 2018/3/13.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "LoginVC.h"
#import "CYLTabBarControllerConfig.h"
#import "RegisterVC.h"
#import "FindPassWordVC.h"
#import <UMSocialQQHandler.h>
#import <UMSocialWechatHandler.h>
#import "JudgeView.h"
#import "BingdingAccountVC.h"
#import "BingdingExitAccountVC.h"

@interface LoginVC ()
@property (nonatomic , strong) UITextField *Account;
@property (nonatomic , strong) UITextField *PassWord;
@property (nonatomic , strong) UIButton *RegisterBtn;
@property (nonatomic , strong) UIButton *QuickLoginBtn;
@property (nonatomic , strong) UIButton *LoginBtn;
@property (nonatomic , strong) UIButton *ProtocolBtn;
@property (nonatomic , strong) UIButton *FindPassWordBtn;
@property (nonatomic , strong) UIImageView *Headerimg;
@property (nonatomic , strong) UIButton  *QQBtn;
@property (nonatomic , strong) UIButton  *WEIBOBTN;
@property (nonatomic, strong) JudgeView *judgeView;

@property (nonatomic, strong) UIButton *settingbtn;
@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self InitUI];
    
}

-(void)InitUI
{
    [self.view addSubview:self.Headerimg];
    [self.view addSubview:self.RegisterBtn];
    [self.view addSubview:self.Account];
    [self.view addSubview:self.PassWord];
    
    [self.view addSubview:self.settingbtn];
    
//    if ([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_WechatSession] && [[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_QQ]) {
//
//        for (int i = 0; i<2; i++) {
//            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(22*SIZE, 249*SIZE+47*SIZE*i, 316*SIZE, 0.5*SIZE)];
//            line.backgroundColor = COLOR(130, 130, 130, 1);
//            [self.view addSubview:line];
//
//            UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(101 *SIZE + i * 133 *SIZE, 526 *SIZE , 27*SIZE, SIZE)];
//            line2.backgroundColor = YJ170Color;
//            [self.view addSubview:line2];
//        }
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(133 *SIZE, 521 *SIZE, 200 *SIZE, 13 *SIZE)];
//        label.textColor = YJ170Color;
//        label.font = [UIFont systemFontOfSize:13 *SIZE];
//        label.text = @"第三方账号登录";
//        [self.view addSubview:label];
//
//        [self.view addSubview:self.WEIBOBTN];
//        [self.view addSubview:self.QQBtn];
//    }else if ([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_WechatSession]){
//
//        for (int i = 0; i<2; i++) {
//            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(22*SIZE, 249*SIZE+47*SIZE*i, 316*SIZE, 0.5*SIZE)];
//            line.backgroundColor = COLOR(130, 130, 130, 1);
//            [self.view addSubview:line];
//
//            UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(101 *SIZE + i * 133 *SIZE, 526 *SIZE , 27*SIZE, SIZE)];
//            line2.backgroundColor = YJ170Color;
//            [self.view addSubview:line2];
//        }
//
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(133 *SIZE, 521 *SIZE, 200 *SIZE, 13 *SIZE)];
//        label.textColor = YJ170Color;
//        label.font = [UIFont systemFontOfSize:13 *SIZE];
//        label.text = @"第三方账号登录";
//        [self.view addSubview:label];
//
//        self.WEIBOBTN.frame = CGRectMake(106.7*SIZE, 544*SIZE+STATUS_BAR_HEIGHT, 40*SIZE, 40*SIZE);
//        [self.view addSubview:self.WEIBOBTN];
//    }else{
//
//        for (int i = 0; i<2; i++) {
//            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(22*SIZE, 249*SIZE+47*SIZE*i, 316*SIZE, 0.5*SIZE)];
//            line.backgroundColor = COLOR(130, 130, 130, 1);
//            [self.view addSubview:line];
//
//            UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(101 *SIZE + i * 133 *SIZE, 526 *SIZE , 27*SIZE, SIZE)];
//            line2.backgroundColor = YJ170Color;
//            [self.view addSubview:line2];
//        }
//
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(133 *SIZE, 521 *SIZE, 200 *SIZE, 13 *SIZE)];
//        label.textColor = YJ170Color;
//        label.font = [UIFont systemFontOfSize:13 *SIZE];
//        label.text = @"第三方账号登录";
//        [self.view addSubview:label];
//
//        self.QQBtn.frame = CGRectMake(160 *SIZE, 544*SIZE+STATUS_BAR_HEIGHT, 40*SIZE, 40*SIZE);
//        [self.view addSubview:self.QQBtn];
//    }
    
    [self.view addSubview:self.LoginBtn];
    [self.view addSubview:self.FindPassWordBtn];
    
}

-(void)Register
{
    //注册
    RegisterVC *next_vc = [[RegisterVC alloc]init];
    [self.navigationController pushViewController:next_vc animated:YES];
}


-(void)FindPassWord
{
    FindPassWordVC *next_vc = [[FindPassWordVC alloc]init];
    [self.navigationController pushViewController:next_vc animated:YES];
}

- (void)ActionQQBtn:(UIButton *)btn{
    
    [self getUserInfoForPlatform:UMSocialPlatformType_QQ];
}

- (void)ActionWechatBtn:(UIButton *)btn{
    
    [self getUserInfoForPlatform:UMSocialPlatformType_WechatSession];
}

- (void)getUserInfoForPlatform:(UMSocialPlatformType)platformType
{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:platformType currentViewController:nil completion:^(id result, NSError *error) {
        UMSocialUserInfoResponse *resp = result;
        // 第三方登录数据(为空表示平台未提供)
        // 授权数据
        NSLog(@" uid: %@", resp.uid);
        NSLog(@" openid: %@", resp.openid);
        NSLog(@" accessToken: %@", resp.accessToken);
        NSLog(@" refreshToken: %@", resp.refreshToken);
        NSLog(@" expiration: %@", resp.expiration);
        // 用户数据
        NSLog(@" name: %@", resp.name);
        NSLog(@" iconurl: %@", resp.iconurl);
        NSLog(@" gender: %@", resp.unionGender);
        // 第三方平台SDK原始数据
        NSLog(@" originalResponse: %@", resp.originalResponse);
        
        if (error) {
            
        }else{
            
            if (platformType == UMSocialPlatformType_QQ) {
                
                [BaseRequest POST:Login_URL parameters:@{@"account":resp.openid,@"login_type":@"1"} success:^(id resposeObject) {
                    
                    NSLog(@"%@",resposeObject);
                    if ([resposeObject[@"code"] integerValue] == 400) {
                        
                        WS(weakSelf);
                        self.judgeView.judgeNewBlock = ^{
                            
                            NSDictionary *dic = @{@"open_id":resp.openid,@"headimgurl":resp.iconurl,@"regist_type":@"1"};
                            BingdingAccountVC *nextVC = [[BingdingAccountVC alloc] initWithData:dic];
                            [weakSelf.navigationController pushViewController:nextVC animated:YES];
                        };
                        self.judgeView.judgeExitBlock = ^{
                            
                            NSDictionary *dic = @{@"open_id":resp.openid,@"type":@"1"};
                            BingdingExitAccountVC *nextVC = [[BingdingExitAccountVC alloc] initWithData:dic];
                            [weakSelf.navigationController pushViewController:nextVC animated:YES];
                        };
                        [self.view addSubview:self.judgeView];
                    }else if ([resposeObject[@"code"] integerValue] == 200){
                        
                        [[NSUserDefaults standardUserDefaults]setValue:LOGINSUCCESS forKey:LOGINENTIFIER];
                        [UserModel defaultModel].Token = resposeObject[@"data"][@"token"];
                        [UserModel defaultModel].agent_id =resposeObject[@"data"][@"agent_id"];
                        [UserModel defaultModel].agent_identity =resposeObject[@"data"][@"agent_identity"];
                        [UserModelArchiver archive];
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"goHome" object:nil];
                    }else{
                        
                        
                    }
                } failure:^(NSError *error) {
                    
                    NSLog(@"%@",error);
                }];
            }else{
                
                [BaseRequest POST:Login_URL parameters:@{@"account":resp.openid,@"login_type":@"2"} success:^(id resposeObject) {
                    
                    NSLog(@"%@",resposeObject);
                    if ([resposeObject[@"code"] integerValue] == 400) {
                        
                        WS(weakSelf);
                        self.judgeView.judgeNewBlock = ^{
                            
                            NSDictionary *dic = @{@"open_id":resp.openid,@"headimgurl":resp.iconurl,@"regist_type":@"2"};
                            BingdingAccountVC *nextVC = [[BingdingAccountVC alloc] initWithData:dic];
                            [weakSelf.navigationController pushViewController:nextVC animated:YES];
                        };
                        self.judgeView.judgeExitBlock = ^{
                            
                            NSDictionary *dic = @{@"open_id":resp.openid,@"type":@"2"};
                            BingdingExitAccountVC *nextVC = [[BingdingExitAccountVC alloc] initWithData:dic];
                            [weakSelf.navigationController pushViewController:nextVC animated:YES];
                        };
                        [self.view addSubview:self.judgeView];
                    }else if ([resposeObject[@"code"] integerValue] == 200){
                        
                        [[NSUserDefaults standardUserDefaults]setValue:LOGINSUCCESS forKey:LOGINENTIFIER];
                        [UserModel defaultModel].Token = resposeObject[@"data"][@"token"];
                        [UserModel defaultModel].agent_id =resposeObject[@"data"][@"agent_id"];
                        [UserModel defaultModel].agent_identity =resposeObject[@"data"][@"agent_identity"];
                        [UserModelArchiver archive];
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"goHome" object:nil];
                    }else{
                        
                        
                    }
                } failure:^(NSError *error) {
                    
                    NSLog(@"%@",error);
                }];
            }
            
        }
    }];
}

- (void)getAuthWithUserInfoFromQQ
{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_QQ currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
        
        } else {
            UMSocialUserInfoResponse *resp = result;
            // 授权信息
            NSLog(@"QQ uid: %@", resp.uid);
            NSLog(@"QQ openid: %@", resp.openid);
            NSLog(@"QQ unionid: %@", resp.unionId);
            NSLog(@"QQ accessToken: %@", resp.accessToken);
            NSLog(@"QQ expiration: %@", resp.expiration);
            // 用户信息
            NSLog(@"QQ name: %@", resp.name);
            NSLog(@"QQ iconurl: %@", resp.iconurl);
            NSLog(@"QQ gender: %@", resp.unionGender);
            // 第三方平台SDK源数据
            NSLog(@"QQ originalResponse: %@", resp.originalResponse);
        }
    }];
}


- (void)getAuthWithUserInfoFromWechat
{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
        } else {
            UMSocialUserInfoResponse *resp = result;
            // 授权信息
            NSLog(@"Wechat uid: %@", resp.uid);
            NSLog(@"Wechat openid: %@", resp.openid);
            NSLog(@"Wechat unionid: %@", resp.unionId);
            NSLog(@"Wechat accessToken: %@", resp.accessToken);
            NSLog(@"Wechat refreshToken: %@", resp.refreshToken);
            NSLog(@"Wechat expiration: %@", resp.expiration);
            // 用户信息
            NSLog(@"Wechat name: %@", resp.name);
            NSLog(@"Wechat iconurl: %@", resp.iconurl);
            NSLog(@"Wechat gender: %@", resp.unionGender);
            // 第三方平台SDK源数据
            NSLog(@"Wechat originalResponse: %@", resp.originalResponse);
        }
    }];
}

-(UIImageView *)Headerimg
{
    if (!_Headerimg) {
        _Headerimg = [[UIImageView alloc]initWithFrame:CGRectMake(130*SIZE, 82*SIZE, 100*SIZE, 68*SIZE)];
        _Headerimg.image = [UIImage imageNamed:@"logo_2"];
    }
    return _Headerimg;
}

-(void)Login{
    
    if (_PassWord.text.length<6) {
        [self showContent:@"密码长度至少为6位"];
        return;
    }
    NSDictionary *parameter = @{
                                @"account":_Account.text,
                                @"password":_PassWord.text
                                };
    
    [BaseRequest POST:Login_URL parameters:parameter success:^(id resposeObject) {
        
        if ([resposeObject[@"code"] integerValue]==200) {
        
            [[NSUserDefaults standardUserDefaults]setValue:LOGINSUCCESS forKey:LOGINENTIFIER];
            [UserModel defaultModel].Token = resposeObject[@"data"][@"token"];
            [UserModel defaultModel].Account = _Account.text;
            [UserModel defaultModel].Password = _PassWord.text;
            [UserModel defaultModel].agent_id =resposeObject[@"data"][@"agent_id"];
            [UserModel defaultModel].agent_identity =resposeObject[@"data"][@"agent_identity"];
            [UserModelArchiver archive];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"goHome" object:nil];

        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
        
    } failure:^(NSError *error) {
        
        [self showContent:@"网络错误"];
    }];
    

}

-(void)QuickLogin
{

    
}

-(void)Protocol
{
    
}

-(UIButton *)RegisterBtn
{
    if (!_RegisterBtn) {
        _RegisterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _RegisterBtn.frame =  CGRectMake(20*SIZE, 417*SIZE, 60*SIZE, 15*SIZE);
        [_RegisterBtn setTitle:@"马上注册" forState:UIControlStateNormal];
        [_RegisterBtn setTitleColor:YJContentLabColor forState:UIControlStateNormal];
        _RegisterBtn.titleLabel.font = [UIFont systemFontOfSize:14*SIZE];
        [_RegisterBtn addTarget:self action:@selector(Register) forControlEvents:UIControlEventTouchUpInside];
    }
    return _RegisterBtn;
}

-(UITextField *)Account{
    if (!_Account) {
        
        _Account = [[UITextField alloc]initWithFrame:CGRectMake(22*SIZE, 219*SIZE, 314*SIZE, 15*SIZE)];
        _Account.placeholder = @"请输入手机号";
        _Account.keyboardType = UIKeyboardTypeNumberPad;
        _Account.font = [UIFont systemFontOfSize:14*SIZE];
        [_Account addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        _Account.clearButtonMode = UITextFieldViewModeWhileEditing;
        _Account.text = [UserModelArchiver unarchive].Account;
    }
    return _Account;
}

-(UITextField *)PassWord{
    if (!_PassWord) {
        
        _PassWord = [[UITextField alloc]initWithFrame:CGRectMake(22*SIZE, 266*SIZE, 314*SIZE, 15*SIZE)];
        _PassWord.placeholder = @"请输入密码";
        _PassWord.font = [UIFont systemFontOfSize:14*SIZE];
        [_PassWord addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        _PassWord.secureTextEntry = YES;
        _PassWord.text = [UserModelArchiver unarchive].Password;
    }
    return _PassWord;
}

-(UIButton *)LoginBtn
{
    if (!_LoginBtn) {
        _LoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _LoginBtn.frame = CGRectMake(22*SIZE, 367*SIZE, 316*SIZE, 41*SIZE);
        _LoginBtn.layer.masksToBounds = YES;
        _LoginBtn.layer.cornerRadius = 2*SIZE;
        _LoginBtn.backgroundColor = YJLoginBtnColor;
        [_LoginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_LoginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _LoginBtn.titleLabel.font = [UIFont systemFontOfSize:16*SIZE];
        [_LoginBtn addTarget:self action:@selector(Login) forControlEvents:UIControlEventTouchUpInside];
    }
    return _LoginBtn;
}



-(UIButton *)QQBtn{
    if (!_QQBtn) {
        _QQBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _QQBtn.frame = CGRectMake(106.7*SIZE, 544*SIZE+STATUS_BAR_HEIGHT, 40*SIZE, 40*SIZE);
//        _QQBtn.backgroundColor = YJBlueBtnColor;
        [_QQBtn addTarget:self action:@selector(ActionQQBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_QQBtn setBackgroundImage:[UIImage imageNamed:@"qq_2"] forState:UIControlStateNormal];
    }
    return _QQBtn;
}


- (UIButton *)WEIBOBTN
{
    if (!_WEIBOBTN) {
        _WEIBOBTN = [UIButton buttonWithType:UIButtonTypeCustom];
        _WEIBOBTN.frame = CGRectMake(213.3*SIZE, 544*SIZE + STATUS_BAR_HEIGHT , 40*SIZE, 40*SIZE);
//        _WEIBOBTN.backgroundColor = YJBlueBtnColor;
        [_WEIBOBTN addTarget:self action:@selector(ActionWechatBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_WEIBOBTN setBackgroundImage:[UIImage imageNamed:@"wechat_2"] forState:UIControlStateNormal];
    }
    return _WEIBOBTN;
    
}

//-(UIButton *)QuickLoginBtn
//{
//    if (!_QuickLoginBtn) {
//        _QuickLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        _QuickLoginBtn.frame =  CGRectMake(20*SIZE, 417*SIZE, 60*SIZE, 15*SIZE);
//        [_QuickLoginBtn setTitle:@"马上注册" forState:UIControlStateNormal];
//        [_QuickLoginBtn setTitleColor:YJContentLabColor forState:UIControlStateNormal];
//        _QuickLoginBtn.titleLabel.font = [UIFont systemFontOfSize:14*SIZE];
//        [_QuickLoginBtn addTarget:self action:@selector(QuickLogin) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _QuickLoginBtn;
//}

-(UIButton *)ProtocolBtn
{
    if (!_ProtocolBtn) {
        _ProtocolBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _ProtocolBtn.frame =  CGRectMake(43*SIZE, 325*SIZE, 100*SIZE, 13*SIZE);
        [_ProtocolBtn setTitle:@"我已阅读并同意" forState: UIControlStateNormal];
        [_ProtocolBtn setTitleColor:YJContentLabColor forState:UIControlStateNormal];
        _ProtocolBtn.titleLabel.font = [UIFont systemFontOfSize:12*SIZE];
        [_ProtocolBtn addTarget:self action:@selector(Protocol) forControlEvents:UIControlEventTouchUpInside];
    }
    return _ProtocolBtn;
}

-(UIButton *)FindPassWordBtn
{
    if (!_FindPassWordBtn) {
        _FindPassWordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _FindPassWordBtn.frame =  CGRectMake(283*SIZE, 417*SIZE, 60*SIZE, 15*SIZE);
        [_FindPassWordBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
        [_FindPassWordBtn setTitleColor:YJContentLabColor forState:UIControlStateNormal];
        _FindPassWordBtn.titleLabel.font = [UIFont systemFontOfSize:14*SIZE];
        [_FindPassWordBtn addTarget:self action:@selector(FindPassWord) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _FindPassWordBtn;
}

- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField == _Account) {
        if (textField.text.length > 20) {
            textField.text = [textField.text substringToIndex:20];
        }
    }
    if (textField == _PassWord) {
        if (textField.text.length > 20) {
            textField.text = [textField.text substringToIndex:20];
        }
    }
 
}


- (JudgeView *)judgeView{
    
    if (!_judgeView) {
        
        _judgeView = [[JudgeView alloc] initWithFrame:self.view.bounds];
    }
    return _judgeView;
}

-(UIButton *)settingbtn
{
    if (!_settingbtn) {
        _settingbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _settingbtn.center = CGPointMake(SCREEN_Width - 25 * SIZE, STATUS_BAR_HEIGHT+20);
        _settingbtn.bounds = CGRectMake(0, 0, 80 * SIZE, 33 * SIZE);
        [_settingbtn addTarget:self action:@selector(action_sever) forControlEvents:UIControlEventTouchUpInside];
        [_settingbtn setImage:[UIImage imageNamed:@"housing_selected"] forState:UIControlStateNormal];
    }
    return _settingbtn;
}

-(void)action_sever
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"服务器选择" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *cs = [UIAlertAction actionWithTitle:@"测试服" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"ServerControl.plist"];
        NSArray *dataarr  = @[@"http://120.27.21.136:2798/"];
        [dataarr writeToFile:filePath atomically:YES];
        
        
    }];
    
    
    
    UIAlertAction *ys = [UIAlertAction actionWithTitle:@"演示服" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"ServerControl.plist"];
        NSArray *dataarr  = @[@"http://47.106.39.169:2797/"];
        [dataarr writeToFile:filePath atomically:YES];
    }];
    
    UIAlertAction *zs = [UIAlertAction actionWithTitle:@"正式服" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"ServerControl.plist"];
        NSArray *dataarr  = @[@"http://120.78.69.178:2902/"];
        [dataarr writeToFile:filePath atomically:YES];
    }];
    
    [alert addAction:cs];
    [alert addAction:ys];
    [alert addAction:zs];
    [alert addAction:cancel];
    [self.navigationController presentViewController:alert animated:YES completion:^{
        
    }];
}

@end
