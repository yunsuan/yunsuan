//
//  BrokerageCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/3/29.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BrokerageCell.h"

@implementation BrokerageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    _nameL = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 13 *SIZE, 60 *SIZE, 14 *SIZE)];
    _nameL.textColor = YJTitleLabColor;
    _nameL.font = [UIFont systemFontOfSize:15 *SIZE];
    [self.contentView addSubview:_nameL];
    
    _phoneL = [[UILabel alloc] initWithFrame:CGRectMake(75 *SIZE, 16 *SIZE, 100 *SIZE, 10 *SIZE)];
    _phoneL.textColor = YJContentLabColor;
    _phoneL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_phoneL];
    
    _unitL = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 38 *SIZE, 230 *SIZE, 14 *SIZE)];
    _unitL.textColor = YJTitleLabColor;
    _unitL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_unitL];
    
    _priceL = [[UILabel alloc] initWithFrame:CGRectMake(250 *SIZE, 38 *SIZE, 100 *SIZE, 14 *SIZE)];
    _priceL.textColor = COLOR(255, 70, 70, 1);
    _priceL.font = [UIFont systemFontOfSize:13 *SIZE];
    _priceL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_priceL];
    
    _codeL = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 62 *SIZE, 200 *SIZE, 11 *SIZE)];
    _codeL.textColor = YJTitleLabColor;
    _codeL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_codeL];
    
    _typeL = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 85 *SIZE, 100 *SIZE, 11 *SIZE)];
    _typeL.textColor = YJTitleLabColor;
    _typeL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_typeL];
    
    _timeL = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 109 *SIZE, 200 *SIZE, 11 *SIZE)];
    _timeL.textColor = COLOR(86, 86, 86, 1);
    _timeL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_timeL];
    
    _endTimeL = [[UILabel alloc] initWithFrame:CGRectMake(190 *SIZE, 109 *SIZE, 155 *SIZE, 11 *SIZE)];
    _endTimeL.textColor = COLOR(86, 86, 86, 1);
    _endTimeL.font = [UIFont systemFontOfSize:12 *SIZE];
    _endTimeL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_endTimeL];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 133 *SIZE, SCREEN_Width, SIZE)];
    line.backgroundColor = YJBackColor;
    [self.contentView addSubview:line];
}

@end
