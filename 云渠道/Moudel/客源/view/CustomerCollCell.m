//
//  CustomerCollCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/3/21.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "CustomerCollCell.h"

@implementation CustomerCollCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    _typeL = [[UILabel alloc] initWithFrame:CGRectMake(0, 14 *SIZE, 70 *SIZE, 11 *SIZE)];
    _typeL.textColor = YJContentLabColor;
    _typeL.font = [UIFont systemFontOfSize:12 *SIZE];
    _typeL.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_typeL];
    
    _dropImg = [[UIImageView alloc] initWithFrame:CGRectMake(70 *SIZE, 17 *SIZE, 10 *SIZE, 10 *SIZE)];
    _dropImg.image = [UIImage imageNamed:@"downarrow1"];
    [self.contentView addSubview:_dropImg];
}

//- (void)setSelected:(BOOL)selected{
//    
//    selected = !selected;
//    if (selected) {
//        
//        _dropImg.image = [UIImage imageNamed:@"uparrow1"];
//    }else{
//        
//        _dropImg.image = [UIImage imageNamed:@"downarrow1"];
//    }
//}

@end
