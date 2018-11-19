//
//  CompleteInfoCollHeader.m
//  云渠道
//
//  Created by 谷治墙 on 2018/6/22.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "CompleteInfoCollHeader.h"

@implementation CompleteInfoCollHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    _blueView = [[UIView alloc] init];
    _blueView.backgroundColor = YJBlueBtnColor;
    [self addSubview:_blueView];
    
    _titleL = [[UILabel alloc] init];
    _titleL.textColor = YJTitleLabColor;
    _titleL.font = [UIFont systemFontOfSize:15 *SIZE];
    [self addSubview:_titleL];
    
    _contentL = [[UILabel alloc] init];
    _contentL.textColor = YJContentLabColor;
    _contentL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self addSubview:_contentL];
    
    [_blueView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self).offset(11 *SIZE);
        make.top.equalTo(self).offset(13 *SIZE);
        make.width.mas_equalTo(7 *SIZE);
        make.height.mas_equalTo(13 *SIZE);
    }];
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(29 *SIZE);
        make.top.equalTo(self).offset(13 *SIZE);
        make.right.equalTo(self).offset(-29 *SIZE);
    }];
    
    [_contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(29 *SIZE);
        make.top.equalTo(_titleL.mas_bottom).offset(15 *SIZE);
        make.right.equalTo(self).offset(-29 *SIZE);
        make.bottom.equalTo(self).offset(-27 *SIZE);
    }];
}
@end
