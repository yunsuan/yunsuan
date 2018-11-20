//
//  BrokerageDetailTableCell4.m
//  云渠道
//
//  Created by 谷治墙 on 2018/3/29.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BrokerageDetailTableCell4.h"

@implementation BrokerageDetailTableCell4

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    _declareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _declareBtn.titleLabel.font = [UIFont systemFontOfSize:13 *sIZE];
//    [<#UIButton#> addTarget:self action:@selector(<#selector#>) forControlEvents:UIControlEventTouchUpInside];
    [_declareBtn setTitle:@"佣金有误，我要申诉？" forState:UIControlStateNormal];
    [_declareBtn setTitleColor:YJContentLabColor forState:UIControlStateNormal];
    [self.contentView addSubview:_declareBtn];
    
    [_declareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(219 *SIZE);
        make.top.equalTo(self.contentView).offset(0);
        make.width.equalTo(@(136 *SIZE));
        make.bottom.equalTo(self.contentView).offset(-23 *SIZE);
        make.height.equalTo(@(23 *SIZE));
    }];
}

@end
