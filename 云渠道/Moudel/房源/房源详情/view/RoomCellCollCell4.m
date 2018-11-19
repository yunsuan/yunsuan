//
//  RoomCellCollCell4.m
//  云渠道
//
//  Created by 谷治墙 on 2018/3/28.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RoomCellCollCell4.h"

@implementation RoomCellCollCell4

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
//    self.contentView.layer.borderColor = COLOR(112, 112, 112, 1).CGColor;
//    self.contentView.layer.borderWidth = SIZE;
    self.contentView.layer.cornerRadius = 2 *SIZE;
    self.contentView.clipsToBounds = YES;
    
    _titleL = [[UILabel alloc] initWithFrame:CGRectMake(0, 7 *SIZE, 60 *SIZE, 13 *SIZE)];
    _titleL.textColor = YJContentLabColor;
    _titleL.font = [UIFont systemFontOfSize:12 *SIZE];
    _titleL.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_titleL];
}

@end
