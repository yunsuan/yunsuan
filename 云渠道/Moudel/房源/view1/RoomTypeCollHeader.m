//
//  RoomTypeCollHeader.m
//  云渠道
//
//  Created by 谷治墙 on 2018/10/11.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RoomTypeCollHeader.h"

@implementation RoomTypeCollHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    _titleL = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 10 *SIZE, 300 *SIZE, 15 *SIZE)];
    _titleL.textColor = YJTitleLabColor;
    _titleL.font = [UIFont systemFontOfSize:15 *SIZE];
    [self addSubview:_titleL];
}

@end
