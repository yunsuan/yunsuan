//
//  MyShopTagView.m
//  云渠道
//
//  Created by 谷治墙 on 2020/3/1.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "MyShopTagView.h"

@implementation MyShopTagView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionConfirmBtn{
    
    if (self.myShopTagViewBlock) {
        
        self.myShopTagViewBlock();
    }
    [self removeFromSuperview];
}

- (void)ActionTap{
    
    [self removeFromSuperview];
}


- (void)initUI{
    
    UIView *alphaView = [[UIView alloc] initWithFrame:self.bounds];
    alphaView.backgroundColor = [UIColor blackColor];
    alphaView.alpha = 0.4;
    alphaView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ActionTap)];
    [alphaView addGestureRecognizer:tap];
    [self addSubview:alphaView];
    
    _backView = [[UIView alloc] init];
    _backView.backgroundColor = [UIColor whiteColor];
    _backView.layer.cornerRadius = 5 *SIZE;
    _backView.clipsToBounds = YES;
    [self addSubview:_backView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20 *SIZE, 30 *SIZE, 200 *SIZE, 20 *SIZE)];
    label.textColor = YJTitleLabColor;
    label.font = [UIFont systemFontOfSize:18 *SIZE];
    label.text = @"新增标签";
    [_backView addSubview:label];
    
    _tagTF = [[BorderTF alloc] initWithFrame:CGRectMake(0, 0, 320 *SIZE, 33 *SIZE)];
    _tagTF.textfield.placeholder = @"如：擅长二手房、楼盘专家、服务达人";
    _tagTF.textfield.font = [UIFont systemFontOfSize:16 *SIZE];
    [_backView addSubview:_tagTF];
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_confirmBtn setTitle:@"完成" forState:UIControlStateNormal];
    [_confirmBtn setTitleColor:YJBlueBtnColor forState:UIControlStateNormal];
    [_confirmBtn addTarget:self action:@selector(ActionConfirmBtn) forControlEvents:UIControlEventTouchUpInside];
    [_backView addSubview:_confirmBtn];
    
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self).offset(10 *SIZE);
        make.top.equalTo(self).offset(150 *SIZE);
        make.width.mas_equalTo(340 *SIZE);
    }];
    
    [_tagTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_backView).offset(10 *SIZE);
        make.top.equalTo(_backView).offset(70 *SIZE);
        make.width.mas_equalTo(320 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(_backView).offset(-10 *SIZE);
        make.top.equalTo(_tagTF.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(60 *SIZE);
        make.height.mas_equalTo(20 *SIZE);
        make.bottom.equalTo(_backView.mas_bottom).offset(-20 *SIZE);;
    }];
}

@end
