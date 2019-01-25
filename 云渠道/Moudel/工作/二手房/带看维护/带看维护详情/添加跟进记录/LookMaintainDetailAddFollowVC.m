//
//  LookMaintainDetailAddFollowVC.m
//  云渠道
//
//  Created by 谷治墙 on 2019/1/25.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "LookMaintainDetailAddFollowVC.h"

#import "DropDownBtn.h"

@interface LookMaintainDetailAddFollowVC ()

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UILabel *wayL;

@property (nonatomic, strong) UILabel *progressL;

@property (nonatomic, strong) UILabel *purposeL;

@property (nonatomic, strong) UILabel *levelL;

@property (nonatomic, strong) UILabel *typeL;

@property (nonatomic, strong) UILabel *decorateL;

@property (nonatomic, strong) UILabel *areaL;

@property (nonatomic, strong) UILabel *priceL;

@property (nonatomic, strong) UILabel *houseTypeL;

@property (nonatomic, strong) UILabel *payWayL;

@property (nonatomic, strong) UILabel *contentL;

@property (nonatomic, strong) UILabel *nextTimeL;

@property (nonatomic, strong) UIButton *commitBtn;

@end

@implementation LookMaintainDetailAddFollowVC

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self initUI];
}

- (void)initUI{
    
    self.titleLabel.text = @"跟进记录";
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.backgroundColor = YJBackColor;
    [self.view addSubview:_scrollView];
    
    _contentView = [[UIView alloc] init];
    [_scrollView addSubview:_contentView];
    
    for (int i = 0; i < 13; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = YJTitleLabColor;
        label.font = [UIFont systemFontOfSize:12 *SIZE];
        switch (i) {
            case 0:
            {
                _timeL = label;
                [_contentView addSubview:_timeL];
                break;
            }
            case 1:
            {
                _wayL = label;
                [_contentView addSubview:_wayL];
                break;
            }
            case 2:
            {
                _progressL = label;
                [_contentView addSubview:_progressL];
                break;
            }
            case 3:
            {
                _purposeL = label;
                [_contentView addSubview:_purposeL];
                break;
            }
            case 4:
            {
                _levelL = label;
                [_contentView addSubview:_levelL];
                break;
            }
            case 5:
            {
                _typeL = label;
                [_contentView addSubview:_typeL];
                break;
            }
            case 6:
            {
                _decorateL = label;
                [_contentView addSubview:_decorateL];
                break;
            }
            case 7:
            {
                _areaL = label;
                [_contentView addSubview:_areaL];
                break;
            }
            case 8:
            {
                _priceL = label;
                [_contentView addSubview:_priceL];
                break;
            }
            case 9:
            {
                _houseTypeL = label;
                [_contentView addSubview:_houseTypeL];
                break;
            }
            case 10:
            {
                _payWayL = label;
                [_contentView addSubview:_payWayL];
                break;
            }
            case 11:
            {
                _contentL = label;
                [_contentView addSubview:_contentL];
                break;
            }
            case 12:
            {
                _nextTimeL = label;
                [_contentView addSubview:_nextTimeL];
                break;
            }
            default:
                break;
        }
    }
}



@end
