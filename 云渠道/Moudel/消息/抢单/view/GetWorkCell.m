//
//  GetWorkCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/8/2.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "GetWorkCell.h"

@implementation GetWorkCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}


- (void)ActionGetBtn:(UIButton *)btn{
    
    if (self.getWorkCellBlock) {
        
        self.getWorkCellBlock(self.tag);
    }
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    NSString *str = dataDic[@"property_type"];
    if ([str containsString:@"参数"]) {
        
        str = [str substringWithRange:NSMakeRange(0, str.length - 2)];
    }
    _sourceL.text = [NSString stringWithFormat:@"类型：%@",dataDic[@"type_name"]];
    _typeL.text = [NSString stringWithFormat:@"物业类型：%@",str];
    _codeL.text = [NSString stringWithFormat:@"房源编号：%@",dataDic[@"house_code"]];
    _communicateL.text = [NSString stringWithFormat:@"小区名称：%@",dataDic[@"house_info"]];
    _timeL.text = [NSString stringWithFormat:@"报备日期：%@",dataDic[@"record_time"]];
}

- (void)initUI{
    
    _typeL = [[UILabel alloc] init];
    _typeL.textColor = YJ86Color;
    _typeL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_typeL];
    
    _sourceL = [[UILabel alloc] init];
    _sourceL.textColor = YJ86Color;
    _sourceL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_sourceL];
    
    _codeL = [[UILabel alloc] init];
    _codeL.textColor = YJTitleLabColor;
    _codeL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_codeL];
    
    _communicateL = [[UILabel alloc] init];
    _communicateL.textColor = YJ86Color;
    _communicateL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_communicateL];
    
    _timeL = [[UILabel alloc] init];
    _timeL.textColor = YJ170Color;
    _timeL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_timeL];

    
    _getBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _getBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_getBtn addTarget:self action:@selector(ActionGetBtn:) forControlEvents:UIControlEventTouchUpInside];
    _getBtn.layer.cornerRadius = 2 *SIZE;
    _getBtn.clipsToBounds = YES;
    [_getBtn setTitle:@"抢单" forState:UIControlStateNormal];
    [_getBtn setBackgroundColor:COLOR(145, 205, 255, 1)];
    [self.contentView addSubview:_getBtn];
    
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = YJBackColor;
    [self.contentView addSubview:_lineView];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_codeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(self.contentView).offset(17 *SIZE);
        make.right.equalTo(self.contentView).offset(-9 *SIZE);
    }];
    
    [_sourceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(_codeL.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
    }];
    
    [_typeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(135 *SIZE);
        make.top.equalTo(_codeL.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(140 *SIZE);
    }];
    
    [_communicateL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(_typeL.mas_bottom).offset(10 *SIZE);
        make.right.equalTo(self.contentView).offset(-100 *SIZE);
    }];
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
    
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(_communicateL.mas_bottom).offset(10 *SIZE);
        make.right.equalTo(self.contentView).offset(-100 *SIZE);
    }];
    
    [_getBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(283 *SIZE);
        make.top.equalTo(_codeL.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(67 *SIZE);
        make.height.mas_equalTo(30 *SIZE);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(_timeL.mas_bottom).offset(17 *SIZE);
        make.right.equalTo(self.contentView).offset(0 *SIZE);
        make.height.equalTo(@(SIZE));
        make.bottom.equalTo(self.contentView).offset(0);
    }];
}

@end
