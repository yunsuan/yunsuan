//
//  SecAllRoomStoreDetailCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/9/19.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "SecAllRoomStoreDetailCell.h"

@implementation SecAllRoomStoreDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setModel:(SecAllRoomStoreModel *)model{
    
    _highL.text = [NSString stringWithFormat:@"%@m",model.shop_height];
    _highTL.text = @"层高";
    
    _widthL.text = [NSString stringWithFormat:@"%@m",model.shop_width];
    _widthTL.text = @"门宽";
    _yearL.text = @"";
    _yearTL.text = @"建成年代";
}

- (void)setOfficeModel:(SecAllRoomOfficeModel *)officeModel{
    
    _highL.text = [NSString stringWithFormat:@"%@m",officeModel.office_height];
    _highTL.text = @"层高";
    
    _widthL.text = [NSString stringWithFormat:@"%@m",officeModel.office_width];
    _widthTL.text = @"门宽";
    _yearL.text = @"";
    _yearTL.text = @"建成年代";
}

- (void)initUI{
    
    self.contentView.backgroundColor = YJBackColor;
    
    _whiteView = [[UIView alloc] init];
    _whiteView.backgroundColor = [UIColor whiteColor];
    _whiteView.layer.cornerRadius = 3 *SIZE;
    _whiteView.clipsToBounds = YES;
    [self.contentView addSubview:_whiteView];
    
    for (int i = 0; i < 2; i++) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(99 *SIZE + i * 141 *SIZE, 44 *SIZE, SIZE, 36 *SIZE)];
        view.backgroundColor = YJBackColor;
        [_whiteView addSubview:view];
    }
    
    _highL = [[UILabel alloc] init];
    _highL.textColor = YJTitleLabColor;
    _highL.font = [UIFont systemFontOfSize:13 *SIZE];
    _highL.textAlignment = NSTextAlignmentCenter;
    [_whiteView addSubview:_highL];
    
    _highTL = [[UILabel alloc] init];
    _highTL.textColor = YJ86Color;
    _highTL.font = [UIFont systemFontOfSize:12 *SIZE];
    _highTL.textAlignment = NSTextAlignmentCenter;
    [_whiteView addSubview:_highTL];
    
    _widthL = [[UILabel alloc] init];
    _widthL.textColor = YJTitleLabColor;
    _widthL.font = [UIFont systemFontOfSize:13 *SIZE];
    _widthL.textAlignment = NSTextAlignmentCenter;
    [_whiteView addSubview:_widthL];
    
    _widthTL = [[UILabel alloc] init];
    _widthTL.textColor = YJ86Color;
    _widthTL.font = [UIFont systemFontOfSize:12 *SIZE];
    _widthTL.textAlignment = NSTextAlignmentCenter;
    [_whiteView addSubview:_widthTL];
    
    _yearL = [[UILabel alloc] init];
    _yearL.textColor = YJTitleLabColor;
    _yearL.font = [UIFont systemFontOfSize:13 *SIZE];
    _yearL.textAlignment = NSTextAlignmentCenter;
    [_whiteView addSubview:_yearL];
    
    _yearTL = [[UILabel alloc] init];
    _yearTL.textColor = YJ86Color;
    _yearTL.font = [UIFont systemFontOfSize:12 *SIZE];
    _yearTL.textAlignment = NSTextAlignmentCenter;
    [_whiteView addSubview:_yearTL];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(8 *SIZE, 9 *SIZE, 100 *SIZE, 15 *SIZE)];
    label.textColor = YJTitleLabColor;
    label.font = [UIFont systemFontOfSize:15 *SIZE];
    label.text = @"房源详情";
    [_whiteView addSubview:label];
    
    [_whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(8 *SIZE);
        make.width.mas_equalTo(340 *SIZE);
        make.height.mas_equalTo(100 *SIZE);
        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
    }];
    
    [_highL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_whiteView).offset(0 *SIZE);
        make.top.equalTo(_whiteView).offset(47 *SIZE);
        make.width.mas_equalTo(110 *SIZE);
    }];
    
    [_highTL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(0 *SIZE);
        make.top.equalTo(_whiteView).offset(69 *SIZE);
        make.width.mas_equalTo(110 *SIZE);
    }];
    
    [_widthL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(110 *SIZE);
        make.top.equalTo(_whiteView).offset(47 *SIZE);
        make.width.mas_equalTo(120 *SIZE);
    }];
    
    [_widthTL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(110 *SIZE);
        make.top.equalTo(_whiteView).offset(69 *SIZE);
        make.width.mas_equalTo(120 *SIZE);
    }];
    
    [_yearL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(230 *SIZE);
        make.top.equalTo(_whiteView).offset(69 *SIZE);
        make.width.mas_equalTo(110 *SIZE);
    }];
    
    [_yearTL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(230 *SIZE);
        make.top.equalTo(_whiteView).offset(69 *SIZE);
        make.width.mas_equalTo(110 *SIZE);
    }];
}

@end
