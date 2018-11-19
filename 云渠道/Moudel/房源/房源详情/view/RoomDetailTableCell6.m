//
//  RoomDetailTableCell6.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/8.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RoomDetailTableCell6.h"

@implementation RoomDetailTableCell6

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    _titleL = [[UILabel alloc] initWithFrame:CGRectMake(28 *SIZE, 17 *SIZE, 300 *SIZE, 14 *SIZE)];
    _titleL.textColor = YJTitleLabColor;
    _titleL.font = [UIFont systemFontOfSize:15 *SIZE];
    [self.contentView addSubview:_titleL];
    
    _contentL = [[UILabel alloc] init];
    _contentL.textColor = YJContentLabColor;
    _contentL.numberOfLines = 0;
    _contentL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_contentL];
    
    [_contentL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(self.contentView).offset(48 *SIZE);
        make.right.equalTo(self.contentView).offset(-25 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-32 *SIZE);
    }];
}

@end
