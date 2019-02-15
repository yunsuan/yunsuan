//
//  ContractTradeCell.m
//  云渠道
//
//  Created by 谷治墙 on 2019/2/15.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "ContractTradeCell.h"

@implementation ContractTradeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionEditBtn:(UIButton *)btn{
    
    
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    _codeL.text = [NSString stringWithFormat:@"合同编号：%@",dataDic[@"take_code"]];
    _priceL.text = [NSString stringWithFormat:@"成交总价：%@万",dataDic[@"deal_money"]];
    _buyBreachL.text = [NSString stringWithFormat:@"买方违约金额：%@",dataDic[@"buy_breach"]];
    _sellBreachL.text = [NSString stringWithFormat:@"卖方违约金额：%@",dataDic[@"sale_breach"]];
    _buyCommissionL.text = [NSString stringWithFormat:@"买方支付佣金金额：%@",dataDic[@"buy_brokerage"]];
    _sellCommissionL.text = [NSString stringWithFormat:@"卖方支付佣金金额：%@",dataDic[@"sale_brokerage"]];
    _payWayL.text = [NSString stringWithFormat:@"付款方式：%@",dataDic[@"pay_way"]];
    _registerTimeL.text = [NSString stringWithFormat:@"办证日期：%@",dataDic[@"certificate_time"]];
    _logoutTimeL.text = [NSString stringWithFormat:@"注销抵押时间：%@",dataDic[@""]];
    _markL.text = [NSString stringWithFormat:@"约定事项：%@",dataDic[@"comment"]];
    _buyReasonL.text = [NSString stringWithFormat:@"买房原因：%@",dataDic[@"buy_reason"]];
    _sellReasonL.text = [NSString stringWithFormat:@"卖房原因：%@",dataDic[@"sale_reason"]];
}

- (void)initUI{
    
    _editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_editBtn addTarget:self action:@selector(ActionEditBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_editBtn setImage:[UIImage imageNamed:@"edit"] forState:UIControlStateNormal];
    [self.contentView addSubview:_editBtn];
    
    [_editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.contentView).offset(-7 *SIZE);
        make.top.equalTo(self.contentView).offset(16 *SIZE);
        make.height.width.mas_equalTo(26 *SIZE);
    }];
    
    for (int i = 0; i < 12; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = YJ86Color;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        switch (i) {
            case 0:
            {
                _codeL = label;
                [self.contentView addSubview:_codeL];
                break;
            }
            case 1:
            {
                _priceL = label;
                [self.contentView addSubview:_priceL];
                break;
            }
            case 2:
            {
                _buyBreachL = label;
                [self.contentView addSubview:_buyBreachL];
                break;
            }
            case 3:
            {
                _sellBreachL = label;
                [self.contentView addSubview:_sellBreachL];
                break;
            }
            case 4:
            {
                _buyCommissionL = label;
                [self.contentView addSubview:_buyCommissionL];
                break;
            }
            case 5:
            {
                _sellCommissionL = label;
                [self.contentView addSubview:_sellCommissionL];
                break;
            }
            case 6:
            {
                _payWayL = label;
                [self.contentView addSubview:_payWayL];
                break;
            }
            case 7:
            {
                _registerTimeL = label;
                [self.contentView addSubview:_registerTimeL];
                break;
            }
            case 8:
            {
                _logoutTimeL = label;
                [self.contentView addSubview:_logoutTimeL];
                break;
            }
            case 9:
            {
                _markL = label;
                [self.contentView addSubview:_markL];
                break;
            }
            case 10:
            {
                _buyReasonL = label;
                [self.contentView addSubview:_buyReasonL];
                break;
            }
            case 11:
            {
                _sellReasonL = label;
                [self.contentView addSubview:_sellReasonL];
                break;
            }
            default:
                break;
        }
    }
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_codeL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(self.contentView).offset(23 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
    }];
    
    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_codeL.mas_bottom).offset(18 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
    }];
    
    [_buyBreachL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_priceL.mas_bottom).offset(18 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
    }];
    
    [_sellBreachL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_buyBreachL.mas_bottom).offset(18 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
    }];
    
    [_buyCommissionL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_sellBreachL.mas_bottom).offset(18 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
    }];
    
    [_sellCommissionL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_buyCommissionL.mas_bottom).offset(18 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
    }];
    
    [_payWayL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_sellCommissionL.mas_bottom).offset(18 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
    }];
    
    [_registerTimeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_payWayL.mas_bottom).offset(18 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
    }];
    
    [_logoutTimeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_registerTimeL.mas_bottom).offset(18 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
    }];
    
    [_markL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_logoutTimeL.mas_bottom).offset(18 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
    }];
    
    [_buyReasonL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_markL.mas_bottom).offset(18 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
    }];
    
    [_sellReasonL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_buyReasonL.mas_bottom).offset(18 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-42 *SIZE);
    }];
}

@end
