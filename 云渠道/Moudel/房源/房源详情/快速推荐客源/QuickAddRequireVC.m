//
//  QuickAddRequireVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/5/4.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "QuickAddRequireVC.h"
#import "DropDownBtn.h"
#import "BorderTF.h"
#import "AdressChooseView.h"
#import "CustomerVC.h"
#import "SinglePickView.h"
#import "CustomDetailTableCell4.h"
#import "AddTagVC.h"
#import "AddTagView.h"
#import "RoomProjectVC.h"
#import "RoomDetailVC1.h"

@interface QuickAddRequireVC ()

<UITextViewDelegate>
{
    
    NSMutableArray *_stairArr;
    NSArray *_propertyArr;
    NSInteger _num;
    NSInteger _btnNum;
    NSString *_projectId;
}

@property (nonatomic, strong) UIScrollView *scrolleView;

@property (nonatomic, strong) UIView *infoView;

@property (nonatomic, strong) UIButton *addBtn;

@property (nonatomic, strong) DropDownBtn *addressBtn;

@property (nonatomic, strong) DropDownBtn *addressBtn2;

@property (nonatomic, strong) DropDownBtn *addressBtn3;

@property (nonatomic, strong) DropDownBtn *houseTypeBtn;

@property (nonatomic, strong) DropDownBtn *priceBtn;

@property (nonatomic, strong) DropDownBtn *areaBtn;

@property (nonatomic, strong) DropDownBtn *typeBtn;

@property (nonatomic, strong) DropDownBtn *purposeBtn;

@property (nonatomic, strong) DropDownBtn *payWayBtn;

@property (nonatomic, strong) UILabel *addressL;

@property (nonatomic, strong) UILabel *houseTypeL;

@property (nonatomic, strong) UILabel *priceL;

@property (nonatomic, strong) UILabel *areaL;

@property (nonatomic, strong) UILabel *typeL;

@property (nonatomic, strong) UILabel *floorL;

@property (nonatomic, strong) UILabel *standardL;

@property (nonatomic, strong) UILabel *purposeL;

@property (nonatomic, strong) UILabel *payWayL;

@property (nonatomic, strong) UILabel *intentionL;

@property (nonatomic, strong) UILabel *urgentL;

@property (nonatomic, strong) DropDownBtn *floorTF1;

@property (nonatomic, strong) DropDownBtn *floorTF2;

@property (nonatomic, strong) DropDownBtn *standardTF;

@property (nonatomic, strong) BorderTF *intentionTF;

@property (nonatomic, strong) BorderTF *urgentTF;

@property (nonatomic, strong) UISlider *intentionSlider;

@property (nonatomic, strong) UISlider *urgentSlider;

@property (nonatomic, strong) UIView *sectionLine;

@property (nonatomic, strong) AddTagView *tagView;

@property (nonatomic, strong) UITextView *markTV;

@property (nonatomic, strong) UILabel *placeL;

@property (nonatomic, strong) UIButton *nextBtn;

@end

@implementation QuickAddRequireVC

- (instancetype)initWithProjectId:(NSString *)projectId
{
    self = [super init];
    if (self) {
        
        _projectId = projectId;
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // 禁用返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // 开启返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
    _stairArr = [[NSMutableArray alloc] init];
    _propertyArr = [self getDetailConfigArrByConfigState:PROPERTY_TYPE];
    for (int i = 1; i < 50; i++) {
        
        NSString *str = [NSString stringWithFormat:@"%d层",i];
        [_stairArr addObject:@{@"id":@(i),@"param":str}];
    }
}

- (void)ActionAreaBtn:(UIButton *)btn{
    
    switch (btn.tag) {
        case 0:
        {
            _btnNum = 1;
            break;
        }
        case 1:
        {
            _btnNum = 2;
            break;
        }
        case 2:
        {
            _btnNum = 3;
            break;
        }
        default:
            break;
    }
    AdressChooseView *addressChooseView= [[AdressChooseView alloc]initWithFrame:self.view.frame withdata:@[]];
    WS(weakself);
    addressChooseView.selectedBlock = ^(NSString *province, NSString *city, NSString *area, NSString *proviceid, NSString *cityid, NSString *areaid) {
        
        if (_btnNum == 1) {
            
            weakself.addressBtn.content.text = [NSString stringWithFormat:@"%@/%@/%@",province,city,area];
            weakself.addressBtn->str = [NSString stringWithFormat:@"%@-%@-%@", proviceid, cityid, areaid];
        }else if (_btnNum == 2){
            
            weakself.addressBtn2.content.text = [NSString stringWithFormat:@"%@/%@/%@",province,city,area];
            weakself.addressBtn3->str = [NSString stringWithFormat:@"%@-%@-%@", proviceid, cityid, areaid];
        }else{
            
            weakself.addressBtn3.content.text = [NSString stringWithFormat:@"%@/%@/%@",province,city,area];
            weakself.addressBtn3->str = [NSString stringWithFormat:@"%@-%@-%@", proviceid, cityid, areaid];
        }
    };
    
    [self.view addSubview:addressChooseView];
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
            SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:_propertyArr];
            WS(weakself);
            view.selectedBlock = ^(NSString *MC, NSString *ID) {
                
                weakself.houseTypeBtn.content.text = MC;
                weakself.houseTypeBtn->str = [NSString stringWithFormat:@"%@", ID];
            };
            [self.view addSubview:view];
            break;
        }
        case 4:
        {
            SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:[self getDetailConfigArrByConfigState:TOTAL_PRICE]];
            WS(weakself);
            view.selectedBlock = ^(NSString *MC, NSString *ID) {
                
                weakself.priceBtn.content.text = MC;
                weakself.priceBtn->str = [NSString stringWithFormat:@"%@", ID];
            };
            [self.view addSubview:view];
            break;
        }
        case 5:
        {
            SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:[self getDetailConfigArrByConfigState:AREA]];
            WS(weakself);
            view.selectedBlock = ^(NSString *MC, NSString *ID) {
                
                weakself.areaBtn.content.text = MC;
                weakself.areaBtn->str = [NSString stringWithFormat:@"%@", ID];
            };
            [self.view addSubview:view];
            break;
        }
        case 6:
        {
            SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:[self getDetailConfigArrByConfigState:HOUSE_TYPE]];
            WS(weakself);
            view.selectedBlock = ^(NSString *MC, NSString *ID) {
                
                weakself.typeBtn.content.text = MC;
                weakself.typeBtn->str = [NSString stringWithFormat:@"%@", ID];
            };
            [self.view addSubview:view];
            break;
        }
        case 7:
        {
            SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:[self getDetailConfigArrByConfigState:BUY_TYPE]];
            WS(weakself);
            view.selectedBlock = ^(NSString *MC, NSString *ID) {
                
                weakself.purposeBtn.content.text = MC;
                weakself.purposeBtn->str = [NSString stringWithFormat:@"%@", ID];
            };
            [self.view addSubview:view];
            break;
        }
        case 8:
        {
            SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:[self getDetailConfigArrByConfigState:PAY_WAY]];
            WS(weakself);
            view.selectedBlock = ^(NSString *MC, NSString *ID) {
                
                weakself.payWayBtn.content.text = MC;
                weakself.payWayBtn->str = [NSString stringWithFormat:@"%@", ID];
            };
            [self.view addSubview:view];
            break;
        }
        case 9:
        {
            SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:_stairArr];
            WS(weakself);
            view.selectedBlock = ^(NSString *MC, NSString *ID) {
                
                weakself.floorTF1.content.text = MC;
                weakself.floorTF1->str = [NSString stringWithFormat:@"%@", ID];
            };
            [self.view addSubview:view];
            break;
        }
        case 10:
        {
            SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:_stairArr];
            WS(weakself);
            view.selectedBlock = ^(NSString *MC, NSString *ID) {
                
                weakself.floorTF2.content.text = MC;
                weakself.floorTF2->str = [NSString stringWithFormat:@"%@", ID];
            };
            [self.view addSubview:view];
            break;
        }
        case 11:
        {
            SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:[self getDetailConfigArrByConfigState:DECORATE]];
            WS(weakself);
            view.selectedBlock = ^(NSString *MC, NSString *ID) {
                
                weakself.standardTF.content.text = MC;
                weakself.standardTF->str = [NSString stringWithFormat:@"%@", ID];
            };
            [self.view addSubview:view];
            break;
        }
        default:
            break;
    }
}

- (void)ActionNextBtn:(UIButton *)btn{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[self.infoModel modeltodic]];
    if (_btnNum == 1) {
        if (self.addressBtn->str.length) {
            
            [dic setObject:self.addressBtn->str forKey:@"region"];
        }
    }else if (_btnNum == 2){
        
        if (self.addressBtn2->str.length) {
            
            [dic setObject:[NSString stringWithFormat:@"%@,%@", self.addressBtn->str, self.addressBtn2->str] forKey:@"region"];
        }
    }else{
        
        if (self.addressBtn3->str.length) {
            
            [dic setObject:[NSString stringWithFormat:@"%@,%@,%@", self.addressBtn->str, self.addressBtn2->str, self.addressBtn3->str] forKey:@"region"];
        }
    }
    if (_houseTypeBtn->str.length) {
        
        [dic setObject:_houseTypeBtn->str forKey:@"property_type"];
    }
    if (_priceBtn->str.length) {
        
        [dic setObject:_priceBtn->str forKey:@"total_price"];
    }
    if (_areaBtn->str.length) {
        
        [dic setObject:_areaBtn->str forKey:@"area"];
    }
    if (_typeBtn->str.length) {
        
        [dic setObject:_typeBtn->str forKey:@"house_type"];
    }
    if (_floorTF1->str.length) {
        
        [dic setObject:_floorTF1->str forKey:@"floor_min"];
    }
    if (_floorTF2->str.length) {
        
        [dic setObject:_floorTF2->str forKey:@"floor_max"];
    }

    if (_standardTF->str.length) {
        
        [dic setObject:_standardTF->str forKey:@"decorate"];
    }
    if (_purposeBtn->str.length) {
        
        [dic setObject:_purposeBtn->str forKey:@"buy_purpose"];
    }
    if (_payWayBtn->str.length) {
        
        [dic setObject:_payWayBtn->str forKey:@"pay_type"];
    }
    if (_intentionTF.textfield.text.length) {
        
        [dic setObject:_intentionTF.textfield.text forKey:@"intent"];
    }
    if (_urgentTF.textfield.text.length) {
        
        [dic setObject:_urgentTF.textfield.text forKey:@"urgency"];
    }
    if (_urgentTF.textfield.text.length) {
        
        [dic setObject:_urgentTF.textfield.text forKey:@"need_tags"];
    }
    if (_markTV.text.length) {
        
        [dic setObject:_markTV.text forKey:@"comment"];
    }
    [dic setObject:_projectId forKey:@"project_id"];
    
    NSString *str;
    for (int i = 0; i < _tagView.dataArr.count; i++) {
        
        if (i == 0) {
            
            str = _tagView.dataArr[i][@"id"];
        }else{
            
            str = [NSString stringWithFormat:@"%@,%@",str,_tagView.dataArr[i][@"id"]];
        }
    }
    if (str.length) {
        
        [dic setObject:str forKey:@"need_tags"];
    }
    [BaseRequest POST:AddAndRecommend_URL parameters:dic success:^(id resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [self alertControllerWithNsstring:@"推荐成功" And:nil WithDefaultBlack:^{
                
                for (UIViewController *vc in self.navigationController.viewControllers) {
                    
                    if ([vc isKindOfClass:[RoomDetailVC1 class]]) {
                        
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"matchReload" object:nil];
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadCustom" object:nil];
                        [self.navigationController popToViewController:vc animated:YES];
                    }
                }
            }];
        }
        else{
            
            [self alertControllerWithNsstring:@"温馨提示" And:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [self showContent:@"网络错误"];
    }];
}

- (void)ActionSliderChange:(UISlider *)slider{
    
    if (slider == _intentionSlider) {
        
        _intentionTF.textfield.text = [NSString stringWithFormat:@"%.0f",slider.value];
    }else{
        
        _urgentTF.textfield.text = [NSString stringWithFormat:@"%.0f",slider.value];
    }
}

- (void)ActionAddBtn:(UIButton *)btn{
    
    if (_num == 0) {
        
        if (_addressBtn.content.text.length) {
            
            _num += 1;
            [_addressBtn2 mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(_infoView).offset(81 *SIZE);
                make.top.equalTo(_addressBtn.mas_bottom).offset(19 *SIZE);
                make.width.equalTo(@(258 *SIZE));
                make.height.equalTo(@(33 *SIZE));
            }];
            _addressBtn2.hidden = NO;
            
            
            [_houseTypeL mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(_infoView).offset(10 *SIZE);
                make.top.equalTo(_addressBtn2.mas_bottom).offset(29 *SIZE);
                make.width.equalTo(@(70 *SIZE));
                make.height.equalTo(@(13 *SIZE));
            }];
            
            [_houseTypeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(_infoView).offset(81 *SIZE);
                make.top.equalTo(_addressBtn2.mas_bottom).offset(19 *SIZE);
                make.width.equalTo(@(258 *SIZE));
                make.height.equalTo(@(33 *SIZE));
            }];
        }else{
            
            [self showContent:@"请选择意向区域"];
        }
    }else{
        
        if (_addressBtn2.content.text.length) {
            
            _num += 1;
            [_addressBtn2 mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(_infoView).offset(81 *SIZE);
                make.top.equalTo(_addressBtn.mas_bottom).offset(19 *SIZE);
                make.width.equalTo(@(258 *SIZE));
                make.height.equalTo(@(33 *SIZE));
            }];
            
            [_addressBtn3 mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(_infoView).offset(81 *SIZE);
                make.top.equalTo(_addressBtn2.mas_bottom).offset(19 *SIZE);
                make.width.equalTo(@(258 *SIZE));
                make.height.equalTo(@(33 *SIZE));
            }];
            _addressBtn2.hidden = NO;
            _addressBtn3.hidden = NO;
            
            [_houseTypeL mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(_infoView).offset(10 *SIZE);
                make.top.equalTo(_addressBtn3.mas_bottom).offset(29 *SIZE);
                make.width.equalTo(@(70 *SIZE));
                make.height.equalTo(@(13 *SIZE));
            }];
            
            [_houseTypeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(_infoView).offset(81 *SIZE);
                make.top.equalTo(_addressBtn3.mas_bottom).offset(19 *SIZE);
                make.width.equalTo(@(258 *SIZE));
                make.height.equalTo(@(33 *SIZE));
            }];
        }
    }
}

- (void)textViewDidChange:(UITextView *)textView{
    
    if (textView.text.length) {
        
        _placeL.hidden = YES;
    }else{
        
        _placeL.hidden = NO;
    }
}

- (void)initUI{
    
    self.titleLabel.text = @"添加需求";
    //    self.titleLabel.text = @"添加客户";
    self.navBackgroundView.hidden = NO;
    self.line.hidden = YES;
    
    _scrolleView = [[UIScrollView alloc] init];
    _scrolleView.backgroundColor = YJBackColor;
    _scrolleView.bounces = NO;
    [self.view addSubview:_scrolleView];
    
    _infoView = [[UIView alloc] init];
    _infoView.backgroundColor = CH_COLOR_white;
    [_scrolleView addSubview:_infoView];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10 *SIZE, 20 *SIZE, 7 *SIZE, 13 *SIZE)];
    view.backgroundColor = YJBlueBtnColor;
    [_infoView addSubview:view];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(32 *SIZE, 18 *SIZE, 80 *SIZE, 15 *SIZE)];
    label.textColor = YJTitleLabColor;
    label.font = [UIFont systemFontOfSize:15 *SIZE];
    label.text = @"需求信息";
    [_infoView addSubview:label];
    
    _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _addBtn.frame = CGRectMake(313 *SIZE, 56 *SIZE, 25 *SIZE, 25 *SIZE);
    [_addBtn addTarget:self action:@selector(ActionAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_addBtn setImage:[UIImage imageNamed:@"add_2"] forState:UIControlStateNormal];
    [_infoView addSubview:_addBtn];
    
    for(int i = 0; i < 13; i++){
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = YJTitleLabColor;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        switch (i) {
            case 0:
            {
                _addressL = label;
                _addressL.text = @"区域:";
                [_infoView addSubview:_addressL];
                break;
            }
            case 1:
            {
                _houseTypeL = label;
                _houseTypeL.text = @"物业类型:";
                [_infoView addSubview:_houseTypeL];
                break;
            }
            case 2:
            {
                _priceL = label;
                _priceL.text = @"总价:";
                [_infoView addSubview:_priceL];
                break;
            }
            case 3:
            {
                _areaL = label;
                _areaL.text = @"面积:";
                [_infoView addSubview:_areaL];
                break;
            }
            case 4:
            {
                _typeL = label;
                _typeL.text = @"户型:";
                [_infoView addSubview:_typeL];
                break;
            }
            case 5:
            {
                _floorL = label;
                _floorL.text = @"楼层:";
                [_infoView addSubview:_floorL];
                break;
            }
            case 6:
            {
                _standardL = label;
                _standardL.text = @"装修标准:";
                [_infoView addSubview:_standardL];
                break;
            }
            case 7:
            {
                _purposeL = label;
                _purposeL.text = @"置业目的:";
                [_infoView addSubview:_purposeL];
                break;
            }
            case 8:
            {
                _payWayL = label;
                _payWayL.text = @"付款方式:";
                [_infoView addSubview:_payWayL];
                break;
            }
            case 9:
            {
                _intentionL = label;
                _intentionL.text = @"购房意向度:";
                [_infoView addSubview:_intentionL];
                break;
            }
            case 10:
            {
                _urgentL = label;
                _urgentL.text = @"购房紧迫度:";
                [_infoView addSubview:_urgentL];
                break;
            }
            default:
                break;
        }
        
        if (i < 12) {
            
            DropDownBtn *btn = [[DropDownBtn alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
            btn.tag = i;
            [btn addTarget:self action:@selector(ActionTagBtn:) forControlEvents:UIControlEventTouchUpInside];
            switch (i) {
                case 0:
                {
                    _addressBtn = btn;
                    [_addressBtn addTarget:self action:@selector(ActionAreaBtn:) forControlEvents:UIControlEventTouchUpInside];
                    _addressBtn.frame = CGRectMake(0, 0, 217 *SIZE, 33 *SIZE);
                    [_infoView addSubview:_addressBtn];
                    break;
                }
                case 1:
                {
                    _addressBtn2 = btn;
                    _addressBtn2.hidden = YES;
                    _addressBtn2.frame = CGRectMake(0, 0, 217 *SIZE, 33 *SIZE);
                    [_addressBtn2 addTarget:self action:@selector(ActionAreaBtn:) forControlEvents:UIControlEventTouchUpInside];
                    [_infoView addSubview:_addressBtn2];
                    break;
                }
                case 2:
                {
                    _addressBtn3 = btn;
                    _addressBtn3.hidden = YES;
                    _addressBtn3.frame = CGRectMake(0, 0, 217 *SIZE, 33 *SIZE);
                    [_addressBtn3 addTarget:self action:@selector(ActionAreaBtn:) forControlEvents:UIControlEventTouchUpInside];
                    [_infoView addSubview:_addressBtn3];
                    break;
                }
                case 3:
                {
                    _houseTypeBtn = btn;
                    [_infoView addSubview:_houseTypeBtn];
                    break;
                }
                case 4:
                {
                    _priceBtn = btn;
                    [_infoView addSubview:_priceBtn];
                    break;
                }
                case 5:
                {
                    _areaBtn = btn;
                    [_infoView addSubview:_areaBtn];
                    break;
                }
                case 6:
                {
                    _typeBtn = btn;
                    [_infoView addSubview:_typeBtn];
                    break;
                }
                case 7:
                {
                    _purposeBtn = btn;
                    [_infoView addSubview:_purposeBtn];
                    break;
                }
                case 8:
                {
                    _payWayBtn = btn;
                    [_infoView addSubview:_payWayBtn];
                    break;
                }
                case 9:
                {
                    _floorTF1 = btn;
                    _floorTF1.frame = CGRectMake(0, 0, 117 *SIZE, 33 *SIZE);
                    [_infoView addSubview:_floorTF1];
                    break;
                }
                case 10:
                {
                    _floorTF2 = btn;
                    _floorTF2.frame = CGRectMake(0, 0, 117 *SIZE, 33 *SIZE);
                    [_infoView addSubview:_floorTF2];
                    break;
                }
                case 11:{
                    
                    _standardTF = btn;
                    [_infoView addSubview:_standardTF];
                }
                default:
                    break;
            }
        }
        
        if (i < 5) {
            
            BorderTF *TF = [[BorderTF alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
            switch (i) {
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
                    _intentionTF = TF;
                    _intentionTF.textfield.textAlignment = NSTextAlignmentRight;
                    _intentionTF.textfield.keyboardType = UIKeyboardTypeNumberPad;
                    [_infoView addSubview:_intentionTF];
                    break;
                }
                case 4:
                {
                    _urgentTF = TF;

                    _urgentTF.textfield.textAlignment = NSTextAlignmentRight;
                    _urgentTF.textfield.keyboardType = UIKeyboardTypeNumberPad;
                    [_infoView addSubview:_urgentTF];
                    break;
                }
                default:
                    break;
            }
        }
        
        if (i < 2) {
            
            UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(0, 0, 300 *SIZE, 5 *SIZE)];
            slider.userInteractionEnabled = YES;
            slider.minimumValue = 0.0;
            slider.maximumValue = 100.0;
            slider.maximumTrackTintColor = YJBackColor;
            slider.minimumTrackTintColor = COLOR(255, 224, 177, 1);
            slider.thumbTintColor = COLOR(255, 224, 177, 1);
            [slider setThumbImage:[UIImage imageNamed:@"point"] forState:UIControlStateNormal];
            [slider setThumbImage:[UIImage imageNamed:@"point"] forState:UIControlStateHighlighted];
            [slider addTarget:self action:@selector(ActionSliderChange:) forControlEvents:UIControlEventValueChanged];
            if (i == 0) {
                
                _intentionSlider = slider;
                [_infoView addSubview:_intentionSlider];
            }else{
                
                _urgentSlider = slider;
                [_infoView addSubview:_urgentSlider];
            }
        }
        
        
    }
    
    
    _tagView = [[AddTagView alloc] initWithFrame:CGRectMake(0, 757 *SIZE, SCREEN_Width, 127 *SIZE)];

    [_tagView reloadInputViews];
    WS(weak);
    _tagView.addBtnBlock = ^{
        
        AddTagVC *nextVC = [[AddTagVC alloc] initWithArray:weak.tagView.dataArr];
        
        nextVC.saveBtnBlock = ^(NSArray *array) {
            
            weak.tagView.dataArr = [NSMutableArray arrayWithArray:array];
            [weak.tagView.tagColl reloadData];
            [weak.tagView reloadInputViews];
        };
        [weak.navigationController pushViewController:nextVC animated:YES];
        
    };
    [_scrolleView addSubview:_tagView];
    
    _markTV = [[UITextView alloc] init];
    _markTV.delegate = self;
    _markTV.contentInset = UIEdgeInsetsMake(10 *SIZE, 12 *SIZE, 12 *SIZE, 12 *SIZE);
    
    [_scrolleView addSubview:_markTV];
    
    _placeL = [[UILabel alloc] initWithFrame:CGRectMake(6 *SIZE, 7 *SIZE, 40 *SIZE, 11 *SIZE)];
    _placeL.textColor = YJContentLabColor;
    _placeL.font = [UIFont systemFontOfSize:12 *SIZE];
    _placeL.text = @"备注...";
    [_markTV addSubview:_placeL];
    
    _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_nextBtn setBackgroundColor:YJBlueBtnColor];
    _nextBtn.layer.cornerRadius = 2 *SIZE;
    _nextBtn.clipsToBounds = YES;
    [_nextBtn addTarget:self action:@selector(ActionNextBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_nextBtn setTitle:@"确定" forState:UIControlStateNormal];
    [_scrolleView addSubview:_nextBtn];
    
    
    [self masonryUI];
    
}



- (void)masonryUI{
    
    [_scrolleView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(NAVIGATION_BAR_HEIGHT);
        make.right.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view).offset(0);
    }];
    
    
    [_infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrolleView).offset(0);
        make.top.equalTo(_scrolleView).offset(0);
        make.right.equalTo(_scrolleView).offset(0);
        make.width.equalTo(@(SCREEN_Width));
        make.bottom.equalTo(_tagView.mas_top).offset(-9 *SIZE);
    }];
    
    [_addressL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_infoView).offset(10 *SIZE);
        make.top.equalTo(_infoView).offset(62 *SIZE);
        make.width.equalTo(@(70 *SIZE));
        make.bottom.equalTo(_addressBtn.mas_bottom).offset(-11 *SIZE);
    }];
    
    [_addressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_infoView).offset(81 *SIZE);
        make.top.equalTo(_infoView).offset(52 *SIZE);
        make.width.equalTo(@(217 *SIZE));
        make.height.equalTo(@(33 *SIZE));
    }];
    
    [_houseTypeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_infoView).offset(10 *SIZE);
        make.top.equalTo(_addressBtn.mas_bottom).offset(33 *SIZE);
        make.width.equalTo(@(70 *SIZE));
        make.bottom.equalTo(_priceL.mas_top).offset(-40 *SIZE);
    }];
    
    [_houseTypeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_infoView).offset(81 *SIZE);
        make.top.equalTo(_addressBtn.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(258 *SIZE));
        make.height.equalTo(@(33 *SIZE));
        make.bottom.equalTo(_priceBtn.mas_top).offset(-19 *SIZE);
    }];
    
    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_infoView).offset(10 *SIZE);
        make.top.equalTo(_houseTypeBtn.mas_bottom).offset(29 *SIZE);
        make.width.equalTo(@(70 *SIZE));
        make.height.equalTo(@(13 *SIZE));
        //        make.bottom.equalTo(_areaL.mas_top).offset(-39 *SIZE);
    }];
    
    [_priceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_infoView).offset(81 *SIZE);
        make.top.equalTo(_houseTypeBtn.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(258 *SIZE));
        make.height.equalTo(@(33 *SIZE));
        make.bottom.equalTo(_areaBtn.mas_top).offset(-19 *SIZE);
    }];
    
    [_areaL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_infoView).offset(10 *SIZE);
        make.top.equalTo(_priceBtn.mas_bottom).offset(29 *SIZE);
        make.width.equalTo(@(70 *SIZE));
        make.height.equalTo(@(13 *SIZE));
        //        make.bottom.equalTo(_typeL.mas_top).offset(-38 *SIZE);
    }];
    
    [_areaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_infoView).offset(81 *SIZE);
        make.top.equalTo(_priceBtn.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(258 *SIZE));
        make.height.equalTo(@(33 *SIZE));
        make.bottom.equalTo(_typeBtn.mas_top).offset(-19 *SIZE);
    }];
    
    [_typeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_infoView).offset(10 *SIZE);
        make.top.equalTo(_areaBtn.mas_bottom).offset(29 *SIZE);
        make.width.equalTo(@(70 *SIZE));
        make.height.equalTo(@(13 *SIZE));
        //        make.bottom.equalTo(_faceL.mas_top).offset(-40 *SIZE);
    }];
    
    [_typeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_infoView).offset(81 *SIZE);
        make.top.equalTo(_areaBtn.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(258 *SIZE));
        make.height.equalTo(@(33 *SIZE));
        make.bottom.equalTo(_floorTF1.mas_top).offset(-19 *SIZE);
    }];

    
    [_floorL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_infoView).offset(10 *SIZE);
        make.top.equalTo(_typeBtn.mas_bottom).offset(29 *SIZE);
        make.width.equalTo(@(70 *SIZE));
        make.height.equalTo(@(13 *SIZE));
        //        make.bottom.equalTo(_standardL.mas_top).offset(-45 *SIZE);
    }];
    
    [_floorTF1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_infoView).offset(81 *SIZE);
        make.top.equalTo(_typeBtn.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(117 *SIZE));
        make.height.equalTo(@(33 *SIZE));
        make.bottom.equalTo(_standardTF.mas_top).offset(-19 *SIZE);
    }];
    
    [_floorTF2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_infoView).offset(222 *SIZE);
        make.top.equalTo(_typeBtn.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(117 *SIZE));
        make.height.equalTo(@(33 *SIZE));
        make.bottom.equalTo(_standardTF.mas_top).offset(-19 *SIZE);
    }];
    
    [_standardL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_infoView).offset(10 *SIZE);
        make.top.equalTo(_floorTF1.mas_bottom).offset(29 *SIZE);
        make.width.equalTo(@(70 *SIZE));
        make.height.equalTo(@(13 *SIZE));
        //        make.bottom.equalTo(_purposeL.mas_top).offset(-40 *SIZE);
    }];
    
    [_standardTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_infoView).offset(81 *SIZE);
        make.top.equalTo(_floorTF1.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(258 *SIZE));
        make.height.equalTo(@(33 *SIZE));
        make.bottom.equalTo(_purposeBtn.mas_top).offset(-19 *SIZE);
    }];
    
    [_purposeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_infoView).offset(10 *SIZE);
        make.top.equalTo(_standardTF.mas_bottom).offset(29 *SIZE);
        make.width.equalTo(@(70 *SIZE));
        make.height.equalTo(@(13 *SIZE));
        //        make.bottom.equalTo(_payWayL.mas_top).offset(-42 *SIZE);
    }];
    
    [_purposeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_infoView).offset(81 *SIZE);
        make.top.equalTo(_standardTF.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(258 *SIZE));
        make.height.equalTo(@(33 *SIZE));
        make.bottom.equalTo(_payWayBtn.mas_top).offset(-19 *SIZE);
    }];
    
    [_payWayL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_infoView).offset(10 *SIZE);
        make.top.equalTo(_purposeBtn.mas_bottom).offset(29 *SIZE);
        make.width.equalTo(@(70 *SIZE));
        make.height.equalTo(@(13 *SIZE));
        //        make.bottom.equalTo(_intentionL.mas_top).offset(-49 *SIZE);
    }];
    
    [_payWayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_infoView).offset(81 *SIZE);
        make.top.equalTo(_purposeBtn.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(258 *SIZE));
        make.height.equalTo(@(33 *SIZE));
        make.bottom.equalTo(_intentionTF.mas_top).offset(-19 *SIZE);
    }];
    
    [_intentionL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_infoView).offset(10 *SIZE);
        make.top.equalTo(_payWayBtn.mas_bottom).offset(29 *SIZE);
        make.width.equalTo(@(70 *SIZE));
        make.height.equalTo(@(13 *SIZE));
        //        make.bottom.equalTo(_urgentL.mas_top).offset(-84 *SIZE);
    }];
    
    [_intentionTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_infoView).offset(81 *SIZE);
        make.top.equalTo(_payWayBtn.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(258 *SIZE));
        make.height.equalTo(@(33 *SIZE));
        make.bottom.equalTo(_urgentTF.mas_top).offset(-62 *SIZE);
    }];
    
    [_urgentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_infoView).offset(10 *SIZE);
        make.top.equalTo(_intentionTF.mas_bottom).offset(73 *SIZE);
        make.width.equalTo(@(70 *SIZE));
        make.height.equalTo(@(13 *SIZE));
        //        make.bottom.equalTo(_infoView.mas_bottom).offset(-79 *SIZE);
    }];
    
    [_urgentTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_infoView).offset(81 *SIZE);
        make.top.equalTo(_intentionTF.mas_bottom).offset(62 *SIZE);
        make.width.equalTo(@(258 *SIZE));
        make.height.equalTo(@(33 *SIZE));
        make.bottom.equalTo(_infoView).offset(-69 *SIZE);
    }];
    
    [_intentionSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_infoView).offset(30 *SIZE);
        make.top.equalTo(_intentionTF.mas_bottom).offset(24 *SIZE);
        make.width.equalTo(@(300 *SIZE));
        make.height.equalTo(@(5 *SIZE));
    }];
    
    [_urgentSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_infoView).offset(30 *SIZE);
        make.top.equalTo(_urgentTF.mas_bottom).offset(24 *SIZE);
        make.width.equalTo(@(300 *SIZE));
        make.height.equalTo(@(5 *SIZE));
    }];
    
    
    [_tagView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrolleView).offset(0);
        make.top.equalTo(_infoView.mas_bottom).offset(9 *SIZE);
        make.right.equalTo(_scrolleView).offset(0);
        make.width.equalTo(@(SCREEN_Width));
        make.height.equalTo(@(127 *SIZE));
        make.bottom.equalTo(_markTV.mas_top).offset(-7 *SIZE);
    }];
    
    [_markTV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrolleView).offset(0);
        make.top.equalTo(_tagView.mas_bottom).offset(7 *SIZE);
        make.right.equalTo(_scrolleView).offset(0);
        make.height.equalTo(@(117 *SIZE));
        make.width.equalTo(@(SCREEN_Width));
        make.bottom.equalTo(_nextBtn.mas_top).offset(-40 *SIZE);
    }];
    
    [_nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrolleView).offset(22 *SIZE);
        make.top.equalTo(_markTV.mas_bottom).offset(40 *SIZE);
        make.right.equalTo(_scrolleView).offset(-22 *SIZE);
        make.height.equalTo(@(40 *SIZE));
        make.bottom.equalTo(_scrolleView.mas_bottom).offset(-48 *SIZE);
    }];
    
}

@end
