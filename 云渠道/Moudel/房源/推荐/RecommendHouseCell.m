//
//  RecommendHouseCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/12/21.
//  Copyright © 2018 xiaoq. All rights reserved.
//

#import "RecommendHouseCell.h"

@implementation RecommendHouseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setModel:(RecommendHouseModel *)model{
    
    
}

- (void)initUI{
    
    _headImg = [[UIImageView alloc] init];//WithFrame:CGRectMake(12 *SIZE, 16 *SIZE, 100 *SIZE, 88 *SIZE)];
    _headImg.contentMode = UIViewContentModeScaleAspectFill;
    _headImg.clipsToBounds = YES;
    [self.contentView addSubview:_headImg];
    
    _titleL = [[UILabel alloc] init];
    _titleL.textColor = YJTitleLabColor;
    _titleL.font = [UIFont systemFontOfSize:13 *SIZE];
    _titleL.numberOfLines = 0;
    [self.contentView addSubview:_titleL];
    
    _contentL = [[UILabel alloc] init];
    _contentL.textColor = YJContentLabColor;
    _contentL.font = [UIFont systemFontOfSize:11 *SIZE];
    _contentL.numberOfLines = 0;
    [self.contentView addSubview:_contentL];
    
    _contentL = [[UILabel alloc] init];
    _contentL.textColor = COLOR(255, 70, 70, 1);
    _contentL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_contentL];

    _sourceL = [[UILabel alloc] init];
    _sourceL.textColor = YJContentLabColor;
    _sourceL.font = [UIFont systemFontOfSize:11 *SIZE];
    _sourceL.numberOfLines = 0;
    [self.contentView addSubview:_sourceL];
    
    _timeL = [[UILabel alloc] init];
    _timeL.textColor = YJContentLabColor;
    _timeL.numberOfLines = 0;
    _timeL.font = [UIFont systemFontOfSize:11 *SIZE];
    [self.contentView addSubview:_timeL];
    
    _line = [[UIView alloc] init];
    _line.backgroundColor = YJBackColor;
    [self.contentView addSubview:_line];
    
    [self masonryUI];
}

- (void)masonryUI{
    
    [_headImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(12 *SIZE);
        make.top.equalTo(self.contentView).offset(16 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
        make.height.mas_equalTo(88 *SIZE);
    }];
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(123 *SIZE);
        make.top.equalTo(self.contentView).offset(15 *SIZE);
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
    [_contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(123 *SIZE);
        make.top.equalTo(_titleL.mas_bottom).offset(8 *SIZE);
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
    [_sourceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(123 *SIZE);
        make.top.equalTo(_headImg.mas_bottom).offset(8 *SIZE);
        make.width.equalTo(@(_sourceL.mj_textWith + 5 *SIZE));
    }];
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(260 *SIZE);
        make.top.equalTo(_contentL.mas_bottom).offset(10 *SIZE);
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(_timeL.mas_bottom).offset(15 *SIZE);
        make.right.equalTo(self.contentView).offset(0 *SIZE);
        make.height.equalTo(@(SIZE));
        make.bottom.equalTo(self.contentView).offset(0);
    }];
    
}

@end
