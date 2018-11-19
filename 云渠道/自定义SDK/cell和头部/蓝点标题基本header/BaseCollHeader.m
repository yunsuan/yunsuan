//
//  BaseCollHeader.m
//  云渠道
//
//  Created by 谷治墙 on 2018/6/19.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseCollHeader.h"

@implementation BaseCollHeader

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
    
    _colorView = [[UIView alloc] init];//WithFrame:CGRectMake(10 *SIZE, 13 *SIZE, 7 *SIZE, 13 *SIZE)];
    _colorView.backgroundColor = YJBlueBtnColor;
    [self addSubview:_colorView];
    
    _titleL = [[UILabel alloc] init];//WithFrame:CGRectMake(28 *SIZE, 13 *SIZE, 300 *SIZE, 15 *SIZE)];
    _titleL.textColor = YJTitleLabColor;
    _titleL.font = [UIFont systemFontOfSize:15 *SIZE];
    [self addSubview:_titleL];
    
    _lineView = [[UIView alloc] init];//WithFrame:CGRectMake(0, 39 *SIZE, SCREEN_Width , SIZE)];
    _lineView.backgroundColor = YJBackColor;
    [self addSubview:_lineView];
    
    [_colorView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(10 *SIZE);
        make.top.equalTo(self).offset(13 *SIZE);
        make.width.mas_equalTo(7 *SIZE);
        make.height.mas_equalTo(13 *SIZE);
    }];
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(28 *SIZE);
        make.top.equalTo(self).offset(13 *SIZE);
        make.right.equalTo(self).offset(30 *SIZE);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(0 *SIZE);
        make.top.equalTo(self).offset(39 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(SIZE);
        make.bottom.equalTo(self).offset(0 *SIZE);
    }];
}

@end
