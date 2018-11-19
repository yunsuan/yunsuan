//
//  ChangeNameVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/2.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "ChangeNameVC.h"

@interface ChangeNameVC ()

@property (nonatomic, strong) UIView *whiteView;

@property (nonatomic, strong) UITextField *nameTF;
@end

@implementation ChangeNameVC

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self initUI];
}

- (void)ActionRightBtn:(UIButton *)btn{
    
    if (_nameTF.text.length > 5) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"姓名不能超过5个字" WithDefaultBlack:^{
            
            return ;
        }];
    }
    
    if (_nameTF.text.length && ![self isEmpty:_nameTF.text]) {
        
        NSDictionary *dic = @{@"name":_nameTF.text};
        [BaseRequest POST:UpdatePersonal_URL parameters:dic success:^(id resposeObject) {
            
//            NSLog(@"%@",resposeObject);
         
            if ([resposeObject[@"code"] integerValue] == 200) {
                
                [UserInfoModel defaultModel].name = _nameTF.text;
                [UserModelArchiver infoArchive];
                [self.navigationController popViewControllerAnimated:YES];
            }        else{
                [self showContent:resposeObject[@"msg"]];
            }
        } failure:^(NSError *error) {
            
            [self showContent:@"网络错误"];
//            NSLog(@"%@",error);
        }];
    }
}

- (void)initUI{
    
    self.titleLabel.text = @"姓名";
    self.navBackgroundView.hidden = NO;
    
    self.rightBtn.hidden = NO;
    [self.rightBtn setTitle:@"保存" forState:UIControlStateNormal];
    self.rightBtn.titleLabel.font = [UIFont systemFontOfSize:15 *SIZE];
    [self.rightBtn setTitleColor:YJTitleLabColor forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(ActionRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.whiteView];
    [self.whiteView addSubview:self.nameTF];
}

- (UITextField *)nameTF{
    
    if (!_nameTF) {
        
        _nameTF = [[UITextField alloc] initWithFrame:CGRectMake(10 *SIZE, 0, 340 *SIZE, 50 *SIZE)];
        _nameTF.font = [UIFont systemFontOfSize:13 *SIZE];
        _nameTF.placeholder = @"请输入姓名";
    }
    return _nameTF;
}

- (UIView *)whiteView{
    
    if (!_whiteView) {
        
        _whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT + 12 *SIZE, SCREEN_Width, 50 *SIZE)];
        _whiteView.backgroundColor = CH_COLOR_white;
    }
    return _whiteView;
}

@end
