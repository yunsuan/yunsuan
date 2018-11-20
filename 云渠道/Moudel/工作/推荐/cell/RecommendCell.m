//
//  RecommendCell.m
//  云渠道
//
//  Created by xiaoq on 2018/3/28.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RecommendCell.h"

@implementation RecommendCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionComfirmBtn:(UIButton *)btn{
    
    if (self.confirmBtnBlock) {
        
        self.confirmBtnBlock(self.tag);
    }
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    _nameL.text = dataDic[@"name"];
    _codeL.text = [NSString stringWithFormat:@"推荐编号：%@",dataDic[@"client_id"]];
    _projectL.text = [NSString stringWithFormat:@"推荐项目：%@",dataDic[@"project_name"]];
//    _confirmL.text = [NSString stringWithFormat:@"到访确认人：%@",dataDic[@"butter_name"]];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"失效时间：%@",dataDic[@"timsLimit"]]];
    [attr addAttribute:NSForegroundColorAttributeName value:YJ86Color range:NSMakeRange(0, 5)];
    _timeL.attributedText = attr;

    _addressL.text = [NSString stringWithFormat:@"项目地址：%@",dataDic[@"absolute_address"]];
}

- (void)initUI{
    
    _nameL = [[UILabel alloc] init];//WithFrame:CGRectMake(9 *SIZE, 21 *SIZE, 100 *SIZE, 14 *SIZE)];
    _nameL.textColor = YJTitleLabColor;
    _nameL.numberOfLines = 0;
    _nameL.font = [UIFont systemFontOfSize:15 *SIZE];
    [self.contentView addSubview:_nameL];
    
    _codeL = [[UILabel alloc] init];//WithFrame:CGRectMake(9 *SIZE, 44 *SIZE, 200 *SIZE, 11 *SIZE)];
    _codeL.textColor = YJ86Color;
    _codeL.numberOfLines = 0;
    _codeL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_codeL];
    
    _projectL = [[UILabel alloc] init];//WithFrame:CGRectMake(9 *SIZE, 65 *SIZE, 200 *SIZE, 11 *SIZE)];
    _projectL.textColor = YJ86Color;
    _projectL.numberOfLines = 0;
    _projectL.font = [UIFont systemFontOfSize:11 *SIZE];
    [self.contentView addSubview:_projectL];
    
    _timeL = [[UILabel alloc] init];//WithFrame:CGRectMake(9 *SIZE, 86 *SIZE, 300 *SIZE, 10 *SIZE)];
    _timeL.textColor = YJBlueBtnColor;
    _timeL.numberOfLines = 0;
    _timeL.font = [UIFont systemFontOfSize:11 *SIZE];
    [self.contentView addSubview:_timeL];
    
//    _confirmL = [[UILabel alloc] initWithFrame:CGRectMake(9 *SIZE, 107 *SIZE, 170 *SIZE, 10 *SIZE)];
//    _confirmL.textColor = YJ170Color;
//    _confirmL.font = [UIFont systemFontOfSize:11 *SIZE];
//    [self.contentView addSubview:_confirmL];

    _statusImg = [[UIImageView alloc] init];
    _statusImg.layer.cornerRadius = 10 *SIZE;
    _statusImg.clipsToBounds = YES;
    [self.contentView addSubview:_statusImg];
    
    _addressL = [[UILabel alloc] init];//WithFrame:CGRectMake(9 *SIZE, 107 *SIZE, 300 *SIZE, 10 *SIZE)];
    _addressL.textColor = YJ170Color;
    _addressL.numberOfLines = 0;
    _addressL.font = [UIFont systemFontOfSize:11 *SIZE];
    [self.contentView addSubview:_addressL];
    
    
    _lineView = [[UIView alloc] init];//WithFrame:CGRectMake(0, 132 *SIZE, SCREEN_Width, SIZE)];
    _lineView.backgroundColor = YJBackColor;
    [self.contentView addSubview:_lineView];
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:14 *sIZE];
    [_confirmBtn addTarget:self action:@selector(ActionComfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
    [_confirmBtn setBackgroundColor:COLOR(255, 165, 29, 1)];
    _confirmBtn.layer.cornerRadius = 2 *SIZE;
    _confirmBtn.clipsToBounds = YES;
    [_confirmBtn setTitleColor:CH_COLOR_white forState:UIControlStateNormal];
    [self.contentView addSubview:_confirmBtn];
    
    if ([[UserModel defaultModel].agent_identity integerValue] == 1) {
        
        _confirmBtn.hidden = YES;
    }else{
        
        _confirmBtn.hidden = NO;
    }
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(self.contentView).offset(15 *SIZE);
        make.right.equalTo(self.contentView).offset(-9 *SIZE);
    }];
    
    [_codeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(_nameL.mas_bottom).offset(14 *SIZE);
        make.right.equalTo(self.contentView).offset(-150 *SIZE);
    }];
    
    [_projectL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(_codeL.mas_bottom).offset(10 *SIZE);
        make.right.equalTo(self.contentView).offset(-150 *SIZE);
    }];
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(_projectL.mas_bottom).offset(10 *SIZE);
        make.right.equalTo(self.contentView).offset(-150 *SIZE);
    }];
    
    [_confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(273 *SIZE);
        make.top.equalTo(_nameL.mas_bottom).offset(34 *SIZE);
        make.width.mas_equalTo(77 *SIZE);
        make.height.mas_equalTo(30 *SIZE);
    }];
    
    [_addressL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(_timeL.mas_bottom).offset(10 *SIZE);
        make.right.equalTo(self.contentView).offset(-9 *SIZE);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(_addressL.mas_bottom).offset(15 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(SIZE);
        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
    }];
    
}



@end
