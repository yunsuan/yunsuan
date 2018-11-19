//
//  SecBrokerCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/7/17.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "SecBrokerCell.h"

@implementation SecBrokerCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    _upLine = [[UIView alloc] init];
    _upLine.backgroundColor = COLOR(255, 165, 29, 1);
    [self.contentView addSubview:_upLine];
    
    _downLine = [[UIView alloc] init];
    _downLine.backgroundColor = COLOR(255, 165, 29, 1);
    [self.contentView addSubview:_downLine];
    
    _tagImg = [[UIImageView alloc] init];
    _tagImg.image = [UIImage imageNamed:@"progressbar"];
    [self.contentView addSubview:_tagImg];
    
    _titleL = [[UILabel alloc] init];
    _titleL.textColor = YJTitleLabColor;
    _titleL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_titleL];
    
    _contentL = [[UILabel alloc] init];
    _contentL.textColor = YJContentLabColor;
    _contentL.numberOfLines = 0;
    _contentL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_contentL];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_upLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(36 *SIZE);
        make.top.equalTo(self.contentView).offset(0);
        make.width.mas_equalTo(SIZE);
        make.height.mas_equalTo(9 *SIZE);
    }];
    
    [_tagImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_upLine.mas_bottom).offset(0);
        make.width.height.mas_equalTo(17 *SIZE);
    }];
    
    [_downLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(36 *SIZE);
        make.top.equalTo(_tagImg.mas_bottom).offset(0);
        make.width.mas_equalTo(SIZE);
        make.bottom.equalTo(self.contentView).offset(0);
//        make.height.mas_equalTo(9 *SIZE);
    }];
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(57 *SIZE);
        make.top.equalTo(self.contentView).offset(11 *SIZE);
        make.right.equalTo(self.contentView).offset(-57 *SIZE);
    }];
    
    [_contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(58 *SIZE);
        make.top.equalTo(self.contentView).offset(39 *SIZE);
        make.right.equalTo(self.contentView).offset(-30 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-14 *SIZE);
    }];
}
@end
