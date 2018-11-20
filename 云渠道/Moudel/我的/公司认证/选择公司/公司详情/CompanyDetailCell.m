//
//  CompanyDetailCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/7/5.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "CompanyDetailCell.h"

@implementation CompanyDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    for (int i = 0; i < 2; i++) {
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(124 *SIZE + i * 93 *SIZE, 24 *SIZE, 17 *SIZE, 2 *SIZE)];
        line.backgroundColor = COLOR(27, 152, 255, 1);
        [self.contentView addSubview:line];
    }
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(141 *SIZE, 17 *SIZE, 76 *SIZE, 14 *SIZE)];
    label.textColor = YJTitleLabColor;
    label.font = [UIFont systemFontOfSize:15 *SIZE];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"公司简介";
    [self.contentView addSubview:label];
    
    _briefL = [[UILabel alloc] init];
    _briefL.textColor = YJTitleLabColor;
    _briefL.font = [UIFont systemFontOfSize:12 *SIZE];
    _briefL.numberOfLines = 0;
    [self.contentView addSubview:_briefL];
    
    [_briefL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(57 *SIZE);
        make.width.mas_equalTo(335 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-48 *SIZE);
    }];
}

@end
