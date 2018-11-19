//
//  MaintainRoomInfoNeiborCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/9/19.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "MaintainRoomInfoNeiborCell.h"

@implementation MaintainRoomInfoNeiborCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    if (self.type == 2) {
        
        _leftL.text = [NSString stringWithFormat:@"左边商铺：%@",dataDic[@"left_shop"]];
        _rightL.text = [NSString stringWithFormat:@"右边商铺：%@",dataDic[@"right_shop"]];
        _markL.text = [NSString stringWithFormat:@"其他要求：%@",dataDic[@"comment"]];
    }else{
        
        _leftL.text = [NSString stringWithFormat:@"左边公司：%@",dataDic[@"left_office"]];
        _rightL.text = [NSString stringWithFormat:@"右边公司：%@",dataDic[@"right_office"]];
        _markL.text = [NSString stringWithFormat:@"其他要求：%@",dataDic[@"comment"]];
    }
}

- (void)initUI{
    
    _leftL = [[UILabel alloc] init];
    _leftL.textColor = YJ86Color;
    _leftL.font = [UIFont systemFontOfSize:12 *SIZE];
    _leftL.numberOfLines = 0;
    [self.contentView addSubview:_leftL];
    
    _rightL = [[UILabel alloc] init];
    _rightL.textColor = YJ86Color;
    _rightL.font = [UIFont systemFontOfSize:12 *SIZE];
    _rightL.numberOfLines = 0;
    [self.contentView addSubview:_rightL];
    
    _seeWayL = [[UILabel alloc] init];
    _seeWayL.textColor = YJ86Color;
    _seeWayL.font = [UIFont systemFontOfSize:12 *SIZE];
    _seeWayL.numberOfLines = 0;
    [self.contentView addSubview:_seeWayL];
    
    _markL = [[UILabel alloc] init];
    _markL.textColor = YJ86Color;
    _markL.font = [UIFont systemFontOfSize:12 *SIZE];
    _markL.numberOfLines = 0;
    [self.contentView addSubview:_markL];
    
    [_leftL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(self.contentView).offset(15 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
    }];
    
    [_rightL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_leftL.mas_bottom).offset(12 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
    }];
    
    [_seeWayL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_rightL.mas_bottom).offset(12 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
    }];
    
    [_markL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_seeWayL.mas_bottom).offset(12 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-20 *SIZE);
    }];
}

@end
