//
//  AuthenTableCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/3/23.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "AuthenTableCell.h"

@implementation AuthenTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    _titleL = [[UILabel alloc] initWithFrame:CGRectMake(9 *SIZE, 16 *SIZE, 100 *SIZE, 14 *SIZE)];
    _titleL.textColor = YJContentLabColor;
    _titleL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_titleL];
    
    
    _contentL = [[UILabel alloc] initWithFrame:CGRectMake(129 *SIZE, 16 *SIZE, 200 *SIZE, 14 *SIZE)];
    _contentL.textColor = YJContentLabColor;
    _contentL.font = [UIFont systemFontOfSize:13 *SIZE];
    _contentL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_contentL];
    
    _rightView = [[UIImageView alloc] initWithFrame:CGRectMake(343 *SIZE, 16 *SIZE, 7 *SIZE, 12 *SIZE)];
    _rightView.image = [UIImage imageNamed:@"rightarrow"];
    [self.contentView addSubview:_rightView];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 50 *SIZE, SCREEN_Width, SIZE)];
    line.backgroundColor = YJBackColor;
    [self.contentView addSubview:line];
}

@end
