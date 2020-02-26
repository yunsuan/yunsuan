//
//  MyShopCommentCell.m
//  云渠道
//
//  Created by 谷治墙 on 2020/2/25.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "MyShopCommentCell.h"

@implementation MyShopCommentCell

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
    _headImg.contentMode = UIViewContentModeScaleAspectFill;
    _headImg.layer.cornerRadius = 20 *SIZE;
    _headImg.clipsToBounds = YES;
    [self.contentView addSubview:_headImg];
    
    _nameL = [[UILabel alloc] init];
    _nameL.font = [UIFont systemFontOfSize:13 *SIZE];
    _nameL.textColor = YJTitleLabColor;
    [self.contentView addSubview:_nameL];
    
    _timeL = [[UILabel alloc] init];
    _timeL.font = [UIFont systemFontOfSize:11 *SIZE];
    _timeL.textColor = YJTitleLabColor;
    [self.contentView addSubview:_timeL];
    
    _contentL = [[UILabel alloc] init];
    _contentL.font = [UIFont systemFontOfSize:11 *SIZE];
    _contentL.textColor = YJTitleLabColor;
    _contentL.numberOfLines = 0;
    _contentL.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:_contentL];
    
    _line = [[UIView alloc] init];
    _line.backgroundColor = CLBackColor;
    [self.contentView addSubview:_line];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_headImg mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(10 *SIZE);
        make.width.height.mas_equalTo(40 *SIZE);
    }];
    
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(60 *SIZE);
        make.top.equalTo(self.contentView).offset(10 *SIZE);
        make.width.mas_equalTo(200 *SIZE);
    }];
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(60 *SIZE);
        make.top.equalTo(self->_nameL.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(200 *SIZE);
    }];
    
    [_contentL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_headImg.mas_bottom).offset(10 *SIZE);
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(self->_contentL.mas_bottom).offset(15*SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(1 *SIZE);
        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
    }];
}

@end
