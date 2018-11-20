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
    
    _backView = [[UIImageView alloc] initWithFrame:CGRectMake(10 *SIZE, 8 *SIZE, 340 *SIZE, 83 *SIZE)];
    _backView.layer.cornerRadius = 3 *SIZE;
    _backView.clipsToBounds = YES;
    _backView.backgroundColor = CH_COLOR_white;
    [self.contentView addSubview:_backView];
    
    UIImageView *rightImg = [[UIImageView alloc] initWithFrame:CGRectMake(319 *SIZE, 17 *SIZE, 12 *SIZE, 12 *SIZE)];
    rightImg.image = [UIImage imageNamed:@"rightarrow"];
    [_backView addSubview:rightImg];
    
    _titleL = [[UILabel alloc] initWithFrame:CGRectMake(13 *SIZE, 17 *SIZE, 84 *SIZE, 18 *SIZE)];
    _titleL.textColor = YJTitleLabColor;
    _titleL.font = [UIFont boldSystemFontOfSize:15 *SIZE];
    [_backView addSubview:_titleL];
    
    _numL = [[UILabel alloc] initWithFrame:CGRectMake(12 *SIZE, 49 *SIZE, 84 *SIZE, 18 *SIZE)];
    _numL.textColor = YJ86Color;
    _numL.font = [UIFont systemFontOfSize:19 *SIZE];
    [_backView addSubview:_numL];
    
    _priceL = [[UILabel alloc] initWithFrame:CGRectMake(200 *SIZE, 49 *SIZE, 120 *SIZE, 18 *SIZE)];
    _priceL.textColor = COLOR(255, 99, 99, 1);
    _priceL.font = [UIFont systemFontOfSize:17 *SIZE];
    _priceL.textAlignment = NSTextAlignmentRight;
    [_backView addSubview:_priceL];

}
@end
