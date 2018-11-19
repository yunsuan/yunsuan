//
//  CustomHeaderCollCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/3/22.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "CustomHeaderCollCell.h"

@implementation CustomHeaderCollCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    _backView = [[UIView alloc] initWithFrame:self.contentView.bounds];
    _backView.backgroundColor = YJBackColor;
    [self.contentView addSubview:_backView];
    
    _titleL = [[UILabel alloc] initWithFrame:CGRectMake(0, 17 *SIZE, 120 *SIZE, 12 *SIZE)];
    _titleL.textColor = YJTitleLabColor;
    _titleL.font = [UIFont systemFontOfSize:13 *SIZE];
    _titleL.textAlignment = NSTextAlignmentCenter;
//    _titleL.text = @"需求信息";
    [self.contentView addSubview:_titleL];
}

- (void)setSelected:(BOOL)selected{
    
    if (selected) {
        
        _backView.backgroundColor = COLOR(28, 151, 255, 1);
        _titleL.textColor = CH_COLOR_white;
    }else{
        
        _backView.backgroundColor = YJBackColor;
        _titleL.textColor = YJTitleLabColor;
    }
}

@end
