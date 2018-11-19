//
//  RoomCollCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/3/22.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RoomCollCell.h"

@implementation RoomCollCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    _typeL = [[UILabel alloc] initWithFrame:CGRectMake(0, 14 *SIZE, 60 *SIZE, 11 *SIZE)];
    _typeL.textColor = YJContentLabColor;
    _typeL.font = [UIFont systemFontOfSize:12 *SIZE];
    _typeL.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_typeL];
    
    _dropImg = [[UIImageView alloc] initWithFrame:CGRectMake(60 *SIZE, 19 *SIZE, 7 *SIZE, 4 *SIZE)];
    [self.contentView addSubview:_dropImg];
}

- (void)setSelected:(BOOL)selected{
    
    if (selected) {
        
        
    }else{
        
        
    }
}

@end
