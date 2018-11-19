//
//  RentingCompleteSurveyInfoVC3.m
//  云渠道
//
//  Created by 谷治墙 on 2018/7/31.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RentingCompleteSurveyInfoVC3.h"
#import "CompleteSurveyInfoVC4.h"

#import "BaseFrameHeader.h"

#import "BorderTF.h"
#import "DropDownBtn.h"

@interface RentingCompleteSurveyInfoVC3 ()<UIScrollViewDelegate,UITextFieldDelegate>
{
    
    NSArray *_titleArr;
    NSArray *_titleArr2;
}
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIView *roomView;

@property (nonatomic, strong) BaseFrameHeader *roomHeader;

@property (nonatomic, strong) UILabel *addressL;

@property (nonatomic, strong) DropDownBtn *addressBtn;

@property (nonatomic, strong) UITextView *addressTV;

@property (nonatomic, strong) UILabel *typeL;

@property (nonatomic, strong) DropDownBtn *typeBtn;

@property (nonatomic, strong) UILabel *roomNumL;

@property (nonatomic, strong) DropDownBtn *roomNumBtn;

@property (nonatomic, strong) UILabel *roomTypeL;

@property (nonatomic, strong) DropDownBtn *roomTypeBtn;

@property (nonatomic, strong) UILabel *areaL;

@property (nonatomic, strong) BorderTF *areaTF;

@property (nonatomic, strong) UILabel *faceL;

@property (nonatomic, strong) DropDownBtn *faceBtn;

@property (nonatomic, strong) UILabel *floorL;

@property (nonatomic, strong) BorderTF *floorTF;

@property (nonatomic, strong) UILabel *yearL;

@property (nonatomic, strong) BorderTF *yearTF;

@property (nonatomic, strong) UILabel *decorateL;

@property (nonatomic, strong) DropDownBtn *decorateBtn;

@property (nonatomic, strong) UILabel *liftL;

@property (nonatomic, strong) DropDownBtn *liftBtn;

@property (nonatomic, strong) UIButton *nextBtn;

@end

@implementation RentingCompleteSurveyInfoVC3

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
    _titleArr2 = @[@"电梯：",@"拿证时间：",@"小区地址：",@"物业类型：",@"房号：",@"户型：",@"面积：",@"朝向：",@"楼层：",@"年代：",@"装修："];
}

- (void)ActionNextBtn:(UIButton *)btn{
    
    CompleteSurveyInfoVC4 *nextVC = [[CompleteSurveyInfoVC4 alloc] init];
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"完成勘察信息";
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.backgroundColor = self.view.backgroundColor;
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    
    
    _roomView = [[UIView alloc] init];
    _roomView.backgroundColor = CH_COLOR_white;
    [_scrollView addSubview:_roomView];
    
    _roomHeader = [[BaseFrameHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
    _roomHeader.titleL.text = @"房源信息";
    [_roomView addSubview:_roomHeader];
    
    _addressTV = [[UITextView alloc] init];
    _addressTV.layer.borderWidth = SIZE;
    _addressTV.layer.borderColor = COLOR(219, 219, 219, 1).CGColor;
    _addressTV.layer.cornerRadius = 5 *SIZE;
    _addressTV.clipsToBounds = YES;
    _addressTV.backgroundColor = COLOR(238, 238, 238, 1);
    _addressTV.userInteractionEnabled = NO;
    //    _addressTV.delegate = self;
    [_roomView addSubview:_addressTV];
    
    for (int i = 0; i < 11; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = YJTitleLabColor;
        label.adjustsFontSizeToFitWidth = YES;
        label.text = _titleArr2[i];
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        
        BorderTF *textField = [[BorderTF alloc] initWithFrame:CGRectMake(81 *SIZE, 47 *SIZE, 257 *SIZE, 33 *SIZE)];
        textField.backgroundColor = COLOR(238, 238, 238, 1);
        textField.userInteractionEnabled = NO;
        textField.textfield.delegate = self;
        
        DropDownBtn *btn = [[DropDownBtn alloc] initWithFrame:CGRectMake(81 *SIZE, 47 *SIZE, 257 *SIZE, 33 *SIZE)];
        btn.backgroundColor = COLOR(238, 238, 238, 1);
        btn.userInteractionEnabled = NO;
        switch (i) {
            case 0:
            {
                _liftL = label;
                [_roomView addSubview:_liftL];
                _liftBtn = btn;
                _liftBtn.userInteractionEnabled = YES;
                _liftBtn.backgroundColor = CH_COLOR_white;
                [_roomView addSubview:_liftBtn];
                break;
            }
            case 1:
            {
//                _timeL = label;
//                _timeBtn = btn;
//                _timeBtn.userInteractionEnabled = YES;
//                _timeBtn.backgroundColor = CH_COLOR_white;
//                [_roomView addSubview:_timeBtn];
//                [_roomView addSubview:_timeL];
                break;
            }
            case 2:
            {
                _addressL = label;
                [_roomView addSubview:_addressL];
                _addressBtn = btn;
                [_roomView addSubview:_addressBtn];
                break;
            }
            case 3:
            {
                _typeL = label;
                [_roomView addSubview:_typeL];
                
                _typeBtn = btn;
                [_roomView addSubview:_typeBtn];
                break;
            }
            case 4:
            {
                _roomNumL = label;
                [_roomView addSubview:_roomNumL];
                _roomNumBtn = btn;
                [_roomView addSubview:_roomNumBtn];
                break;
            }
            case 5:
            {
                _roomTypeL = label;
                [_roomView addSubview:_roomTypeL];
                _roomTypeBtn = btn;
                [_roomView addSubview:_roomTypeBtn];
                break;
            }
            case 6:
            {
                _areaL = label;
                [_roomView addSubview:_areaL];
                _areaTF = textField;
                [_roomView addSubview:_areaTF];
                break;
            }
            case 7:
            {
                _faceL = label;
                [_roomView addSubview:_faceL];
                _faceBtn = btn;
                [_roomView addSubview:_faceBtn];
                break;
            }
            case 8:
            {
                _floorL = label;
                [_roomView addSubview:_floorL];
                _floorTF = textField;
                [_roomView addSubview:_floorTF];
                break;
            }
            case 9:
            {
                _yearL = label;
                [_roomView addSubview:_yearL];
                _yearTF = textField;
                [_roomView addSubview:_yearTF];
                break;
            }
            case 10:
            {
                _decorateL = label;
                [_roomView addSubview:_decorateL];
                _decorateBtn = btn;
                _decorateBtn.userInteractionEnabled = YES;
                _decorateBtn.backgroundColor = CH_COLOR_white;
                [_roomView addSubview:_decorateBtn];
                break;
            }
            default:
                break;
        }
    }
    
    _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _nextBtn.titleLabel.font = [UIFont systemFontOfSize:14 *sIZE];
    [_nextBtn addTarget:self action:@selector(ActionNextBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [_nextBtn setBackgroundColor:YJBlueBtnColor];
    [_scrollView addSubview:_nextBtn];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(NAVIGATION_BAR_HEIGHT);
        make.right.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view).offset(0);
    }];
    
    [_roomView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrollView).offset(0);
        make.top.equalTo(_scrollView).offset(0 *SIZE);
        make.right.equalTo(_scrollView).offset(0);
        make.width.equalTo(@(SCREEN_Width));
        //        make.bottom.equalTo(_nextBtn.mas_top).offset(-28 *SIZE);
    }];
    
    
    [_typeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_roomView).offset(9 *SIZE);
        make.top.equalTo(_roomView).offset(70 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_typeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_roomView).offset(80 *SIZE);
        make.top.equalTo(_roomView).offset(60 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_roomNumL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_roomView).offset(9 *SIZE);
        make.top.equalTo(_typeBtn.mas_bottom).offset(29 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_roomNumBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_roomView).offset(80 *SIZE);
        make.top.equalTo(_typeBtn.mas_bottom).offset(18 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_roomTypeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_roomView).offset(9 *SIZE);
        make.top.equalTo(_roomNumBtn.mas_bottom).offset(29 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_roomTypeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_roomView).offset(80 *SIZE);
        make.top.equalTo(_roomNumBtn.mas_bottom).offset(18 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_areaL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_roomView).offset(9 *SIZE);
        make.top.equalTo(_roomTypeBtn.mas_bottom).offset(29 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_areaTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_roomView).offset(80 *SIZE);
        make.top.equalTo(_roomTypeBtn.mas_bottom).offset(18 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_faceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_roomView).offset(9 *SIZE);
        make.top.equalTo(_areaTF.mas_bottom).offset(29 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_faceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_roomView).offset(80 *SIZE);
        make.top.equalTo(_areaTF.mas_bottom).offset(18 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_floorL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_roomView).offset(9 *SIZE);
        make.top.equalTo(_faceBtn.mas_bottom).offset(29 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_floorTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_roomView).offset(80 *SIZE);
        make.top.equalTo(_faceBtn.mas_bottom).offset(18 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_yearL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_roomView).offset(9 *SIZE);
        make.top.equalTo(_floorTF.mas_bottom).offset(29 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_yearTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_roomView).offset(80 *SIZE);
        make.top.equalTo(_floorTF.mas_bottom).offset(18 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
        //        make.bottom.equalTo(_roomView).offset(-27 *SIZE);
    }];
    
    [_decorateL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_roomView).offset(9 *SIZE);
        make.top.equalTo(_yearTF.mas_bottom).offset(29 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_decorateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_roomView).offset(80 *SIZE);
        make.top.equalTo(_yearTF.mas_bottom).offset(18 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_liftL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_roomView).offset(9 *SIZE);
        make.top.equalTo(_decorateBtn.mas_bottom).offset(29 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_liftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_roomView).offset(80 *SIZE);
        make.top.equalTo(_decorateBtn.mas_bottom).offset(18 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_addressL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_roomView).offset(9 *SIZE);
        make.top.equalTo(_liftBtn.mas_bottom).offset(29 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_addressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_roomView).offset(80 *SIZE);
        make.top.equalTo(_liftBtn.mas_bottom).offset(18 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_addressTV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_roomView).offset(79 *SIZE);
        make.top.equalTo(_addressBtn.mas_bottom).offset(30 *SIZE);
        make.height.mas_equalTo(77 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.bottom.equalTo(_roomView.mas_bottom).offset(-27 *SIZE);
    }];
    
    [_nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrollView).offset(22 *SIZE);
        make.top.equalTo(_roomView.mas_bottom).offset(36 *SIZE);
        make.width.equalTo(@(317 *SIZE));
        make.height.equalTo(@(40 *SIZE));
        make.bottom.equalTo(_scrollView.mas_bottom).offset(-19 *SIZE);
    }];
}

@end
