//
//  SurveySuccessDetailHeaderCollCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/6/19.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "SurveySuccessDetailHeaderCollCell.h"

@implementation SurveySuccessDetailHeaderCollCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    _backView = [[UIView alloc] initWithFrame:self.contentView.bounds];
    _backView.backgroundColor = COLOR(229, 229, 229, 1);
    [self.contentView addSubview:_backView];
    
    _titleL = [[UILabel alloc] initWithFrame:CGRectMake(0, 17 *SIZE, 180 *SIZE, 12 *SIZE)];
    _titleL.textColor = YJTitleLabColor;
    _titleL.font = [UIFont systemFontOfSize:13 *SIZE];
    _titleL.textAlignment = NSTextAlignmentCenter;
    //    _titleL.text = @"需求信息";
    [self.contentView addSubview:_titleL];
}

- (void)setSelected:(BOOL)selected{
    
    if (selected) {
        
        _backView.backgroundColor = COLOR(28, 151, 255, 1);
        _titleL.textColor = [UIColor whiteColor];
    }else{
        
        _backView.backgroundColor = COLOR(229, 229, 229, 1);
        _titleL.textColor = YJTitleLabColor;
    }
}

@end
