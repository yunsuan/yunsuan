//
//  AddContractCell3.m
//  云渠道
//
//  Created by 谷治墙 on 2019/1/11.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "AddContractCell3.h"

@implementation AddContractCell3

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    NSArray *arr = @[@"",@"",@"",@"付款日期：",@"付款金额：",@"商业贷款银行："];
    for (int i = 0; i < 6; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = YJTitleLabColor;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        label.text = arr[i];
        label.adjustsFontSizeToFitWidth = YES;
        
        switch (i) {
            case 0:
            {
                _payWayL = label;
                [self.contentView addSubview:_payWayL];
                
                break;
            }
            case 1:
            {
                _allPriceL = label;
                [self.contentView addSubview:_allPriceL];
                break;
            }
            case 2:
            {
                _priceL = label;
                [self.contentView addSubview:_priceL];
                break;
            }
            case 3:
            {
                _payTimeL = label;
                [self.contentView addSubview:_payTimeL];
                break;
            }
            case 4:
            {
                _payPriceL = label;
                [self.contentView addSubview:_payPriceL];
                break;
            }
            case 5:
            {
                _loanBankL = label;
                [self.contentView addSubview:_loanBankL];
                break;
            }
            default:
                break;
        }
        
        _payTimeBtn = [[DropDownBtn alloc] initWithFrame:CGRectMake(0, 0, 243 *SIZE, 33 *SIZE)];
        [self.contentView addSubview:_payTimeBtn];
        
        if (i < 2) {
            
            BorderTF *tf = [[BorderTF alloc] initWithFrame:CGRectMake(0, 0, 243 *SIZE, 33 *SIZE)];
            if (i < 3) {
                
                tf.unitL.text = @"万";
            }
            
            switch (i) {
                case 0:
                {
                    _payPriceTF = tf;
                    [self.contentView addSubview:_payPriceTF];
                    
                    break;
                }
                case 1:
                {
                    _loanBankTF = tf;
                    [self.contentView addSubview:_loanBankTF];
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
    
    [_payWayL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
        make.top.equalTo(self.contentView).offset(15 *SIZE);
    }];
    
    [_allPriceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
        make.top.equalTo(_payWayL.mas_bottom).offset(16 *SIZE);
    }];
    
    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
        make.top.equalTo(_allPriceL.mas_bottom).offset(16 *SIZE);
    }];
    
    [_payTimeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_priceL.mas_bottom).offset(35 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_payTimeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(100 *SIZE);
        make.width.mas_equalTo(243 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
        make.top.equalTo(_priceL.mas_bottom).offset(35 *SIZE);
    }];
    
    [_payPriceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_payTimeBtn.mas_bottom).offset(33 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_payPriceTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(100 *SIZE);
        make.width.mas_equalTo(243 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
        make.top.equalTo(_payTimeBtn.mas_bottom).offset(20 *SIZE);
    }];
    
    [_loanBankL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_payPriceTF.mas_bottom).offset(33 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_loanBankTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(100 *SIZE);
        make.width.mas_equalTo(243 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
        make.top.equalTo(_payPriceTF.mas_bottom).offset(20 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-22 *SIZE);
    }];
}

@end
