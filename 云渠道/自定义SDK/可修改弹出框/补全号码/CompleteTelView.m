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
    _textField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    _textField.text = @"13438339177";
    _textField.textColor = [UIColor whiteColor];
    [_textField addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    //    _textField.delegate = self;
    [self addSubview:_textField];
    _telstr = @"13438339177";
    NSMutableArray *arr = [NSMutableArray array];
    for (int i =0; i<11; i++) {
        NSRange r = NSMakeRange(i, 1);
        [arr addObject:[_telstr substringWithRange:r]];
    }
    NSLog(@"%@",arr);
    
    
    for (int i = 0; i < 11; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(80 *SIZE+i*25*SIZE, 75 *SIZE, 20 *SIZE, 25 *SIZE);
        btn.titleLabel.font = [UIFont systemFontOfSize:13.3*SIZE];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.layer.cornerRadius = 5*SIZE;
        btn.layer.borderColor = COLOR(219, 219, 219, 1).CGColor;
        btn.layer.borderWidth = 1*SIZE;
        btn.tag = i;
//        NSRange r = NSMakeRange(i, 1);
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btn_action:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];

    }
    
}


-(void)btn_action:(UIButton *)btn
{
    NSLog(@"%ld",(long)btn.tag);
    
    [_textField becomeFirstResponder];
    UITextPosition* beginning = _textField.beginningOfDocument;
    UITextPosition* startPosition = [_textField positionFromPosition:beginning offset:btn.tag];
    UITextPosition* endPosition = [_textField positionFromPosition:beginning offset:btn.tag+1];
    UITextRange* selectionRange = [_textField textRangeFromPosition:startPosition toPosition:endPosition];
    [_textField setSelectedTextRange:selectionRange];

}

-(void)textFieldDidChange{
    if (_textField.text.length>11) {
        _textField.text = [_textField.text substringWithRange:NSMakeRange(0, 11)];
    }
    
    NSLog(@"%@",_textField.text);
}


@end
