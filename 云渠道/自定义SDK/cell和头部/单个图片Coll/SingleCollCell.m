//
//  SingleCollCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/6/20.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "SingleCollCell.h"

@implementation SingleCollCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    _singleImg = [[UIImageView alloc] initWithFrame:self.bounds];
    _singleImg.contentMode = UIViewContentModeScaleAspectFill;
    _singleImg.clipsToBounds = YES;
    [self.contentView addSubview:_singleImg];
}

@end
