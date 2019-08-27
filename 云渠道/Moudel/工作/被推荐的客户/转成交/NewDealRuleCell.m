//
//  NewDealRuleCell.m
//  云渠道
//
//  Created by 谷治墙 on 2019/8/26.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "NewDealRuleCell.h"

@implementation NewDealRuleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setDic:(NSDictionary *)dic{
    
    _labelA.text = [NSString stringWithFormat:@"甲方负责人：%@/%@",dic[@"project_docker"],dic[@"project_docker_tel"]];
    _labelB.text = [NSString stringWithFormat:@"乙方负责人：%@/%@",dic[@"sell_docker"],dic[@"sell_docker_tel"]];
    _ruleL.text = [NSString stringWithFormat:@"规则类型：%@",dic[@"rule_type"]];
    _beginL.text = [NSString stringWithFormat:@"合同开始时间：%@",dic[@"act_start"]];
    _endL.text = [NSString stringWithFormat:@"合同直接时间：%@",dic[@"act_end"]];
}

- (void)initUI{
    
    self.contentView.backgroundColor = CLBackColor;
    
    _whiteView = [[UIView alloc] init];
    _whiteView.backgroundColor = CLWhiteColor;
    _whiteView.layer.cornerRadius = 5 *SIZE;
    _whiteView.clipsToBounds = YES;
    [self.contentView addSubview:_whiteView];
    
    for (int i = 0; i < 5; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = YJTitleLabColor;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        switch (i) {
            case 0:
            {
                _labelA = label;
                [_whiteView addSubview:_labelA];
                break;
            }
            case 1:
            {
                _labelB = label;
                [_whiteView addSubview:_labelB];
                break;
            }
            case 2:
            {
                _ruleL = label;
                [_whiteView addSubview:_ruleL];
                break;
            }
            case 3:
            {
                _beginL = label;
                [_whiteView addSubview:_beginL];
                break;
            }
            case 4:
            {
                _endL = label;
                [_whiteView addSubview:_endL];
                break;
            }
            default:
                break;
        }
    }
    
    [_whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(5 *SIZE);
        make.width.mas_equalTo(340 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-5 *SIZE);
    }];
    
    [_labelA mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(10 *SIZE *SIZE);
        make.top.equalTo(self->_whiteView).offset(5 *SIZE);
        make.right.equalTo(self->_whiteView).offset(-5 *SIZE);
    }];
    
    [_labelB mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(10 *SIZE *SIZE);
        make.top.equalTo(self->_labelA.mas_bottom).offset(10 *SIZE);
        make.right.equalTo(self->_whiteView).offset(-5 *SIZE);
    }];
    
    [_ruleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(10 *SIZE *SIZE);
        make.top.equalTo(self->_labelB.mas_bottom).offset(10 *SIZE);
        make.right.equalTo(self->_whiteView).offset(-5 *SIZE);
    }];
    
    [_beginL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(10 *SIZE *SIZE);
        make.top.equalTo(self->_ruleL.mas_bottom).offset(10 *SIZE);
        make.right.equalTo(self->_whiteView).offset(-5 *SIZE);
    }];
    
    [_endL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(10 *SIZE *SIZE);
        make.top.equalTo(self->_beginL.mas_bottom).offset(10 *SIZE);
        make.right.equalTo(self->_whiteView).offset(-5 *SIZE);
        make.bottom.equalTo(self->_whiteView.mas_bottom).offset(-10 *SIZE);
    }];
}

@end
