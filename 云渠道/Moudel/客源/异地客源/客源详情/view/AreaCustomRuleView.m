//
//  AreaCustomRuleView.m
//  云渠道
//
//  Created by 谷治墙 on 2019/12/9.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "AreaCustomRuleView.h"

@implementation AreaCustomRuleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self removeFromSuperview];
}

- (void)initUI{
    
    UIView *alphaView = [[UIView alloc] initWithFrame:self.bounds];
    alphaView.backgroundColor = [UIColor blackColor];
    alphaView.alpha = 0.4;
    [self addSubview:alphaView];
    
    _scroll = [[UIScrollView alloc] init];
    [self addSubview:_scroll];
    
    _whiteView = [[UIView alloc] init];
    _whiteView.backgroundColor = CLWhiteColor;
    [self addSubview:_whiteView];
    
    _ruleL = [[UILabel alloc] init];
    _ruleL.textColor = YJTitleLabColor;
//    _ruleL.backgroundColor = CLWhiteColor;
    _ruleL.numberOfLines = 0;
    _ruleL.adjustsFontSizeToFitWidth = YES;
    _ruleL.font = [UIFont systemFontOfSize:13 *SIZE];
    [_whiteView addSubview:_ruleL];
    
    [_scroll mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self).offset(10 *SIZE);
        make.top.equalTo(self).offset(10 *SIZE);
        make.width.mas_equalTo(340 *SIZE);
        make.height.mas_equalTo(self.bounds.size.height - 20 *SIZE);
    }];
    
    [_whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.width.mas_equalTo(340 *SIZE);
        make.center.mas_equalTo(_scroll.center).priority(250);;
        make.top.equalTo(_scroll).mas_offset(50 *SIZE);
        make.bottom.equalTo(_scroll.mas_bottom).mas_offset(-50 *SIZE);
    }];
    
    [_ruleL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.width.mas_equalTo(300 *SIZE);
//        make.center.mas_equalTo(_whiteView.center);
        make.left.equalTo(_whiteView).offset(10 *SIZE);
        make.top.equalTo(_whiteView).offset(40 *SIZE);
        make.bottom.equalTo(_whiteView.mas_bottom).offset(-40 *SIZE).priority(300);;
    }];
}

@end
