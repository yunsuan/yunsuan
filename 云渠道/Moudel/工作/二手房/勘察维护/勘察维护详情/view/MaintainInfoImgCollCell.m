//
//  MaintainInfoImgCollCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/7/19.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "MaintainInfoImgCollCell.h"

@implementation MaintainInfoImgCollCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10 *SIZE, 12 *SIZE, 100 *SIZE, 83 *SIZE)];
    _imgView.backgroundColor = [UIColor redColor];
    _imgView.contentMode = UIViewContentModeScaleAspectFill;
    _imgView.clipsToBounds = YES;
    [self.contentView addSubview:_imgView];
    
    _titleL = [[UILabel alloc] initWithFrame:CGRectMake(0, 104 *SIZE, self.bounds.size.width, 12 *SIZE)];
    _titleL.textColor = YJContentLabColor;
    _titleL.font = [UIFont systemFontOfSize:13 *SIZE];
    _titleL.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_titleL];
}

@end
