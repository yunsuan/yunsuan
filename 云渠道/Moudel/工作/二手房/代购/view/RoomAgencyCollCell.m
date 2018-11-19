//
//  RoomAgencyCollCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/6/21.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RoomAgencyCollCell.h"

@implementation RoomAgencyCollCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    _titleL = [[UILabel alloc] initWithFrame:CGRectMake(0, 14 *SIZE, SCREEN_Width / 4, 11 *SIZE)];
    _titleL.textColor = YJ86Color;
    _titleL.font = [UIFont systemFontOfSize:12 *SIZE];
    _titleL.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_titleL];
    
    _line = [[UIView alloc] initWithFrame:CGRectMake(31 *SIZE, 38 *SIZE, 28 *SIZE, 2 *SIZE)];
    _line.backgroundColor = COLOR(27, 152, 255, 1);
    _line.hidden = YES;
    [self.contentView addSubview:_line];
}

- (void)setSelected:(BOOL)selected{
    
    if (selected) {
        
        _titleL.textColor = YJTitleLabColor;
        _titleL.font = [UIFont boldSystemFontOfSize:15 *SIZE];
        _line.hidden = NO;
    }else{
        
        _titleL.textColor = YJ86Color;
        _titleL.font = [UIFont systemFontOfSize:12 *SIZE];
        _line.hidden = YES;
    }
}

@end
