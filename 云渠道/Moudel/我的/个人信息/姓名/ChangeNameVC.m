//
//  ChangeNameVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/2.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "ChangeNameVC.h"

@interface ChangeNameVC ()
{
    
    NSString *_name;
}
@property (nonatomic, strong) UIView *whiteView;

@property (nonatomic, strong) UITextField *nameTF;
@end

@implementation ChangeNameVC

- (instancetype)initWithName:(NSString *)name
{
    self = [super init];
    if (self) {
        
        _name = name;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)ActionRightBtn:(UIButton *)btn{
    
    //    if (_nameTF.text.length > 5) {
    //
    //        [self alertControllerWithNsstring:@"温馨提示" And:@"姓名不能超过5个字" WithDefaultBlack:^{
    //
    //            return ;
    //        }];
    //    }
    
    if (_nameTF.text.length && ![self isEmpty:_nameTF.text]) {
        
        NSDictionary *dic = @{@"name":_nameTF.text};
        [BaseRequest POST:UpdatePersonal_URL parameters:dic success:^(id resposeObject) {
            
            if ([resposeObject[@"code"] integerValue] == 200) {
                
                [UserInfoModel defaultModel].name = _nameTF.text;
                [UserModelArchiver infoArchive];
                if (self.changeNameVCBlock) {
                    
                    self.changeNameVCBlock();
                }
                [self.navigationController popViewControllerAnimated:YES];
            }
            else{
                
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
    [self.rightBtn addTarget:self action:@selector(ActionRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightBtn setTitleColor:YJContentLabColor forState:UIControlStateNormal];
    
    self.rightBtn.frame = CGRectMake(SCREEN_Width - 65 *SIZE, 7 *SIZE + STATUS_BAR_HEIGHT, 60 *SIZE, 30 *SIZE);
    
    [self.view addSubview:self.whiteView];
    [self.whiteView addSubview:self.nameTF];
}

- (UITextField *)nameTF{
    
    if (!_nameTF) {
        
        _nameTF = [[UITextField alloc] initWithFrame:CGRectMake(10 *SIZE, 0, 340 *SIZE, 50 *SIZE)];
        _nameTF.font = [UIFont systemFontOfSize:13 *SIZE];
        _nameTF.placeholder = @"请输入姓名";
        _nameTF.text = _name;
    }
    return _nameTF;
}

- (UIView *)whiteView{
    
    if (!_whiteView) {
        
        _whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT + 12 *SIZE, SCREEN_Width, 50 *SIZE)];
        _whiteView.backgroundColor = [UIColor whiteColor];
    }
    return _whiteView;
}

@end
