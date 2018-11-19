//
//  MaintainRoomInfoCell3.m
//  云渠道
//
//  Created by 谷治墙 on 2018/7/19.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "MaintainRoomInfoCell3.h"

@implementation MaintainRoomInfoCell3

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    for (int i = 0 ; i < 2; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = YJTitleLabColor;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        label.numberOfLines = 0;
        label.preferredMaxLayoutWidth = 304 *SIZE;
        if (i == 0) {
            
            _titleL = label;
            [self.contentView addSubview:_titleL];
        }else{
            
            label.textColor = YJContentLabColor;
            label.font = [UIFont systemFontOfSize:12 *SIZE];
            _contentL = label;
            [self.contentView addSubview:_contentL];
        }
    }
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(self.contentView).offset(6 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
    }];
    
    [_contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_titleL.mas_bottom).offset(10 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-22 *SIZE);
    }];
}

@end
