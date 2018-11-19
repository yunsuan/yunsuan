//
//  RoomDetailTableHeader5.m
//  云渠道
//
//  Created by 谷治墙 on 2018/3/28.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RoomDetailTableHeader5.h"

@implementation RoomDetailTableHeader5

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionMoreBtn:(UIButton *)btn{
    
    if (self.moreBtnBlock) {
        
        self.moreBtnBlock();
    }
}

- (void)initUI{
    
    self.contentView.backgroundColor = CH_COLOR_white;
    
    _numL = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 10 *SIZE, 200 *SIZE, 14 *SIZE)];
    _numL.textColor = YJTitleLabColor;
    _numL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_numL];
    
    _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _moreBtn.frame = CGRectMake(287 *SIZE, 7 *SIZE, 65 *SIZE, 20 *SIZE);
    _moreBtn.titleLabel.font = [UIFont systemFontOfSize:11 *sIZE];
    [_moreBtn addTarget:self action:@selector(ActionMoreBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_moreBtn setTitle:@"查看更多 >>" forState:UIControlStateNormal];
    [_moreBtn setTitleColor:YJContentLabColor forState:UIControlStateNormal];
    [self.contentView addSubview:_moreBtn];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 31 *SIZE, SCREEN_Width, 2 *SIZE)];
    line.backgroundColor = YJBackColor;
    [self.contentView addSubview:line];
}

@end
