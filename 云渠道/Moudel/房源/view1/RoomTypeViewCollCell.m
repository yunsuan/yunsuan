//
//  RoomTypeViewCollCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/10/12.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RoomTypeViewCollCell.h"

@implementation RoomTypeViewCollCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    //    self.contentView.backgroundColor = YJContentLabColor;
    
    _titleL = [[UILabel alloc] init];//WithFrame:CGRectMake(0, 14 *SIZE, self.contentView.frame.size.width, 11 *SIZE)];
    _titleL.textColor = COLOR(153, 153, 153, 1);
    _titleL.font = [UIFont systemFontOfSize:12 *SIZE];
    _titleL.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_titleL];
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(self.contentView).offset(2 *SIZE);
        make.top.equalTo(self.contentView).offset(14 *SIZE);
        make.right.equalTo(self.contentView).offset(-2 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-14 *SIZE);
    }];
}

@end
