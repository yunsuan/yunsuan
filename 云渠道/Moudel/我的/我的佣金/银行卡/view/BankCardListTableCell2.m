//
//  BankCardListTableCell2.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/17.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BankCardListTableCell2.h"

@implementation BankCardListTableCell2

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    _addImg = [[UIImageView alloc] initWithFrame:CGRectMake(150 *SIZE, 43.5 *SIZE, 60 *SIZE, 60 *SIZE)];
    _addImg.contentMode = UIViewContentModeCenter;
    _addImg.image = [UIImage imageNamed:@"add_3"];
    [self.contentView addSubview:_addImg];
}

@end
