
//
//  LookMaintainAddRoomCell.m
//  云渠道
//
//  Created by 谷治墙 on 2019/1/25.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "LookMaintainAddRoomCell.h"

@implementation LookMaintainAddRoomCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setDicData:(NSMutableDictionary *)dicData{
    
    [_roomImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,dicData[@""]]] placeholderImage:[UIImage imageNamed:@""] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
       
        if (error) {
            
            _roomImg.image = [UIImage imageNamed:@""];
        }
    }];
    
    _codeL.text = [NSString stringWithFormat:@"房源编号：%@",dicData[@""]];
    _titleL.text = [NSString stringWithFormat:@"%@",dicData[@""]];
    _contentL.text = [NSString stringWithFormat:@"%@",dicData[@""]];
    _priceL.text = [NSString stringWithFormat:@"%@万",dicData[@""]];
    _unitPriceL.text = [NSString stringWithFormat:@"%@元/㎡",dicData[@""]];
    _seeWayL.text = [NSString stringWithFormat:@"%@",dicData[@""]];
}

- (void)initUI{
    
    _roomImg = [[UIImageView alloc] init];
    [self.contentView addSubview:_roomImg];
    
    for (int i = 0; i < 6; i++) {
        
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
                _titleL = label;
                [self.contentView addSubview:_titleL];
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
                _priceL = label;
                [self.contentView addSubview:_priceL];
                break;
            }
            case 4:
            {
                _unitPriceL = label;
                [self.contentView addSubview:_unitPriceL];
                break;
            }
            case 5:
            {
                _seeWayL = label;
                [self.contentView addSubview:_seeWayL];
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
        make.width.mas_equalTo(240 *SIZE);
    }];
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-12 *SIZE);
        make.top.equalTo(_codeL.mas_bottom).offset(8 *SIZE);
        make.width.mas_equalTo(240 *SIZE);
    }];
    
    [_contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(123 *SIZE);
        make.top.equalTo(_titleL.mas_bottom).offset(7 *SIZE);
        make.width.mas_equalTo(240 *SIZE);
    }];
    
    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-12 *SIZE);
        make.top.equalTo(_contentL.mas_bottom).offset(7 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_unitPriceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(180 *SIZE);
        make.top.equalTo(_contentL.mas_bottom).offset(7 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_seeWayL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(123 *SIZE);
        make.top.equalTo(_priceL.mas_bottom).offset(7 *SIZE);
        make.width.mas_equalTo(200 *SIZE);
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(_roomImg.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
    }];
}

@end
