//
//  RecommendWaitCell.m
//  云渠道
//
//  Created by 谷治墙 on 2019/1/9.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "RecommendWaitCell.h"

@implementation RecommendWaitCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    _codeL.text = [NSString stringWithFormat:@"客源编号：%@",dataDic[@"recommend_code"]];
    _nameL.text = [NSString stringWithFormat:@"%@",dataDic[@"client_name"]];
    if ([dataDic[@"client_sex"] integerValue] == 1) {
        
        _sexImg.image = [UIImage imageNamed:@"man"];
    }else if ([dataDic[@"client_sex"] integerValue] == 1){
        
        _sexImg.image = [UIImage imageNamed:@"girl"];
    }else{
        
        _sexImg.image = [UIImage imageNamed:@""];
    }
    _phoneL.text = [NSString stringWithFormat:@"%@",dataDic[@"client_tel"]];
    _storeL.text = [NSString stringWithFormat:@"门店名称：%@",dataDic[@"store_name"]];
    _timeL.text = [NSString stringWithFormat:@"推荐日期：%@",dataDic[@"recommend_time"]];
    
    
    [_nameL mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(10 *SIZE);
        make.width.mas_equalTo(_nameL.mj_textWith + 5 *SIZE);
    }];
}

- (void)initUI{
    
    _nameL = [[UILabel alloc] init];
    _nameL.textColor = YJ86Color;
    _nameL.font = [UIFont systemFontOfSize:15 *SIZE];
    [self.contentView addSubview:_nameL];
    
    _sexImg = [[UIImageView alloc] init];
    [self.contentView addSubview:_sexImg];
    
    _phoneL = [[UILabel alloc] init];
    _phoneL.textColor = YJ86Color;
    _phoneL.font = [UIFont systemFontOfSize:12 *SIZE];
    _phoneL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_phoneL];
    
    _storeL = [[UILabel alloc] init];
    _storeL.textColor = YJTitleLabColor;
    _storeL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_storeL];
    
    _codeL = [[UILabel alloc] init];
    _codeL.textColor = YJTitleLabColor;
    _codeL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_codeL];
    
    _timeL = [[UILabel alloc] init];
    _timeL.textColor = YJTitleLabColor;
    _timeL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_timeL];
    
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
        make.top.equalTo(self.contentView).offset(11 *SIZE);
        make.width.mas_equalTo(150 *SIZE);
    }];
    
    [_storeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(_nameL.mas_bottom).offset(13 *SIZE);
        make.width.mas_equalTo(140 *SIZE);
    }];

    [_codeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(_storeL.mas_bottom).offset(11 *SIZE);
        make.width.mas_equalTo(140 *SIZE);
    }];

    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(_codeL.mas_bottom).offset(14 *SIZE);
        make.width.mas_equalTo(140 *SIZE);
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(_timeL.mas_bottom).offset(15 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
    }];
}

@end
