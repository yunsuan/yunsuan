//
//  LookMaintainDetailRoomCell.m
//  云渠道
//
//  Created by 谷治墙 on 2019/1/23.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "LookMaintainDetailRoomCell.h"

@implementation LookMaintainDetailRoomCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    _roomImg = [[UIImageView alloc] init];
    [self.contentView addSubview:_roomImg];
    
    for (int i = 0; i < 8; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = YJContentLabColor;
        label.font = [UIFont systemFontOfSize:11 *SIZE];
        switch (i) {
            case 0:
            {
                _codeL = label;
                _codeL.textColor = YJTitleLabColor;
                _codeL.font = [UIFont systemFontOfSize:13 *SIZE];
                [self.contentView addSubview:label];
                break;
            }
            case 1:
            {
                _satisfyL = label;
                [self.contentView addSubview:_satisfyL];
                break;
            }
            case 2:
            {
                _contentL = label;
                [self.contentView addSubview:_contentL];
                break;
            }
            case 3:
            {
                _compL = label;
                [self.contentView addSubview:_compL];
                break;
            }
            case 4:
            {
                _firstTimeL = label;
                [self.contentView addSubview:_firstTimeL];
                break;
            }
            case 5:
            {
                _lastTimeL = label;
                [self.contentView addSubview:_lastTimeL];
                break;
            }
            case 6:
            {
                _numL = label;
                [self.contentView addSubview:_numL];
                break;
            }
            case 7:
            {
                _priceL = label;
                [self.contentView addSubview:_priceL];
                break;
            }
            default:
                break;
        }
    }
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_roomImg mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(12 *SIZE);
        make.top.equalTo(self.contentView).offset(16 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
        make.height.mas_equalTo(88 *SIZE);
    }];
    
    [_codeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(123 *SIZE);
        make.top.equalTo(self.contentView).offset(16 *SIZE);
        make.width.mas_equalTo(150 *SIZE);
    }];
    
    [_satisfyL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-12 *SIZE);
        make.top.equalTo(self.contentView).offset(16 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(123 *SIZE);
        make.top.equalTo(_codeL.mas_bottom).offset(7 *SIZE);
        make.width.mas_equalTo(150 *SIZE);
    }];
    
    [_compL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-12 *SIZE);
        make.top.equalTo(_satisfyL).offset(7 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_firstTimeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(123 *SIZE);
        make.top.equalTo(_contentL.mas_bottom).offset(7 *SIZE);
        make.width.mas_equalTo(200 *SIZE);
    }];
    
    [_lastTimeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(123 *SIZE);
        make.top.equalTo(_firstTimeL.mas_bottom).offset(7 *SIZE);
        make.width.mas_equalTo(200 *SIZE);
    }];
    
    [_numL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(123 *SIZE);
        make.top.equalTo(_lastTimeL.mas_bottom).offset(7 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
    }];
    
    [_satisfyL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-12 *SIZE);
        make.top.equalTo(_lastTimeL.mas_bottom).offset(7 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
        
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(_roomImg.mas_bottom).offset(19 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
    }];
}

@end
