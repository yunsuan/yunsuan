//
//  HouseHeaderCollCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/4.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "HouseHeaderCollCell.h"

@implementation HouseHeaderCollCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    _titleL = [[UILabel alloc] initWithFrame:CGRectMake(0, 8 *SIZE, self.contentView.bounds.size.width, 11 *SIZE)];
    _titleL.textColor = YJContentLabColor;
    _titleL.font = [UIFont systemFontOfSize:12 *SIZE];
    _titleL.textAlignment = NSTextAlignmentCenter;
    
    [self.contentView addSubview:_titleL];
}

@end
