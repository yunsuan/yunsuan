//
//  AreaCustomCollHeader.m
//  云渠道
//
//  Created by 谷治墙 on 2019/12/8.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "AreaCustomCollHeader.h"

@implementation AreaCustomCollHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    _titleL = [[UILabel alloc]init];
    _titleL.textColor = YJTitleLabColor;
    _titleL.font = [UIFont boldSystemFontOfSize:13.3*SIZE];
    [self addSubview:_titleL];
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(10 *SIZE);
        make.top.equalTo(self).offset(16 *SIZE);
        make.width.mas_equalTo(200 *SIZE);
    }];
}

@end
