//
//  BankCardListTableCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/3/21.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BankCardListTableCell.h"

@implementation BankCardListTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    _backImg = [[UIImageView alloc] initWithFrame:CGRectMake(10 *SIZE, 15 *SIZE, 340 *SIZE, 117 *SIZE)];
    _backImg.layer.cornerRadius = 3 *SIZE;
    _backImg.clipsToBounds = YES;
    _backImg.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_backImg];
    
    _logoImg = [[UIImageView alloc] initWithFrame:CGRectMake(23 *SIZE, 31 *SIZE, 28 *SIZE, 28 *SIZE)];
    _logoImg.layer.cornerRadius = 14 *SIZE;
    _logoImg.clipsToBounds = YES;
    _logoImg.backgroundColor = YJBackColor;
//    [self.contentView addSubview:_logoImg];
    
    _bankL = [[UILabel alloc] initWithFrame:CGRectMake(68 *SIZE,  38*SIZE, 280 *SIZE, 14 *SIZE)];
    _bankL.textColor = CH_COLOR_white;
    _bankL.font = [UIFont systemFontOfSize:15 *SIZE];
//    _bankL.text = @"中国建设银行";
    [self.contentView addSubview:_bankL];
    
    _typeL = [[UILabel alloc] initWithFrame:CGRectMake(68 *SIZE, 60 *SIZE, 200 *SIZE, 11 *SIZE)];
    _typeL.textColor = CH_COLOR_white;
    _typeL.font = [UIFont systemFontOfSize:12 *SIZE];
//    _typeL.text = @"储蓄卡";
    [self.contentView addSubview:_typeL];
    
    _accL = [[UILabel alloc] initWithFrame:CGRectMake(68 *SIZE, 80 *SIZE, 200 *SIZE, 14 *SIZE)];
    _accL.textColor = CH_COLOR_white;
    _accL.font = [UIFont systemFontOfSize:15 *SIZE];
//    _accL.text = @"****   ****   ****   3956";
    [self.contentView addSubview:_accL];
}

@end
