//
//  RentingCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/7/23.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RentingCell.h"

@implementation RentingCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    _headImg = [[UIImageView alloc] initWithFrame:CGRectMake(12 *SIZE, 16 *SIZE, 100 *SIZE, 88 *SIZE)];
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
    
    _priceL = [[UILabel alloc] init];
    _priceL.textColor = COLOR(255, 70, 70, 1);
    _priceL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_priceL];
    
    _statusImg = [[UIImageView alloc] init];
    _statusImg.image = [UIImage imageNamed:@"rising"];
    [self.contentView addSubview:_statusImg];
    
    _averageL = [[UILabel alloc] init];
    _averageL.textColor = YJContentLabColor;
    _averageL.font = [UIFont systemFontOfSize:11 *SIZE];
    _averageL.numberOfLines = 0;
    [self.contentView addSubview:_averageL];
    
    _typeL = [[UILabel alloc] init];
    _typeL.textColor = YJContentLabColor;
    _typeL.font = [UIFont systemFontOfSize:11 *SIZE];
    _typeL.numberOfLines = 0;
    [self.contentView addSubview:_typeL];
    
    _classL = [[UILabel alloc] init];
    _classL.textColor = YJBlueBtnColor;
    _classL.backgroundColor = COLOR(213, 242, 255, 1);
    _classL.font = [UIFont systemFontOfSize:10 *SIZE];
    _classL.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_classL];
    
    _tagView = [[TagView alloc]initWithFrame:CGRectMake(123 *SIZE, 90 *SIZE, 200*SIZE, 17*SIZE)  type:@"1"];
    [self.contentView addSubview:_tagView];
    
    _tagView2 = [[TagView alloc]initWithFrame:CGRectMake(123 *SIZE, 109 *SIZE, 200*SIZE, 17*SIZE)  type:@"1"];
    [self.contentView addSubview:_tagView2];
    
    _line = [[UIView alloc] init];
    _line.backgroundColor = YJBackColor;
    [self.contentView addSubview:_line];
    
    [self masonryUI];
}

- (void)masonryUI{
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(123 *SIZE);
        make.top.equalTo(self.contentView).offset(15 *SIZE);
        make.right.equalTo(self.contentView).offset(-55 *SIZE);
    }];
    
    [_classL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
        make.top.equalTo(self.contentView).offset(13 *SIZE);
        make.width.mas_equalTo(33 *SIZE);
        make.height.mas_equalTo(17 *SIZE);
    }];
    
    [_contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(123 *SIZE);
        make.top.equalTo(_titleL.mas_bottom).offset(8 *SIZE);
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(123 *SIZE);
        make.top.equalTo(_contentL.mas_bottom).offset(8 *SIZE);
        make.width.equalTo(@(_priceL.mj_textWith + 5 *SIZE));
    }];
    
    [_statusImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_priceL.mas_right).offset(10 *SIZE);
        make.top.equalTo(_contentL.mas_bottom).offset(10 *SIZE);
        make.width.height.mas_equalTo(10 *SIZE);
    }];
    
    [_averageL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_statusImg.mas_right).offset(44 *SIZE);
        make.top.equalTo(_contentL.mas_bottom).offset(8 *SIZE);
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
    [_typeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(123 *SIZE);
        make.top.equalTo(_priceL.mas_bottom).offset(8 *SIZE);
        make.right.equalTo(self.contentView).offset(-140 *SIZE);
    }];
    
    [_tagView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(123 *SIZE);
        make.top.equalTo(_typeL.mas_bottom).offset(8 *SIZE);
        make.width.equalTo(@(200 *SIZE));
        make.height.equalTo(@(17 *SIZE));
    }];
    
    [_tagView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(123 *SIZE);
        make.top.equalTo(_tagView.mas_bottom).offset(9 *SIZE);
        make.width.equalTo(@(200 *SIZE));
        make.height.equalTo(@(17 *SIZE));
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(_tagView2.mas_bottom).offset(15 *SIZE);
        make.right.equalTo(self.contentView).offset(0 *SIZE);
        make.height.equalTo(@(SIZE));
        make.bottom.equalTo(self.contentView).offset(0);
    }];
    
}

@end
