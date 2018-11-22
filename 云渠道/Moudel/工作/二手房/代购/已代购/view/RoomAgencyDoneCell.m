//
//  RoomAgencyDoneBtn.m
//  云渠道
//
//  Created by 谷治墙 on 2018/6/20.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RoomAgencyDoneCell.h"

@implementation RoomAgencyDoneCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    for (int i = 0; i < 8; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = YJ86Color;
        label.font = [UIFont systemFontOfSize:11 *SIZE];
        switch (i) {
            case 0:
            {
                label.textColor = YJTitleLabColor;
                label.font = [UIFont systemFontOfSize:13 *SIZE];
                _roomCodeL = label;
                [self.contentView addSubview:_roomCodeL];
                break;
            }
            case 1:
            {
                label.textColor = YJTitleLabColor;
                label.font = [UIFont systemFontOfSize:13 *SIZE];
                _tradeCodeL = label;
                [self.contentView addSubview:_tradeCodeL];
                break;
            }
            case 2:
            {
                _agentL = label;
                [self.contentView addSubview:_agentL];
                break;
            }
            case 3:
            {
                _timeL = label;
                [self.contentView addSubview:_timeL];
                break;
            }
            case 4:
            {
                label.textColor = [UIColor whiteColor];
                label.backgroundColor = YJBlueBtnColor;
                label.layer.cornerRadius = 2 *SIZE;
                label.clipsToBounds = YES;
                label.textAlignment = NSTextAlignmentCenter;
                _validL = label;
                [self.contentView addSubview:_validL];
                break;
            }
            case 5:
            {
                label.textColor = [UIColor whiteColor];
                label.backgroundColor = COLOR(27, 152, 255, 0.4);
                label.layer.cornerRadius = 2 *SIZE;
                label.clipsToBounds = YES;
                label.textAlignment = NSTextAlignmentCenter;
                _auditL = label;
                [self.contentView addSubview:_auditL];
                break;
            }
            case 6:
            {
                label.textColor = [UIColor whiteColor];
                label.backgroundColor = COLOR(220, 220, 220, 1);
                label.layer.cornerRadius = 2 *SIZE;
                label.clipsToBounds = YES;
                label.textAlignment = NSTextAlignmentCenter;
                _payL = label;
                [self.contentView addSubview:_payL];
                break;
            }
            case 7:
            {
                _recommendL = label;
                [self.contentView addSubview:_recommendL];
                break;
            }
            default:
                break;
        }
    }
    
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = YJBackColor;
    [self.contentView addSubview:_lineView];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_roomCodeL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(16 *SIZE);
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
    [_tradeCodeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(_roomCodeL.mas_bottom).offset(6 *SIZE);
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
//    [_recommendL mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self.contentView).offset(10 *SIZE);
//        make.top.equalTo(_tradeCodeL.mas_bottom).offset(6 *SIZE);
//        make.right.equalTo(self.contentView).offset(-10 *SIZE);
//    }];
    
    [_agentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(_tradeCodeL.mas_bottom).offset(6 *SIZE);
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(_agentL.mas_bottom).offset(6 *SIZE);
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
    [_validL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(_timeL.mas_bottom).offset(7 *SIZE);
        make.width.mas_equalTo(40 *SIZE);
        make.height.mas_equalTo(17 *SIZE);
    }];
    
    [_auditL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_validL.mas_right).offset(5 *SIZE);
        make.top.equalTo(_timeL.mas_bottom).offset(7 *SIZE);
//        make.right.equalTo(self.contentView).offset(-16 *SIZE);
        make.width.mas_equalTo(40 *SIZE);
        make.height.mas_equalTo(17 *SIZE);
    }];
    
    [_payL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_auditL.mas_right).offset(5 *SIZE);
        make.top.equalTo(_timeL.mas_bottom).offset(7 *SIZE);
//        make.left.equalTo(self.contentView).offset(-16 *SIZE);
        make.width.mas_equalTo(40 *SIZE);
        make.height.mas_equalTo(17 *SIZE);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(_payL.mas_bottom).offset(16 *SIZE);
        make.right.equalTo(self.contentView).offset(0 *SIZE);
        make.height.equalTo(@(SIZE));
        make.bottom.equalTo(self.contentView).offset(0);
    }];
}

@end
