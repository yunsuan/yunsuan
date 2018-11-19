//
//  MaintainLookCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/6/21.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "MaintainLookCell.h"

@implementation MaintainLookCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionPhoneBtn:(UIButton *)btn{
    
    if (self.maintainLookBlock) {
        
        self.maintainLookBlock(self.tag);
    }
}

- (void)initUI{
    
    for (int i = 0;  i < 4; i++) {
        
        UILabel *label2 = [[UILabel alloc] init];
        label2.textColor = YJContentLabColor;
        label2.font = [UIFont systemFontOfSize:12 *SIZE];
        switch (i) {
            case 0:
            {
                _timeL = label2;
                [self.contentView addSubview:_timeL];
                break;
            }
            case 1:
            {
                _priceL = label2;
                [self.contentView addSubview:_priceL];
                break;
            }
            case 2:
            {
                _agentL = label2;
                [self.contentView addSubview:_agentL];
                break;
            }
            case 3:
            {
                _phoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                [_phoneBtn addTarget:self action:@selector(ActionPhoneBtn:) forControlEvents:UIControlEventTouchUpInside];
                [_phoneBtn setImage:[UIImage imageNamed:@"phone"] forState:UIControlStateNormal];
                [self.contentView addSubview:_phoneBtn];
                break;
            }
            default:
                break;
        }
    }
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = YJBackColor;
    [self.contentView addSubview:_lineView];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(15 *SIZE);
        make.width.mas_equalTo(80 *SIZE);
    }];
    
    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(100 *SIZE);
        make.top.equalTo(self.contentView).offset(14 *SIZE);
        make.width.mas_equalTo(80 *SIZE);
    }];
    
    [_agentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(190 *SIZE);
        make.top.equalTo(self.contentView).offset(14 *SIZE);
        make.width.mas_equalTo(80 *SIZE);
    }];
    
    [_phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(313 *SIZE);
        make.top.equalTo(self.contentView).offset(8 *SIZE);
        make.width.mas_equalTo(24 *SIZE);
        make.width.mas_equalTo(24 *SIZE);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(_timeL.mas_bottom).offset(15 *SIZE);
        make.right.equalTo(self.contentView).offset(0 *SIZE);
        make.height.equalTo(@(SIZE));
        make.bottom.equalTo(self.contentView).offset(0);
    }];
}

@end
