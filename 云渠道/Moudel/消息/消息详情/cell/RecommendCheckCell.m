//
//  RecommendCheckCell.m
//  云渠道
//
//  Created by 谷治墙 on 2019/7/29.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "RecommendCheckCell.h"

@implementation RecommendCheckCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

-(void)initUI
{
    
    _titleL = [[UILabel alloc]initWithFrame:CGRectMake(27*SIZE, 0*SIZE, 300*SIZE, 14 *SIZE)];
    _titleL.font = [UIFont systemFontOfSize:14*SIZE];
    _titleL.textColor = COLOR(249, 156, 59, 1);
    _titleL.textAlignment = NSTextAlignmentCenter;
    _titleL.text = @"推荐已成功，以到访为准";
    [self.contentView addSubview:_titleL];
}

@end
