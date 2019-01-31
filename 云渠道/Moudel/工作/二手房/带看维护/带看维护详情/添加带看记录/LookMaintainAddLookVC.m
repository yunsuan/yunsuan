//
//  LookMaintainAddLookVC.m
//  云渠道
//
//  Created by 谷治墙 on 2019/1/25.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "LookMaintainAddLookVC.h"

#import "DropDownBtn.h"
#import "BorderTF.h"

@interface LookMaintainAddLookVC ()
{
    
    NSString *_houseTakeFollowId;
    NSDictionary *_dataDic;
    LookMaintainDetailAddAppointRoomModel *_model;
}
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIView *houseView;

@property (nonatomic, strong) UILabel *placeL;

@property (nonatomic, strong) UIView *intentView;

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UILabel *codeL;

@property (nonatomic, strong) UILabel *houseL;

@property (nonatomic, strong) UILabel *intentL;

@property (nonatomic, strong) BorderTF *intentTF;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) DropDownBtn *timeBtn;

@property (nonatomic, strong) UILabel *numL;

@property (nonatomic, strong) BorderTF *numTF;

@property (nonatomic, strong) UILabel *favL;

@property (nonatomic, strong) UITextView *favTV;

@property (nonatomic, strong) UILabel *resisL;

@property (nonatomic, strong) UITextView *resisTV;

@property (nonatomic, strong) UILabel *offerL;

@property (nonatomic, strong) DropDownBtn *offerBtn;

@property (nonatomic, strong) UILabel *priceL;

@property (nonatomic, strong) DropDownBtn *priceBtn;

@property (nonatomic, strong) UILabel *payWayL;

@property (nonatomic, strong) DropDownBtn *payWayBtn;

@property (nonatomic, strong) UILabel *secLookL;

@property (nonatomic, strong) DropDownBtn *secLookBtn;

@property (nonatomic, strong) UILabel *markL;

@property (nonatomic, strong) UITextView *markTV;

@property (nonatomic, strong) UIButton *confirmBtn;
@end

@implementation LookMaintainAddLookVC

- (instancetype)initWithModel:(LookMaintainDetailAddAppointRoomModel *)model
{
    self = [super init];
    if (self) {
        
        _model = model;
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];

}

- (void)ActionTagBtn:(UIButton *)btn{
    
    switch (btn.tag) {
        case 0:
        {
            break;
        }
        case 1:
        {
            break;
        }
        case 2:
        {
            break;
        }
        case 3:
        {
            break;
        }
        default:
            break;
    }
}

- (void)ActionCommitBtn:(UIButton *)btn{
    
    
}

- (void)ActionTimeBtn:(UIButton *)btn{
    
    
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"跟进记录";
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT)];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.backgroundColor = YJBackColor;
    [self.view addSubview:_scrollView];
    
    _houseView = [[UIView alloc] init];
    _houseView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:_houseView];
    
    _intentView = [[UIView alloc] init];
    _intentView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:_intentView];
    
    _contentView = [[UIView alloc] init];
    _contentView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:_contentView];
    
    NSArray *titleArr = @[@"房源编号：",@"房号：",@"客户反馈信息",@"意向度：",@"带看时间：",@"带看人数：",@"客户中意点：",@"客户抗性：",@"是否出价：",@"出价金额：",@"付款方式：",@"附带看：",@"备注："];
    for (int i = 0; i < 13; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = YJTitleLabColor;
        label.text = titleArr[i];
        label.adjustsFontSizeToFitWidth = YES;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        switch (i) {
            case 0:
            {
                _codeL = label;
//                _codeL.text = [NSString stringWithFormat:@"%@",_model.ho]
                [_houseView addSubview:_codeL];
                break;
            }
            case 1:
            {
                _houseL = label;
                [_houseView addSubview:_houseL];
                break;
            }
            case 2:
            {
                _placeL = label;
                _placeL.text = @"客户反馈信息";
                [_scrollView addSubview:_placeL];
                break;
            }
            case 3:
            {
                _intentL = label;
                [_intentView addSubview:_intentL];
                break;
            }
            case 4:
            {
                _timeL = label;
                [_intentView addSubview:_timeL];
                break;
            }
            case 5:
            {
                _numL = label;
                [_intentView addSubview:_numL];
                break;
            }
            case 6:
            {
                _favL = label;
                [_contentView addSubview:_favL];
                break;
            }
            case 7:
            {
                _resisL = label;
                [_contentView addSubview:_resisL];
                break;
            }
            case 8:
            {
                _offerL = label;
                [_contentView addSubview:_offerL];
                break;
            }
            case 9:
            {
                _priceL = label;
                [_contentView addSubview:_priceL];
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
                _secLookL = label;
                [_contentView addSubview:_secLookL];
                break;
            }
            case 12:
            {
                _markL = label;
                [_contentView addSubview:_markL];
                break;
            }
            default:
                break;
        }
    }
    
    for (int i = 0; i < 4; i++) {
        
        DropDownBtn *btn = [[DropDownBtn alloc] initWithFrame:CGRectMake(81 *SIZE, 0, 258 *SIZE, 33 *SIZE)];
        [btn addTarget:self action:@selector(ActionTagBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
        switch (i) {
            case 0:
            {
                _offerBtn = btn;
                [_contentView addSubview:_offerBtn];
                break;
            }
            case 1:
            {
                _priceBtn = btn;
                [_contentView addSubview:_priceBtn];
                break;
            }
            case 2:
            {
                _payWayBtn = btn;
                [_contentView addSubview:_payWayBtn];
                break;
            }
            case 3:
            {
                _secLookBtn = btn;
                [_contentView addSubview:_secLookBtn];
                break;
            }
            default:
                break;
        }
    }
    
    for (int i = 0; i < 3; i++) {
        
        BorderTF *tf = [[BorderTF alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
        if (i == 0) {
            
            _intentTF = tf;
            _intentTF.unitL.text = @"%";
            _intentTF.textfield.keyboardType = UIKeyboardTypeNumberPad;
            [_intentView addSubview:_intentTF];
        }else if (i == 1){
            
            _timeBtn = [[DropDownBtn alloc] initWithFrame:tf.frame];
            [_timeBtn addTarget:self action:@selector(ActionTimeBtn:) forControlEvents:UIControlEventTouchUpInside];
            [_intentView addSubview:_timeBtn];
        }else{
            
            _numTF = tf;
            _numTF.unitL.text = @"人";
            _numTF.textfield.keyboardType = UIKeyboardTypeNumberPad;
            [_intentView addSubview:_numTF];
        }
    }
    
    for (int i = 0; i < 3; i++) {
        
        UITextView *tv = [[UITextView alloc] init];
        tv.layer.cornerRadius = 5 *SIZE;
        tv.layer.borderWidth = SIZE;
        tv.layer.borderColor = YJBackColor.CGColor;
        tv.clipsToBounds = YES;
        if (i == 0) {
            
            _favTV = tv;
            [_contentView addSubview:_favTV];
        }else if (i == 1){
            
            _resisTV = tv;
            [_contentView addSubview:_resisTV];
        }else{
            
            _markTV = tv;
            [_contentView addSubview:_markTV];
        }
    }
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_confirmBtn addTarget:self action:@selector(ActionCommitBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_confirmBtn setTitle:@"提 交" forState:UIControlStateNormal];
    [_confirmBtn setBackgroundColor:YJBlueBtnColor];
    _confirmBtn.layer.cornerRadius = 2 *SIZE;
    _confirmBtn.clipsToBounds = YES;
    [_scrollView addSubview:_confirmBtn];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(NAVIGATION_BAR_HEIGHT);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(SCREEN_Height - NAVIGATION_BAR_HEIGHT);
    }];
    
    [_houseView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrollView).offset(0);
        make.top.equalTo(_scrollView).offset(0);
        make.width.mas_equalTo(SCREEN_Width);
    }];
    
    [_codeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_houseView).offset(10 *SIZE);
        make.top.equalTo(_houseView).offset(18 *SIZE);
        make.right.equalTo(_houseView.mas_right).offset(-10 *SIZE);
    }];
    
    [_houseL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_houseView).offset(10 *SIZE);
        make.top.equalTo(_codeL.mas_bottom).offset(15 *SIZE);
        make.right.equalTo(_houseView.mas_right).offset(-10 *SIZE);
        make.bottom.equalTo(_houseView).offset(-18 *SIZE);
    }];
    
    [_placeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrollView).offset(10 *SIZE);
        make.top.equalTo(_houseView.mas_bottom).offset(17 *SIZE);
        make.width.mas_equalTo(340 *SIZE);
    }];
    
    [_intentView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrollView).offset(0);
        make.top.equalTo(_placeL.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
    }];
    
    [_intentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_intentView).offset(10 *SIZE);
        make.top.equalTo(_intentView).offset(18 *SIZE);
        make.right.equalTo(_intentView.mas_right).offset(-10 *SIZE);
    }];

    [_intentTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(80 *SIZE);
        make.top.equalTo(_intentView.mas_bottom).offset(8 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_intentView).offset(10 *SIZE);
        make.top.equalTo(_intentTF.mas_bottom).offset(18 *SIZE);
        make.right.equalTo(_intentView.mas_right).offset(-10 *SIZE);
    }];
    
    [_timeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(80 *SIZE);
        make.top.equalTo(_intentTF.mas_bottom).offset(8 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_numL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_intentView).offset(10 *SIZE);
        make.top.equalTo(_timeBtn.mas_bottom).offset(18 *SIZE);
        make.right.equalTo(_intentView.mas_right).offset(-10 *SIZE);
        
    }];
    
    [_numTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(80 *SIZE);
        make.top.equalTo(_timeBtn.mas_bottom).offset(8 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
        make.bottom.equalTo(_intentView).offset(-14 *SIZE);
    }];
    
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrollView).offset(0);
        make.top.equalTo(_intentView.mas_bottom).offset(6 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
//        make.bottom.equalTo(_scrollView).offset(0 *SIZE);
    }];
    
    [_favL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(10 *SIZE);
        make.top.equalTo(_contentView).offset(24 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_favTV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(80 *SIZE);
        make.top.equalTo(_contentView).offset(24 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(77 *SIZE);
    }];
    
    [_resisL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(10 *SIZE);
        make.top.equalTo(_favTV.mas_bottom).offset(18 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_resisTV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(80 *SIZE);
        make.top.equalTo(_favTV.mas_bottom).offset(18 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(77 *SIZE);
    }];
    
    [_offerL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(10 *SIZE);
        make.top.equalTo(_resisTV.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_offerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(80 *SIZE);
        make.top.equalTo(_resisTV.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(10 *SIZE);
        make.top.equalTo(_offerBtn.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_priceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(80 *SIZE);
        make.top.equalTo(_offerBtn.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_payWayL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(10 *SIZE);
        make.top.equalTo(_priceBtn.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_payWayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(80 *SIZE);
        make.top.equalTo(_priceBtn.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_secLookL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(10 *SIZE);
        make.top.equalTo(_payWayBtn.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_secLookBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(80 *SIZE);
        make.top.equalTo(_payWayBtn.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_markL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(10 *SIZE);
        make.top.equalTo(_secLookBtn.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_markTV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(80 *SIZE);
        make.top.equalTo(_secLookBtn.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(77 *SIZE);
        make.bottom.equalTo(_contentView).offset(-38 *SIZE);
    }];
    
    [_confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrollView).offset(22 *SIZE);
        make.top.equalTo(_contentView.mas_bottom).offset(37 *SIZE);
        make.width.mas_equalTo(317 *SIZE);
        make.height.mas_equalTo(40 *SIZE);
        make.bottom.equalTo(_scrollView.mas_bottom).offset(-36 *SIZE);
    }];
}

@end
