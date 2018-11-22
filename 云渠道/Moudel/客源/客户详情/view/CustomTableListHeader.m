//
//  CustomTableListHeader.m
//  云渠道
//
//  Created by 谷治墙 on 2018/11/1.
//  Copyright © 2018 xiaoq. All rights reserved.
//

#import "CustomTableListHeader.h"

@implementation CustomTableListHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionMoreBtn:(UIButton *)btn{
    
    if (self.customTableListHeaderMoreBlock) {
        
        self.customTableListHeaderMoreBlock();
    }
}

- (void)ActionStatusBtn:(UIButton *)btn{
    
    if (self.customTableListHeaderStatusBlock) {
        
        self.customTableListHeaderStatusBlock();
    }
    
}

- (void)initUI{
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    _numListL = [[UILabel alloc] initWithFrame:CGRectMake(11 *SIZE, 26 *SIZE, 150 *SIZE, 16 *SIZE)];
    _numListL.textColor = YJTitleLabColor;
    _numListL.font = [UIFont systemFontOfSize:15 *SIZE];
    [self.contentView addSubview:_numListL];
    
    _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _moreBtn.frame = CGRectMake(6 *SIZE, 21 *SIZE  , 160 *SIZE, 26 *SIZE);
    [_moreBtn addTarget:self action:@selector(ActionMoreBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_moreBtn];
    
    _recommendListL = [[UILabel alloc] initWithFrame:CGRectMake(250 *SIZE, 28 *SIZE  , 98 *SIZE, 16 *SIZE)];
    _recommendListL.textColor = YJBlueBtnColor;
    _recommendListL.textAlignment = NSTextAlignmentRight;
    _recommendListL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_recommendListL];
    
    _recommendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _recommendBtn.frame = CGRectMake(245 *SIZE, 23 *SIZE  , 108 *SIZE, 26 *SIZE);
    [_recommendBtn addTarget:self action:@selector(ActionStatusBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_recommendBtn];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 67 *SIZE, SCREEN_Width, SIZE)];
    line2.backgroundColor = YJBackColor;
    
    [self.contentView addSubview:line2];
}

@end
