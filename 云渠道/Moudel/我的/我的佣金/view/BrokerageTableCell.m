//
//  BrokerageTableCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/3/29.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BrokerageTableCell.h"

@implementation BrokerageTableCell

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
    
    _backImg = [[UIImageView alloc] initWithFrame:CGRectMake(11 *SIZE, 6 *SIZE, 338 *SIZE, 138 *SIZE)];
    [self.contentView addSubview:_backImg];
    
    _numL = [[UILabel alloc] initWithFrame:CGRectMake(8 *SIZE, 69 *SIZE, 84 *SIZE, 18 *SIZE)];
    _numL.textColor = CH_COLOR_white;
    _numL.font = [UIFont systemFontOfSize:23 *SIZE];
    _numL.textAlignment = NSTextAlignmentCenter;
    [_backImg addSubview:_numL];
    
    _priceL = [[UILabel alloc] initWithFrame:CGRectMake(200 *SIZE, 69 *SIZE, 110 *SIZE, 18 *SIZE)];
    _priceL.textColor = CH_COLOR_white;
    _priceL.font = [UIFont systemFontOfSize:23 *SIZE];
    _priceL.textAlignment = NSTextAlignmentRight;
    [_backImg addSubview:_priceL];
    
    UILabel *numL = [[UILabel alloc] initWithFrame:CGRectMake(24 *SIZE, 98 *SIZE, 50 *SIZE, 11 *SIZE)];
    numL.textColor = CH_COLOR_white;
    numL.font = [UIFont systemFontOfSize:12 *SIZE];
    numL.text = @"条数";
    [_backImg addSubview:numL];
    
    UILabel *statusL = [[UILabel alloc] initWithFrame:CGRectMake(267 *SIZE, 98 *SIZE, 40 *SIZE, 11 *SIZE)];
    statusL.textColor = CH_COLOR_white;
    statusL.font = [UIFont systemFontOfSize:12 *SIZE];
    statusL.text = @"累计";
    [_backImg addSubview:statusL];
}
@end
