//
//  TitleContentImgCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/9/28.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "TitleContentImgCell.h"

@implementation TitleContentImgCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    _titleL = [[UILabel alloc] init];
    _titleL.textColor = YJTitleLabColor;
    _titleL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_titleL];
 
    _contentL = [[UILabel alloc] init];
    _contentL.textColor = YJTitleLabColor;
    _contentL.font = [UIFont systemFontOfSize:13 *SIZE];
    _contentL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_contentL];
    
    _rightImg = [[UIImageView alloc] init];
    [self.contentView addSubview:_rightImg];
    
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = YJBackColor;
    [self.contentView addSubview:_lineView];
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(18 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
    }];
    
    [_contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(120 *SIZE);
        make.top.equalTo(self.contentView).offset(18 *SIZE);
        make.width.mas_equalTo(204 *SIZE);
    }];
    
    [_rightImg mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(343 *SIZE);
        make.top.equalTo(self.contentView).offset(19 *SIZE);
        make.width.height.mas_equalTo(12 *SIZE);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(self.contentView).offset(49 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
    }];
}

@end
