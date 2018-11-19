//
//  RuleView.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/23.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RuleView.h"

@implementation RuleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    self.backgroundColor = CH_COLOR_white;
    
    _titleImg = [[UIImageView alloc] initWithFrame:CGRectMake(11 *SIZE, 12 *SIZE, 17 *SIZE, 17 *SIZE)];
    [self addSubview:_titleImg];
    
    _titleL = [[UILabel alloc] initWithFrame:CGRectMake(42 *SIZE, 13 *SIZE, 200 *SIZE, 14 *SIZE)];
    _titleL.textColor = YJTitleLabColor;
    _titleL.font = [UIFont systemFontOfSize:15 *SIZE];
    [self addSubview:_titleL];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 39 *SIZE, SCREEN_Width, SIZE)];
    line.backgroundColor = YJBackColor;
    [self addSubview:line];
    
    _contentL = [[UILabel alloc] init];
    _contentL.textColor = YJ86Color;
    _contentL.numberOfLines = 0;
    _contentL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self addSubview:_contentL];
    
    [_contentL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self).offset(41 *SIZE);
        make.top.equalTo(self).offset(58 *SIZE);
        make.bottom.equalTo(self).offset(- 31 *SIZE);
        make.width.equalTo(@(304 *SIZE));
    }];
}

@end
