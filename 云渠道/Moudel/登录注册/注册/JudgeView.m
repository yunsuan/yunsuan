//
//  JudgeView.m
//  云渠道
//
//  Created by 谷治墙 on 2018/6/1.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "JudgeView.h"

@implementation JudgeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionTagBtn:(UIButton *)btn{
    
    if (btn.tag == 0) {
        
        if (self.judgeExitBlock) {
            
            self.judgeExitBlock();
            [self removeFromSuperview];
        }
    }else{
        
        if (self.judgeNewBlock) {
            
            self.judgeNewBlock();
            [self removeFromSuperview];
        }
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if ([touches.anyObject.view isKindOfClass:[self class]]) {
        
        [self removeFromSuperview];
    }
}

- (void)initUI{
    
    UIView *alphaView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    alphaView.backgroundColor = [UIColor blackColor];
    alphaView.alpha = 0.4;
    [self addSubview:alphaView];
    
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0 *SIZE, SCREEN_Height - 100 *SIZE - TAB_BAR_MORE, SCREEN_Width, 100 *SIZE - TAB_BAR_MORE)];
    whiteView.backgroundColor = CH_COLOR_white;
    [self addSubview:whiteView];
    
    for (int i = 0; i < 2; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(50 *SIZE + i * 143 *SIZE, 30 *SIZE, 117 *SIZE, 40 *SIZE);
        btn.titleLabel.font = [UIFont systemFontOfSize:14 *sIZE];
        btn.tag = i;
        [btn addTarget:self action:@selector(ActionTagBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i == 0) {
            
            [btn setTitle:@"绑定已有账号" forState:UIControlStateNormal];
            [btn setTitleColor:YJBlueBtnColor forState:UIControlStateNormal];
            [btn setBackgroundColor:COLOR(213, 242, 255, 1)];
            _existBtn = btn;
            [whiteView addSubview:_existBtn];
        }else{
            
            [btn setTitle:@"绑定新账号" forState:UIControlStateNormal];
            [btn setBackgroundColor:YJBlueBtnColor];
            _unExistBtn = btn;
            [whiteView addSubview:_unExistBtn];
        }
    }
}

@end
