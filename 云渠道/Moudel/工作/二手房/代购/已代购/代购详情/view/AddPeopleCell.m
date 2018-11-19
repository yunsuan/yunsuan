//
//  AddPeopleCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/7/18.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "AddPeopleCell.h"

@implementation AddPeopleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    self.contentView.backgroundColor = YJBackColor;
    
    _addImg = [[UIImageView alloc] init];
//    _addImg.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:_addImg];
    
    [_addImg mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(22 *SIZE);
        make.top.equalTo(self.contentView).offset(19 *SIZE);
        make.width.mas_equalTo(317 *SIZE);
        make.height.mas_equalTo(40 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-19 *SIZE);
    }];
//    _addImg.image
}

@end
