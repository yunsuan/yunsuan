//
//  RoomAgencyAddProtocolCell6.m
//  云渠道
//
//  Created by 谷治墙 on 2018/7/18.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RoomAgencyAddProtocolCell6.h"

@implementation RoomAgencyAddProtocolCell6

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    _codeL = [[UILabel alloc] init];
    _codeL.textColor = YJTitleLabColor;
    _codeL.text = @"推荐编号";
    _codeL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_codeL];
    
    _codeTF = [[BorderTF alloc] initWithFrame:CGRectMake(81 *SIZE, 47 *SIZE, 257 *SIZE, 33 *SIZE)];
    _codeTF.userInteractionEnabled = NO;
    _codeTF.textfield.placeholder = @"自动生成";
    [self.contentView addSubview:_codeTF];
    
    [self masonryUI];
}

- (void)masonryUI{
    
    
    [_codeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(self.contentView).offset(18 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_codeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(81 *SIZE);
        make.top.equalTo(self.contentView).offset(7 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-13 *SIZE);
    }];
}
        

@end
