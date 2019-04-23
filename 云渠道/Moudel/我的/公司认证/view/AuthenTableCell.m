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
    
    _titleL = [[UILabel alloc] init];//WithFrame:CGRectMake(9 *SIZE, 16 *SIZE, 100 *SIZE, 14 *SIZE)];
    _titleL.textColor = YJContentLabColor;
    _titleL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_titleL];
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(self.contentView).offset(16 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
    }];
    
    
    _contentL = [[UILabel alloc] init];//WithFrame:CGRectMake(129 *SIZE, 16 *SIZE, 200 *SIZE, 14 *SIZE)];
    _contentL.textColor = YJContentLabColor;
    _contentL.font = [UIFont systemFontOfSize:13 *SIZE];
    _contentL.textAlignment = NSTextAlignmentRight;
    _contentL.numberOfLines = 0;
    [self.contentView addSubview:_contentL];
    
    [_contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(129 *SIZE);
        make.top.equalTo(self.contentView).offset(16 *SIZE);
        make.width.mas_equalTo(200 *SIZE);
    }];
    
    _rightView = [[UIImageView alloc] initWithFrame:CGRectMake(343 *SIZE, 16 *SIZE, 7 *SIZE, 12 *SIZE)];
    _rightView.image = [UIImage imageNamed:@"rightarrow"];
    [self.contentView addSubview:_rightView];
    
    _line = [[UIView alloc] init];//WithFrame:CGRectMake(0, 50 *SIZE, SCREEN_Width, SIZE)];
    _line.backgroundColor = YJBackColor;
    [self.contentView addSubview:_line];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(self->_contentL.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(360 *SIZE);
        make.height.mas_equalTo(SIZE);
        make.bottom.equalTo(self.contentView).offset(0);
    }];
}

@end
