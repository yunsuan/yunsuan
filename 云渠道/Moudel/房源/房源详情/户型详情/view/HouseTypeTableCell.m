//
//  HouseTypeTableCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/4.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "HouseTypeTableCell.h"

@implementation HouseTypeTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    _typeL = [[UILabel alloc] initWithFrame:CGRectMake(9 *SIZE, 11 *SIZE, 200 *SIZE, 12 *SIZE)];
    _typeL.textColor = YJTitleLabColor;
    _typeL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_typeL];
    
    _areaL = [[UILabel alloc] initWithFrame:CGRectMake(9 *SIZE, 36 *SIZE, 300 *SIZE, 12 *SIZE)];
    _areaL.textColor = YJContentLabColor;
    _areaL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_areaL];
    
    _houseDisL = [[UILabel alloc] initWithFrame:CGRectMake(9 *SIZE, 60 *SIZE, 300 *SIZE, 12 *SIZE)];
    _houseDisL.textColor = YJContentLabColor;
    _houseDisL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_houseDisL];
    
    _titleL = [[UILabel alloc] initWithFrame:CGRectMake(9 *SIZE, 93 *SIZE, 300 *SIZE, 14 *SIZE)];
    _titleL.textColor = YJTitleLabColor;
    _titleL.font = [UIFont systemFontOfSize:15 *SIZE];
    [self.contentView addSubview:_titleL];
    
    _contentL = [[UILabel alloc] init];
    _contentL.numberOfLines = 0;
    _contentL.textColor = YJContentLabColor;
    _contentL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_contentL];
    
    [self masonryUI];
}

- (void)masonryUI{
    
    [_contentL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(11 *SIZE);
        make.top.equalTo(self.contentView).offset(120 *SIZE);
        make.right.equalTo(self.contentView).offset(-16 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-23 *SIZE);
    }];
}

@end
