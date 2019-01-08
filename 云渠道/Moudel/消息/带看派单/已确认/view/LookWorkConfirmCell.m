//
//  LookWorkConfirmCell.m
//  云渠道
//
//  Created by 谷治墙 on 2019/1/8.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "LookWorkConfirmCell.h"

@implementation LookWorkConfirmCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    _codeL.text = [NSString stringWithFormat:@"推荐编号：%@",dataDic[@"house_code"]];
    _nameL.text = [NSString stringWithFormat:@"客户姓名：%@",dataDic[@"name"]];
    _numL.text = [NSString stringWithFormat:@"匹配房源：%@",dataDic[@"house"]];
    _sourceL.text = [NSString stringWithFormat:@"来源：%@",dataDic[@"house"]];
    _typeL.text = [NSString stringWithFormat:@"类型：%@",dataDic[@"type_name"]];
    _proTypeL.text = [NSString stringWithFormat:@"物业类型：%@",dataDic[@"property_type"]];
    _phoneL.text = [NSString stringWithFormat:@"%@",dataDic[@"house"]];
    _timeL.text = [NSString stringWithFormat:@"接单时间：%@",dataDic[@"disabled_time"]];
    _confirmTimeL.text = [NSString stringWithFormat:@"确认房源信息截止时间：%@",dataDic[@"disabled_time"]];
    
    [_nameL mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(_codeL.mas_bottom).offset(15 *SIZE);
        make.width.mas_equalTo(_nameL.mj_textWith + 5 *SIZE);
    }];
}

- (void)ActionConfirmBtn:(UIButton *)btn{
    
    if (self.lookWorkConfirmBlock) {
        
        self.lookWorkConfirmBlock(self.tag);
    }
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
    
    _numL = [[UILabel alloc] init];
    _numL.textColor = YJ86Color;
    _numL.font = [UIFont systemFontOfSize:12 *SIZE];
    _numL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_numL];
    
    _phoneL = [[UILabel alloc] init];
    _phoneL.textColor = YJ86Color;
    _phoneL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_phoneL];
    
    _sourceL = [[UILabel alloc] init];
    _sourceL.textColor = YJ86Color;
    _sourceL.font = [UIFont systemFontOfSize:13 *SIZE];
    _sourceL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_sourceL];
    
    _typeL = [[UILabel alloc] init];
    _typeL.textColor = YJ86Color;
    _typeL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_typeL];
    
    _proTypeL = [[UILabel alloc] init];
    _proTypeL.textColor = YJ86Color;
    _proTypeL.font = [UIFont systemFontOfSize:12 *SIZE];
    _proTypeL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_proTypeL];
    
    _timeL = [[UILabel alloc] init];
    _timeL.textColor = YJ170Color;
    _timeL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_timeL];
    
    _confirmTimeL = [[UILabel alloc] init];
    _confirmTimeL.textColor = YJ170Color;
    _confirmTimeL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_confirmTimeL];
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_confirmBtn addTarget:self action:@selector(ActionConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_confirmBtn setBackgroundColor:YJBlueBtnColor];
    [_confirmBtn setTitle:@"接单" forState:UIControlStateNormal];
    [self.contentView addSubview:_confirmBtn];
    
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
    
    [_phoneL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(_nameL.mas_bottom).offset(15 *SIZE);
        make.width.mas_equalTo(200 *SIZE);
    }];
    
    [_sourceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(220 *SIZE);
        make.top.equalTo(_numL.mas_bottom).offset(15 *SIZE);
        make.width.mas_equalTo(130 *SIZE);
    }];
    
    [_numL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(220 *SIZE);
        make.top.equalTo(_codeL.mas_bottom).offset(15 *SIZE);
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
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(_typeL.mas_bottom).offset(15 *SIZE);
        make.width.mas_equalTo(250 *SIZE);
    }];
    
    [_confirmTimeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(_timeL.mas_bottom).offset(19 *SIZE);
        make.width.mas_equalTo(250 *SIZE);
    }];
    
    [_confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(273 *SIZE);
        make.top.equalTo(_proTypeL.mas_bottom).offset(15 *SIZE);
        make.width.mas_equalTo(77 *SIZE);
        make.height.mas_equalTo(30 *SIZE);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(_confirmTimeL.mas_bottom).offset(18 *SIZE);
        make.width.mas_equalTo(360 *SIZE);
        make.height.mas_equalTo(SIZE);
        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
    }];
}

@end
