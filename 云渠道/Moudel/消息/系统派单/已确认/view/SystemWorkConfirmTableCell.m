//
//  SystemWorkConfirmTableCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/10/25.
//  Copyright © 2018 xiaoq. All rights reserved.
//

#import "SystemWorkConfirmTableCell.h"

@implementation SystemWorkConfirmTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    _codeL.text = [NSString stringWithFormat:@"房源编号：%@",dataDic[@"house_code"]];
    _typeL.text = [NSString stringWithFormat:@"类型：%@",dataDic[@"type_name"]];
    _proTypeL.text = [NSString stringWithFormat:@"物业类型：%@",dataDic[@"property_type"]];
    _nameL.text = [NSString stringWithFormat:@"小区名称：%@",dataDic[@"house"]];
    _getTimeL.text = [NSString stringWithFormat:@"接单时间：%@",dataDic[@"disabled_time"]];
    _timeL.text = [NSString stringWithFormat:@"确认房源信息截止时间：%@",dataDic[@"disabled_time"]];
}

- (void)setDisableDic:(NSMutableDictionary *)DisableDic{
    
    _codeL.text = [NSString stringWithFormat:@"房源编号：%@",DisableDic[@"house_code"]];
    _typeL.text = [NSString stringWithFormat:@"类型：%@",DisableDic[@"type_name"]];
    _proTypeL.text = [NSString stringWithFormat:@"物业类型：%@",DisableDic[@"property_type"]];
    _nameL.text = [NSString stringWithFormat:@"小区名称：%@",DisableDic[@"house"]];
    _getTimeL.text = [NSString stringWithFormat:@"失效类型：%@",DisableDic[@"disabled_time"]];
    _timeL.textColor = YJ170Color;
    _timeL.text = [NSString stringWithFormat:@"失效时间：%@",DisableDic[@"disabled_time"]];
}

- (void)ActionConfirmBtn:(UIButton *)btn{
    
    if (self.systemWorkConfirmConfirmBlock) {
        
        self.systemWorkConfirmConfirmBlock(self.tag);
    }
}

- (void)initUI{
    
    _codeL = [[UILabel alloc] init];
    _codeL.textColor = YJTitleLabColor;
    _codeL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_codeL];
    
    _typeL = [[UILabel alloc] init];
    _typeL.textColor = YJ86Color;
    _typeL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_typeL];
    
    _proTypeL = [[UILabel alloc] init];
    _proTypeL.textColor = YJ86Color;
    _proTypeL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_proTypeL];
    
    _nameL = [[UILabel alloc] init];
    _nameL.textColor = YJ86Color;
    _nameL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_nameL];
    
    _getTimeL = [[UILabel alloc] init];
    _getTimeL.textColor = YJ86Color;
    _getTimeL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_getTimeL];
    
    _timeL = [[UILabel alloc] init];
    _timeL.textColor = YJBlueBtnColor;
    _timeL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_timeL];
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_confirmBtn addTarget:self action:@selector(ActionConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_confirmBtn setBackgroundColor:YJBlueBtnColor];
    [_confirmBtn setTitle:@"去确认" forState:UIControlStateNormal];
    [self.contentView addSubview:_confirmBtn];
    
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = YJBackColor;
    [self.contentView addSubview:_lineView];

    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_codeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(self.contentView).offset(17 *SIZE);
        make.right.equalTo(self.contentView).offset(9 *SIZE);
    }];
    
    [_typeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(_codeL.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
    }];
    
    [_proTypeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(135 *SIZE);
        make.top.equalTo(_codeL.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(140 *SIZE);
    }];
    
    [_confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(283 *SIZE);
        make.top.equalTo(_codeL.mas_bottom).offset(41 *SIZE);
        make.width.mas_equalTo(67 *SIZE);
        make.height.mas_equalTo(30 *SIZE);
    }];
    
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(_typeL.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(250 *SIZE);
    }];
    
    [_getTimeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(_nameL.mas_bottom).offset(11 *SIZE);
        make.right.equalTo(self.contentView).offset(-9 *SIZE);
    }];
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(_getTimeL.mas_bottom).offset(11 *SIZE);
        make.right.equalTo(self.contentView).offset(-9 *SIZE);
//        make.bottom.equalTo(self.contentView).offset(-17 *SIZE);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(_timeL.mas_bottom).offset(17 *SIZE);
        make.width.mas_equalTo(360 *SIZE);
        make.height.mas_equalTo(SIZE);
        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
    }];
}

@end
