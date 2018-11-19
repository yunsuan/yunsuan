//
//  PassCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/5/4.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "PassCell.h"

@implementation PassCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    _auditorL = [[UILabel alloc] init];
    _auditorL.textColor = YJContentLabColor;
    _auditorL.font = [UIFont systemFontOfSize:13 *SIZE];
    _auditorL.numberOfLines = 0;
    [self.contentView addSubview:_auditorL];
    
    _phoneL = [[UILabel alloc] init];
    _phoneL.textColor = YJContentLabColor;
    _phoneL.font = [UIFont systemFontOfSize:13 *SIZE];
    _phoneL.numberOfLines = 0;
    [self.contentView addSubview:_phoneL];
    
    _timeL = [[UILabel alloc] init];
    _timeL.textColor = YJContentLabColor;
    _timeL.font = [UIFont systemFontOfSize:13 *SIZE];
    _timeL.numberOfLines = 0;
    [self.contentView addSubview:_timeL];
    
    _typeImg = [[UIImageView alloc] init];
    [self.contentView addSubview:_typeImg];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_auditorL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(self.contentView).offset(SIZE);
        make.right.equalTo(self.contentView).offset(- 110 *SIZE);
    }];
    
    [_phoneL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_auditorL.mas_bottom).offset(17 *SIZE);
        make.right.equalTo(self.contentView).offset(- 110 *SIZE);
    }];
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_phoneL.mas_bottom).offset(17 *SIZE);
        make.right.equalTo(self.contentView).offset(- 110 *SIZE);
        make.bottom.equalTo(self.contentView).offset(- 23 *SIZE);
    }];
    
    [_typeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(- 14 *SIZE);
        make.bottom.equalTo(self.contentView).offset(- 26 *SIZE);
        make.width.height.equalTo(@(75 *SIZE));
    }];
}

@end
