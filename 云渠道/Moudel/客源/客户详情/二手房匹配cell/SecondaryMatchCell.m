//
//  SecondaryMatchCell.m
//  云渠道
//
//  Created by 谷治墙 on 2019/1/27.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "SecondaryMatchCell.h"

@implementation SecondaryMatchCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    if ([dataDic[@"fit_store_num"] integerValue]) {
        
        _storeL.text = [NSString stringWithFormat:@"匹配门店数：%@",dataDic[@"fit_store_num"]];
    }else{
        
        _storeL.text = @"匹配门店数：0";
    }
    
    if ([dataDic[@"fit_house_num"] integerValue]) {
        
        _roomL.text = [NSString stringWithFormat:@"匹配房源数量：%@",dataDic[@"fit_house_num"]];
    }else{
        
        _roomL.text = @"匹配房源数量：0";
    }
    
    if ([dataDic[@"is_take_num"] integerValue]) {
        
        _roomSeeL.text = [NSString stringWithFormat:@"已看房源数量：%@",dataDic[@"is_take_num"]];
    }else{
        
        _roomSeeL.text = @"已看房源数量：0";
    }
    
    if ([dataDic[@"is_recommend_num"] integerValue]) {
        
        _storeAllL.text = [NSString stringWithFormat:@"已推荐门店总数：%@",dataDic[@"is_recommend_num"]];
    }else{
        
        _storeAllL.text = @"已推荐门店总数：0";
    }
}

- (void)initUI{
    
    for (int i = 0; i < 4; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = YJ86Color;
        label.font = [UIFont systemFontOfSize:12 *SIZE];
        switch (i) {
            case 0:
            {
                _storeL = label;
                [self.contentView addSubview:_storeL];
                break;
            }
            case 1:
            {
                _storeAllL = label;
                _storeAllL.textAlignment = NSTextAlignmentRight;
                [self.contentView addSubview:_storeAllL];
                break;
            }
            case 2:
            {
                _roomL = label;
                [self.contentView addSubview:_roomL];
                break;
            }
            case 3:
            {
                _roomSeeL = label;
                _roomSeeL.textAlignment = NSTextAlignmentRight;
                [self.contentView addSubview:_roomSeeL];
                break;
            }
            default:
                break;
        }
    }
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_storeL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(11 *SIZE);
        make.top.equalTo(self.contentView).offset(16 *SIZE);
        make.width.mas_equalTo(150 *SIZE);
    }];
    
    [_storeAllL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-12 *SIZE);
        make.top.equalTo(self.contentView).offset(16 *SIZE);
        make.width.mas_equalTo(150 *SIZE);
    }];
    
    [_roomL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(11 *SIZE);
        make.top.equalTo(_storeL.mas_bottom).offset(15 *SIZE);
        make.width.mas_equalTo(150 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-16 *SIZE);
    }];
    
    [_roomSeeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-12 *SIZE);
        make.top.equalTo(_storeAllL.mas_bottom).offset(15 *SIZE);
        make.width.mas_equalTo(150 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-16 *SIZE);
    }];
}

@end
