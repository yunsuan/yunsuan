//
//  TransmitView.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/10.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "TransmitView.h"

@implementation TransmitView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionTagBtn:(UIButton *)btn{
    
    if (self.transmitTagBtnBlock) {
        
        self.transmitTagBtnBlock(btn.tag);
    }
    [self removeFromSuperview];
}

- (void)ActionCancelBtn:(UIButton *)btn{
    
    [self removeFromSuperview];
}

- (void)initUI{
    
    NSArray *titleArr = @[@"QQ",@"QQ空间",@"微信",@"朋友圈"];
    NSArray *imgArr = @[@"qq",@"space",@"wechat",@"circleofFriends"];
    
    UIView *alphaView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    alphaView.backgroundColor = [UIColor blackColor];
    alphaView.alpha = 0.4;
    [self addSubview:alphaView];
    
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_Height - 167 *SIZE - TAB_BAR_MORE, SCREEN_Width, 167 *SIZE + TAB_BAR_MORE)];
    whiteView.backgroundColor = CH_COLOR_white;
    [self addSubview:whiteView];
    
    for (int i = 0; i < 4; i++) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40 *SIZE + i * 73 *SIZE, 88 *SIZE, 50 *SIZE, 13 *SIZE)];
        label.textColor = YJTitleLabColor;
        label.font = [UIFont systemFontOfSize:13 *sIZE];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = titleArr[i];
        [whiteView addSubview:label];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(40 *SIZE + i * 73 *SIZE, 28 *SIZE, 50 *SIZE, 71 *SIZE);
        [btn addTarget:self action:@selector(ActionTagBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
        [btn setImage:[UIImage imageNamed:imgArr[i]] forState:UIControlStateNormal];
        [whiteView addSubview:btn];
    }
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(0 *SIZE , 127 *sIZE, SCREEN_Width , 40 *SIZE + TAB_BAR_MORE);
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:13 *sIZE];
    [cancelBtn addTarget:self action:@selector(ActionCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setBackgroundColor:COLOR(238, 238, 238, 1)];
    [cancelBtn setTitleColor:YJContentLabColor forState:UIControlStateNormal];
    [whiteView addSubview:cancelBtn];
}

@end
