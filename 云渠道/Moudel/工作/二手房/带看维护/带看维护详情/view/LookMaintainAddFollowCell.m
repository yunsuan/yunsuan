//
//  LookMaintainAddFollowCell.m
//  云渠道
//
//  Created by 谷治墙 on 2019/1/28.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "LookMaintainAddFollowCell.h"

@implementation LookMaintainAddFollowCell

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
    
    _addLabel = [[UILabel alloc] init];
    _addLabel.textColor = YJ86Color;
    _addLabel.text = @"添加跟进";
    _addLabel.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_addLabel];
    
    [_addImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(139 *SIZE);
        make.top.equalTo(self.contentView).offset(10 *SIZE);
        make.width.height.mas_equalTo(20 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
    [_addLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(169 *SIZE);
        make.top.equalTo(self.contentView).offset(14 *SIZE);
        make.width.mas_equalTo(80 *SIZE);
    }];
}

@end
