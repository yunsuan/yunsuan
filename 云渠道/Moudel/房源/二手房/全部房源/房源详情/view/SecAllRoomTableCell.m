//
//  SecAllRoomTableCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/6/11.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "SecAllRoomTableCell.h"

@implementation SecAllRoomTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setModel:(SecAllRoomProjectModel *)model{
    
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
    
//    if ([model.unit_price integerValue]) {
//
//        _yearL.text = [NSString stringWithFormat:@"建成年代：%@",model.price];
//    }else{
//
        _yearL.text = [NSString stringWithFormat:@"建成年代：暂无数据"];
//    }
    
    
    if (model.decoration.length) {
        
        _decorateL.text = [NSString stringWithFormat:@"装修：%@",model.decoration];
    }else{
        
        _decorateL.text = [NSString stringWithFormat:@"装修：暂无数据"];
    }
    
    if (model.permit_time.length) {
        
        _timeL.text = [NSString stringWithFormat:@"拿证时间：%@",model.permit_time];
    }else{
        
        _timeL.text = [NSString stringWithFormat:@"拿证时间：暂无数据"];
    }
    
    if (model.floor_type.length) {
        
        _floorL.text = [NSString stringWithFormat:@"楼层：%@",model.floor_type];
    }else{
        
        _floorL.text = [NSString stringWithFormat:@"楼层：暂无数据"];
    }
    
    if (model.check_in_time.length) {
        
        _inTimeL.text = [NSString stringWithFormat:@"可入住时间：%@后",model.check_in_time];
    }else{
        
        _inTimeL.text = [NSString stringWithFormat:@"可入住时间：暂无数据"];
    }
    
    if ([model.property_limit integerValue]) {
        
        _proLimitL.text = [NSString stringWithFormat:@"产权年限：%@年",model.property_limit];
    }else{
        
        _proLimitL.text = [NSString stringWithFormat:@"产权年限：暂无数据"];
    }
    
    if (model.comment.length) {
        
        _markL.text = [NSString stringWithFormat:@" 其他要求：%@\n",model.comment];
    }else{
        
        _markL.text = [NSString stringWithFormat:@"其他要求：暂无数据"];
    }
}

- (void)setOfficeModel:(SecAllRoomOfficeModel *)officeModel{
    
    [_tagView setData:officeModel.project_tags];
    [_tagView2 setData:officeModel.house_tags];
    
    if ([officeModel.unit_price integerValue]) {
        
        _codeL.text = [NSString stringWithFormat:@"房源编号：%@",officeModel.price];
    }else{
        
        _codeL.text = [NSString stringWithFormat:@"房源编号：暂无数据"];
    }
    
    
    if ([officeModel.unit_price integerValue]) {
        
        _priceL.text = [NSString stringWithFormat:@"单价：%@元/m²",officeModel.unit_price];
    }else{
        
        _priceL.text = [NSString stringWithFormat:@"单价：暂无数据"];
    }
    
    if (officeModel.permit_time.length) {
        
        _yearL.text = [NSString stringWithFormat:@"拿证时间：%@",officeModel.permit_time];
    }else{
        
        _yearL.text = [NSString stringWithFormat:@"拿证时间：暂无数据"];
    }
    
    
    if ([officeModel.property_limit integerValue]) {
        
        _decorateL.text = [NSString stringWithFormat:@"产权年限：%@年",officeModel.property_limit];
    }else{
        
        _decorateL.text = [NSString stringWithFormat:@"产权年限：暂无数据"];
    }
    
    if (officeModel.floor_type.length) {
        
        _timeL.text = [NSString stringWithFormat:@"楼层：%@",officeModel.floor_type];
    }else{
        
        _timeL.text = [NSString stringWithFormat:@"楼层：暂无数据"];
    }
    
    if ([officeModel.rent_money integerValue]) {
        
        _floorL.text = [NSString stringWithFormat:@"当前租金：%@元/㎡",officeModel.rent_money];
    }else{
        
        _floorL.text = [NSString stringWithFormat:@"当前租金：暂无数据"];
    }
    
    if (officeModel.rent_over_time.length) {
        
        _inTimeL.text = [NSString stringWithFormat:@"租期结束时间：%@",officeModel.rent_over_time];
    }else{
        
        _inTimeL.text = [NSString stringWithFormat:@"租期结束时间：暂无数据"];
    }
    
    _proLimitL.textColor = YJBlueBtnColor;
//    if ([officeModel.unit_price integerValue]) {
//
//        _proLimitL.text = [NSString stringWithFormat:@"参考租金：%@",officeModel.price];
//    }else{
//
        _proLimitL.text = [NSString stringWithFormat:@"参考租金：暂无数据"];
//    }
    
    if (officeModel.comment.length) {
        
        _markL.text = [NSString stringWithFormat:@" 其他要求：%@\n",officeModel.comment];
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
//                [self.contentView addSubview:_codeL];
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
                _yearL = label;
                [self.contentView addSubview:_yearL];
                break;
            }
            case 3:
            {
                _decorateL = label;
                [self.contentView addSubview:_decorateL];
                break;
            }
            case 4:
            {
                _timeL = label;
                [self.contentView addSubview:_timeL];
                break;
            }
            case 5:
            {
                _floorL = label;
                [self.contentView addSubview:_floorL];
                break;
            }
            case 6:
            {
                _inTimeL = label;
                [self.contentView addSubview:_inTimeL];
                break;
            }
            case 7:
            {
                _proLimitL = label;
                [self.contentView addSubview:_proLimitL];
                break;
            }
            case 8:
            {
                _markL = label;
//                _markL.backgroundColor = COLOR(244, 244, 244, 1);
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
    
    [_yearL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(_priceL.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(150 *SIZE));
    }];
    
    [_decorateL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(200 *SIZE);
        make.top.equalTo(self.contentView).offset(76 *SIZE);
        make.width.equalTo(@(150 *SIZE));

        
//        make.left.equalTo(self.contentView).offset(200 *SIZE);
//        make.top.equalTo(_priceL.mas_bottom).offset(19 *SIZE);
//        make.width.equalTo(@(150 *SIZE));
    }];
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(_yearL.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(150 *SIZE));
    }];
    
    
    [_floorL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.left.equalTo(self.contentView).offset(200 *SIZE);
        make.top.equalTo(_priceL.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(150 *SIZE));

//        make.left.equalTo(self.contentView).offset(200 *SIZE);
//        make.top.equalTo(_decorateL.mas_bottom).offset(19 *SIZE);
//        make.width.equalTo(@(150 *SIZE));
    }];
    
    [_inTimeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(_timeL.mas_bottom).offset(19 *SIZE);
//        make.width.equalTo(@(150 *SIZE));
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
    [_proLimitL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.left.equalTo(self.contentView).offset(200 *SIZE);
        make.top.equalTo(_floorL.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(150 *SIZE));
//        make.left.equalTo(self.contentView).offset(200 *SIZE);
//        make.top.equalTo(_floorL.mas_bottom).offset(19 *SIZE);
//        make.width.equalTo(@(150 *SIZE));
    }];
    
    [_markView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(_inTimeL.mas_bottom).offset(16 *SIZE);
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
