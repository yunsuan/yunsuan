//
//  RentingAllRoomTableCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/7/23.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RentingAllRoomTableCell.h"

@implementation RentingAllRoomTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setModel:(RentingAllRoomProjectModel *)model{
    
    [_tagView setData:model.project_tags];
    [_tagView2 setData:model.house_tags];
}

- (void)initUI{
    
    _tagView = [[TagView alloc] initWithFrame:CGRectMake(10 *SIZE, 15 *SIZE, 300 *SIZE, 20 *SIZE) type:@"1"];
    [self.contentView addSubview:_tagView];
    
    _tagView2 = [[TagView alloc] initWithFrame:CGRectMake(10 *SIZE, 46 *SIZE, 300 *SIZE, 20 *SIZE) type:@"1"];
    [self.contentView addSubview:_tagView2];
    
    for (int i = 0; i < 7; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = YJ86Color;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        
        switch (i) {
//            case 0:
//            {
//                _plotL = label;
//                [self.contentView addSubview:_plotL];
//                break;
//            }
//            case 1:
//            {
//                _floorL = label;
//                [self.contentView addSubview:_floorL];
//                break;
//            }
//            case 2:
//            {
//                _classL = label;
//                [self.contentView addSubview:_classL];
//                break;
//            }
            case 0:
            {
                _payWayL = label;
                [self.contentView addSubview:_payWayL];
                break;
            }
//            case 4:
//            {
//                _periodL = label;
//                [self.contentView addSubview:_periodL];
//                break;
//            }
            case 1:
            {
                _liftL = label;
                [self.contentView addSubview:_liftL];
                break;
            }
            case 2:
            {
                _seeL = label;
                [self.contentView addSubview:_seeL];
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
                _faceL = label;
                [self.contentView addSubview:_faceL];
                break;
            }
//            case 9:
//            {
//
//                _intakeL = label;
//                [self.contentView addSubview:_intakeL];
//                break;
//            }
            case 5:
            {
                _intentL = label;
                [self.contentView addSubview:_intentL];
                break;
            }
            case 6:
            {
                _urgentL = label;
                [self.contentView addSubview:_urgentL];
                break;
            }
            default:
                break;
        }
    }
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
//    [_plotL mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self.contentView).offset(10 *SIZE);
//        make.top.equalTo(self.contentView).offset(76 *SIZE);
//        make.width.equalTo(@(150 *SIZE));
//    }];
//
//    [_floorL mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self.contentView).offset(200 *SIZE);
//        make.top.equalTo(self.contentView).offset(76 *SIZE);
//        make.width.equalTo(@(150 *SIZE));
//    }];
//
//
//    [_classL mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self.contentView).offset(200 *SIZE);
//        make.top.equalTo(_plotL.mas_bottom).offset(19 *SIZE);
//        make.width.equalTo(@(150 *SIZE));
//    }];
    
    [_payWayL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(76 *SIZE);
        make.width.equalTo(@(150 *SIZE));
    }];
    
//    [_periodL mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self.contentView).offset(200 *SIZE);
//        make.top.equalTo(_classL.mas_bottom).offset(19 *SIZE);
//        make.width.equalTo(@(150 *SIZE));
//    }];
    
    [_liftL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(_payWayL.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(150 *SIZE));
    }];
    
    [_seeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(200 *SIZE);
        make.top.equalTo(self.contentView).offset(76 *SIZE);
        make.width.equalTo(@(150 *SIZE));
    }];
    
    [_decorateL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(200 *SIZE);
        make.top.equalTo(_seeL.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(150 *SIZE));
        
    }];
    
    [_faceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(_liftL.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(150 *SIZE));
    }];
    
//    [_intakeL mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self.contentView).offset(10 *SIZE);
//        make.top.equalTo(_decorateL.mas_bottom).offset(19 *SIZE);
//        make.width.equalTo(@(150 *SIZE));
//    }];
    
    [_intentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(_faceL.mas_bottom).offset(15 *SIZE);
        make.width.equalTo(@(150 *SIZE));
        make.bottom.equalTo(self.contentView).offset(-12 *SIZE);
    }];
    
    [_urgentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(200 *SIZE);
        make.top.equalTo(_faceL.mas_bottom).offset(15 *SIZE);
        make.width.equalTo(@(150 *SIZE));
        make.bottom.equalTo(self.contentView).offset(-12 *SIZE);
    }];
    
}

@end
