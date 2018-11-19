//
//  MoreViewCollHeader.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/10.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "MoreViewCollHeader.h"

@implementation MoreViewCollHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _titleL = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 13 *SIZE, SCREEN_Width, 12 *SIZE)];
        _titleL.textColor = YJ86Color;
        _titleL.font = [UIFont systemFontOfSize:13 *SIZE];
        [self addSubview:_titleL];
    }
    return self;
}

@end
