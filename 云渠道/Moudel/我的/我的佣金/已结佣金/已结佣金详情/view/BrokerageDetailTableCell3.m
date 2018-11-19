//
//  BrokerageDetailTableCell3.m
//  云渠道
//
//  Created by 谷治墙 on 2018/3/29.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BrokerageDetailTableCell3.h"

@implementation BrokerageDetailTableCell3

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    _titleL = [[UILabel alloc] initWithFrame:CGRectMake(57 *SIZE, 23 *SIZE, 250 *SIZE, 12 *SIZE)];
    _titleL.textColor = YJTitleLabColor;
//    _titleL.numberOfLines = 0;
    _titleL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_titleL];
    
    _circleImg = [[UIImageView alloc] initWithFrame:CGRectMake(28 *SIZE, 20 *SIZE, 17 *SIZE, 17 *SIZE)];
    _circleImg.image = [UIImage imageNamed:@"progressbar"];
    [self.contentView addSubview:_circleImg];
    
    _upLine = [[UIView alloc] initWithFrame:CGRectMake(36 *SIZE, 0, SIZE, 20 *SIZE)];
    _upLine.backgroundColor = COLOR(255, 165, 29, 1);
    [self.contentView addSubview:_upLine];
    
    
    _downLine = [[UIView alloc] initWithFrame:CGRectMake(36 *SIZE, 37 *SIZE, SIZE, 43 *SIZE)];
    _downLine.backgroundColor = COLOR(255, 165, 29, 1);
    [self.contentView addSubview:_downLine];
    
    [self masonryUI];
}

- (void)masonryUI{
    
    [_upLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(36 *SIZE);
        make.top.equalTo(self.contentView).offset(0 *SIZE);
        make.width.equalTo(@(SIZE));
        make.height.equalTo(@(20 *SIZE));
        make.bottom.equalTo(self.contentView).offset(-60 *SIZE);
    }];
    
    
    [_downLine mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(36 *SIZE);
        make.top.equalTo(self.contentView).offset(37 *SIZE);
        make.width.equalTo(@(SIZE));
        make.height.equalTo(@(43 *SIZE));
        make.bottom.equalTo(self.contentView).offset(0);
    }];
}

@end
