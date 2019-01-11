//
//  AddContractCell2.m
//  云渠道
//
//  Created by 谷治墙 on 2019/1/11.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "AddContractCell2.h"

@implementation AddContractCell2

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    NSArray *arr = @[@"",@"",@"",@"首付款：",@"商业贷款金额：",@"商业贷款年限：",@"商业贷款银行："];
    for (int i = 0; i < 7; i++) {
        
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
                _firstPayL = label;
                [self.contentView addSubview:_firstPayL];
                break;
            }
            case 4:
            {
                _loanPriceL = label;
                [self.contentView addSubview:_loanPriceL];
                break;
            }
            case 5:
            {
                _loanYearL = label;
                [self.contentView addSubview:_loanYearL];
                break;
            }
            case 6:
            {
                _loanBankL = label;
                [self.contentView addSubview:_loanBankL];
                break;
            }
            default:
                break;
        }
        
        if (i < 4) {
            
            BorderTF *tf = [[BorderTF alloc] initWithFrame:CGRectMake(0, 0, 243 *SIZE, 33 *SIZE)];
            if (i < 3) {
                
                tf.unitL.text = @"万";
            }
            
            switch (i) {
                case 0:
                {
                    _firstPayTF = tf;
                    [self.contentView addSubview:_firstPayTF];
                    
                    break;
                }
                case 1:
                {
                    _loanPriceTF = tf;
                    [self.contentView addSubview:_loanPriceTF];
                    break;
                }
                case 2:
                {
                    _loanYearTF = tf;
                    [self.contentView addSubview:_loanYearTF];
                    break;
                }
                case 3:
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
    
    [_firstPayL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_priceL.mas_bottom).offset(35 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_firstPayTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(100 *SIZE);
        make.width.mas_equalTo(243 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
        make.top.equalTo(_priceL.mas_bottom).offset(35 *SIZE);
    }];
    
    [_loanPriceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_firstPayTF.mas_bottom).offset(33 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_loanPriceTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(100 *SIZE);
        make.width.mas_equalTo(243 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
        make.top.equalTo(_firstPayTF.mas_bottom).offset(20 *SIZE);
    }];
    
    [_loanYearL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_loanPriceTF.mas_bottom).offset(33 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_loanYearTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(100 *SIZE);
        make.width.mas_equalTo(243 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
        make.top.equalTo(_loanPriceTF.mas_bottom).offset(20 *SIZE);
    }];
    
    [_loanBankL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_loanYearTF.mas_bottom).offset(33 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_loanBankTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(100 *SIZE);
        make.width.mas_equalTo(243 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
        make.top.equalTo(_loanYearTF.mas_bottom).offset(20 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-22 *SIZE);
    }];
}

@end
