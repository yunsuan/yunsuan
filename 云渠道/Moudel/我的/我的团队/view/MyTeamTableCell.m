//
//  MyTeamTableCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/8/14.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "MyTeamTableCell.h"

@implementation MyTeamTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    self.contentView.backgroundColor = YJBackColor;
    
    _backView = [[UIView alloc] init];
    _backView.backgroundColor = CH_COLOR_white;
    _backView.layer.cornerRadius = 3 *SIZE;
    _backView.clipsToBounds = YES;
    [self.contentView addSubview:_backView];
    
    _headImg = [[UIImageView alloc] init];
    _headImg.layer.cornerRadius = 20 *SIZE;
    _headImg.clipsToBounds = YES;
    [_backView addSubview:_headImg];

    
    _nameL = [[UILabel alloc] init];
    _nameL.textColor = YJTitleLabColor;
    _nameL.font = [UIFont systemFontOfSize:13 *SIZE];
    [_backView addSubview:_nameL];
    
    _genderImg = [[UIImageView alloc] init];
    [_backView addSubview:_genderImg];
    
    _levelL = [[UILabel alloc] init];
    _levelL.textColor = YJContentLabColor;
    _levelL.font = [UIFont systemFontOfSize:12 *SIZE];
    [_backView addSubview:_levelL];
    
    _timeL = [[UILabel alloc] init];
    _timeL.textColor = YJContentLabColor;
    _timeL.textAlignment = NSTextAlignmentRight;
    _timeL.font = [UIFont systemFontOfSize:12 *SIZE];
    [_backView addSubview:_timeL];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
        make.top.equalTo(self.contentView).offset(0 *SIZE);
        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
        make.height.mas_equalTo(67 *SIZE);
    }];
    
    [_headImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_backView).offset(12 *SIZE);
        make.top.equalTo(_backView).offset(13 *SIZE);
        make.width.mas_equalTo(40 *SIZE);
        make.height.mas_equalTo(40 *SIZE);
    }];
    
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_headImg.mas_right).offset(11 *SIZE);
        make.top.equalTo(_backView).offset(16 *SIZE);
        make.width.mas_equalTo(_nameL.mj_textWith + 5 *SIZE);
    }];
    
    [_genderImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_nameL.mas_right).offset(4 *SIZE);
        make.top.equalTo(_backView).offset(16 *SIZE);
        make.width.height.mas_equalTo(12 *SIZE);
    }];
    
    
    [_levelL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_headImg.mas_right).offset(11 *SIZE);
        make.top.equalTo(_backView).offset(39 *SIZE);
        make.right.equalTo(_backView).offset(-100 *SIZE);
    }];
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_backView).offset(180 *SIZE);
        make.top.equalTo(_backView).offset(18 *SIZE);
        make.right.equalTo(_backView).offset(-12 *SIZE);
    }];
}

@end
