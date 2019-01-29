//
//  LookMaintainDetailContactCell.m
//  云渠道
//
//  Created by 谷治墙 on 2019/1/23.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "LookMaintainDetailContactCell.h"

@implementation LookMaintainDetailContactCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}


- (void)ActionTagBtn:(UIButton *)btn{
    
    if (self.lookMaintainDetailContactCellBlock) {
        
        self.lookMaintainDetailContactCellBlock(self.tag,btn.tag);
    }
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    _nameL.text = dataDic[@"name"];
    
    if ([dataDic[@"sex"] integerValue] == 1) {
        
        _sexImg.image = [UIImage imageNamed:@"man"];
    }else if ([dataDic[@"sex"] integerValue] == 1){
        
        _sexImg.image = [UIImage imageNamed:@"girl"];
    }else{
        
        _sexImg.image = [UIImage imageNamed:@""];
    }
    if ([dataDic[@"tel"] count]) {
        
        _phoneL.text = [NSString stringWithFormat:@"联系电话：%@",dataDic[@"tel"][0]];
    }else{
        
        _phoneL.text = [NSString stringWithFormat:@"联系电话："];
    }
    [_nameL mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(12 *SIZE);
        make.top.equalTo(_typeL.mas_bottom).offset(17 *SIZE);
        make.width.mas_equalTo(_nameL.mj_textWith + 5 *SIZE);
        make.bottom.equalTo(_whiteView).offset(-19 *SIZE);
    }];
}

- (void)initUI{
    
    self.contentView.backgroundColor = YJBackColor;
    
    _whiteView = [[UIView alloc] init];
    _whiteView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_whiteView];
    
    _typeL = [[UILabel alloc] init];
    _typeL.textColor = YJTitleLabColor;
    _typeL.font = [UIFont systemFontOfSize:15 *SIZE];
    [_whiteView addSubview:_typeL];
    
    _nameL = [[UILabel alloc] init];
    _nameL.textColor = YJ86Color;
    _nameL.font = [UIFont systemFontOfSize:13 *SIZE];
    [_whiteView addSubview:_nameL];
    
    _sexImg = [[UIImageView alloc] init];
    [_whiteView addSubview:_sexImg];
    
    _phoneL = [[UILabel alloc] init];
    _phoneL.textColor = YJ86Color;
    _phoneL.font = [UIFont systemFontOfSize:13 *SIZE];
    _phoneL.textAlignment = NSTextAlignmentRight;
    [_whiteView addSubview:_phoneL];
    
    for (int i = 0; i < 2; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        [btn addTarget:self action:@selector(ActionTagBtn:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0) {
            
            _upBtn = btn;
            [_upBtn setImage:[UIImage imageNamed:@"shang1"] forState:UIControlStateNormal];
            [self.contentView addSubview:_upBtn];
        }else{
            
            _downBtn = btn;
            [_downBtn setImage:[UIImage imageNamed:@"xia1"] forState:UIControlStateNormal];
            [self.contentView addSubview:_downBtn];
        }
    }
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    
    [_whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(6 *SIZE);
        make.width.mas_equalTo(340 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-6 *SIZE);
    }];
    
    [_typeL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_whiteView).offset(12 *SIZE);
        make.top.equalTo(_whiteView).offset(19 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
    }];
    
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(12 *SIZE);
        make.top.equalTo(_typeL.mas_bottom).offset(17 *SIZE);
        make.width.mas_equalTo(_nameL.mj_textWith + 5 *SIZE);
        make.bottom.equalTo(_whiteView).offset(-19 *SIZE);
    }];
    
    [_sexImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_nameL.mas_right).offset(4 *SIZE);
        make.top.equalTo(_typeL.mas_bottom).offset(16 *SIZE);
        make.width.height.mas_equalTo(12 *SIZE);
    }];
    
    [_upBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(270 *SIZE);
        make.top.equalTo(_whiteView).offset(10 *SIZE);
        make.width.mas_equalTo(29 *SIZE);
        make.height.mas_equalTo(29 *SIZE);
    }];
    
    [_downBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(300 *SIZE);
        make.top.equalTo(_whiteView).offset(10 *SIZE);
        make.width.mas_equalTo(29 *SIZE);
        make.height.mas_equalTo(29 *SIZE);
    }];
    
    [_phoneL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(_whiteView.mas_right).offset(-10 *SIZE);
        make.top.equalTo(_typeL.mas_bottom).offset(16 *SIZE);
        make.width.mas_equalTo(160 *SIZE);
        make.bottom.equalTo(_whiteView.mas_bottom).offset(-19 *SIZE);
    }];
}

@end
