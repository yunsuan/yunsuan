//
//  CompleteTelView.m
//  云渠道
//
//  Created by 谷治墙 on 2019/1/15.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "CompleteTelView.h"


@interface CompleteTelView ()<UITextFieldDelegate>

@end

@implementation CompleteTelView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    UIView *alphaView = [[UIView alloc] initWithFrame:self.frame];
    alphaView.backgroundColor = [UIColor blackColor];
    alphaView.alpha = 0.4;
    [self addSubview:alphaView];
    
    _whiteView = [[UIView alloc] init];
    _whiteView.backgroundColor = [UIColor whiteColor];
    _whiteView.layer.cornerRadius = 3 *SIZE;
    _whiteView.clipsToBounds = YES;
    [self addSubview:_whiteView];
    
    _titleL = [[UILabel alloc] init];
    _titleL.textColor = YJTitleLabColor;
    _titleL.font = [UIFont systemFontOfSize:15 *SIZE];
    _titleL.numberOfLines = 0;
    _titleL.textAlignment = NSTextAlignmentCenter;
    _titleL.text = @"补全号码";
    [_whiteView addSubview:_titleL];
    
    _lineView = [[DashesLineView alloc] initWithFrame:CGRectMake(23 *SIZE, 61 *SIZE, 203 *SIZE, 2 *SIZE)];
    [_whiteView addSubview:_lineView];
    
    for (int i = 0; i < 4; i++) {
        
        UITextField *borderTF = [[UITextField alloc] initWithFrame:CGRectMake(80 *SIZE, 75 *SIZE, 19 *SIZE, 24 *SIZE)];
        borderTF.textColor = YJContentLabColor;
        borderTF.keyboardType = UIKeyboardTypePhonePad;
        borderTF.font = [UIFont systemFontOfSize:13.3*SIZE];
        borderTF.layer.cornerRadius = 5*SIZE;
        borderTF.layer.borderColor = COLOR(219, 219, 219, 1).CGColor;
        borderTF.layer.borderWidth = 1*SIZE;
        borderTF.textAlignment = NSTextAlignmentCenter;
        switch (i) {
            case 0:
            {
                borderTF.layer.borderColor = COLOR(169, 219, 255, 1).CGColor;
                _phoneTF4 = borderTF;
                _phoneTF4.delegate = self;
                
                [_whiteView addSubview:_phoneTF4];
                break;
            }
            case 1:
            {
                borderTF.layer.borderColor = COLOR(169, 219, 255, 1).CGColor;
                _phoneTF5 = borderTF;
                _phoneTF5.delegate = self;
                
                [_whiteView addSubview:_phoneTF5];
                break;
            }
            case 2:
            {
                borderTF.layer.borderColor = COLOR(169, 219, 255, 1).CGColor;
                _phoneTF6 = borderTF;
                _phoneTF6.delegate = self;
                
                [_whiteView addSubview:_phoneTF6];
                break;
            }
            case 3:
            {
                borderTF.layer.borderColor = COLOR(169, 219, 255, 1).CGColor;
                _phoneTF7 = borderTF;
                _phoneTF7.delegate = self;
                
                [_whiteView addSubview:_phoneTF7];
                break;
            }
            default:
                break;
        }
    }
}

- (void)MasonryUI{
    
    
}

@end
