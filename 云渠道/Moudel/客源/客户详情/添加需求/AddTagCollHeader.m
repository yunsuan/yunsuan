//
//  AddTagCollHeader.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/19.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "AddTagCollHeader.h"

@implementation AddTagCollHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(11 *SIZE, 13 *SIZE, 7 *SIZE, 13 *SIZE)];
    view.backgroundColor = YJBlueBtnColor;
    [self addSubview:view];
    
    _titleL = [[UILabel alloc] initWithFrame:CGRectMake(32 *SIZE, 13 *SIZE, 100 *SIZE, 14 *SIZE)];
    _titleL.textColor = YJTitleLabColor;
    _titleL.font = [UIFont systemFontOfSize:15 *SIZE];
    [self addSubview:_titleL];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 39 *SIZE, SCREEN_Width, SIZE)];
    line.backgroundColor = YJBackColor;
    [self addSubview:line];

}

@end
