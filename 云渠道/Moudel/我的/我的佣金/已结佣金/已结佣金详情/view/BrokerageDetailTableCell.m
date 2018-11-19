//
//  BrokerageDetailTableCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/3/29.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BrokerageDetailTableCell.h"

@implementation BrokerageDetailTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10 *SIZE, 19 *SIZE, 7 *SIZE, 13 *SIZE)];
    view.backgroundColor = YJBlueBtnColor;
    [self.contentView addSubview:view];
    
    _titleL = [[UILabel alloc] initWithFrame:CGRectMake(27 *SIZE, 19 *SIZE, 200 *SIZE, 14 *SIZE)];
    _titleL.textColor = YJTitleLabColor;
    _titleL.font = [UIFont systemFontOfSize:15 *SIZE];
    [self.contentView addSubview:_titleL];
    
    
    _numL =[[UILabel alloc] init];
    _numL.textColor = YJContentLabColor;
    _numL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_numL];;
    
    _pushtimeL =[[UILabel alloc] init];
    _pushtimeL.textColor = YJContentLabColor;
    _pushtimeL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_pushtimeL];;
    
    _projectnameL =[[UILabel alloc] init];
    _projectnameL.textColor = YJContentLabColor;
    _projectnameL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_projectnameL];;
    
    _adressL =[[UILabel alloc] init];
    _adressL.textColor = YJContentLabColor;
    _adressL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_adressL];;
    
    _nameL = [[UILabel alloc] init];
    _nameL.textColor = YJContentLabColor;
    _nameL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_nameL];
    
    _genderL = [[UILabel alloc] init];
    _genderL.textColor = YJContentLabColor;
    _genderL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_genderL];
    
    _phoneL = [[UILabel alloc] init];
    _phoneL.textColor = YJContentLabColor;
    _phoneL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_phoneL];
    
    [self masonryUI];
}

- (void)masonryUI{
    
    [_numL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(self.contentView).offset(55 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
        make.bottom.equalTo(_pushtimeL.mas_top).offset(-17 *SIZE);
    }];
    
    [_pushtimeL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_numL.mas_bottom).offset(17 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
        make.bottom.equalTo(_projectnameL.mas_top).offset(-17 *SIZE);
    }];
    
    [_projectnameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_pushtimeL.mas_bottom).offset(17 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
        make.bottom.equalTo(_adressL.mas_top).offset(-17 *SIZE);
    }];
    
    [_adressL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_projectnameL.mas_bottom).offset(17 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
        make.bottom.equalTo(_nameL.mas_top).offset(-17 *SIZE);
    }];
    
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_adressL.mas_bottom).offset(17 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
        make.bottom.equalTo(_genderL.mas_top).offset(-17 *SIZE);
    }];
    
    [_genderL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_nameL.mas_bottom).offset(17 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
        make.bottom.equalTo(_phoneL.mas_top).offset(-17 *SIZE);
    }];
    
    [_phoneL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_genderL.mas_bottom).offset(17 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-26 *SIZE);
    }];
}

@end
