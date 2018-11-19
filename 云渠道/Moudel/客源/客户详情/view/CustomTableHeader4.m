//
//  CustomTableHeader4.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/2.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "CustomTableHeader4.h"

@implementation CustomTableHeader4

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionShowBtn:(UIButton *)btn{
    
    if (self.showBtnBlock) {
        
        self.showBtnBlock(btn.tag);
    }
}

- (void)initUI{
    
    self.contentView.backgroundColor = YJBackColor;
    
    UIImageView *houseImg = [[UIImageView alloc] initWithFrame:CGRectMake(10 *SIZE, 13 *SIZE, 16 *SIZE, 16 *SIZE)];
    houseImg.image = [UIImage imageNamed:@"residential"];
    [self.contentView addSubview:houseImg];
    
    _typeL = [[UILabel alloc] initWithFrame:CGRectMake(40 *SIZE, 14 *SIZE, 200 *SIZE, 13 *SIZE)];
    _typeL.textColor = YJTitleLabColor;
    _typeL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_typeL];
    
    _showBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _showBtn.frame = CGRectMake(331 *SIZE, 14 *SIZE, 12 *SIZE, 12 *SIZE);
//    _showBtn.backgroundColor = YJGreenColor;
    [_showBtn setImage:[UIImage imageNamed:@"downarrow"] forState:UIControlStateNormal];
    [_showBtn addTarget:self action:@selector(ActionShowBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_showBtn];
//    [<#UIButton#> setTitleColor:COLOR(<#_R#>, <#_G#>, <#_B#>, <#_A#>) forState:UIControlStateNormal];
}

@end
