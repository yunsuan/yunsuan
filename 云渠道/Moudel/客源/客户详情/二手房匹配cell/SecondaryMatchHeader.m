//
//  SecondaryMatchHeader.m
//  云渠道
//
//  Created by 谷治墙 on 2019/1/27.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "SecondaryMatchHeader.h"

@implementation SecondaryMatchHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionMoreBtn:(UIButton *)btn{
    
    if (self.secondaryMatchHeaderMoreBlock) {
        
        self.secondaryMatchHeaderMoreBlock();
    }
}

- (void)initUI{
    
    self.contentView.backgroundColor = YJBackColor;
    
    _numListL = [[UILabel alloc] initWithFrame:CGRectMake(11 *SIZE, 26 *SIZE, 150 *SIZE, 16 *SIZE)];
    _numListL.textColor = YJTitleLabColor;
    _numListL.font = [UIFont systemFontOfSize:15 *SIZE];
    [self.contentView addSubview:_numListL];
    
    _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_moreBtn setTitle:@"查看全部 》" forState:UIControlStateNormal];
    _moreBtn.titleLabel.font = [UIFont systemFontOfSize:11 *SIZE];
    [_moreBtn setTitleColor:YJ170Color forState:UIControlStateNormal];
    _moreBtn.frame = CGRectMake(286 *SIZE, 21 *SIZE, 60 *SIZE, 26 *SIZE);
    [_moreBtn addTarget:self action:@selector(ActionMoreBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_moreBtn];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 67 *SIZE, SCREEN_Width, SIZE)];
    line2.backgroundColor = YJBackColor;
    
    [self.contentView addSubview:line2];
}

@end
