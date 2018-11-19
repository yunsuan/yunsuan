//
//  RoomAgencyAddProtocolCell5.m
//  云渠道
//
//  Created by 谷治墙 on 2018/6/29.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RoomAgencyAddProtocolCell5.h"

@implementation RoomAgencyAddProtocolCell5

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    _addImg = [[UIImageView alloc] init];
    _addImg.image = [UIImage imageNamed:@"add_3-1"];
    [self.contentView addSubview:_addImg];
    
    [_addImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(165 *SIZE);
        make.top.equalTo(self.contentView).offset(7 *SIZE);
        make.width.mas_equalTo(15 *SIZE);
        make.height.mas_equalTo(15 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-7 *SIZE);
    }];
}

@end
