//
//  RentingComTableCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/7/23.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RentingComTableCell.h"

@implementation RentingComTableCell

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
    
//    _classL = [[UILabel alloc] init];
//    _classL.textColor = YJBlueBtnColor;
//    _classL.backgroundColor = COLOR(213, 242, 255, 1);
//    _classL.font = [UIFont systemFontOfSize:10 *SIZE];
//    _classL.textAlignment = NSTextAlignmentCenter;
//    [self.contentView addSubview:_classL];
    
    _contentL = [[UILabel alloc] init];
    _contentL.textColor = YJContentLabColor;
    _contentL.font = [UIFont systemFontOfSize:11 *SIZE];
    _contentL.numberOfLines = 0;
    [self.contentView addSubview:_contentL];
    
    _averageL = [[UILabel alloc] init];
    _averageL.textColor = COLOR(255, 70, 70, 1);
    _averageL.font = [UIFont systemFontOfSize:13 *SIZE];
    _averageL.numberOfLines = 0;
    [self.contentView addSubview:_averageL];
    
    _codeL = [[UILabel alloc] init];
    _codeL.textColor = YJContentLabColor;
    _codeL.font = [UIFont systemFontOfSize:11 *SIZE];
    _codeL.numberOfLines = 0;
    [self.contentView addSubview:_codeL];
    
    _onSaleL = [[UILabel alloc] init];
    _onSaleL.textColor = YJBlueBtnColor;
    _onSaleL.textAlignment = NSTextAlignmentRight;
    _onSaleL.font = [UIFont systemFontOfSize:11 *SIZE];
    [self.contentView addSubview:_onSaleL];
    
    _attionL = [[UILabel alloc] init];
    _attionL.textColor = YJContentLabColor;
    _attionL.font = [UIFont systemFontOfSize:11 *SIZE];
    _attionL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_attionL];
    
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
    
//    [_classL mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.right.equalTo(self.contentView).offset(-10 *SIZE);
//        make.top.equalTo(self.contentView).offset(13 *SIZE);
//        make.width.mas_equalTo(33 *SIZE);
//        make.height.mas_equalTo(17 *SIZE);
//    }];
    
    [_contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(123 *SIZE);
        make.top.equalTo(_titleL.mas_bottom).offset(10 *SIZE);
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
    [_averageL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(123 *SIZE);
        make.top.equalTo(_contentL.mas_bottom).offset(10 *SIZE);
        make.right.equalTo(self.contentView).offset(-90 *SIZE);
    }];
    
    [_codeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(123 *SIZE);
        make.top.equalTo(_averageL.mas_bottom).offset(10 *SIZE);
        make.right.equalTo(self.contentView).offset(-120 *SIZE);
    }];
    
    [_onSaleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(280 *SIZE);
        make.top.equalTo(_contentL.mas_bottom).offset(11 *SIZE);
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
    [_attionL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(250 *SIZE);
        make.top.equalTo(_averageL.mas_bottom).offset(8 *SIZE);
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(_codeL.mas_bottom).offset(26 *SIZE);
        make.right.equalTo(self.contentView).offset(0 *SIZE);
        make.height.equalTo(@(SIZE));
        make.bottom.equalTo(self.contentView).offset(0);
    }];
    
}

@end
