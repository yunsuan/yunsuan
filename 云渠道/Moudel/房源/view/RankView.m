//
//  RankView.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/26.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RankView.h"

@implementation RankView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    _rankL = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70 *SIZE, 10 *SIZE)];
    _rankL.textColor = YJContentLabColor;
    _rankL.font = [UIFont systemFontOfSize:11 *SIZE];
    [self addSubview:_rankL];
    
    [_rankL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self).offset(0);
        make.top.equalTo(self).offset(0);
        make.height.equalTo(@(10 *SIZE));
        make.width.equalTo(@(_rankL.mj_textWith + 5 *SIZE));
    }];
    
    _statusImg = [[UIImageView alloc] init];
    [self addSubview:_statusImg];
    
    [_statusImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_rankL.mas_right).offset(0);
        make.top.equalTo(self).offset(0);
        make.height.equalTo(@(12 *SIZE));
        make.width.equalTo(@(12));
    }];
}

@end
