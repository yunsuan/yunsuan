//
//  SHRecommenView.m
//  云渠道
//
//  Created by xiaoq on 2019/1/27.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "SHRecommenView.h"

@implementation SHRecommenView



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionTranmitBtn:(UIButton *)btn{
    

     [self removeFromSuperview];
}

- (void)ActionConfirmBtn:(UIButton *)btn{
    
    if (self.recommendViewConfirmBlock) {
        
        self.recommendViewConfirmBlock();
    }
    [self removeFromSuperview];
}



- (void)initUI{
    
    UIView *alphaView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    alphaView.backgroundColor = [UIColor blackColor];
    alphaView.alpha = 0.4;
    [self addSubview:alphaView];
    
    _whiteView = [[UIView alloc] initWithFrame:CGRectMake(55 *SIZE, 154 *SIZE, 250 *SIZE, 331 *SIZE)];
    _whiteView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_whiteView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 18 *SIZE, 250 *SIZE, 16 *SIZE)];
    label.textColor = YJTitleLabColor;
    label.font = [UIFont systemFontOfSize:17 *SIZE];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"推荐";
    [_whiteView addSubview:label];
    
    _nameL = [[UILabel alloc]initWithFrame:CGRectMake(20*SIZE, 58 *SIZE, 150 *SIZE, 13 *SIZE)];
    _nameL.textColor = YJContentLabColor;
    _nameL.font = [UIFont systemFontOfSize:12 *SIZE];
    _nameL.text =@"客户：";
    [_whiteView addSubview:_nameL];
    
    _nameTF =  [[BorderTF alloc] initWithFrame:CGRectMake(80 *SIZE, 50 *SIZE, 150 *SIZE, 33 *SIZE)];
    [_whiteView addSubview:_nameTF];
    
    _phoneL = [[UILabel alloc]initWithFrame:CGRectMake(20*SIZE, 98 *SIZE, 200 *SIZE, 13 *SIZE)];
    _phoneL.textColor = YJContentLabColor;
    _phoneL.font = [UIFont systemFontOfSize:12 *SIZE];
    _phoneL.text = @"联系方式:";
    [_whiteView addSubview:_phoneL];
    
    _phoneTF =  [[BorderTF alloc] initWithFrame:CGRectMake(80 *SIZE, 90 *SIZE, 150 *SIZE, 33 *SIZE)];
    [_whiteView addSubview:_phoneTF];
    
    _sexL = [[UILabel alloc]initWithFrame:CGRectMake(20*SIZE, 138 *SIZE, 200 *SIZE, 13 *SIZE)];
    _sexL.textColor = YJContentLabColor;
    _sexL.font = [UIFont systemFontOfSize:12 *SIZE];
    _sexL.text = @"性别：";
    
    [_whiteView addSubview:_sexL];
    
    _sexBtn = [[DropDownBtn alloc]initWithFrame:CGRectMake(80*SIZE, 130*SIZE, 150*SIZE, 33*SIZE)];
    [_whiteView addSubview:_sexBtn];
    _markL = [[UILabel alloc]initWithFrame:CGRectMake(20*SIZE, 178 *SIZE, 200 *SIZE, 13 *SIZE)];
    _markL.textColor = YJContentLabColor;
    _markL.font = [UIFont systemFontOfSize:12 *SIZE];
    _markL.text =@"备注：";
    [_whiteView addSubview:_markL];
    
   _markTV= [[UITextView alloc] initWithFrame:CGRectMake(80 *SIZE, 170 *SIZE, 150 *SIZE,90 *SIZE)];
    _markTV.contentInset = UIEdgeInsetsMake(5 *SIZE, 5 *SIZE, 5 *SIZE, 5 *SIZE);
    _markTV.layer.cornerRadius = 5 *SIZE;
    _markTV.layer.borderWidth = SIZE;
    _markTV.layer.borderColor = COLOR(219, 219, 219, 1).CGColor;
    _markTV.clipsToBounds = YES;
    [_whiteView addSubview:_markTV];
    
    //    _nameL.text = @"客户：";

    _tranmitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _tranmitBtn.frame = CGRectMake(0, 291*SIZE, 125 *SIZE, 40 *SIZE);
    _tranmitBtn.titleLabel.font = [UIFont systemFontOfSize:13 *SIZE];
    [_tranmitBtn addTarget:self action:@selector(ActionTranmitBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_tranmitBtn setBackgroundColor:COLOR(238, 238, 238, 1)];
    [_tranmitBtn setTitle:@"返回" forState:UIControlStateNormal];
    [_tranmitBtn setTitleColor:YJTitleLabColor forState:UIControlStateNormal];
    [_whiteView addSubview:_tranmitBtn];
        
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirmBtn.frame = CGRectMake(125*SIZE, 291*SIZE, 125 *SIZE, 40 *SIZE);
    _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:13 *SIZE];
    [_confirmBtn addTarget:self action:@selector(ActionConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_confirmBtn setBackgroundColor:YJBlueBtnColor];
    [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_whiteView addSubview:_confirmBtn];


    
}


@end

