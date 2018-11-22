//
//  CompleteImgHeader.m
//  云渠道
//
//  Created by 谷治墙 on 2018/6/26.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "CompleteImgHeader.h"

@implementation CompleteImgHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        _titleTF = [[UITextField alloc] initWithFrame:CGRectMake(0 *SIZE, 0 *SIZE, SCREEN_Width, 40 *SIZE)];
//        _titleTF.
        _titleTF.placeholder = @"输入图片名称";
        _titleTF.clearButtonMode = UITextFieldViewModeAlways;
        _titleTF.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10 *SIZE, 0)];
        //设置显示模式为永远显示(默认不显示)
        _titleTF.leftViewMode = UITextFieldViewModeAlways;
        _titleTF.font = [UIFont systemFontOfSize:13 *SIZE];
        [self addSubview:_titleTF];
    }
    return self;
}

@end
