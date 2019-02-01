//
//  LookMaintainAddLookVC.m
//  云渠道
//
//  Created by 谷治墙 on 2019/1/25.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "LookMaintainAddLookVC.h"

#import "LookMaintainDetailAddAppointVC.h"

#import "DateChooseView.h"
#import "SinglePickView.h"

#import "DropDownBtn.h"
#import "BorderTF.h"

@interface LookMaintainAddLookVC ()<UITextFieldDelegate>
{
    
    NSString *_houseTakeFollowId;
    NSDictionary *_dataDic;
    LookMaintainDetailAddAppointRoomModel *_model;
    NSMutableArray *_agentArr;
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

@property (nonatomic, strong) BorderTF *priceBtn;

@property (nonatomic, strong) UILabel *payWayL;

@property (nonatomic, strong) DropDownBtn *payWayBtn;

@property (nonatomic, strong) UILabel *secLookL;

@property (nonatomic, strong) DropDownBtn *secLookBtn;

@property (nonatomic, strong) UILabel *markL;

@property (nonatomic, strong) UITextView *markTV;

@property (nonatomic, strong) UIButton *confirmBtn;

@property (nonatomic, strong) NSDateFormatter *formatter;

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
    
    [self initDataSource];
    [self initUI];

}

- (void)initDataSource{
    
    self.formatter = [[NSDateFormatter alloc] init];
    [self.formatter setDateFormat:@"YYYY-MM-dd"];
    _agentArr = [@[] mutableCopy];
}

- (void)ActionTagBtn:(UIButton *)btn{
    
    switch (btn.tag) {
        case 0:
        {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否出价" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
            
            UIAlertAction *Yaction = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                _offerBtn.content.text = @"是";
                _payWayL.hidden = NO;
                _payWayBtn.hidden = NO;
                _priceL.hidden = NO;
                _priceBtn.hidden = NO;
                [_secLookL mas_remakeConstraints:^(MASConstraintMaker *make) {
                    
                    make.left.equalTo(_contentView).offset(10 *SIZE);
                    make.top.equalTo(_payWayBtn.mas_bottom).offset(31 *SIZE);
                    make.width.mas_equalTo(70 *SIZE);
                }];
                
                [_secLookBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                    
                    make.left.equalTo(_contentView).offset(80 *SIZE);
                    make.top.equalTo(_payWayBtn.mas_bottom).offset(21 *SIZE);
                    make.width.mas_equalTo(257 *SIZE);
                    make.height.mas_equalTo(33 *SIZE);
                }];
            }];
            
            UIAlertAction *Naction = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                _offerBtn.content.text = @"否";
                _payWayL.hidden = YES;
                _payWayBtn.hidden = YES;
                _priceL.hidden = YES;
                _priceBtn.hidden = YES;
                
                [_secLookL mas_remakeConstraints:^(MASConstraintMaker *make) {
                    
                    make.left.equalTo(_contentView).offset(10 *SIZE);
                    make.top.equalTo(_offerBtn.mas_bottom).offset(31 *SIZE);
                    make.width.mas_equalTo(70 *SIZE);
                }];
                
                [_secLookBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                    
                    make.left.equalTo(_contentView).offset(80 *SIZE);
                    make.top.equalTo(_offerBtn.mas_bottom).offset(21 *SIZE);
                    make.width.mas_equalTo(257 *SIZE);
                    make.height.mas_equalTo(33 *SIZE);
                }];
            }];
            
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
                
            }];
            [alert addAction:Yaction];
            [alert addAction:Naction];
            [alert addAction:cancel];
            [self.navigationController presentViewController:alert animated:YES completion:^{
                
            }];
            break;
        }
        case 1:
        {
            break;
        }
        case 2:
        {
            SinglePickView *view = [[SinglePickView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height) WithData:[self getDetailConfigArrByConfigState:PAY_WAY]];
            view.selectedBlock = ^(NSString *MC, NSString *ID) {
                
                _payWayBtn.content.text = [NSString stringWithFormat:@"%@",MC];
                _payWayBtn->str = [NSString stringWithFormat:@"%@",ID];
            };
            [self.view addSubview:view];
            break;
        }
        case 3:
        {
            if (_agentArr.count) {
                
                SinglePickView *view = [[SinglePickView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height) WithData:_agentArr];
                view.selectedBlock = ^(NSString *MC, NSString *ID) {
                    
                    _secLookBtn.content.text = [NSString stringWithFormat:@"%@",MC];
                    _secLookBtn->str = [NSString stringWithFormat:@"%@",ID];
                };
                [self.view addSubview:view];
            }else{
                
                [BaseRequest GET:TakeMaintainFollowAgentList_URL parameters:nil success:^(id resposeObject) {
                    
                    if ([resposeObject[@"code"] integerValue] == 200) {
                        
                        _agentArr = [NSMutableArray arrayWithArray:[resposeObject[@"data"] mutableCopy]];
                        for (int i = 0; i < _agentArr.count; i++) {
                            
                            NSMutableDictionary *tempDic = [_agentArr[i] mutableCopy];
                            [tempDic setObject:tempDic[@"agent_id"] forKey:@"id"];
                            [tempDic setObject:tempDic[@"name"] forKey:@"param"];
                            [tempDic removeObjectForKey:@"agent_id"];
                            [tempDic removeObjectForKey:@"name"];
                            
                            [_agentArr replaceObjectAtIndex:i withObject:tempDic];
                        }
                        
                        SinglePickView *view = [[SinglePickView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height) WithData:_agentArr];
                        view.selectedBlock = ^(NSString *MC, NSString *ID) {
                            
                            _secLookBtn.content.text = [NSString stringWithFormat:@"%@",MC];
                            _secLookBtn->str = [NSString stringWithFormat:@"%@",ID];
                        };
                        [self.view addSubview:view];
                    }else{
                        
                        [self showContent:resposeObject[@"msg"]];
                    }
                } failure:^(NSError *error) {
                   
                    [self showContent:@"获取经纪人失败，请重试"];
                }];
            }
            break;
        }
        default:
            break;
    }
}

- (void)ActionCommitBtn:(UIButton *)btn{
    
    
    if ([self isEmpty:self.favTV.text]) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请填写客户中意点"];
        return;
    }
    
    if ([self isEmpty:self.resisTV.text]) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请填写客户抗性"];
        return;
    }
    
    if ([self isEmpty:_intentTF.textfield.text]) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请填写客户意向度"];
        return;
    }
    
    if (!_timeBtn.content.text.length) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请选择带看时间"];
        return;
    }
    
    if ([self isEmpty:_numTF.textfield.text]) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请填写带看人数"];
        return;
    }
    
    NSMutableDictionary *dic = [@{} mutableCopy];
    if ([_offerBtn.content.text isEqualToString:@"是"]) {
        
        if ([self isEmpty:_priceBtn.textfield.text]) {
            
            [self alertControllerWithNsstring:@"温馨提示" And:@"请填写出价金额"];
            return;
        }
        
        if (!_payWayBtn.content.text.length) {
            
            [self alertControllerWithNsstring:@"温馨提示" And:@"请选择付款方式"];
            return;
        }
        
        if ([self isEmpty:_markTV.text]) {
            
            [self alertControllerWithNsstring:@"温馨提示" And:@"请填写备注"];
            return;
        }
        [dic setObject:_priceBtn.textfield.text forKey:@"price"];
        [dic setObject:_payWayBtn->str forKey:@"pay_way"];
        
    }else{
        
        if ([self isEmpty:_markTV.text]) {
            
            [self alertControllerWithNsstring:@"温馨提示" And:@"请填写备注"];
            return;
        }
    }
    if (_secLookBtn.content.text.length) {
        
        [dic setObject:_secLookBtn->str forKey:@"attach_agent_id"];
    }
    [dic setObject:_favTV.text forKey:@"client_like"];
    [dic setObject:_resisTV.text forKey:@"client_dislike"];
    [dic setObject:_intentTF.textfield.text forKey:@"intent"];
    [dic setObject:_timeBtn.content.text forKey:@"take_time"];
    [dic setObject:_numTF.textfield.text forKey:@"take_visit_num"];
    [dic setObject:_markTV.text forKey:@"comment"];
    [dic setObject:_model.house_id forKey:@"house_id"];
    [dic setObject:_model forKey:@"model"];
    if (self.lookMaintainAddLookVCBlock) {
        
        self.lookMaintainAddLookVCBlock(dic);
    }
    for (UIViewController *vc in self.navigationController.viewControllers) {
        
        if ([vc isKindOfClass:[LookMaintainDetailAddAppointVC class]]) {
            
            [self.navigationController popToViewController:vc animated:YES];
        }
    }
}

- (void)ActionTimeBtn:(UIButton *)btn{
    
    DateChooseView *view = [[DateChooseView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    
//    view.pickerView.datePickerMode = UIDatePickerModeDateAndTime;

    
    __weak __typeof(&*self)weakSelf = self;
    view.dateblock = ^(NSDate *date) {
        
        weakSelf.timeBtn.content.text = [weakSelf.formatter stringFromDate:date];
    };
    [self.view addSubview:view];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (textField == _intentTF.textfield) {
        
        if ([_intentTF.textfield.text integerValue] > 100) {
            
            _intentTF.textfield.text = @"100";
        }
        _intentTF.textfield.text = [NSString stringWithFormat:@"%ld",[_intentTF.textfield.text integerValue]];
    }else if (textField == _numTF.textfield){
        
        if ([_numTF.textfield.text integerValue] > 10) {
            
            _numTF.textfield.text = @"10";
        }
        _numTF.textfield.text = [NSString stringWithFormat:@"%ld",[_numTF.textfield.text integerValue]];
    }
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
                _codeL.text = [NSString stringWithFormat:@"房源编号：%@",_model.house_code];
                [_houseView addSubview:_codeL];
                break;
            }
            case 1:
            {
                _houseL = label;
                _houseL.text = [NSString stringWithFormat:@"%@",_model.describe];
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
                _offerBtn.content.text = @"是";
                [_contentView addSubview:_offerBtn];
                break;
            }
            case 1:
            {
                _priceBtn = [[BorderTF alloc] initWithFrame:btn.frame];
                _priceBtn.unitL.text = @"元";
                _priceBtn.textfield.keyboardType = UIKeyboardTypeNumberPad;
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
            _intentTF.textfield.delegate = self;
            _intentTF.textfield.keyboardType = UIKeyboardTypeNumberPad;
            [_intentView addSubview:_intentTF];
        }else if (i == 1){
            
            _timeBtn = [[DropDownBtn alloc] initWithFrame:tf.frame];
            [_timeBtn addTarget:self action:@selector(ActionTimeBtn:) forControlEvents:UIControlEventTouchUpInside];
            [_intentView addSubview:_timeBtn];
        }else{
            
            _numTF = tf;
            _numTF.unitL.text = @"人";
            _numTF.textfield.delegate = self;
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
        make.width.mas_equalTo(70 *SIZE);
    }];

    [_intentTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_intentView).offset(80 *SIZE);
        make.top.equalTo(_intentView).offset(8 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_intentView).offset(10 *SIZE);
        make.top.equalTo(_intentTF.mas_bottom).offset(18 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_timeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_intentView).offset(80 *SIZE);
        make.top.equalTo(_intentTF.mas_bottom).offset(8 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_numL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_intentView).offset(10 *SIZE);
        make.top.equalTo(_timeBtn.mas_bottom).offset(18 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_numTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_intentView).offset(80 *SIZE);
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
