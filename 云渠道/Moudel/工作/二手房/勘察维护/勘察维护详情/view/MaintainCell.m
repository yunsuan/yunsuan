//
//  MaintainCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/7/19.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "MaintainCell.h"

@implementation MaintainCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionTagBtn:(UIButton *)btn{
    
    if (self.maintainCellBlock) {
        
        self.maintainCellBlock(self.tag,btn.tag);
    }
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    _nameL.text = [NSString stringWithFormat:@"联系人：%@",dataDic[@"name"]];
    _typeL.text = [NSString stringWithFormat:@"类型：%@",dataDic[@"report_type"]];
    for (int i = 0; i < [dataDic[@"tel"] count]; i++) {
        
        if (i == 0) {
            
            _phoneL.text = [NSString stringWithFormat:@"联系电话：%@",dataDic[@"tel"][0]];
        }else{
            
            _phoneL.text = [NSString stringWithFormat:@"%@,%@",_phoneL.text,dataDic[@"tel"][i]];
        }
    }
    if ([dataDic[@"sex"] integerValue] == 2) {
        
        _sexImg.image = [UIImage imageNamed:@"girl"];
    }else{
        
        _sexImg.image = [UIImage imageNamed:@"man"];
    }
    
}

- (void)initUI{
    
    for (int i = 0; i < 3; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = YJ86Color;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        [btn addTarget:self action:@selector(ActionTagBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        switch (i) {
            case 0:
            {
                _nameL = label;
                [self.contentView addSubview:_nameL];
                _moreBtn = btn;
                _moreBtn.titleLabel.font = [UIFont systemFontOfSize:11 *SIZE];
                [_moreBtn setTitleColor:YJ170Color forState:UIControlStateNormal];
                [_moreBtn setTitle:@"查看全部 >>" forState:UIControlStateNormal];
                [self.contentView addSubview:_moreBtn];
                break;
            }
            case 1:
            {
                _typeL = label;
                [self.contentView addSubview:_typeL];
                _upBtn = btn;
                [_upBtn setImage:[UIImage imageNamed:@"shang1"] forState:UIControlStateNormal];
                [self.contentView addSubview:_upBtn];
                break;
            }
            case 2:
            {
                _phoneL = label;
                [self.contentView addSubview:_phoneL];
                _downBtn = btn;
                [_downBtn setImage:[UIImage imageNamed:@"xia1"] forState:UIControlStateNormal];
                [self.contentView addSubview:_downBtn];
                break;
            }
            default:
                break;
        }
    }
    
    _sexImg = [[UIImageView alloc] init];
//    _sexImg.image = [UIImage imageNamed:@"man"];
//    _sexImg.hidden = YES;
    [self.contentView addSubview:_sexImg];
    
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = YJBackColor;
    [self.contentView addSubview:_lineView];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(self.contentView).offset(21 *SIZE);
        make.width.mas_equalTo(_nameL.mj_textWith + 10 *SIZE);
    }];
    
    [_sexImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_nameL.mas_right).offset(0*SIZE);
        make.top.equalTo(self.contentView).offset(21 *SIZE);
        make.width.height.mas_equalTo(12 *SIZE);
    }];
    
    [_typeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_nameL.mas_bottom).offset(15 *SIZE);
        make.right.equalTo(self.contentView).offset(-70 *SIZE);
    }];
    
    [_phoneL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_typeL.mas_bottom).offset(15 *SIZE);
        make.right.equalTo(self.contentView).offset(-70 *SIZE);
    }];
    
    [_moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(287 *SIZE);
        make.top.equalTo(self.contentView).offset(13 *SIZE);
        make.width.mas_equalTo(65 *SIZE);
        make.height.mas_equalTo(20 *SIZE);
    }];
    
    [_upBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(300 *SIZE);
        make.top.equalTo(self.contentView).offset(67 *SIZE);
        make.width.mas_equalTo(29 *SIZE);
        make.height.mas_equalTo(29 *SIZE);
    }];
    
    [_downBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(330 *SIZE);
        make.top.equalTo(self.contentView).offset(67 *SIZE);
        make.width.mas_equalTo(29 *SIZE);
        make.height.mas_equalTo(29 *SIZE);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0);
        make.top.equalTo(_phoneL.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(SIZE);
        make.bottom.equalTo(self.contentView).offset(0);
    }];
}

@end
