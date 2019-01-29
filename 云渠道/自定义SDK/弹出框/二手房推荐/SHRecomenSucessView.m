//
//  SHRecomenSucessView.m
//  云渠道
//
//  Created by xiaoq on 2019/1/28.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "SHRecomenSucessView.h"

@implementation SHRecomenSucessView




- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}


- (void)ActionConfirmBtn:(UIButton *)btn{

    [self removeFromSuperview];
}



- (void)initUI{
    
    UIView *alphaView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    alphaView.backgroundColor = [UIColor blackColor];
    alphaView.alpha = 0.4;
    [self addSubview:alphaView];
    
    _whiteView = [[UIView alloc] initWithFrame:CGRectMake(55 *SIZE, 154 *SIZE, 250 *SIZE, 218 *SIZE)];
    _whiteView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_whiteView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 18 *SIZE, 250 *SIZE, 16 *SIZE)];
    label.textColor = YJTitleLabColor;
    label.font = [UIFont systemFontOfSize:17 *SIZE];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"推荐成功";
    [_whiteView addSubview:label];
    
    _codeL= [[UILabel alloc]initWithFrame:CGRectMake(28*SIZE, 50 *SIZE, 150 *SIZE, 13 *SIZE)];
    _codeL.textColor = YJContentLabColor;
    _codeL.font = [UIFont systemFontOfSize:12 *SIZE];
    [_whiteView addSubview:_codeL];

    
    _nameL = [[UILabel alloc]initWithFrame:CGRectMake(28*SIZE, 80 *SIZE, 150 *SIZE, 13 *SIZE)];
    _nameL.textColor = YJContentLabColor;
    _nameL.font = [UIFont systemFontOfSize:12 *SIZE];
//    _nameL.text =@"客户名称：";
    [_whiteView addSubview:_nameL];
    

    
    _phoneL = [[UILabel alloc]initWithFrame:CGRectMake(28*SIZE, 110 *SIZE, 200 *SIZE, 13 *SIZE)];
    _phoneL.textColor = YJContentLabColor;
    _phoneL.font = [UIFont systemFontOfSize:12 *SIZE];
//    _phoneL.text = @"联系方式:";
    [_whiteView addSubview:_phoneL];
    
    _timeL = [[UILabel alloc]initWithFrame:CGRectMake(28*SIZE, 140 *SIZE, 200 *SIZE, 13 *SIZE)];
    _timeL.textColor = YJContentLabColor;
    _timeL.font = [UIFont systemFontOfSize:12 *SIZE];
//    _timeL.text = @"联系方式:";
    [_whiteView addSubview:_timeL];
    
    
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirmBtn.frame = CGRectMake(0*SIZE, 178*SIZE, 250 *SIZE, 40 *SIZE);
    _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:13 *SIZE];
    [_confirmBtn addTarget:self action:@selector(ActionConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_confirmBtn setBackgroundColor:YJBlueBtnColor];
    [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_whiteView addSubview:_confirmBtn];
    
    
    
}


@end
