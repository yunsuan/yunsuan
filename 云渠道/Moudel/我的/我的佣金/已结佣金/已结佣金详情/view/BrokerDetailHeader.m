//
//  BrokerDetailHeader.m
//  云渠道
//
//  Created by 谷治墙 on 2018/3/29.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BrokerDetailHeader.h"

@implementation BrokerDetailHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionDropBtn:(UIButton *)btn{
    
//    _drop = !_drop;
//    if (self.dropBtnBlock) {
//
//        self.dropBtnBlock();
//    }
}

- (void)initUI{
    
    self.contentView.backgroundColor = CH_COLOR_white;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10 *SIZE, 19 *SIZE, 7 *SIZE, 13 *SIZE)];
    view.backgroundColor = YJBlueBtnColor;
    [self.contentView addSubview:view];
    
    _titleL = [[UILabel alloc] initWithFrame:CGRectMake(27 *SIZE, 19 *SIZE, 200 *SIZE, 14 *SIZE)];
    _titleL.textColor = YJTitleLabColor;
    _titleL.font = [UIFont systemFontOfSize:15 *SIZE];
    [self.contentView addSubview:_titleL];
    
//    _dropImg = [[UIImageView alloc] initWithFrame:CGRectMake(335 *SIZE, 23 *SIZE, 12 *SIZE, 12 *SIZE)];
//    if (_drop) {
//
//        _dropImg.image = [UIImage imageNamed:@"uparrow"];
//    }else{
//
//        _dropImg.image = [UIImage imageNamed:@"downarrow"];
//    }
//
////    _dropImg.image = [UIImage imageNamed:@"downarrow"];
//    [self.contentView addSubview:_dropImg];
//
//    _dropBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    _dropBtn.frame = CGRectMake(330 *SIZE, 18 *SIZE, 22 *SIZE, 22 *SIZE);
//    [_dropBtn addTarget:self action:@selector(ActionDropBtn:) forControlEvents:UIControlEventTouchUpInside];
//    [self.contentView addSubview:_dropBtn];
}

@end
