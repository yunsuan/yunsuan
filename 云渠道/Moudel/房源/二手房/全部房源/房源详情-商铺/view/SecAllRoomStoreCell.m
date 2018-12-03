//
//  SecAllRoomStoreCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/9/27.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "SecAllRoomStoreCell.h"

@implementation SecAllRoomStoreCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setModel:(SecAllRoomStoreModel *)model{
    
    [_tagView setData:model.project_tags];
    [_tagView2 setData:model.house_tags];
    
    if (model.house_code.length) {
        
        _codeL.text = [NSString stringWithFormat:@"房源编号：%@",model.house_code];
    }else{
        
        _codeL.text = [NSString stringWithFormat:@"房源编号：暂无数据"];
    }
    
    if ([model.unit_price integerValue]) {
        
        _priceL.text = [NSString stringWithFormat:@"单价：%@元/m²",model.unit_price];
    }else{
        
        _priceL.text = [NSString stringWithFormat:@"单价：暂无数据"];
    }
    
    if (model.permit_time.length) {
        
        _proLimitL.text = [NSString stringWithFormat:@"拿证时间：%@",model.permit_time];
    }else{
        
        _proLimitL.text = [NSString stringWithFormat:@"拿证时间：暂无数据"];
    }
    
    if ([model.property_limit integerValue]) {
        
        _yearL.text = [NSString stringWithFormat:@"产权年限：%@",model.property_limit];
    }else{
        
        _yearL.text = [NSString stringWithFormat:@"产权年限：暂无数据"];
    }
    
    
    if ([model.rent_money integerValue]) {
        
        _rentL.text = [NSString stringWithFormat:@"当前租金：%@元/月",model.rent_money];
    }else{
        
        _rentL.text = [NSString stringWithFormat:@"当前租金：暂无数据"];
    }
    
    if ([model.reference_rent integerValue]) {
        
        _reRentL.text = [NSString stringWithFormat:@"参考租金：%@元/月",model.reference_rent];
    }else{
        
        _reRentL.text = [NSString stringWithFormat:@"参考租金：暂无数据"];
    }
    
    if ([model.rent_over_time integerValue]) {
        
        _endTimeL.text = [NSString stringWithFormat:@"租期结束时间：%@",model.rent_over_time];
    }else{
        
        _endTimeL.text = [NSString stringWithFormat:@"租期结束时间：暂无数据"];
    }
    
    if (model.format_tags.length) {
        
        _formatL.text = [NSString stringWithFormat:@"适合业态：%@",model.format_tags];
    }else{
        
        _formatL.text = [NSString stringWithFormat:@"适合业态：暂无数据"];
    }
    
    if (model.comment.length) {
        
        _markL.text = [NSString stringWithFormat:@" 其他要求：%@\n",model.comment];
    }else{
        
        _markL.text = [NSString stringWithFormat:@"其他要求：暂无数据"];
    }
}

- (void)initUI{
    
    _tagView = [[TagView alloc] initWithFrame:CGRectMake(10 *SIZE, 15 *SIZE, 300 *SIZE, 20 *SIZE) type:@"1"];
    [self.contentView addSubview:_tagView];
    
    _tagView2 = [[TagView alloc] initWithFrame:CGRectMake(10 *SIZE, 46 *SIZE, 300 *SIZE, 20 *SIZE) type:@"1"];
    [self.contentView addSubview:_tagView2];
    
    _markView = [[UIView alloc] init];
    _markView.backgroundColor = COLOR(244, 244, 244, 1);
    [self.contentView addSubview:_markView];
    
    for (int i = 0; i < 9; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = YJ86Color;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        
        switch (i) {
            case 0:
            {
                _codeL = label;
                [self.contentView addSubview:_codeL];
                break;
            }
            case 1:
            {
                _priceL = label;
                [self.contentView addSubview:_priceL];
                break;
            }
            case 2:
            {
                _proLimitL = label;
                [self.contentView addSubview:_proLimitL];
                break;
            }
            case 3:
            {
                _yearL = label;
                [self.contentView addSubview:_yearL];
                break;
            }
            case 4:
            {
                _rentL = label;
                [self.contentView addSubview:_rentL];
                break;
            }
            case 5:
            {
                _reRentL = label;
                [self.contentView addSubview:_reRentL];
                break;
            }
            case 6:
            {
                _endTimeL = label;
                [self.contentView addSubview:_endTimeL];
                break;
            }
            case 7:
            {
                _formatL = label;
                [self.contentView addSubview:_formatL];
                break;
            }
            case 8:
            {
                _markL = label;
                [_markView addSubview:_markL];
                break;
            }
            default:
                break;
        }
    }
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
//    [_codeL mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self.contentView).offset(10 *SIZE);
//        make.top.equalTo(self.contentView).offset(76 *SIZE);
//        make.width.equalTo(@(150 *SIZE));
//    }];
    
    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(76 *SIZE);
        make.width.equalTo(@(150 *SIZE));
//        make.left.equalTo(self.contentView).offset(200 *SIZE);
//        make.top.equalTo(self.contentView).offset(76 *SIZE);
//        make.width.equalTo(@(150 *SIZE));
    }];
    
    [_proLimitL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(200 *SIZE);
        make.top.equalTo(self.contentView).offset(76 *SIZE);
        make.width.equalTo(@(150 *SIZE));

//        make.left.equalTo(self.contentView).offset(10 *SIZE);
//        make.top.equalTo(_codeL.mas_bottom).offset(19 *SIZE);
//        make.width.equalTo(@(150 *SIZE));
    }];
    
    [_yearL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(200 *SIZE);
        make.top.equalTo(_priceL.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(150 *SIZE));
    }];
    
    [_rentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(_proLimitL.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(150 *SIZE));
    }];
    
    
    [_reRentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(200 *SIZE);
        make.top.equalTo(_yearL.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(150 *SIZE));
    }];
    
    [_formatL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(_rentL.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(300 *SIZE));
    }];
    
    [_endTimeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(_formatL.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(300 *SIZE));
    }];
    
    
    
    [_markView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(_endTimeL.mas_bottom).offset(16 *SIZE);
        make.width.equalTo(@(340 *SIZE));
        make.bottom.equalTo(self.contentView).offset(-16 *SIZE);
    }];
    
    [_markL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_markView).offset(4 *SIZE);
        make.top.equalTo(_markView).offset(15 *SIZE);
        make.width.equalTo(@(330 *SIZE));
        //        make.height.mas_equalTo(CGRectGetHeight(_markL) + 26 *SIZE);
        make.bottom.equalTo(_markView).offset(-15 *SIZE);
    }];
    
}

@end
