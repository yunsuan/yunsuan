//
//  SecAllRoomCollCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/9/28.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "SecAllRoomCollCell.h"

@implementation SecAllRoomCollCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    self.contentView.backgroundColor = CH_COLOR_white;
    
    _typeImg = [[UIImageView alloc] initWithFrame:CGRectMake(10 *SIZE, 18 *SIZE, 103 *SIZE, 103 *SIZE)];
    _typeImg.contentMode = UIViewContentModeScaleAspectFill;
    _typeImg.clipsToBounds = YES;
    [self.contentView addSubview:_typeImg];
    
    _nameL = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 134 *SIZE, 100 *SIZE, 11 *SIZE)];
    _nameL.textColor = YJTitleLabColor;
    _nameL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_nameL];
    
    _priceL = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 150 *SIZE, 100 *SIZE, 12 *SIZE)];
    _priceL.textColor = YJBlueBtnColor;
    _priceL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_priceL];
    
    _areaL = [[UILabel alloc] initWithFrame:CGRectMake(11 *SIZE, 167 *SIZE, 70 *SIZE, 12 *SIZE)];
    _areaL.textColor = YJTitleLabColor;
    _areaL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_areaL];
    
}

@end
