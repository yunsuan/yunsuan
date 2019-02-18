//
//  ThreePartView.m
//  云渠道
//
//  Created by 谷治墙 on 2019/2/15.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "ThreePartView.h"

@implementation ThreePartView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    NSArray *titleArr = @[@"近7日看房",@"累计看房",@"关注房源的人"];
    for (int i = 0; i < 3; i++) {
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_Width / 3 * i, 17 *SIZE, SIZE, 36 *SIZE)];
        line.backgroundColor = [UIColor blackColor];
        line.alpha = 0.2;
        if (i != 0) {
            
            [self addSubview:line];
        }
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_Width / 3 * i, 41 *SIZE, SCREEN_Width / 3, 13 *SIZE)];
        label.textColor = YJBlueBtnColor;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        label.textAlignment = NSTextAlignmentCenter;
        
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_Width / 3 * i, 19 *SIZE, SCREEN_Width / 3, 11 *SIZE)];
        label1.textColor = YJ86Color;
        label1.font = [UIFont systemFontOfSize:12 *SIZE];
        label1.textAlignment = NSTextAlignmentCenter;
        label1.text = titleArr[i];
        
        switch (i) {
            case 0:
            {
                _daysL = label;
                [self addSubview:_daysL];
                _daysLabel = label1;
                [self addSubview:_daysLabel];
                break;
            }
            case 1:
            {
                _allL = label;
                [self addSubview:_allL];
                _allLabel = label1;
                [self addSubview:_allLabel];
                break;
            }
            case 2:
            {
                _intentL = label;
                [self addSubview:_intentL];
                _intentLabel = label1;
                [self addSubview:_intentLabel];
                break;
            }
            default:
                break;
        }
    }
}

@end
