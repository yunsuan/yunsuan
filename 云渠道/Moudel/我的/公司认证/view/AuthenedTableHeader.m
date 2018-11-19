//
//  AuthenedTableHeader.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/10.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "AuthenedTableHeader.h"

@implementation AuthenedTableHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    self.contentView.backgroundColor = YJBlueBtnColor;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 31 *SIZE, SCREEN_Width, 17 *SIZE)];
    label.textColor = CH_COLOR_white;
    label.font = [UIFont systemFontOfSize:19 *SIZE];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"已认证";
    [self.contentView addSubview:label];
    
    _phoneL = [[UILabel alloc] initWithFrame:CGRectMake(0, 69 *SIZE, SCREEN_Width, 17 *SIZE)];
    _phoneL.textColor = CH_COLOR_white;
    _phoneL.font = [UIFont systemFontOfSize:13 *SIZE];
    _phoneL.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_phoneL];
}

@end
