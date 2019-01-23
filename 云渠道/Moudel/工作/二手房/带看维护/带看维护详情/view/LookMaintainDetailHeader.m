//
//  LookMaintainDetailHeader.m
//  云渠道
//
//  Created by 谷治墙 on 2019/1/23.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "LookMaintainDetailHeader.h"

@implementation LookMaintainDetailHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionTagBtn:(UIButton *)btn{
    
    
}

- (void)initUI{
    
    _systemView = [[UIView alloc] init];
    _systemView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_systemView];
    
    _customHeader = [[BaseHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
    [_systemView addSubview:_customHeader];
    
    for (int i = 0 ; i < 3; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = YJContentLabColor;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
//        label.textAlignment = <#NSTextAlignment#>;
        if (i == 0) {
            
            _sourceL = label;
            [_systemView addSubview:_sourceL];
        }else if (i == 1){
            
            _wayL = label;
            [_systemView addSubview:_wayL];
        }else{
            
            _timeL = label;
            [_systemView addSubview:_timeL];
        }
    }
    
    _customView = [[UIView alloc] init];
    _customView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_customView];
    
    for (int i = 0 ; i < 6; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = YJContentLabColor;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        switch (i) {
            case 0:
            {
                _nameL = label;
                [_customView addSubview:_nameL];
                break;
            }
            case 1:
            {
                _phoneL = label;
                [_customView addSubview:_phoneL];
                break;
            }
            case 2:
            {
                _followTimeL = label;
                [_customView addSubview:_followTimeL];
                break;
            }
            case 3:
            {
                _customLevelL = label;
                [_customView addSubview:_customLevelL];
                break;
            }
            case 4:
            {
                _matchL = label;
                [_customView addSubview:_matchL];
                break;
            }
            case 5:
            {
                _progressL = label;
                [_customView addSubview:_progressL];
                break;
            }
            default:
                break;
        }
    }
    
    _needView = [[UIView alloc] init];
    _needView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_needView];
    
    _needHeader = [[BaseHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
    [_needView addSubview:_needHeader];
    
    for (int i = 0; i < 8 ; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = YJContentLabColor;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        switch (i) {
            case 0:
            {
                _purposeL = label;
                [_needView addSubview:_purposeL];
                break;
            }
            case 1:
            {
                _typeL = label;
                [_needView addSubview:_houseTypeL];
                break;
            }
            case 2:
            {
                _decorateL = label;
                [_needView addSubview:_decorateL];
                break;
            }
            case 3:
            {
                _priceL = label;
                [_needView addSubview:_priceL];
                break;
            }
            case 4:
            {
                _areaL = label;
                [_needView addSubview:_areaL];
                break;
            }
            case 5:
            {
                _houseTypeL = label;
                [_needView addSubview:_houseTypeL];
                break;
            }
            case 6:
            {
                _payWayL = label;
                [_needView addSubview:_payWayL];
                break;
            }
            case 7:
            {
                _markL = label;
                [_needView addSubview:_markL];
                break;
            }
            default:
                break;
        }
    }
    
    for (int i = 0; i < 3; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
        [btn addTarget:self action:@selector(ActionTagBtn:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0) {
            
        }else if (i == 1){
            
        }else{
            
            
        }
    }
}



@end
