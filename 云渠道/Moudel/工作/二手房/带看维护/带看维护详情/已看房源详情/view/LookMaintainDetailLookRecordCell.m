
//
//  LookMaintainDetailLookRecordCell.m
//  云渠道
//
//  Created by 谷治墙 on 2019/1/29.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "LookMaintainDetailLookRecordCell.h"

@implementation LookMaintainDetailLookRecordCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionEditBtn:(UIButton *)btn{
    
    if (self.lookMaintainDetailLookRecordCellBlock) {
        
        self.lookMaintainDetailLookRecordCellBlock(self.tag);
    }
}

- (void)initUI{
    
    for (int i = 0 ; i < 4; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = YJ86Color;
        label.font = [UIFont systemFontOfSize:12 *SIZE];
        switch (i) {
            case 0:
            {
                
                _timeL = label;
                [self.contentView addSubview:_timeL];
                break;
            }
            case 1:
            {
                
                _intentL = label;
                [self.contentView addSubview:_intentL];
                break;
            }
            case 2:
            {
                
                _isBuyL = label;
                [self.contentView addSubview:_isBuyL];
                break;
            }
            case 3:
            {
                
                _priceL = label;
                [self.contentView addSubview:_priceL];
                break;
            }
            default:
                break;
        }
    }
    
    _editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_editBtn addTarget:self action:@selector(ActionEditBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_editBtn setImage:[UIImage imageNamed:@"edit"] forState:UIControlStateNormal];
    [self.contentView addSubview:_editBtn];
    
    _line = [[UIView alloc] init];
    _line.backgroundColor = YJBackColor;
    [self.contentView addSubview:_line];
    
    [self masonryUI];
}

- (void)masonryUI{
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(15 *SIZE);
        make.width.mas_offset(70 *SIZE);
    }];
    
    [_intentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(92 *SIZE);
        make.top.equalTo(self.contentView).offset(15 *SIZE);
        make.width.mas_offset(70 *SIZE);
    }];
    
    [_isBuyL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(174 *SIZE);
        make.top.equalTo(self.contentView).offset(15 *SIZE);
        make.width.mas_offset(70 *SIZE);
    }];
    
    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(263 *SIZE);
        make.top.equalTo(self.contentView).offset(15 *SIZE);
        make.width.mas_offset(70 *SIZE);
    }];
    
    [_editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(326 *SIZE);
        make.top.equalTo(self.contentView).offset(8 *SIZE);
        make.width.height.mas_offset(26 *SIZE);
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(_timeL.mas_bottom).offset(14 *SIZE);
        make.width.mas_offset(SCREEN_Width);
        make.width.mas_offset(SIZE);
    }];
}

@end
