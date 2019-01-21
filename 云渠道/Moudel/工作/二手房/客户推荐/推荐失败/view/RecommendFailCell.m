//
//  RecommendFailCell.m
//  云渠道
//
//  Created by 谷治墙 on 2019/1/10.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "RecommendFailCell.h"

@implementation RecommendFailCell

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
    
    _nameL = [[UILabel alloc] init];
    _nameL.textColor = YJTitleLabColor;
    _nameL.font = [UIFont systemFontOfSize:15 *SIZE];
    [self.contentView addSubview:_nameL];
    
    _sexImg = [[UIImageView alloc] init];
    [self.contentView addSubview:_sexImg];
    
    _phoneL = [[UILabel alloc] init];
    _phoneL.textColor = YJ86Color;
    _phoneL.font = [UIFont systemFontOfSize:12 *SIZE];
    _phoneL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_phoneL];
    
    _codeL = [[UILabel alloc] init];
    _codeL.textColor = YJ86Color;
    _codeL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_codeL];
    
    _typeL = [[UILabel alloc] init];
    _typeL.textColor = YJ86Color;
    _typeL.font = [UIFont systemFontOfSize:12 *SIZE];
    _typeL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_typeL];
    
    _failTimeL = [[UILabel alloc] init];
    _failTimeL.textColor = YJ86Color;
    _failTimeL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_failTimeL];
    
    
    _codeL = [[UILabel alloc] init];
    _codeL.textColor = YJ86Color;
    _codeL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_codeL];
    
    
    _line = [[UIView alloc] init];
    _line.backgroundColor = YJBackColor;
    [self.contentView addSubview:_line];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(10 *SIZE);
        make.width.mas_equalTo(_nameL.mj_textWith + 5 *SIZE);
    }];
    
    [_sexImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(5 *SIZE);
        make.top.equalTo(self.contentView).offset(10 *SIZE);
        make.width.height.mas_equalTo(12 *SIZE);
    }];
    
    [_phoneL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(201 *SIZE);
        make.top.equalTo(_nameL.mas_bottom).offset(13 *SIZE);
        make.width.mas_equalTo(150 *SIZE);
    }];
    
    [_storeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(_nameL.mas_bottom).offset(13 *SIZE);
        make.width.mas_equalTo(140 *SIZE);
    }];
    
    [_typeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(201 *SIZE);
        make.top.equalTo(_nameL.mas_bottom).offset(13 *SIZE);
        make.width.mas_equalTo(150 *SIZE);
    }];
    
    [_codeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(_storeL.mas_bottom).offset(13 *SIZE);
        make.width.mas_equalTo(140 *SIZE);
    }];
    
    [_failTimeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(_codeL.mas_bottom).offset(13 *SIZE);
        make.width.mas_equalTo(140 *SIZE);
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(_failTimeL.mas_bottom).offset(13 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
    }];
}


@end
