//
//  LookMaintainCustomDetailCell.m
//  云渠道
//
//  Created by 谷治墙 on 2019/12/27.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "LookMaintainCustomDetailCell.h"

@implementation LookMaintainCustomDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    _cardImg = [[UIImageView alloc] init];
    _cardImg.contentMode = UIViewContentModeScaleAspectFill;
    _cardImg.clipsToBounds = YES;
    _cardImg.image = [UIImage imageNamed:@"default_3"];
//    _cardImg.userInteractionEnabled = YES;
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ActionTap)];
//    [_cardImg addGestureRecognizer:tap];
    [self.contentView addSubview:_cardImg];
    
    _backImg = [[UIImageView alloc] init];
    _backImg.contentMode = UIViewContentModeScaleAspectFill;
    _backImg.clipsToBounds = YES;
    _backImg.image = [UIImage imageNamed:@"default_3"];
//    _backImg.userInteractionEnabled = YES;
//    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ActionTap1)];
//    [_backImg addGestureRecognizer:tap1];
    [self.contentView addSubview:_backImg];
    
    [_cardImg mas_makeConstraints:^(MASConstraintMaker *make) {
            
        make.left.equalTo(self.contentView).offset(27 *SIZE);
        make.top.equalTo(self.contentView).offset(20 *SIZE);
        make.width.mas_equalTo(120 *SIZE);
        make.height.mas_equalTo(90 *SIZE);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-25 *SIZE);
    }];
    
    [_backImg mas_makeConstraints:^(MASConstraintMaker *make) {
            
        make.left.equalTo(self.contentView).offset(168 *SIZE);
        make.top.equalTo(self.contentView).offset(20 *SIZE);
        make.width.mas_equalTo(120 *SIZE);
        make.height.mas_equalTo(90 *SIZE);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-25 *SIZE);
    }];
}

@end
