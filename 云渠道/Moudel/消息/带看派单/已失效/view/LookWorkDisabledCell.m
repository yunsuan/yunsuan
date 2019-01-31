//
//  LookWorkDisabledCell.m
//  云渠道
//
//  Created by 谷治墙 on 2019/1/8.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "LookWorkDisabledCell.h"

@implementation LookWorkDisabledCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    _codeL.text = [NSString stringWithFormat:@"推荐编号：%@",dataDic[@"recommend_code"]];
    _nameL.text = [NSString stringWithFormat:@"客户姓名：%@",dataDic[@"client_name"]];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"匹配房源：%@套",dataDic[@"fit_house"]]];
    [attr addAttribute:NSForegroundColorAttributeName value:YJBlueBtnColor range:NSMakeRange(5, attr.length - 5)];
    _numL.attributedText = attr;
    _sourceL.text = [NSString stringWithFormat:@"来源：%@",dataDic[@"source"]];
    _typeL.text = [NSString stringWithFormat:@"类型：%@",dataDic[@"type"]];
    _proTypeL.text = [NSString stringWithFormat:@"物业类型：%@",dataDic[@"property_type"]];
    _reasonL.text = [NSString stringWithFormat:@"失效类型：%@",dataDic[@"disabled_state"]];
    _timeL.text = [NSString stringWithFormat:@"失效时间：%@",dataDic[@"disabled_time"]];
    
    [_nameL mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(_codeL.mas_bottom).offset(15 *SIZE);
        make.width.mas_equalTo(_nameL.mj_textWith + 5 *SIZE);
    }];
}

- (void)initUI{
    
    _codeL = [[UILabel alloc] init];
    _codeL.textColor = YJTitleLabColor;
    _codeL.font = [UIFont boldSystemFontOfSize:14 *SIZE];
    [self.contentView addSubview:_codeL];
    
    _nameL = [[UILabel alloc] init];
    _nameL.textColor = YJ86Color;
    _nameL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_nameL];
    
    _genderImg = [[UIImageView alloc] init];
    [self.contentView addSubview:_genderImg];
    
    _sourceL = [[UILabel alloc] init];
    _sourceL.textColor = YJ86Color;
    _sourceL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_sourceL];
    
    _numL = [[UILabel alloc] init];
    _numL.textColor = YJ86Color;
    _numL.font = [UIFont systemFontOfSize:12 *SIZE];
    _numL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_numL];
    
    _typeL = [[UILabel alloc] init];
    _typeL.textColor = YJ86Color;
    _typeL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_typeL];
    
    _proTypeL = [[UILabel alloc] init];
    _proTypeL.textColor = YJ86Color;
    _proTypeL.font = [UIFont systemFontOfSize:12 *SIZE];
    _proTypeL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_proTypeL];
    
    _reasonL = [[UILabel alloc] init];
    _reasonL.textColor = YJ170Color;
    _reasonL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_reasonL];
    
    _timeL = [[UILabel alloc] init];
    _timeL.textColor = YJ170Color;
    _timeL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_timeL];
    
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = YJBackColor;
    [self.contentView addSubview:_lineView];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_codeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(self.contentView).offset(20 *SIZE);
        make.right.equalTo(self.contentView).offset(9 *SIZE);
    }];
    
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(_codeL.mas_bottom).offset(15 *SIZE);
        make.width.mas_equalTo(_nameL.mj_textWith + 5 *SIZE);
    }];
    
    [_genderImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_nameL).offset(9 *SIZE);
        make.top.equalTo(_codeL.mas_bottom).offset(15 *SIZE);
        make.width.height.mas_equalTo(12 *SIZE);
    }];
    
    [_sourceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(_nameL.mas_bottom).offset(15 *SIZE);
        make.width.mas_equalTo(130 *SIZE);
    }];
    
    [_numL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(220 *SIZE);
        make.top.equalTo(_nameL.mas_bottom).offset(15 *SIZE);
        make.width.mas_equalTo(130 *SIZE);
    }];

    [_typeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(_sourceL.mas_bottom).offset(15 *SIZE);
        make.width.mas_equalTo(200 *SIZE);
    }];
    
    [_proTypeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(220 *SIZE);
        make.top.equalTo(_sourceL.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(130 *SIZE);
    }];
    
    [_reasonL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(_typeL.mas_bottom).offset(15 *SIZE);
        make.right.equalTo(self.contentView).offset(-9 *SIZE);
    }];
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(_reasonL.mas_bottom).offset(15 *SIZE);
        make.right.equalTo(self.contentView).offset(-9 *SIZE);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(_timeL.mas_bottom).offset(19 *SIZE);
        make.width.mas_equalTo(360 *SIZE);
        make.height.mas_equalTo(SIZE);
        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
    }];
}

@end
