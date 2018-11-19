//
//  RoomDetailTableCell2.m
//  云渠道
//
//  Created by 谷治墙 on 2018/3/27.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RoomDetailTableCell2.h"

@implementation RoomDetailTableCell2


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 9 *SIZE, 65 *SIZE, 15 *SIZE)];
    label.textColor = YJTitleLabColor;
    label.font = [UIFont systemFontOfSize:15 *SIZE];
    label.text = @"楼栋信息";
    [self.contentView addSubview:label];
    
    _bigImg = [[UIImageView alloc] init];
    _bigImg.backgroundColor = [UIColor whiteColor];
    _bigImg.contentMode = UIViewContentModeScaleAspectFill;
    _bigImg.clipsToBounds = YES;
    [self.contentView addSubview:_bigImg];
    
    [self masonryUI];
}

- (void)masonryUI{
    
    [_bigImg mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.contentView).offset(33 *SIZE);
        make.right.equalTo(self.contentView).offset(0);
        make.bottom.equalTo(self.contentView).offset(0);
        make.width.equalTo(@(360 *SIZE));
        make.height.equalTo(@(187 *SIZE));
    }];
}

@end
