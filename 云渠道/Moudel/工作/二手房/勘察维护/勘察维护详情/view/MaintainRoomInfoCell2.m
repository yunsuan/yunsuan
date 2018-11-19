//
//  MaintainRoomInfoCell2.m
//  云渠道
//
//  Created by 谷治墙 on 2018/7/19.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "MaintainRoomInfoCell2.h"

@implementation MaintainRoomInfoCell2

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    _tagView = [[TagView alloc] initWithFrame:CGRectMake(28 *SIZE, 17 *SIZE, SCREEN_Width - 28 *SIZE, 30 *SIZE) type:@"1"];
    [self.contentView addSubview:_tagView];
    
    [_tagView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(self.contentView).offset(18 *SIZE);
        make.width.mas_equalTo(SCREEN_Width - 28 *SIZE);
        make.height.mas_equalTo(30 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-31 *SIZE);
    }];
}



@end
