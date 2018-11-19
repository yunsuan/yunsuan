//
//  CustomDetailTableCell5.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/19.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "CustomDetailTableCell5.h"

@implementation CustomDetailTableCell5

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    _contentL = [[UILabel alloc] init];
    _contentL.textColor = YJ86Color;
    _contentL.font = [UIFont systemFontOfSize:12 *SIZE];
    _contentL.numberOfLines = 0;
    [self.contentView addSubview:_contentL];
    
    [_contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(self.contentView).offset(17 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-17 *SIZE);
    }];
}

@end
