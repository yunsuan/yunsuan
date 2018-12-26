//
//  RentingAllRoomStoreDetailCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/12/25.
//  Copyright © 2018 xiaoq. All rights reserved.
//

#import "RentingAllRoomStoreCell.h"

@implementation RentingAllRoomStoreCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setModel:(RentingAllRoomStoreModel *)model{
    
    [_tagView setData:model.project_tags];
    [_tagView2 setData:model.house_tags];
    
    _transferL.text = [NSString stringWithFormat:@"转让费：%@元",model.transfer_money];
    _depositL.text = [NSString stringWithFormat:@"押金：%@元",model.deposit];
    _roomLevelL.text = [NSString stringWithFormat:@"房源等级：%@",model.level];
    _rentTypeL.text = [NSString stringWithFormat:@"租赁类型：%@",model.rent_type];
    _payWayL.text = [NSString stringWithFormat:@"收款方式：%@",[model.receive_way componentsJoinedByString:@","]];
    _minPeriodL.text = [NSString stringWithFormat:@"最短租期：%@",model.rent_min_comment];
    _maxPeriodL.text = [NSString stringWithFormat:@"最长租期：%@",model.rent_max_comment];
    if ([model.check_in_time containsString:@"0000"]) {
        
        _inTimeL.text = @"可入住时间：随时入住";
    }else{
        
        _inTimeL.text = [NSString stringWithFormat:@"可入住时间：%@",model.check_in_time];
    }
    
    _seeL.text = [NSString stringWithFormat:@"看房方式：%@",model.check_way];
    if ([model.rent_free_month integerValue] == 0) {
        
        _rentFreeL.text = @"免租期：无";
    }else{
        
        _rentFreeL.text = [NSString stringWithFormat:@"免租期：%@",model.rent_free_month];
    }
    
    _commercailL.text = [NSString stringWithFormat:@"适合业态：%@",model.format_tags];
    _intentL.text = [NSString stringWithFormat:@"出租意愿度：%@",model.intent];
    _urgentL.text = [NSString stringWithFormat:@"出租急迫度：%@",model.urgency];
    _markL.text = [NSString stringWithFormat:@"%@",model.comment];
}

- (void)initUI{
    
    _tagView = [[TagView alloc] initWithFrame:CGRectMake(10 *SIZE, 15 *SIZE, 300 *SIZE, 20 *SIZE) type:@"1"];
    [self.contentView addSubview:_tagView];
    
    _tagView2 = [[TagView alloc] initWithFrame:CGRectMake(10 *SIZE, 46 *SIZE, 300 *SIZE, 20 *SIZE) type:@"1"];
    [self.contentView addSubview:_tagView2];
    
    _markView = [[UIView alloc] init];
    _markView.backgroundColor = COLOR(244, 244, 244, 1);
    [self.contentView addSubview:_markView];
    
    for (int i = 0; i < 14; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = YJ86Color;
//        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        
        switch (i) {
                
            case 0:{
                
                _transferL = label;
                [self.contentView addSubview:_transferL];
                break;
            }
            case 1:{
                
                _depositL = label;
                [self.contentView addSubview:_depositL];
                break;
            }
            case 2:{
                
                _roomLevelL = label;
                [self.contentView addSubview:_roomLevelL];
                break;
            }
            case 3:{
                
                _rentTypeL = label;
                [self.contentView addSubview:_rentTypeL];
                break;
            }
            case 4:{
                
                _payWayL = label;
                [self.contentView addSubview:_payWayL];
                break;
            }
            case 5:{
                
                _minPeriodL = label;
                [self.contentView addSubview:_minPeriodL];
                break;
            }
            case 6:{
                
                _maxPeriodL = label;
                [self.contentView addSubview:_maxPeriodL];
                break;
            }
            case 7:{
                
                _inTimeL = label;
                [self.contentView addSubview:_inTimeL];
                break;
            }
            case 8:{
                
                _seeL = label;
                [self.contentView addSubview:_seeL];
                break;
            }
            case 9:{
                
                _rentFreeL = label;
                [self.contentView addSubview:_rentFreeL];
                break;
            }
            case 10:{
                
                _commercailL = label;
                [self.contentView addSubview:_commercailL];
                break;
            }
            case 11:{
                
                _intentL = label;
                [self.contentView addSubview:_intentL];
                break;
            }
            case 12:{
                
                _urgentL = label;
                [self.contentView addSubview:_urgentL];
                break;
            }
            case 13:{
                
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
    
    [_transferL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(76 *SIZE);
        make.width.equalTo(@(150 *SIZE));
    }];
    
    [_depositL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(200 *SIZE);
        make.top.equalTo(self.contentView).offset(76 *SIZE);
        make.width.equalTo(@(150 *SIZE));
    }];
    
    [_roomLevelL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(_transferL.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(150 *SIZE));
    }];
    
    [_rentTypeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(200 *SIZE);
        make.top.equalTo(_depositL.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(150 *SIZE));
    }];
    
    [_payWayL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(_roomLevelL.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(340 *SIZE));
    }];
    
    [_minPeriodL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(_payWayL.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(150 *SIZE));
    }];
    
    [_maxPeriodL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(200 *SIZE);
        make.top.equalTo(_payWayL.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(150 *SIZE));
    }];
    
    [_inTimeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(_minPeriodL.mas_bottom).offset(15 *SIZE);
        make.width.equalTo(@(150 *SIZE));
    }];
    
    [_seeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(200 *SIZE);
        make.top.equalTo(_maxPeriodL.mas_bottom).offset(15 *SIZE);
        make.width.equalTo(@(150 *SIZE));
    }];
    
    [_rentFreeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(_inTimeL.mas_bottom).offset(15 *SIZE);
        make.width.equalTo(@(150 *SIZE));
    }];
    
    [_commercailL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(200 *SIZE);
        make.top.equalTo(_seeL.mas_bottom).offset(15 *SIZE);
        make.width.equalTo(@(150 *SIZE));
    }];
    
    [_intentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(200 *SIZE);
        make.top.equalTo(_rentFreeL.mas_bottom).offset(15 *SIZE);
        make.width.equalTo(@(150 *SIZE));
    }];
    
    [_urgentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(_commercailL.mas_bottom).offset(15 *SIZE);
        make.width.equalTo(@(150 *SIZE));
    }];
    
    [_markView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(_urgentL.mas_bottom).offset(16 *SIZE);
        make.width.equalTo(@(340 *SIZE));
        make.bottom.equalTo(self.contentView).offset(-16 *SIZE);
    }];
    
    [_markL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_markView).offset(4 *SIZE);
        make.top.equalTo(_markView).offset(15 *SIZE);
        make.width.equalTo(@(330 *SIZE));
        make.bottom.equalTo(_markView).offset(-15 *SIZE);
    }];
    
}

@end
