//
//  SecAllRoomStoreNeiborCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/9/19.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "SecAllRoomStoreNeiborCell.h"

@implementation SecAllRoomStoreNeiborCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setModel:(SecAllRoomStoreModel *)model{
    
    _leftImg.image = [UIImage imageNamed:@"store"];
    _centerImg.image = [UIImage imageNamed:@"store_1"];
    _rightImg.image = [UIImage imageNamed:@"store"];
    
    if (model.left_shop.length) {
        
        _leftL.text = model.left_shop;
    }else{
        
        _leftL.text = @"暂无数据";
    }
    
    _centerL.text = @"本铺";
    
    
    if (model.right_shop.length) {
        
        _rightL.text = model.right_shop;
    }else{
        
        _rightL.text = @"暂无数据";
    }

}

- (void)setOfficeModel:(SecAllRoomOfficeModel *)officeModel{
    
    _leftImg.image = [UIImage imageNamed:@"company"];
    _centerImg.image = [UIImage imageNamed:@"company_1"];
    _rightImg.image = [UIImage imageNamed:@"company"];
    
    if (officeModel.left_office.length) {
        
        _leftL.text = officeModel.left_office;
    }else{
        
        _leftL.text = @"暂无数据";
    }
    
    _centerL.text = @"本企业";
    
    
    if (officeModel.right_office.length) {
        
        _rightL.text = officeModel.right_office;
    }else{
        
        _rightL.text = @"暂无数据";
    }
}

- (void)initUI{
    
    self.contentView.backgroundColor = YJBackColor;
    
    _whiteView = [[UIView alloc] init];
    _whiteView.backgroundColor = [UIColor whiteColor];
    _whiteView.layer.cornerRadius = 3 *SIZE;
    _whiteView.clipsToBounds = YES;
    [self.contentView addSubview:_whiteView];
    
    for (int i = 0; i < 2; i++) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(113 *SIZE * (i + 1), 44 *SIZE, SIZE, 36 *SIZE)];
        view.backgroundColor = YJBackColor;
        [_whiteView addSubview:view];
    }
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(8 *SIZE, 9 *SIZE, 100 *SIZE, 15 *SIZE)];
    label.textColor = YJTitleLabColor;
    label.font = [UIFont systemFontOfSize:15 *SIZE];
    label.text = @"左云右算";
    [_whiteView addSubview:label];
    
    _leftL = [[UILabel alloc] init];
    _leftL.textColor = YJ86Color;
    _leftL.font = [UIFont systemFontOfSize:12 *SIZE];
    _leftL.textAlignment = NSTextAlignmentCenter;
    [_whiteView addSubview:_leftL];
    
    _leftImg = [[UIImageView alloc] init];
    _leftImg.image = [UIImage imageNamed:@""];
    [_whiteView addSubview:_leftImg];
    
    _centerL = [[UILabel alloc] init];
    _centerL.textColor = YJTitleLabColor;
    _centerL.font = [UIFont systemFontOfSize:13 *SIZE];
    _centerL.textAlignment = NSTextAlignmentCenter;
    [_whiteView addSubview:_centerL];
    
    _centerImg = [[UIImageView alloc] init];
    _centerImg.image = [UIImage imageNamed:@""];
    [_whiteView addSubview:_centerImg];
    
    _rightL = [[UILabel alloc] init];
    _rightL.textColor = YJ86Color;
    _rightL.font = [UIFont systemFontOfSize:12 *SIZE];
    _rightL.textAlignment = NSTextAlignmentCenter;
    [_whiteView addSubview:_rightL];
    
    _rightImg = [[UIImageView alloc] init];
    _rightImg.image = [UIImage imageNamed:@""];
    [_whiteView addSubview:_rightImg];
    
    [_whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(8 *SIZE);
        make.width.mas_equalTo(340 *SIZE);
        make.height.mas_equalTo(100 *SIZE);
        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
    }];
    
    [_leftL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(0 *SIZE);
        make.top.equalTo(_whiteView).offset(69 *SIZE);
        make.width.mas_equalTo(113 *SIZE);
        make.bottom.equalTo(_whiteView.mas_bottom).offset(-19 *SIZE);
    }];
    
    [_leftImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(44 *SIZE);
        make.top.equalTo(_whiteView).offset(36 *SIZE);
        make.width.mas_equalTo(25 *SIZE);
    }];
    
    [_centerL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(114 *SIZE);
        make.top.equalTo(_whiteView).offset(69 *SIZE);
        make.width.mas_equalTo(113 *SIZE);
        make.bottom.equalTo(_whiteView.mas_bottom).offset(-19 *SIZE);
    }];
    
    [_centerImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(157 *SIZE);
        make.top.equalTo(_whiteView).offset(36 *SIZE);
        make.width.mas_equalTo(25 *SIZE);
    }];
    
    [_rightImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(271 *SIZE);
        make.top.equalTo(_whiteView).offset(36 *SIZE);
        make.width.mas_equalTo(25 *SIZE);
    }];
    
    [_rightL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(228 *SIZE);
        make.top.equalTo(_whiteView).offset(69 *SIZE);
        make.width.mas_equalTo(113 *SIZE);
        make.bottom.equalTo(_whiteView.mas_bottom).offset(-19 *SIZE);
    }];
    
    
}

@end
