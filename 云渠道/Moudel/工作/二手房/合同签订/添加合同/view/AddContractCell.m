//
//  AddContractVC.m
//  云渠道
//
//  Created by 谷治墙 on 2019/1/11.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "AddContractCell.h"

@implementation AddContractCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    NSArray *titleArr = @[@"合同编号：",@"交易总价：",@"买方违约金额：",@"买卖方违约金额：",@"居间费用：",@"办贷日期：",@"办证时间：",@"注销抵押时间：",@"付款方式："];
    
    for (int i = 0 ; i < 9; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = YJTitleLabColor;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        label.numberOfLines = 0;
        label.text = titleArr[i];
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
                _costL = label;
                [self.contentView addSubview:_costL];
                break;
            }
            case 5:
            {
                _loanTimeL = label;
                [self.contentView addSubview:_loanTimeL];
                break;
            }
            case 6:
            {
                _cardTimeL = label;
                [self.contentView addSubview:_cardTimeL];
                break;
            }
            case 7:
            {
                _mortgageTimeL = label;
                [self.contentView addSubview:_mortgageTimeL];
                break;
            }
            case 8:
            {
                _payWayL = label;
                [self.contentView addSubview:_payWayL];
                break;
            }
            default:
                break;
        }
        
        if (i < 5) {
            
            BorderTF *tf = [[BorderTF alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
            switch (i) {
                case 0:
                {
                    _codeTF = tf;
                    [self.contentView addSubview:_codeTF];
                    break;
                }
                case 1:
                {
                    tf.unitL.text = @"万";
                    _codeTF = tf;
                    [self.contentView addSubview:_codeTF];
                    break;
                }
                case 2:
                {
                    tf.unitL.text = @"万";
                    _buyBreachTF = tf;
                    [self.contentView addSubview:_buyBreachTF];
                    break;
                }
                case 3:
                {
                    tf.unitL.text = @"万";
                    _sellBreachTF = tf;
                    [self.contentView addSubview:_sellBreachTF];
                    break;
                }
                case 4:
                {
                    tf.unitL.text = @"万";
                    _costTF = tf;
                    [self.contentView addSubview:_costTF];
                    break;
                }
                default:
                    break;
            }
        }else{
            
            DropDownBtn *btn = [[DropDownBtn alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
            switch (i) {
                case 5:
                {
                    _loanTimeBtn = btn;
                    [self.contentView addSubview:_loanTimeBtn];
                    break;
                }
                case 6:
                {
                    _cardTimeBtn = btn;
                    [self.contentView addSubview:_cardTimeBtn];
                    break;
                }
                case 7:
                {
                    _mortgageTimeBtn = btn;
                    [self.contentView addSubview:_mortgageTimeBtn];
                    break;
                }
                case 8:
                {
                    _payWayBtn = btn;
                    [self.contentView addSubview:_payWayBtn];
                    break;
                }
                default:
                    break;
            }
        }
    }
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    
    [_codeL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(self.contentView).offset(25 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_codeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(80 *SIZE);
        make.top.equalTo(self.contentView).offset(16 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(_codeTF.mas_bottom).offset(30 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_priceTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(80 *SIZE);
        make.top.equalTo(_codeTF.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_buyBreachL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(_priceTF.mas_bottom).offset(30 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_buyBreachTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(80 *SIZE);
        make.top.equalTo(_priceTF.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_sellBreachL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(_buyBreachTF.mas_bottom).offset(30 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_sellBreachTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(80 *SIZE);
        make.top.equalTo(_buyBreachTF.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_costL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(_sellBreachTF.mas_bottom).offset(30 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_costTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(80 *SIZE);
        make.top.equalTo(_sellBreachTF.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_loanTimeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(_costTF.mas_bottom).offset(30 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_loanTimeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(80 *SIZE);
        make.top.equalTo(_costTF.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_cardTimeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(_loanTimeBtn.mas_bottom).offset(30 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_cardTimeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(80 *SIZE);
        make.top.equalTo(_loanTimeBtn.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_mortgageTimeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(_cardTimeBtn.mas_bottom).offset(30 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_mortgageTimeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(80 *SIZE);
        make.top.equalTo(_cardTimeBtn.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_payWayL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(_mortgageTimeBtn.mas_bottom).offset(30 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_payWayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(80 *SIZE);
        make.top.equalTo(_mortgageTimeBtn.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-28 *SIZE);
    }];
}

@end
