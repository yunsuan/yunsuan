//
//  AreaCustomColl.m
//  云渠道
//
//  Created by 谷治墙 on 2019/12/8.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "AreaCustomColl.h"

@implementation AreaCustomColl

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
    _titleL.font = [UIFont systemFontOfSize:13*SIZE];
    [self addSubview:_titleL];
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(0 *SIZE);
        make.top.equalTo(self).offset(5 *SIZE);
        make.width.mas_equalTo(140 *SIZE);
    }];
    
    _bigImg = [[UIImageView alloc] initWithFrame:CGRectMake(0 *SIZE, 30 *SIZE, 140 *SIZE, 100 *SIZE)];
    _bigImg.contentMode = UIViewContentModeScaleAspectFill;
    _bigImg.clipsToBounds = YES;
    _bigImg.image = [UIImage imageNamed:@"banner_default_2"];
    [self.contentView addSubview:_bigImg];
}

@end
