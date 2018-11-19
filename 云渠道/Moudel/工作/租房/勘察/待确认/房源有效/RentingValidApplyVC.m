//
//  RentingValidApplyVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/7/26.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RentingValidApplyVC.h"

#import "DropDownBtn.h"

@interface RentingValidApplyVC ()
{
    
    NSArray *_titleArr;
    NSArray *_contentArr;
}
@property (nonatomic, strong) DropDownBtn *timeBtn;

@property (nonatomic, strong) UIButton *confirmBtn;
@end

@implementation RentingValidApplyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
    _titleArr = @[@"联系人",@"联系电话",@"勘察地址"];
}

- (void)ActionConfirmBtn:(UIButton *)btn{
    
    
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"勘察计划";
    
    UIView *whiteView1 = [[UIView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, 131 *SIZE)];
    whiteView1.backgroundColor = CH_COLOR_white;
    [self.view addSubview:whiteView1];
    
    for (int i = 0; i < 3; i++) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 16 *SIZE + i * 43 *SIZE, 70 *SIZE, 13 *SIZE)];
        label.textColor = YJContentLabColor;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        label.text = _titleArr[i];
        [whiteView1 addSubview:label];
        
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(80 *SIZE, 16 *SIZE + i * 43 *SIZE, 70 *SIZE, 13 *SIZE)];
        label1.textColor = YJ170Color;
        label1.font = [UIFont systemFontOfSize:13 *SIZE];
        label1.text = @"自动生成";
        [whiteView1 addSubview:label1];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(10 *SIZE, 43 *SIZE * i - SIZE, 340 *SIZE, SIZE)];
        line.backgroundColor = COLOR(202, 201, 201, 0.55);
        if (i != 0) {
            
            [whiteView1 addSubview:line];
        }
    }
    
    UIView *whiteView2 = [[UIView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT + 136  *SIZE, SCREEN_Width, 83 *SIZE)];
    whiteView2.backgroundColor = CH_COLOR_white;
    [self.view addSubview:whiteView2];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(9 *SIZE, 38 *SIZE, 80 *SIZE, 10 *SIZE)];
    label.textColor = YJTitleLabColor;
    label.font = [UIFont systemFontOfSize:11 *SIZE];
    label.text = @"预约勘察时间:";
    [whiteView2 addSubview:label];
    
    _timeBtn = [[DropDownBtn alloc] initWithFrame:CGRectMake(80 *SIZE, 25 *SIZE, 258 *SIZE, 33 *SIZE)];
    [whiteView2 addSubview:_timeBtn];
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirmBtn.frame = CGRectMake(22 *SIZE, 493 *SIZE + NAVIGATION_BAR_HEIGHT, 317 *SIZE, 40 *SIZE);
    _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:14 *sIZE];
    [_confirmBtn addTarget:self action:@selector(ActionConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
    [_confirmBtn setBackgroundColor:YJBlueBtnColor];
    [self.view addSubview:_confirmBtn];
}

@end
