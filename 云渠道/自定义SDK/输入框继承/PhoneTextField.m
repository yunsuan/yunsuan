//
//  PhoneTextField.m
//  云渠道
//
//  Created by 谷治墙 on 2019/1/19.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "PhoneTextField.h"

@implementation PhoneTextField

- (void)deleteBackward{
    
    [super deleteBackward];
    if (_keyInputTextFieldDelegate && [_keyInputTextFieldDelegate respondsToSelector:@selector(deleteBackward)]) {
        
        [_keyInputTextFieldDelegate deleteBackWard:self];
    }
}

@end
