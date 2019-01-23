//
//  LookMaintainCell.m
//  云渠道
//
//  Created by 谷治墙 on 2019/1/23.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "LookMaintainCell.h"

@implementation LookMaintainCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    _codeL.text = [NSString stringWithFormat:@"客源编号：%@",dataDic[@""]];
    _nameL.text = [NSString stringWithFormat:@"客户姓名：%@",dataDic[@""]];
    _phoneL.text = [NSString stringWithFormat:@"联系方式：%@",dataDic[@""]];
    _contentL.text = [NSString stringWithFormat:@"%@",dataDic[@""]];
    _customL.text = [NSString stringWithFormat:@"客户等级：%@",dataDic[@""]];
    _matchL.text = [NSString stringWithFormat:@"匹配房源：%@",dataDic[@""]];
    _numL.text = [NSString stringWithFormat:@"已看房源数量：%@",dataDic[@""]];
    _progressL.text = [NSString stringWithFormat:@"带看进度：%@",dataDic[@""]];
    
    
    [_nameL mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(14 *SIZE);
        make.width.mas_equalTo(_nameL.mj_textWith + 5 *SIZE);
    }];
}

- (void)initUI{
    
    _codeL = [[UILabel alloc] init];
    _codeL.textColor = YJTitleLabColor;
    _codeL.font = [UIFont systemFontOfSize:15 *SIZE];
    [self.contentView addSubview:_codeL];
    
    _nameL = [[UILabel alloc] init];
    _nameL.textColor = YJ86Color;
    _nameL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_nameL];
    
    _genderImg = [[UIImageView alloc] init];
    [self.contentView addSubview:_genderImg];
    
    _phoneL = [[UILabel alloc] init];
    _phoneL.textColor = YJ86Color;
    _phoneL.font = [UIFont systemFontOfSize:12 *SIZE];
    _phoneL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_phoneL];
    
    _contentL = [[UILabel alloc] init];
    _contentL.textColor = YJ86Color;
    _contentL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_contentL];
    
    _customL = [[UILabel alloc] init];
    _customL.textColor = YJ86Color;
    _customL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_customL];
    
    _matchL = [[UILabel alloc] init];
    _matchL.textColor = YJ86Color;
    _matchL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_matchL];
    
    _numL = [[UILabel alloc] init];
    _numL.textColor = YJ86Color;
    _numL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_numL];
    
    _progressL = [[UILabel alloc] init];
    _progressL.textColor = YJ86Color;
    _progressL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_progressL];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_codeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(14 *SIZE);
        make.width.mas_equalTo(340 *SIZE);
    }];
    
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(_codeL.mas_bottom).offset(14 *SIZE);
        make.width.mas_equalTo(_nameL.mj_textWith + 5 *SIZE);
    }];
    
    [_genderImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_nameL.mas_right).offset(6 *SIZE);
        make.top.equalTo(_codeL.mas_bottom).offset(15 *SIZE);
        make.width.height.mas_equalTo(12 *SIZE);
    }];
    
    [_phoneL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(200 *SIZE);
        make.top.equalTo(_codeL.mas_bottom).offset(17 *SIZE);
        make.width.mas_equalTo(150 *SIZE);
    }];
    
    [_contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(200 *SIZE);
        make.top.equalTo(_nameL.mas_bottom).offset(17 *SIZE);
        make.width.mas_equalTo(150 *SIZE);
    }];
    
    [_customL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(200 *SIZE);
        make.top.equalTo(_codeL.mas_bottom).offset(17 *SIZE);
        make.width.mas_equalTo(150 *SIZE);
    }];
    
    [_matchL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(200 *SIZE);
        make.top.equalTo(_codeL.mas_bottom).offset(17 *SIZE);
        make.width.mas_equalTo(150 *SIZE);
    }];
    
    [_numL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(200 *SIZE);
        make.top.equalTo(_codeL.mas_bottom).offset(17 *SIZE);
        make.width.mas_equalTo(150 *SIZE);
    }];
    
    [_progressL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(200 *SIZE);
        make.top.equalTo(_codeL.mas_bottom).offset(17 *SIZE);
        make.width.mas_equalTo(150 *SIZE);
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(_progressL.mas_bottom).offset(13 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
    }];
}

@end
