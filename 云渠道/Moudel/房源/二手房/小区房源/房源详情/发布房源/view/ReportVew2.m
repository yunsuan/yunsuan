//
//  ReportVew2.m
//  云渠道
//
//  Created by 谷治墙 on 2018/6/12.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "ReportVew2.h"

@implementation ReportVew2

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionTagBtn:(UIButton *)btn{
    
    if (btn.tag == 1) {
        
        _otherBtn.selected = YES;
        _timeL.hidden = YES;
        _selfBtn.selected = NO;
        _timeBtn.hidden = YES;
    }else{
        
        _otherBtn.selected = NO;
        _selfBtn.selected = YES;
        _timeBtn.hidden = NO;
        _timeL.hidden = NO;
    }
}

- (void)ActionTimeBtn:(UIButton *)btn{
    
    if (self.reportTimeBlock) {
        
        self.reportTimeBlock();
    }
}

- (void)initUI{
    
    self.backgroundColor = CH_COLOR_white;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(9 *SIZE, 20 *SIZE, 100 *SIZE, 11 *SIZE)];
    label.textColor = YJTitleLabColor;
    label.font = [UIFont systemFontOfSize:12 *SIZE];
    label.text = @"勘察方式：";
    [self addSubview:label];
    
    for (int i = 0; i < 2; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(71 *SIZE + i * 146 *SIZE, 14 *SIZE, 96 *SIZE, 25 *SIZE);
        btn.titleLabel.font = [UIFont systemFontOfSize:14 *sIZE];
        [btn addTarget:self action:@selector(ActionTagBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i + 1;
        [btn setImage:[UIImage imageNamed:@"default"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateSelected];
        [btn setTitleColor:YJContentLabColor forState:UIControlStateNormal];
        if (i == 0) {
            
            [btn setTitle:@"他人勘察" forState:UIControlStateNormal];
            btn.selected = YES;
            _otherBtn = btn;
            [self addSubview:_otherBtn];
        }else{
            
            [btn setTitle:@"自行勘察" forState:UIControlStateNormal];
            _selfBtn = btn;
            [self addSubview:_selfBtn];
        }
    }
    
    _timeL = [[UILabel alloc] initWithFrame:CGRectMake(9 *SIZE, 75 *SIZE, 100 *SIZE, 10 *SIZE)];
    _timeL.textColor = YJTitleLabColor;
    _timeL.text = @"预约勘察时间:";
    _timeL.font = [UIFont systemFontOfSize:11 *SIZE];
    _timeL.hidden = YES;
    [self addSubview:_timeL];
    
    _timeBtn = [[DropDownBtn alloc] initWithFrame:CGRectMake(80 *SIZE, 62 *SIZE, 270 *SIZE, 33 *SIZE)];
    [_timeBtn addTarget:self action:@selector(ActionTimeBtn:) forControlEvents:UIControlEventTouchUpInside];
    _timeBtn.hidden = YES;
    [self addSubview:_timeBtn];
}

@end
