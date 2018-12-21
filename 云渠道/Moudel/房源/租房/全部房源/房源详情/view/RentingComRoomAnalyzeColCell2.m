//
//  RentingComRoomAnalyzeColCell2.m
//  云渠道
//
//  Created by 谷治墙 on 2018/7/23.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RentingComRoomAnalyzeColCell2.h"

@implementation RentingComRoomAnalyzeColCell2


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
    
    self.contentL = [[UILabel alloc] init];
    self.contentL.numberOfLines = 0;
    self.contentL.textColor = YJ86Color;
    self.contentL.font = [UIFont systemFontOfSize:11 *SIZE];
//    self.contentL.mas_height
//    _contentL.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.contentL];
    
    
    [self.contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(self.contentView).offset(7 *SIZE);
        make.width.mas_equalTo(311 *SIZE);
//        make.height.mas_equalTo(self.contentL.heightAnchor);
        make.right.equalTo(self.contentView).offset(-21 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-27 *SIZE);
    }];
}

@end
