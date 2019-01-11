//
//  ContractSignListCell.m
//  云渠道
//
//  Created by 谷治墙 on 2019/1/10.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "ContractSignListCell.h"

@implementation ContractSignListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    //    _codeL.text = [NSString stringWithFormat:@"客户编号：%@",dataDic[@""]];
    //    _houseCodeL.text = [NSString stringWithFormat:@"房源编号：%@",dataDic[@""]];
    //    _nameL.text = [NSString stringWithFormat:@"名称：%@",dataDic[@""]];
    //    _phoneL.text = [NSString stringWithFormat:@"%@",dataDic[@""]];
    //    _numL.text = [NSString stringWithFormat:@"已看房数量：%@",dataDic[@""]];
}

- (void)initUI{
    
    _headImg = [[UIImageView alloc] init];
    _headImg.contentMode = UIViewContentModeScaleAspectFill;
    _headImg.clipsToBounds = YES;
    [self.contentView addSubview:_headImg];
    
    _statusL = [[UILabel alloc] init];
//    _statusL.textColor = YJ86Color;
    _statusL.font = [UIFont systemFontOfSize:10 *SIZE];
    [self.contentView addSubview:_statusL];
    
    _codeL = [[UILabel alloc] init];
    _codeL.textColor = YJTitleLabColor;
    _codeL.font = [UIFont systemFontOfSize:14 *SIZE];
    [self.contentView addSubview:_codeL];
    
    _priceL = [[UILabel alloc] init];
    _priceL.textColor = YJTitleLabColor;
    _priceL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_priceL];
    
    _areaL = [[UILabel alloc] init];
    _areaL.textColor = YJTitleLabColor;
    _areaL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_areaL];
    
    _customL = [[UILabel alloc] init];
    _customL.textColor = YJ86Color;
    _customL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_customL];
    
    _ownerL = [[UILabel alloc] init];
    _ownerL.textColor = YJ86Color;
    _ownerL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_ownerL];
    
    _signerL = [[UILabel alloc] init];
    _signerL.textColor = YJ86Color;
    _signerL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_signerL];
    
    _timeL = [[UILabel alloc] init];
    _timeL.textColor = YJ86Color;
    _timeL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_timeL];
    
    _line = [[UIView alloc] init];
    _line.backgroundColor = YJBackColor;
    [self.contentView addSubview:_line];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_headImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(16 *SIZE);
        make.height.with.mas_equalTo(67 *SIZE);
    }];
    
    [_statusL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_headImg).offset(0 *SIZE);
        make.top.equalTo(_headImg.mas_bottom).offset(50 *SIZE);
        make.width.mas_equalTo(67 *SIZE);
        make.height.mas_equalTo(17 *SIZE);
    }];
    
    [_codeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(93 *SIZE);
        make.top.equalTo(_codeL.mas_bottom).offset(16 *SIZE);
        make.width.mas_equalTo(200 *SIZE);
    }];
    
    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(300 *SIZE);
        make.top.equalTo(_codeL.mas_bottom).offset(16 *SIZE);
        make.width.mas_equalTo(50 *SIZE);
    }];
    
    [_areaL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(92 *SIZE);
        make.top.equalTo(_codeL.mas_bottom).offset(11 *SIZE);
        make.width.mas_equalTo(200 *SIZE);
    }];
    
    [_customL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(_codeL.mas_bottom).offset(11 *SIZE);
        make.width.mas_equalTo(50 *SIZE);
    }];
    
    [_ownerL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(92 *SIZE);
        make.top.equalTo(_areaL.mas_bottom).offset(11 *SIZE);
        make.width.mas_equalTo(200 *SIZE);
    }];
    
    [_signerL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(_areaL.mas_bottom).offset(11 *SIZE);
        make.width.mas_equalTo(50 *SIZE);
    }];
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(92 *SIZE);
        make.top.equalTo(_ownerL.mas_bottom).offset(11 *SIZE);
        make.width.mas_equalTo(200 *SIZE);
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(_timeL.mas_bottom).offset(15 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
    }];
}

@end
