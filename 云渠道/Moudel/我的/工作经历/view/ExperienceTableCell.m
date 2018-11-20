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
    
    _upLine = [[UIView alloc] initWithFrame:CGRectMake(18 *SIZE, 0, SIZE, 14 *SIZE)];
    _upLine.backgroundColor = YJBlueBtnColor;
    [self.contentView addSubview:_upLine];
    
    _circleImg = [[UIImageView alloc] initWithFrame:CGRectMake(10 *SIZE, 14 *SIZE, 17 *SIZE, 17 *SIZE)];
    _circleImg.image = [UIImage imageNamed:@"bar_blue"];
    [self.contentView addSubview:_circleImg];
    
    _downLine = [[UIView alloc] initWithFrame:CGRectMake(18 *SIZE, 31 *SIZE, SIZE, 114 *SIZE)];
    _downLine.backgroundColor = YJBlueBtnColor;
    [self.contentView addSubview:_downLine];
    
    _companyL = [[UILabel alloc] initWithFrame:CGRectMake(210 *SIZE, 15 *SIZE, 140 *SIZE, 14 *SIZE)];
    _companyL.textColor = YJTitleLabColor;
    _companyL.font = [UIFont systemFontOfSize:15 *SIZE];
    _companyL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_companyL];
    
    _timeL = [[UILabel alloc] initWithFrame:CGRectMake(38 *SIZE, 16 *SIZE, 200 *SIZE, 12 *SIZE)];
    _timeL.textColor = YJTitleLabColor;
    _timeL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_timeL];
    
    _recommendL = [[UILabel alloc] initWithFrame:CGRectMake(38 *SIZE, 42 *SIZE, 150 *SIZE, 13 *SIZE)];
    _recommendL.textColor = COLOR(81, 81, 81, 1);
    _recommendL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_recommendL];
    
    
    _visitL = [[UILabel alloc] initWithFrame:CGRectMake(38 *SIZE, 66 *SIZE, 150 *SIZE, 13 *SIZE)];
    _visitL.textColor = COLOR(81, 81, 81, 1);
    _visitL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_visitL];
    
    _dealL = [[UILabel alloc] initWithFrame:CGRectMake(38 *SIZE, 91 *SIZE, 150 *SIZE, 13 *SIZE)];
    _dealL.textColor = COLOR(81, 81, 81, 1);
    _dealL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_dealL];
    
    _roleL = [[UILabel alloc] initWithFrame:CGRectMake(200 *SIZE, 42 *SIZE, 150 *SIZE, 13 *SIZE)];
    _roleL.textColor = COLOR(81, 81, 81, 1);
    _roleL.font = [UIFont systemFontOfSize:13 *SIZE];
    _roleL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_roleL];
}

@end
