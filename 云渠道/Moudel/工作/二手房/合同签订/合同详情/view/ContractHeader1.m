//
//  ContractHeader1.m
//  云渠道
//
//  Created by xiaoq on 2019/2/14.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "ContractHeader1.h"

@implementation ContractHeader1

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

-(void)initUI{
    
    [self addSubview:self.tradeView];
    
    
    _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(10*SIZE, 13*SIZE, 67*SIZE, 67*SIZE)];
    [_tradeView addSubview:_imgView];

    
    _numLab = [[UILabel alloc]initWithFrame:CGRectMake(93*SIZE, 13*SIZE, 250*SIZE, 15*SIZE)];
    _numLab.font = [UIFont systemFontOfSize:14*SIZE];
    _numLab.textColor = YJTitleLabColor;
//    _numLab.text = @"交易编号：001332";
    [_tradeView addSubview:_numLab];
 
    
    _creattimeLab = [[UILabel alloc]initWithFrame:CGRectMake(93*SIZE, 38*SIZE, 150*SIZE, 13*SIZE)];
    _creattimeLab.font = [UIFont systemFontOfSize:12*SIZE];
    _creattimeLab.textColor = YJContentLabColor;
//    _creattimeLab.text = @"创建时间：2018/02/01";
    [_tradeView addSubview:_creattimeLab];
 
    
    _passtimeLab = [[UILabel alloc]initWithFrame:CGRectMake(240*SIZE, 38*SIZE, 110*SIZE, 13*SIZE)];
    _passtimeLab.font = [UIFont systemFontOfSize:12*SIZE];
    _passtimeLab.textColor = YJContentLabColor;
    _passtimeLab.textAlignment = NSTextAlignmentRight;
//    _passtimeLab.text = @"审核时间：2018/02/01";
    [_tradeView addSubview:_passtimeLab];
  
    
    _peopleLab = [[UILabel alloc]initWithFrame:CGRectMake(93*SIZE, 61*SIZE, 250*SIZE, 13*SIZE)];
    _peopleLab.font = [UIFont systemFontOfSize:12*SIZE];
    _peopleLab.textColor = YJContentLabColor;
//    _peopleLab.text = @"签约人员：李四-链家门店";
    [_tradeView addSubview:_peopleLab];
 
    
    _moneyLab = [[UILabel alloc]initWithFrame:CGRectMake(250*SIZE, 13*SIZE, 100*SIZE, 13*SIZE)];
    _moneyLab.font = [UIFont systemFontOfSize:12*SIZE];
    _moneyLab.textAlignment = NSTextAlignmentRight;
    _moneyLab.textColor = COLOR(255, 70, 70, 1);
//    _moneyLab.text = @"300万";
    [_tradeView addSubview:_moneyLab];
    
    
    
    [self addSubview:self.infoView];
   
    
    _adressLab = [[UILabel alloc]initWithFrame:CGRectMake(10*SIZE, 13*SIZE, 300*SIZE, 15*SIZE)];
    _adressLab.font = [UIFont systemFontOfSize:14*SIZE];
    _adressLab.textColor = YJTitleLabColor;
//    _adressLab.text = @"翡翠滨江 成都市-高新区-大禹东路";
    [_infoView addSubview:_adressLab];
    
    _roomLab = [[UILabel alloc]initWithFrame:CGRectMake(10*SIZE, 37*SIZE, 300*SIZE, 13*SIZE)];
    _roomLab.font = [UIFont systemFontOfSize:12*SIZE];
    _roomLab.textColor = YJContentLabColor;
//    _roomLab.text = @"房间信息：12栋-2单元-1102";
    [_infoView addSubview:_roomLab];
    
    _buyLab = [[UILabel alloc]initWithFrame:CGRectMake(10*SIZE, 62*SIZE, 200*SIZE, 13*SIZE)];
    _buyLab.font = [UIFont systemFontOfSize:12*SIZE];
    _buyLab.textColor = YJContentLabColor;
//    _buyLab.text = @"买房原因：投资";
    [_infoView addSubview:_buyLab];
    
    _sellLab = [[UILabel alloc]initWithFrame:CGRectMake(150*SIZE, 62*SIZE, 200*SIZE, 13*SIZE)];
    _sellLab.font = [UIFont systemFontOfSize:12*SIZE];
    _sellLab.textAlignment = NSTextAlignmentRight;
    _sellLab.textColor = YJContentLabColor;
//    _sellLab.text = @"卖房原因：变现";
    [_infoView addSubview:_sellLab];
    
    
    
}

-(UIView *)tradeView
{
    if (!_tradeView) {
        _tradeView = [[UIView alloc]initWithFrame:CGRectMake(0, 1*SIZE, 360*SIZE, 93*SIZE)];
        _tradeView.backgroundColor = [UIColor whiteColor];
    }
    return _tradeView;
}

-(UIView *)infoView
{
    if (!_infoView) {
        _infoView = [[UIView alloc]initWithFrame:CGRectMake(0, 97*SIZE, 360*SIZE, 93*SIZE)];
        _infoView.backgroundColor = [UIColor whiteColor];
    }
    return _infoView;
}

@end
