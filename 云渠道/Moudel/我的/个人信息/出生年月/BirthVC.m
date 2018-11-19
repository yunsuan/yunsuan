//
//  BirthVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/2.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BirthVC.h"
#import "DateChooseView.h"

@interface BirthVC ()
@property (nonatomic, strong) UILabel *birthL;

@property (nonatomic, strong) UIButton *birthBtn;

@property (nonatomic, strong) UIView *whiteView;

@property (nonatomic, strong) DateChooseView *dateView;

@property (nonatomic, strong) NSDateFormatter *formatter;

@end

@implementation BirthVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self initUI];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.dateView = nil;
}

- (void)ActionBirthBtn:(UIButton *)btn{
    
    [[[UIApplication sharedApplication] keyWindow] addSubview:self.dateView];
    
}

- (void)ActionRightBtn:(UIButton *)btn{
    
    if (_birthL.text.length && ![self isEmpty:_birthL.text]) {
        
        NSDictionary *dic = @{@"birth":_birthL.text};
        [BaseRequest POST:UpdatePersonal_URL parameters:dic success:^(id resposeObject) {
            
//            NSLog(@"%@",resposeObject);
          
            if ([resposeObject[@"code"] integerValue] == 200) {
                
                [UserInfoModel defaultModel].birth = _birthL.text;
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
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"出生年月";
    
    self.rightBtn.hidden = NO;
    [self.rightBtn setTitle:@"保存" forState:UIControlStateNormal];
    self.rightBtn.titleLabel.font = [UIFont systemFontOfSize:15 *SIZE];
    [self.rightBtn setTitleColor:YJTitleLabColor forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(ActionRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    _formatter = [[NSDateFormatter alloc] init];
    [_formatter setDateFormat:@"yyyy-MM-dd"];
    
    [self.view addSubview:self.whiteView];
    
    _birthL = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 20 *SIZE, 300 *SIZE, 12 *SIZE)];
    _birthL.textColor = YJTitleLabColor;
    _birthL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.whiteView addSubview:_birthL];
    
    _birthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _birthBtn.frame = CGRectMake(0, 0, SCREEN_Width, 50 *SIZE);
    [_birthBtn addTarget:self action:@selector(ActionBirthBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.whiteView addSubview:_birthBtn];
    
}

- (UIView *)whiteView{
    
    if (!_whiteView) {
        
        _whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT + 12 *SIZE, SCREEN_Width, 50 *SIZE)];
        _whiteView.backgroundColor = CH_COLOR_white;
    }
    return _whiteView;
}

- (DateChooseView *)dateView{
    
    if (!_dateView) {
        
        _dateView = [[DateChooseView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
        __weak __typeof(&*self)weakSelf = self;
        _dateView.dateblock = ^(NSDate *date) {

            weakSelf.birthL.text = [weakSelf.formatter stringFromDate:date];
        };
    }
    return _dateView;
}

@end
