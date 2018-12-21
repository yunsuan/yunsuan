//
//  RentingAnalysisHeaderView.m
//  云渠道
//
//  Created by 谷治墙 on 2018/12/21.
//  Copyright © 2018 xiaoq. All rights reserved.
//

#import "RentingAnalysisHeaderView.h"

@implementation RentingAnalysisHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(10 *SIZE, 13 *SIZE, 7 *SIZE, 13 *SIZE)];
    view1.backgroundColor = YJBlueBtnColor;
    [self addSubview:view1];
    
    _titleL = [[UILabel alloc] initWithFrame:CGRectMake(27 *SIZE, 13 *SIZE, 100 *SIZE, 14 *SIZE)];
    _titleL.textColor = YJTitleLabColor;
    _titleL.font = [UIFont systemFontOfSize:15 *SIZE];
    [self addSubview:_titleL];
    
}
@end
