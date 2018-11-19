//
//  RoomDetailTableCell8.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/8.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RoomDetailTableCell8.h"

@implementation RoomDetailTableCell8

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    _headImg = [[UIImageView alloc] init];
    _headImg.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_headImg];
    [_headImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(self.contentView).offset(31 *SIZE);
        make.width.equalTo(@(22 *SIZE));
        make.height.equalTo(@(22 *SIZE));
        make.bottom.equalTo(self.contentView).offset(-31 *SIZE);
    }];
    
    _titleL = [[UILabel alloc] initWithFrame:CGRectMake(68 *SIZE, 33 *SIZE, 130 *SIZE, 13 *SIZE)];
    _titleL.textColor = YJTitleLabColor;
    _titleL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_titleL];
    
    _timeL = [[UILabel alloc] initWithFrame:CGRectMake(210 *SIZE, 33 *SIZE, 137 *SIZE, 13 *SIZE)];
    _timeL.textColor = YJContentLabColor;
    _timeL.font = [UIFont systemFontOfSize:13 *SIZE];
    _timeL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_timeL];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 83 *SIZE, SCREEN_Width,  SIZE)];
    line.backgroundColor = YJBackColor;
    [self.contentView addSubview:line];
}

@end
