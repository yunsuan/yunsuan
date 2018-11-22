//
//  RoomCellCollCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/3/27.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RoomCellCollCell.h"

@implementation RoomCellCollCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    _typeImg = [[UIImageView alloc] initWithFrame:CGRectMake(10 *SIZE, 18 *SIZE, 103 *SIZE, 103 *SIZE)];
    _typeImg.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_typeImg];
    
    _letterL = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 134 *SIZE, 100 *SIZE, 11 *SIZE)];
    _letterL.textColor = YJTitleLabColor;
    _letterL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_letterL];
    
    _areaL = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 150 *SIZE, 100 *SIZE, 11 *SIZE)];
    _areaL.textColor = YJTitleLabColor;
    _areaL.font = [UIFont systemFontOfSize:12 *SIZE];
    //    _areaL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_areaL];
    
    _typeL = [[UILabel alloc] initWithFrame:CGRectMake(11 *SIZE, 167 *SIZE, 70 *SIZE, 11 *SIZE)];
    _typeL.textColor = YJTitleLabColor;
    _typeL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_typeL];
    
    _statusL = [[UILabel alloc] initWithFrame:CGRectMake(11 *SIZE, 190 *SIZE, 70 *SIZE, 11 *SIZE)];
    _statusL.textColor = COLOR(27, 152, 255, 1);
    _statusL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_statusL];
}

@end
