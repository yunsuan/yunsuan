//
//  AddContractVC.m
//  云渠道
//
//  Created by 谷治墙 on 2019/1/11.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "AddContractCell.h"

@interface AddContractCell ()<UITextViewDelegate>

@end

@implementation AddContractCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}


-(void)action_cardTime
{
    if (self.cardTimeBlock !=nil) {
        
        self.cardTimeBlock();
    }
}

-(void)action_cancelTime
{
    if (self.cancelTimeBlock !=nil) {
        
        self.cancelTimeBlock();
    }
}

-(void)action_paywWay
{
    if (self.paywWayBlock !=nil) {
        
        self.paywWayBlock();
    }
}

-(void)action_buyReason
{
    if (self.buyReasonBlock !=nil) {
        
        self.buyReasonBlock();
    }
}


-(void)action_sellReason
{
    if (self.sellReasonBlock !=nil) {
        
        self.sellReasonBlock();
    }
}

-(void)setDataWithdic:(NSMutableDictionary *)dic{
    if (dic) {
        _data = [NSMutableDictionary dictionaryWithDictionary:dic];
        _codeTF.textfield.text = _data[@"deal_code"];
        _priceTF.textfield.text = _data[@"deal_money"];
        _buyBreachTF.textfield.text = _data[@"buy_breach"];
        _sellBreachTF.textfield.text = _data[@"sale_breach"];
        _buyCommissionTF.textfield.text = _data[@"buy_brokerage"];
        _sellCommissionTF.textfield.text = _data[@"sale_brokerage"];
        _loanTimeBtn.content.text = _data[@"certificate_time"];
        _cardTimeBtn.content.text =_data[@"mortgage_cancel_time"];
        _notesTV.text = _data[@"comment"];
        
        }
}

//@"construct_code":@"",
//@"deal_money":@"",
//@"buy_breach":@"",
//@"sale_breach":@"",
//@"buy_brokerage":@"",
//@"sale_brokerage":@"",
//@"certificate_time":@"",
//@"mortgage_cancel_time":@"",
//@"pay_way":@"",
//@"sale_reason":@"",
//@"buy_reason":@"",
//@"comment":@""

-(void)textChange:(UITextField *)textField{
    if (!self.data) {
        self.data = [NSMutableDictionary dictionary];
    }
    if (textField.tag ==1001) {
        [self.data setValue:textField.text forKey:@"deal_code"];
    }else if (textField.tag == 1002)
    {
        [self.data setValue:textField.text forKey:@"deal_money"];
    }else if (textField.tag == 1003)
    {
        [self.data setValue:textField.text forKey:@"buy_breach"];
    }
    else if(textField.tag == 1004){
        [self.data setValue:textField.text forKey:@"sale_breach"];
    }
    else if(textField.tag == 1005){
        [self.data setValue:textField.text forKey:@"buy_brokerage"];
    }
    else{
        [self.data setValue:textField.text forKey:@"sale_brokerage"];
    }
    if (self.textFiledBlock != nil) {
        self.textFiledBlock(self.data);
    }
}


-(void)textViewDidChange:(UITextView *)textView
{
     [self.data setValue:textView.text forKey:@"comment"];
    
    if (self.textFiledBlock != nil) {
        self.textFiledBlock(self.data);
    }
}


- (void)initUI{
    
    NSArray *titleArr = @[@"合同编号：",@"成交总价：",@"买方违约金额：",@"卖方违约金额：",@"买方支付佣金：",@"卖方支付佣金：",@"办证时间：",@"注销抵押时间：",@"付款方式：",@"买房原因：",@"卖房原因：",@"约定事项："];
    
    for (int i = 0 ; i < 12; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = YJTitleLabColor;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
//        label.numberOfLines = 0;
        label.text = titleArr[i];
        label.adjustsFontSizeToFitWidth = YES;
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
                _loanTimeL = label;
                [self.contentView addSubview:_loanTimeL];
                break;
            }
            case 7:
            {
                _cardTimeL = label;
                [self.contentView addSubview:_cardTimeL];
                break;
            }
            case 8:
            {
                _payWayL = label;
                [self.contentView addSubview:_payWayL];
                break;
            }
            case 9:
            {
                _buyReasonL = label;
                [self.contentView addSubview:_buyReasonL];
                break;
            }
            case 10:
            {
                _sellReasonL = label;
                [self.contentView addSubview:_sellReasonL];
                break;
            }
            case 11:
            {
                _notesL = label;
                [self.contentView addSubview:_notesL];
                break;
            }
            default:
                break;
        }
        
        if (i < 6) {
            
            BorderTF *tf = [[BorderTF alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
            switch (i) {
                case 0:
                {
                    _codeTF = tf;
                    _codeTF.textfield.tag = 1001;
                    [_codeTF.textfield addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingDidEnd];
                    _codeTF.textfield.keyboardType = UIKeyboardTypeASCIICapable;
                    _codeTF.textfield.text = _data[@"deal_code"];
                    [self.contentView addSubview:_codeTF];
                    break;
                }
                case 1:
                {
                    tf.unitL.text = @"元";
                    _priceTF = tf;
                    _priceTF.textfield.tag = 1002;
                    _priceTF.textfield.keyboardType =  UIKeyboardTypeDecimalPad;
                    [_priceTF.textfield addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingDidEnd];
                    _priceTF.textfield.text = _data[@"deal_money"];
                    [self.contentView addSubview:_priceTF];
                    break;
                }
                case 2:
                {
                    tf.unitL.text = @"元";
                    _buyBreachTF = tf;
                    _buyBreachTF.textfield.tag = 1003;
                    _buyBreachTF.textfield.keyboardType =  UIKeyboardTypeDecimalPad;
                    [_buyBreachTF.textfield addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingDidEnd];
                    _buyBreachTF.textfield.text = _data[@"buy_breach"];
                    [self.contentView addSubview:_buyBreachTF];
                    break;
                }
                case 3:
                {
                    tf.unitL.text = @"元";
                    _sellBreachTF = tf;
                    _sellBreachTF.textfield.tag = 1004;
                    _sellBreachTF.textfield.keyboardType =  UIKeyboardTypeDecimalPad;
                    [_sellBreachTF.textfield addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingDidEnd];
                    _sellBreachTF.textfield.text = _data[@"sale_breach"];
                    [self.contentView addSubview:_sellBreachTF];
                    break;
                }
                case 4:
                {
                    tf.unitL.text = @"元";
                    _buyCommissionTF = tf;
                    _buyCommissionTF.textfield.tag = 1005;
                    _buyCommissionTF.textfield.keyboardType =  UIKeyboardTypeDecimalPad;
                    [_buyCommissionTF.textfield addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingDidEnd];
                    _buyCommissionTF.textfield.text = _data[@"buy_brokerage"];
                    [self.contentView addSubview:_buyCommissionTF];
                    break;
                }
                    
                    case 5:
                {
                    tf.unitL.text = @"元";
                    _sellCommissionTF = tf;
                    _sellCommissionTF.textfield.tag = 1006;
                    _sellCommissionTF.textfield.keyboardType =  UIKeyboardTypeDecimalPad;
                     [_sellCommissionTF.textfield addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingDidEnd];
                    _sellCommissionTF.textfield.text = _data[@"sale_brokerage"];
                    [self.contentView addSubview:_sellCommissionTF];
                    
                    break;
                }
                default:
                    break;
            }
        }else if(i<11){
            
            DropDownBtn *btn = [[DropDownBtn alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
            switch (i) {
                case 6:
                {
                    _loanTimeBtn = btn;
                  
                    [_loanTimeBtn addTarget:self action:@selector(action_cardTime) forControlEvents:UIControlEventTouchUpInside];
                    _loanTimeBtn.content.text = _data[@"certificate_time"];
                    [self.contentView addSubview:_loanTimeBtn];
                    break;
                }
                case 7:
                {
                    _cardTimeBtn = btn;
                    _cardTimeBtn.content.text =_data[@"mortgage_cancel_time"];
                    [_cardTimeBtn addTarget:self action:@selector(action_cancelTime) forControlEvents:UIControlEventTouchUpInside];

                    [self.contentView addSubview:_cardTimeBtn];
                    break;
                }
                case 8:
                {
                    _payWayBtn = btn;
                    [_payWayBtn addTarget:self action:@selector(action_paywWay) forControlEvents:UIControlEventTouchUpInside];
                    [self.contentView addSubview:_payWayBtn];
                    break;
                }
                case 9:
                {
                    _buyReasonBtn = btn;
                    [_buyReasonBtn addTarget:self action:@selector(action_buyReason) forControlEvents:UIControlEventTouchUpInside];
                    [self.contentView addSubview:_buyReasonBtn];
                    break;
                }
                case 10:
                {
                    _sellReasonBtn = btn;
                    [_sellReasonBtn addTarget:self action:@selector(action_sellReason) forControlEvents:UIControlEventTouchUpInside];
                    [self.contentView addSubview:_sellReasonBtn];
                    break;
                }
                default:
                    break;
            }
        }
        else
        {
              _notesTV  = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 66 *SIZE)];
            _notesTV.contentInset = UIEdgeInsetsMake(5 *SIZE, 5 *SIZE, 5 *SIZE, 5 *SIZE);
            _notesTV.layer.cornerRadius = 5 *SIZE;
            _notesTV.layer.borderWidth = SIZE;
            _notesTV.layer.borderColor = COLOR(219, 219, 219, 1).CGColor;
            _notesTV.clipsToBounds = YES;
            _notesTV.delegate = self;
            _notesTV.text = _data[@"comment"];
            [self.contentView addSubview:_notesTV];
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
    
    [_buyCommissionL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(_sellBreachTF.mas_bottom).offset(30 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_buyCommissionTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(80 *SIZE);
        make.top.equalTo(_sellBreachTF.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_sellCommissionL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(_buyCommissionTF.mas_bottom).offset(30 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_sellCommissionTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(80 *SIZE);
        make.top.equalTo(_buyCommissionTF.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_loanTimeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(_sellCommissionTF.mas_bottom).offset(30 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_loanTimeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(80 *SIZE);
        make.top.equalTo(_sellCommissionTF.mas_bottom).offset(20 *SIZE);
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
    
    [_payWayL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(_cardTimeBtn.mas_bottom).offset(30 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_payWayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(80 *SIZE);
        make.top.equalTo(_cardTimeBtn.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
      
    }];
    
    [_buyReasonL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(_payWayBtn.mas_bottom).offset(30 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_buyReasonBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(80 *SIZE);
        make.top.equalTo(_payWayBtn.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
        
    }];
    
    [_sellReasonL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(_buyReasonBtn.mas_bottom).offset(30 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_sellReasonBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(80 *SIZE);
        make.top.equalTo(_buyReasonBtn.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
        
    }];
    
    [_notesL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(_sellReasonBtn.mas_bottom).offset(30 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_notesTV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(80 *SIZE);
        make.top.equalTo(_sellReasonBtn.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(66 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-28 *SIZE);
        
    }];
    

}

@end
