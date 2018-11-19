//
//  RentingComRoomAnalyzeColCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/7/23.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RentingComRoomAnalyzeColCell.h"

@implementation RentingComRoomAnalyzeColCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    self.contentView.backgroundColor = CH_COLOR_white;
    
    self.bigImg = [[UIImageView alloc] init];
    self.bigImg.clipsToBounds = YES;
    [self.contentView addSubview:self.bigImg];
    
    self.titleL = [[UILabel alloc] init];
    self.titleL.textColor = YJ86Color;
    self.titleL.font = [UIFont systemFontOfSize:11 *SIZE];
    self.titleL.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.titleL];
    
    [self.bigImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(14 *SIZE);
        make.top.equalTo(self.contentView).offset(14 *SIZE);
        make.width.height.mas_equalTo(25 *SIZE);
        make.right.equalTo(self.contentView).offset(-14 *SIZE);
    }];
    
    [self.titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.bigImg.mas_bottom).offset(14 *SIZE);
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-14 *SIZE);
    }];
}

@end
