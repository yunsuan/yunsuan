//
//  MoreViewCollCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/10.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "MoreViewCollCell.h"

@implementation MoreViewCollCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    self.contentView.backgroundColor = COLOR(238, 238, 238, 1);
    self.contentView.layer.cornerRadius = 2 *SIZE;
    self.contentView.clipsToBounds = YES;
    
    _titleL = [[UILabel alloc] initWithFrame:CGRectMake(0, 9 *SIZE, self.contentView.bounds.size.width, 12 *SIZE)];
    _titleL.textColor = YJ86Color;
    _titleL.font = [UIFont systemFontOfSize:13 *SIZE];
    _titleL.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_titleL];
    
    self.layer.borderColor = COLOR(133, 200, 255, 1).CGColor;
}
//
//- (void)setSelected:(BOOL)selected{
//    
//    if (selected) {
//        
//        self.contentView.backgroundColor = COLOR(133, 200, 255, 1);
//        _titleL.textColor = CH_COLOR_white;
//    }else{
//        
//        _titleL.textColor = YJ86Color;
//        self.contentView.backgroundColor = COLOR(238, 238, 238, 1);
//    }
//}

@end
