//
//  RentingSurveyInvalidVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/7/26.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RentingSurveyInvalidVC.h"

#import "DropDownBtn.h"

@interface RentingSurveyInvalidVC (){
    
    NSArray *_titleArr;
    NSArray *_contentArr;
}
@property (nonatomic, strong) DropDownBtn *timeBtn;

@property (nonatomic, strong) UITextView *reasonTV;

@property (nonatomic, strong) UIButton *confirmBtn;

@end

@implementation RentingSurveyInvalidVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
    _titleArr = @[@"房源编号",@"勘察地址"];
}

- (void)ActionConfirmBtn:(UIButton *)btn{
    
    
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"勘察计划";
    
    UIView *whiteView1 = [[UIView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, 87 *SIZE)];
    whiteView1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiteView1];
    
    for (int i = 0; i < 2; i++) {
        
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
    
    UIView *whiteView2 = [[UIView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT + 93 *SIZE, SCREEN_Width, 183 *SIZE)];
    whiteView2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiteView2];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(9 *SIZE, 27 *SIZE, 80 *SIZE, 10 *SIZE)];
    label.textColor = YJTitleLabColor;
    label.font = [UIFont systemFontOfSize:11 *SIZE];
    label.text = @"失效类型:";
    [whiteView2 addSubview:label];
    
    _timeBtn = [[DropDownBtn alloc] initWithFrame:CGRectMake(80 *SIZE, 17 *SIZE, 258 *SIZE, 33 *SIZE)];
    [whiteView2 addSubview:_timeBtn];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(9 *SIZE, 84 *SIZE, 80 *SIZE, 10 *SIZE)];
    label2.textColor = YJTitleLabColor;
    label2.font = [UIFont systemFontOfSize:11 *SIZE];
    label2.text = @"失效描述:";
    [whiteView2 addSubview:label2];
    
    _reasonTV = [[UITextView alloc] initWithFrame:CGRectMake(79 *SIZE, 74 *SIZE, 258 *SIZE, 77 *SIZE)];
    _reasonTV.layer.cornerRadius = 5 *SIZE;
    _reasonTV.clipsToBounds = YES;
    _reasonTV.layer.borderColor = COLOR(219, 219, 219, 1).CGColor;
    _reasonTV.layer.borderWidth = SIZE;
    [whiteView2 addSubview:_reasonTV];
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirmBtn.frame = CGRectMake(22 *SIZE, 493 *SIZE + NAVIGATION_BAR_HEIGHT, 317 *SIZE, 40 *SIZE);
    _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_confirmBtn addTarget:self action:@selector(ActionConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
    [_confirmBtn setBackgroundColor:YJBlueBtnColor];
    [self.view addSubview:_confirmBtn];
}

@end
