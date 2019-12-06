//
//  ConfrimPhoneWaitCell.m
//  云渠道
//
//  Created by 谷治墙 on 2019/2/22.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "ConfrimPhoneWaitCell.h"

@implementation ConfrimPhoneWaitCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionConfirmBtn:(UIButton *)btn{
    
    if (self.confrimPhoneWaitCellBlock) {
        
        self.confrimPhoneWaitCellBlock();
    }
}

- (void)Action_copy:(UIButton *)btn{
    
    if (self.copyPhoneWaitCellBlock) {
        
        self.copyPhoneWaitCellBlock();
    }
}

- (void)setDataDic:(NSDictionary *)dataDic{
    
    _nameL.text = [NSString stringWithFormat:@"%@",dataDic[@"name"]];
    _codeL.text = [NSString stringWithFormat:@"推荐编号：%@",dataDic[@"client_id"]];
    _projectL.text = [NSString stringWithFormat:@"推荐项目：%@",dataDic[@"project_name"]];
    
    _addressL.text = [NSString stringWithFormat:@"项目地址：%@",dataDic[@"absolute_address"]];
    _phoneL.text = [NSString stringWithFormat:@"联系方式：%@",dataDic[@"tel"]];
    if ([dataDic[@"recommend_check"] integerValue] == 0) {
        
        _timeL.text = [NSString stringWithFormat:@"失效时间：%@",@"以到访为准"];
    }else{
        
        _timeL.text = [NSString stringWithFormat:@"失效时间：%@",dataDic[@"timsLimit"]];
    }
}

- (void)initUI{
    
    for (int i = 0; i < 6; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = YJContentLabColor;
        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:12 *SIZE];
        switch (i) {
            case 0:
            {
                _nameL = label;
                _nameL.textColor = YJTitleLabColor;
                _nameL.font = [UIFont systemFontOfSize:14 *SIZE];
                [self.contentView addSubview:_nameL];
                break;
            }
            case 1:
            {
                _codeL = label;
                [self.contentView addSubview:_codeL];
                break;
            }
            case 2:
            {
                _projectL = label;
                [self.contentView addSubview:_projectL];
                break;
            }
            case 3:
            {
                _timeL = label;
                [self.contentView addSubview:_timeL];
                break;
            }
            case 4:
            {
                _addressL = label;
                [self.contentView addSubview:_addressL];
                break;
            }
            case 5:
            {
                _phoneL = label;
                [self.contentView addSubview:_phoneL];
                break;
            }
            default:
                break;
        }
    }
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_confirmBtn addTarget:self action:@selector(ActionConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
    [_confirmBtn setBackgroundColor:COLOR(255, 165, 29, 1)];
    _confirmBtn.layer.cornerRadius = 2 *SIZE;
    _confirmBtn.clipsToBounds = YES;
    [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.contentView addSubview:_confirmBtn];
    
    _copybtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _copybtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_copybtn addTarget:self action:@selector(Action_copy:) forControlEvents:UIControlEventTouchUpInside];
    [_copybtn setTitle:@"复制号码" forState:UIControlStateNormal];
    [_copybtn setBackgroundColor:YJBlueBtnColor];
    _copybtn.layer.cornerRadius = 2 *SIZE;
    _copybtn.clipsToBounds = YES;
    [_copybtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.contentView addSubview:_copybtn];
    
    _line = [[UIView alloc] init];
    _line.backgroundColor = YJBackColor;
    [self.contentView addSubview:_line];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(self.contentView).offset(16 *SIZE);
        make.right.equalTo(self.contentView).offset(-150 *SIZE);
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
    
    [_addressL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(_timeL.mas_bottom).offset(10 *SIZE);
        make.right.equalTo(self.contentView).offset(-150 *SIZE);
    }];
    
    [_phoneL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(_addressL.mas_bottom).offset(10 *SIZE);
        make.right.equalTo(self.contentView).offset(-150 *SIZE);
    }];
    
    [_confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(273 *SIZE);
        make.top.equalTo(_nameL.mas_bottom).offset(34 *SIZE);
        make.width.mas_equalTo(77 *SIZE);
        make.height.mas_equalTo(30 *SIZE);
    }];
    
    
    [_copybtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(273 *SIZE);
        make.top.equalTo(_confirmBtn.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(77 *SIZE);
        make.height.mas_equalTo(30 *SIZE);
    }];
    
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(_phoneL.mas_bottom).offset(15 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(SIZE);
        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
    }];
}

@end
