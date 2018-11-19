//
//  RoomBrokerageTableCell2.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/23.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RoomBrokerageTableCell2.h"

@implementation RoomBrokerageTableCell2

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
    
    _ruleView = [[RuleView alloc] initWithFrame:CGRectMake(0, 0 *SIZE, SCREEN_Width, 40 *SIZE)];
    [self.contentView addSubview:_ruleView];
    [_ruleView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0);
        make.right.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.contentView).offset(0 *SIZE);
    }];
    
    _standView = [[RuleView alloc] initWithFrame:CGRectMake(0, 48 *SIZE, SCREEN_Width, 40 *SIZE)];
    [self.contentView addSubview:_standView];
    [_standView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0);
        make.right.equalTo(self.contentView).offset(0);
        make.top.equalTo(_ruleView.mas_bottom).offset(8 *SIZE);
        make.bottom.equalTo(self.contentView).offset(0);
    }];
}

@end
