//
//  CustomTableAddHeader.m
//  云渠道
//
//  Created by 谷治墙 on 2018/10/8.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "CustomTableAddHeader.h"

@implementation CustomTableAddHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionAddBtn:(UIButton *)btn{
    
    if (self.customTableAddHeaderBlock) {
        
        self.customTableAddHeaderBlock();
    }
}

- (void)initUI{
    
    _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _addBtn.frame = CGRectMake(0, 0, SCREEN_Width, 40 *SIZE);
    _addBtn.titleLabel.font = [UIFont systemFontOfSize:14 *sIZE];
    [_addBtn addTarget:self action:@selector(ActionAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_addBtn setImage:[UIImage imageNamed:@"add_follow"] forState:UIControlStateNormal];
    [self.contentView addSubview:_addBtn];
}

@end
