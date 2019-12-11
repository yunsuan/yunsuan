//
//  CustomLookConfirmCell.m
//  云渠道
//
//  Created by 谷治墙 on 2019/1/8.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "CustomLookConfirmCell.h"

@implementation CustomLookConfirmCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    _nameL.text = [NSString stringWithFormat:@"%@",dataDic[@"client_name"]];
    if ([dataDic[@"client_sex"] integerValue] == 1) {
        
        _genderImg.image = [UIImage imageNamed:@"man"];
    }else if ([dataDic[@"client_sex"] integerValue] == 1){
        
        _genderImg.image = [UIImage imageNamed:@"girl"];
    }else{
        
        _genderImg.image = [UIImage imageNamed:@""];
    }
    _codeL.text = [NSString stringWithFormat:@"带看编号：%@",dataDic[@"take_code"]];
    _phoneL.text = [NSString stringWithFormat:@"%@",dataDic[@"client_tel"]];
    _typeL.text = [NSString stringWithFormat:@"物业类型：%@",dataDic[@"property_type"]];
    _sourceL.text = [NSString stringWithFormat:@"来源：%@",dataDic[@"source"]];
    _timeL.text = [NSString stringWithFormat:@"确认时间：%@",dataDic[@"accept_time"]];
    
    [_nameL mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(14 *SIZE);
        make.width.mas_equalTo(_nameL.mj_textWith + 5 *SIZE);
    }];
}

- (void)ActionConfirmBtn:(UIButton *)btn{
    
    if (self.customLookConfirmCellBlock) {
        
        self.customLookConfirmCellBlock(btn.tag);
    }
}

- (void)initUI{
    
    _nameL = [[UILabel alloc] init];
    _nameL.textColor = YJTitleLabColor;
    _nameL.font = [UIFont systemFontOfSize:15 *SIZE];
    [self.contentView addSubview:_nameL];
    
    _genderImg = [[UIImageView alloc] init];
    [self.contentView addSubview:_genderImg];
    
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
    [self.contentView addSubview:_typeL];
    
    _sourceL = [[UILabel alloc] init];
    _sourceL.textColor = YJ86Color;
    _sourceL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_sourceL];
    
    _timeL = [[UILabel alloc] init];
    _timeL.textColor = YJ86Color;
    _timeL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_timeL];
    
    _comfirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _comfirmBtn.layer.cornerRadius = 2 *SIZE;
    _comfirmBtn.clipsToBounds = YES;
    _comfirmBtn.tag = self.tag;
    _comfirmBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_comfirmBtn setBackgroundColor:YJBlueBtnColor];
    [_comfirmBtn addTarget:self action:@selector(ActionConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_comfirmBtn setTitle:@"带看维护" forState:UIControlStateNormal];
    [self.contentView addSubview:_comfirmBtn];
    
    _line = [[UIView alloc] init];
    _line.backgroundColor = YJBackColor;
    [self.contentView addSubview:_line];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(14 *SIZE);
        make.width.mas_equalTo(_nameL.mj_textWith + 5 *SIZE);
    }];
    
    [_genderImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_nameL.mas_right).offset(6 *SIZE);
        make.top.equalTo(self.contentView).offset(15 *SIZE);
        make.width.height.mas_equalTo(12 *SIZE);
    }];
    
    [_phoneL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(200 *SIZE);
        make.top.equalTo(self.contentView).offset(17 *SIZE);
        make.width.mas_equalTo(150 *SIZE);
    }];
    
    [_codeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(_nameL.mas_bottom).offset(13 *SIZE);
        make.width.mas_equalTo(340 *SIZE);
    }];
    
    [_typeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(_codeL.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
    }];
    
    [_sourceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(126 *SIZE);
        make.top.equalTo(_codeL.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
    }];
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(_typeL.mas_bottom).offset(11 *SIZE);
        make.width.mas_equalTo(250 *SIZE);
    }];
    
    [_comfirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(283 *SIZE);
        make.top.equalTo(_codeL.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(67 *SIZE);
        make.height.mas_equalTo(30 *SIZE);
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(_timeL.mas_bottom).offset(13 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(SIZE);
        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
    }];
}

@end
