//
//  RoomBrokerageTableCell2.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/23.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RoomBrokerageTableCell2.h"

@implementation RoomBrokerageTableCell2

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
    
    _ruleView = [[UIView alloc] init];
    _ruleView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_ruleView];
    
    UIImageView *titleImg = [[UIImageView alloc] initWithFrame:CGRectMake(11 *SIZE, 12 *SIZE, 17 *SIZE, 17 *SIZE)];
    titleImg.image = [UIImage imageNamed:@"rules"];
    [_ruleView addSubview:titleImg];
    
    UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(42 *SIZE, 13 *SIZE, 200 *SIZE, 14 *SIZE)];
    titleL.textColor = YJTitleLabColor;
    titleL.font = [UIFont systemFontOfSize:15 *SIZE];
    titleL.text = @"佣金规则";
    [_ruleView addSubview:titleL];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 39 *SIZE, SCREEN_Width, SIZE)];
    line.backgroundColor = YJBackColor;
    [_ruleView addSubview:line];
    
    _ruleL = [[UILabel alloc] init];
    _ruleL.textColor = YJ86Color;
    _ruleL.font = [UIFont systemFontOfSize:12 *SIZE];
    _ruleL.numberOfLines = 0;
    [_ruleView addSubview:_ruleL];
    
    _standView = [[UIView alloc] init];
    _standView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_standView];
    
    UIImageView *titleImg2 = [[UIImageView alloc] initWithFrame:CGRectMake(11 *SIZE, 12 *SIZE, 17 *SIZE, 17 *SIZE)];
    titleImg2.image = [UIImage imageNamed:@"commission4"];
    [_standView addSubview:titleImg2];
    
    UILabel *titleL2 = [[UILabel alloc] initWithFrame:CGRectMake(42 *SIZE, 13 *SIZE, 200 *SIZE, 14 *SIZE)];
    titleL2.textColor = YJTitleLabColor;
    titleL2.font = [UIFont systemFontOfSize:15 *SIZE];
    titleL2.text = @"结佣标准";
    [_standView addSubview:titleL2];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 39 *SIZE, SCREEN_Width, SIZE)];
    line2.backgroundColor = YJBackColor;
    [_standView addSubview:line2];
    
    _standL = [[UILabel alloc] init];
    _standL.textColor = YJ86Color;
    _standL.font = [UIFont systemFontOfSize:12 *SIZE];
    _standL.numberOfLines = 0;
    [_standView addSubview:_standL];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_ruleView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(self.contentView).offset(0 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
    }];
    
    [_ruleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_ruleView).offset(41 *SIZE);
        make.top.equalTo(_ruleView).offset(58 *SIZE);
        make.width.mas_equalTo(304 *SIZE);
        make.bottom.equalTo(_ruleView).offset(-31 *SIZE);
    }];
    
    [_standView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(_ruleView.mas_bottom).offset(8 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
    }];
    
    [_standL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_standView).offset(41 *SIZE);
        make.top.equalTo(_standView).offset(58 *SIZE);
        make.width.mas_equalTo(304 *SIZE);
        make.bottom.equalTo(_standView).offset(-31 *SIZE);
    }];
}


@end
