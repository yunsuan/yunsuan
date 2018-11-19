//
//  IdentifyHeader.m
//  云渠道
//
//  Created by 谷治墙 on 2018/5/7.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "IdentifyHeader.h"

@implementation IdentifyHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}


- (void)initUI{
    
    self.contentView.backgroundColor = YJBlueBtnColor;
    
    _statusL = [[UILabel alloc] initWithFrame:CGRectMake(0, 31 *SIZE, SCREEN_Width, 17 *SIZE)];
    _statusL.textColor = CH_COLOR_white;
    _statusL.font = [UIFont systemFontOfSize:19 *SIZE];
    _statusL.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_statusL];
 
    _phoneL = [[UILabel alloc] initWithFrame:CGRectMake(0, 69 *SIZE, SCREEN_Width, 13 *SIZE)];
    _phoneL.textColor = CH_COLOR_white;
    _phoneL.font = [UIFont systemFontOfSize:13 *SIZE];
    _phoneL.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_phoneL];
}
@end
