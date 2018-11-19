//
//  ExperienceTableCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/3/30.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "ExperienceTableCell.h"

@implementation ExperienceTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    _upLine = [[UIView alloc] init];//WithFrame:CGRectMake(18 *SIZE, 0, SIZE, 14 *SIZE)];
    _upLine.backgroundColor = YJBlueBtnColor;
    [self.contentView addSubview:_upLine];
    
    _circleImg = [[UIImageView alloc] init];//WithFrame:CGRectMake(10 *SIZE, 14 *SIZE, 17 *SIZE, 17 *SIZE)];
    _circleImg.image = [UIImage imageNamed:@"bar_blue"];
    [self.contentView addSubview:_circleImg];
    
    _downLine = [[UIView alloc] init];//WithFrame:CGRectMake(18 *SIZE, 31 *SIZE, SIZE, 114 *SIZE)];
    _downLine.backgroundColor = YJBlueBtnColor;
    [self.contentView addSubview:_downLine];
    
    _companyL = [[UILabel alloc] init];//WithFrame:CGRectMake(210 *SIZE, 15 *SIZE, 140 *SIZE, 14 *SIZE)];
    _companyL.textColor = YJTitleLabColor;
    _companyL.preferredMaxLayoutWidth = 313 *SIZE;
    _companyL.font = [UIFont systemFontOfSize:15 *SIZE];
    _companyL.numberOfLines = 0;
//    _companyL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_companyL];
    
    _timeL = [[UILabel alloc] init];//WithFrame:CGRectMake(38 *SIZE, 16 *SIZE, 200 *SIZE, 12 *SIZE)];
    _timeL.preferredMaxLayoutWidth = 230 *SIZE;
    _timeL.textColor = YJBlueBtnColor;
    _timeL.numberOfLines = 0;
    _timeL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_timeL];
    
    _recommendL = [[UILabel alloc] init];//WithFrame:CGRectMake(38 *SIZE, 42 *SIZE, 150 *SIZE, 13 *SIZE)];
    _recommendL.textColor = COLOR(81, 81, 81, 1);
    _recommendL.font = [UIFont systemFontOfSize:11 *SIZE];
    [self.contentView addSubview:_recommendL];
    
    _visitL = [[UILabel alloc] init];//WithFrame:CGRectMake(38 *SIZE, 66 *SIZE, 150 *SIZE, 13 *SIZE)];
    _visitL.textColor = COLOR(81, 81, 81, 1);
    _visitL.font = [UIFont systemFontOfSize:11 *SIZE];
    [self.contentView addSubview:_visitL];
    
    _dealL = [[UILabel alloc] init];//WithFrame:CGRectMake(38 *SIZE, 91 *SIZE, 150 *SIZE, 13 *SIZE)];
    _dealL.textColor = COLOR(81, 81, 81, 1);
    _dealL.font = [UIFont systemFontOfSize:11 *SIZE];
    [self.contentView addSubview:_dealL];
    
    _roleL = [[UILabel alloc] init];//WithFrame:CGRectMake(200 *SIZE, 42 *SIZE, 150 *SIZE, 13 *SIZE)];
    _roleL.textColor = COLOR(81, 81, 81, 1);
    _roleL.font = [UIFont systemFontOfSize:12 *SIZE];
    _roleL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_roleL];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_upLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(18 *SIZE);
        make.top.equalTo(self.contentView).offset(0 *SIZE);
        make.width.mas_equalTo(SIZE);
        make.height.mas_equalTo(14 *SIZE);
    }];
    
    [_circleImg mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(14 *SIZE);
        make.width.height.mas_equalTo(17 *SIZE);
    }];
    
    [_downLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(18 *SIZE);
        make.top.equalTo(self.contentView).offset(0 *SIZE);
        make.width.mas_equalTo(SIZE);
        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
//        make.height.mas_equalTo(14 *SIZE);
    }];
    
    [_companyL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(37 *SIZE);
        make.top.equalTo(self.contentView).offset(14 *SIZE);
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(38 *SIZE);
        make.top.equalTo(_companyL.mas_bottom).offset(13 *SIZE);
        make.right.equalTo(self.contentView).offset(-90 *SIZE);
    }];
    
    [_roleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(37 *SIZE);
        make.top.equalTo(_companyL.mas_bottom).offset(14 *SIZE);
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
    [_recommendL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(37 *SIZE);
        make.top.equalTo(_timeL.mas_bottom).offset(12 *SIZE);
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
    [_visitL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(37 *SIZE);
        make.top.equalTo(_recommendL.mas_bottom).offset(11 *SIZE);
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
    [_dealL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(37 *SIZE);
        make.top.equalTo(_visitL.mas_bottom).offset(11 *SIZE);
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-26 *SIZE);
    }];
}

@end
