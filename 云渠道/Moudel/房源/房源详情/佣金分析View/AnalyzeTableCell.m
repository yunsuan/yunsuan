//
//  AnalyzeTableCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/23.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "AnalyzeTableCell.h"

@implementation AnalyzeTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
 
    UIView * header = [[UIView alloc]initWithFrame:CGRectMake(10*SIZE , 16*SIZE, 6.7*SIZE, 15*SIZE)];
    header.backgroundColor = YJBlueBtnColor;
    [self.contentView addSubview:header];
    _titleL = [[UILabel alloc] init];
    _titleL.textColor = YJTitleLabColor;
    _titleL.font = [UIFont systemFontOfSize:15 *SIZE];
    [self.contentView addSubview:_titleL];
    
    _contentL = [[UILabel alloc] init];
    _contentL.textColor = YJContentLabColor;
    _contentL.numberOfLines = 0;
    _contentL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_contentL];
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.width.equalTo(@(319 *SIZE));
        make.top.equalTo(self.contentView).offset(16 *SIZE);
    }];
    
    [_contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.width.equalTo(@(319 *SIZE));
        make.top.equalTo(_titleL.mas_bottom).offset(18 *SIZE);
        make.bottom.equalTo(self.contentView).offset(- 32 *SIZE);
    }];
}

@end
