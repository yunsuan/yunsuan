//
//  BuildingAlbumCollCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/4.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BuildingAlbumCollCell.h"

@implementation BuildingAlbumCollCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    self.contentView.layer.cornerRadius = 2 *SIZE;
    self.contentView.clipsToBounds = YES;
    self.contentView.backgroundColor = COLOR(229, 229, 229, 1);
    
    _contentL = [[UILabel alloc] initWithFrame:CGRectMake(0, 7 *SIZE, self.bounds.size.width, 11 *SIZE)];
    _contentL.textColor = COLOR(86, 86, 86, 1);
    _contentL.font = [UIFont systemFontOfSize:12 *SIZE];
    _contentL.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_contentL];
}

- (void)setSelected:(BOOL)selected{
    
    if (selected) {
        
        _contentL.textColor = CH_COLOR_white;
        self.contentView.backgroundColor = YJBlueBtnColor;
    }else{
        
        _contentL.textColor = COLOR(86, 86, 86, 1);
        self.contentView.backgroundColor = COLOR(229, 229, 229, 1);
    }
}

@end
