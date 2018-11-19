//
//  NomineeCollCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/9.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "NomineeCollCell.h"

@implementation NomineeCollCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    _titleL = [[UILabel alloc] initWithFrame:CGRectMake(0, 12 *SIZE, self.bounds.size.width, 14 *SIZE)];
    _titleL.textColor = YJ86Color;
    _titleL.font = [UIFont systemFontOfSize:12 *SIZE];
    _titleL.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_titleL];
    
    _line = [[UIView alloc] initWithFrame:CGRectMake(47.5 *SIZE, 38 *SIZE, 27 *SIZE, 2 *SIZE)];
    _line.backgroundColor = YJBlueBtnColor;
    _line.hidden = YES;
    [self.contentView addSubview:_line];
    
}

- (void)setSelected:(BOOL)selected{
    
    if (selected) {
        
        _titleL.textColor = YJTitleLabColor;
        _titleL.font = [UIFont systemFontOfSize:14 *SIZE];
        _line.hidden = NO;
    }else{
        
        _titleL.textColor = YJ86Color;
        _titleL.font = [UIFont systemFontOfSize:12 *SIZE];
        _line.hidden = YES;
    }
}

@end
