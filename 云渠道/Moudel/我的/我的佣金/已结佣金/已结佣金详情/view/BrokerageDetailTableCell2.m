//
//  BrokerageDetailTableCell2.m
//  云渠道
//
//  Created by 谷治墙 on 2018/3/29.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BrokerageDetailTableCell2.h"

@implementation BrokerageDetailTableCell2

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
    
    _typeL = [[UILabel alloc] init];
    _typeL.textColor = YJContentLabColor;
    _typeL.numberOfLines = 0;
    _typeL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_typeL];
    
    _moneyL = [[UILabel alloc] init];
    _moneyL.textColor = YJContentLabColor;
    _moneyL.numberOfLines = 0;
    _moneyL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_moneyL];
    
    _numL = [[UILabel alloc] init];
    _numL.textColor = YJContentLabColor;
    _numL.numberOfLines = 0;
    _numL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_numL];
    
    _tmoneyL = [[UILabel alloc] init];
    _tmoneyL.textColor = YJContentLabColor;
    _tmoneyL.numberOfLines = 0;
    _tmoneyL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_tmoneyL];
    
    _areaL = [[UILabel alloc] init];
    _areaL.textColor = YJContentLabColor;
    _areaL.numberOfLines = 0;
    _areaL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_areaL];
    
    _statuL = [[UILabel alloc] init];
    _statuL.textColor = YJContentLabColor;
    _statuL.numberOfLines = 0;
    _statuL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_statuL];
    
    _timeL = [[UILabel alloc] init];
    _timeL.textColor = YJContentLabColor;
    _timeL.numberOfLines = 0;
    _timeL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_timeL];
    
    _propertyL = [[UILabel alloc] init];
    _propertyL.textColor = YJContentLabColor;
    _propertyL.numberOfLines = 0;
    _propertyL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_propertyL];

    _ruleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    _ruleBtn.frame = CGRectMake(259 *SIZE, 262 *SIZE, 94 *SIZE, 23 *SIZE);
    _ruleBtn.titleLabel.font = [UIFont systemFontOfSize:13 *sIZE];
    [_ruleBtn setTitle:@"查看佣金规则!" forState:UIControlStateNormal];
    [_ruleBtn setTitleColor:YJBlueBtnColor forState:UIControlStateNormal];
    [self.contentView addSubview:_ruleBtn];
    
    _statusImg = [[UIImageView alloc] init];
    [self.contentView addSubview:_statusImg];
    
    [self masonryUI];
}

- (void)masonryUI{
    
    [_typeL mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(self.contentView).offset(55 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
        make.bottom.equalTo(_moneyL.mas_top).offset(-17 *SIZE);
    }];

    [_moneyL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_typeL.mas_bottom).offset(17 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
        make.bottom.equalTo(_propertyL.mas_top).offset(-17 *SIZE);
    }];
    
    [_propertyL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_moneyL.mas_bottom).offset(17 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
        make.bottom.equalTo(_numL.mas_top).offset(-17 *SIZE);
    }];
    
    [_numL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_propertyL.mas_bottom).offset(17 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
        make.bottom.equalTo(_tmoneyL.mas_top).offset(-17 *SIZE);
    }];
    [_tmoneyL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_numL.mas_bottom).offset(17 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
        make.bottom.equalTo(_areaL.mas_top).offset(-17 *SIZE);
    }];
    [_areaL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_tmoneyL.mas_bottom).offset(17 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
        make.bottom.equalTo(_statuL.mas_top).offset(-17 *SIZE);
    }];
    [_statuL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_areaL.mas_bottom).offset(17 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
        make.bottom.equalTo(_timeL.mas_top).offset(-17 *SIZE);
    }];

    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_statuL.mas_bottom).offset(17 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-26 *SIZE);
    }];
    
    [_ruleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(259 *SIZE);
        make.top.equalTo(_titleL.mas_bottom).offset(0 *SIZE);
        make.width.equalTo(@(94 *SIZE));
        make.height.equalTo(@(23 *SIZE));
    }];
    
    [_statusImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(271 *SIZE);
        make.top.equalTo(_titleL.mas_bottom).offset(30 *SIZE);
        make.width.height.equalTo(@(75 *SIZE));
//        make.height.equalTo(@(23 *SIZE));
    }];
}

@end
