//
//  LookMaintainDetailAddAppointCell.m
//  云渠道
//
//  Created by 谷治墙 on 2019/1/30.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "LookMaintainDetailAddAppointCell.h"

@implementation LookMaintainDetailAddAppointCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    _roomImg = [[UIImageView alloc] init];
    _roomImg.contentMode = UIViewContentModeScaleAspectFit;
    _roomImg.clipsToBounds = YES;
    [self.contentView addSubview:_roomImg];
    
    [_roomImg mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(130 *SIZE);
        make.top.equalTo(self.contentView).offset(10 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-10 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
        make.height.mas_equalTo(100 *SIZE);
    }];
}



@end
