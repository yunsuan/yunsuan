//
//  HouseTypeTableHeader2.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/4.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "HouseTypeTableHeader2.h"

@implementation HouseTypeTableHeader2

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionMoreBtn:(UIButton *)btn{
    
    if (self.houseTypeTableHeader2Block) {
        
        self.houseTypeTableHeader2Block();
    }
}

- (void)initUI{
    
    self.contentView.backgroundColor = CH_COLOR_white;
    
    _titleL = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 10 *SIZE, 200 *SIZE, 14 *SIZE)];
    _titleL.textColor = YJTitleLabColor;
    _titleL.font = [UIFont systemFontOfSize:15 *SIZE];
    [self.contentView addSubview:_titleL];
    
    _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _moreBtn.frame = CGRectMake(287 *SIZE, 7 *SIZE, 65 *SIZE, 20 *SIZE);
    _moreBtn.titleLabel.font = [UIFont systemFontOfSize:11 *sIZE];
    [_moreBtn addTarget:self action:@selector(ActionMoreBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_moreBtn setTitle:@"查看更多 >>" forState:UIControlStateNormal];
    [_moreBtn setTitleColor:YJContentLabColor forState:UIControlStateNormal];
    [self.contentView addSubview:_moreBtn];
}

@end
