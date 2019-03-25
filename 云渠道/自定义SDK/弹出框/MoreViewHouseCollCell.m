//
//  MoreViewHouseCollCell.m
//  云渠道
//
//  Created by 谷治墙 on 2019/3/25.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "MoreViewHouseCollCell.h"

@implementation MoreViewHouseCollCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionDropBtn:(UIButton *)btn{
    
    if (self.moreViewHouseCollCellBlock) {
        
        self.moreViewHouseCollCellBlock();
    }
}

- (void)initUI{
    
    _houseBtn = [[DropDownBtn alloc] initWithFrame:CGRectMake(10 *SIZE, 10 *SIZE, 340 *SIZE, 33 *SIZE)];
    [_houseBtn addTarget:self action:@selector(ActionDropBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_houseBtn];
}

@end
