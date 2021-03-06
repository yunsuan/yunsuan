//
//  AddStoreRequireMentVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/9/20.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "AddStoreRequireMentVC.h"

#import "CustomerListVC.h"
#import "CustomDetailVC.h"

#import "BaseFrameHeader.h"
#import "CompleteSurveyCollCell.h"

#import "SinglePickView.h"
#import "AddressChooseView3.h"

#import "DropDownBtn.h"
#import "BorderTF.h"

@interface AddStoreRequireMentVC ()<UITextViewDelegate,UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    NSInteger _btnNum;
    
    CustomRequireModel *_model;
    NSArray *_titleArr;
    NSArray *_storeArr;
    NSMutableArray *_selectArr;
}

@property (nonatomic, strong) UIScrollView *scrolleView;

@property (nonatomic, strong) UIView *infoView;

@property (nonatomic, strong) UILabel *addressL;

@property (nonatomic, strong) DropDownBtn *addressBtn;

@property (nonatomic, strong) UILabel *typeL;

@property (nonatomic, strong) DropDownBtn *typeBtn;

@property (nonatomic, strong) UILabel *commercialL;

@property (nonatomic, strong) UICollectionView *comercialColl;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) UILabel *priceL;

@property (nonatomic, strong) DropDownBtn *priceBtn;

@property (nonatomic, strong) UILabel *areaL;

@property (nonatomic, strong) DropDownBtn *areaTF;

@property (nonatomic, strong) UILabel *useL;

@property (nonatomic, strong) DropDownBtn *useBtn;

@property (nonatomic, strong) UILabel *payWayL;

@property (nonatomic, strong) DropDownBtn *payWayBtn;

@property (nonatomic, strong) UILabel *intentionL;

@property (nonatomic, strong) UILabel *urgentL;

@property (nonatomic, strong) BorderTF *intentionTF;

@property (nonatomic, strong) BorderTF *urgentTF;

@property (nonatomic, strong) UISlider *intentionSlider;

@property (nonatomic, strong) UISlider *urgentSlider;

@property (nonatomic, strong) UILabel *markL;

@property (nonatomic, strong) UITextView *markTV;

@property (nonatomic, strong) UIButton *nextBtn;

@end

@implementation AddStoreRequireMentVC

- (instancetype)initWithCustomRequireModel:(CustomRequireModel *)model
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
    
    _titleArr = @[@"区域",@"物业类型",@"商铺类型",@"意向总价",@"意向面积",@"购买用途",@"付款方式",@"购房意向度",@"购房紧迫度",@"其他要求"];
    _storeArr = [self getDetailConfigArrByConfigState:SHOP_TYPE];
    _selectArr = [@[] mutableCopy];
    for (int i = 0; i < _storeArr.count; i++) {
        
        [_selectArr addObject:@(0)];
    }
    
    for (NSString *str in _model.shop_type) {
        
        for (int i = 0; i < _storeArr.count; i++) {
            
            if ([str isEqualToString:_storeArr[i][@"param"]]) {
                
                [_selectArr replaceObjectAtIndex:i withObject:@1];
            }
        }
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (textField == _intentionTF.textfield) {
        
        if ([_intentionTF.textfield.text integerValue] > 100) {
            
            _intentionTF.textfield.text = @"100";
        }
        _intentionTF.textfield.text = [NSString stringWithFormat:@"%ld", (long) [_intentionTF.textfield.text integerValue]];
        _intentionSlider.value = (float) ([_intentionTF.textfield.text floatValue] / 100.0 * 100);
    }else if (textField == _urgentTF.textfield){
        
        if ([_urgentTF.textfield.text integerValue] > 100) {
            
            _urgentTF.textfield.text = @"100";
        }
        _urgentTF.textfield.text = [NSString stringWithFormat:@"%li",[_urgentTF.textfield.text integerValue]];
        _urgentSlider.value = (float) ([_urgentTF.textfield.text floatValue] / 100.0 * 100);
    }
}

- (void)ActionNextBtn:(UIButton *)btn{
    
    if ([self.status isEqualToString:@"addCustom"]) {
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[self.infoModel modeltodic]];
        if (_btnNum == 0) {
            if (self.addressBtn->str.length) {
                
                dic[@"region"] = self.addressBtn->str;
            }else{
                
                [self showContent:@"请选择意向区域"];
                return;
            }
        }
        
        NSString *shop;
        for (int i = 0; i < _selectArr.count; i++) {
            
            if ([_selectArr[i] integerValue] == 1) {
                
                if (!shop.length) {
                    
                    shop = [NSString stringWithFormat:@"%@",_storeArr[i][@"id"]];
                }else{
                    
                    shop = [NSString stringWithFormat:@"%@,%@",shop,_storeArr[i][@"id"]];
                }
            }
        }
        if (!shop.length) {
            
            [self alertControllerWithNsstring:@"温馨提示" And:@"请选择商铺类型"];
            return;
        }else{
            
            dic[@"shop_type"] = shop;
        }

        if (_priceBtn->str.length) {
            
            dic[@"total_price"] = _priceBtn->str;
        }
        if (_areaTF->str.length) {
            
            dic[@"area"] = _areaTF->str;
        }
//        if (_typeBtn.str.length) {
//
//            [dic setObject:_typeBtn.str forKey:@"house_type"];
//        }
        if (_useBtn->str.length) {
            
            dic[@"buy_use"] = _useBtn->str;
        }

        if (_payWayBtn->str.length) {
            
            dic[@"pay_type"] = _payWayBtn->str;
        }
        if (_intentionTF.textfield.text.length) {
            
            dic[@"intent"] = _intentionTF.textfield.text;
        }
        if (_urgentTF.textfield.text.length) {
            
            dic[@"urgency"] = _urgentTF.textfield.text;
        }
        if (_urgentTF.textfield.text.length) {
            
            dic[@"need_tags"] = _urgentTF.textfield.text;
        }
        if (_markTV.text.length) {
            
            dic[@"comment"] = _markTV.text;
        }
        
        _nextBtn.userInteractionEnabled = NO;
        [BaseRequest POST:AddCustomer_URL parameters:dic success:^(id resposeObject) {
            
            //            NSLog(@"%@",resposeObject);
            
            _nextBtn.userInteractionEnabled = YES;
            if ([resposeObject[@"code"] integerValue] == 200) {
                
                //                [self showContent:@"添加成功"];
                for (UIViewController *vc in self.navigationController.viewControllers) {
                    
                    if ([vc isKindOfClass:[CustomerListVC class]]) {
                        
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadCustom" object:nil];
                        [self.navigationController popToViewController:vc animated:YES];
                    }
                }
            }
            else{
                [self showContent:resposeObject[@"msg"]];
            }
        } failure:^(NSError *error) {
            _nextBtn.userInteractionEnabled = YES;
            [self showContent:@"网络错误"];
            //            NSLog(@"%@",error);
        }];
    }else{
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[self.infoModel modeltodic]];
        dic[@"need_id"] = _model.need_id;
        if (_btnNum == 0) {
            if (self.addressBtn->str.length) {
                
                dic[@"region"] = self.addressBtn->str;
            }
        }
        
        NSString *shop;
        for (int i = 0; i < _selectArr.count; i++) {
            
            if ([_selectArr[i] integerValue] == 1) {
                
                if (!shop.length) {
                    
                    shop = [NSString stringWithFormat:@"%@",_storeArr[i][@"id"]];
                }else{
                    
                    shop = [NSString stringWithFormat:@"%@,%@",shop,_storeArr[i][@"id"]];
                }
            }
        }
        if (!shop.length) {
            
            [self alertControllerWithNsstring:@"温馨提示" And:@"请选择商铺类型"];
            return;
        }else{
            
            dic[@"shop_type"] = shop;
        }
        
        if (_priceBtn->str.length) {
            
            dic[@"total_price"] = _priceBtn->str;
        }
        if (_areaTF->str.length) {
            
            dic[@"area"] = _areaTF->str;
        }
        //        if (_typeBtn.str.length) {
        //
        //            [dic setObject:_typeBtn.str forKey:@"house_type"];
        //        }
        if (_useBtn->str.length) {
            
            dic[@"buy_use"] = _useBtn->str;
        }
        
        if (_payWayBtn->str.length) {
            
            dic[@"pay_type"] = _payWayBtn->str;
        }
        if (_intentionTF.textfield.text.length) {
            
            dic[@"intent"] = _intentionTF.textfield.text;
        }
        if (_urgentTF.textfield.text.length) {
            
            dic[@"urgency"] = _urgentTF.textfield.text;
        }
        if (_urgentTF.textfield.text.length) {
            
            dic[@"need_tags"] = _urgentTF.textfield.text;
        }
        if (_markTV.text.length) {
            
            dic[@"comment"] = _markTV.text;
        }
        
        _nextBtn.userInteractionEnabled = NO;
        [BaseRequest POST:UpdateNeed_URL parameters:dic success:^(id resposeObject) {
            
            _nextBtn.userInteractionEnabled = YES;
            if ([resposeObject[@"code"] integerValue] == 200) {
                
                [self showContent:@"修改成功"];
                for (UIViewController *vc in self.navigationController.viewControllers) {
                    
                    if ([vc isKindOfClass:[CustomDetailVC class]]) {
                        
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadCustom" object:nil];
                        [self.navigationController popToViewController:vc animated:YES];
                    }
                }
            }
        } failure:^(NSError *error) {
            _nextBtn.userInteractionEnabled = YES;
            [self showContent:@"网络错误"];
        }];
    }
}

- (void)ActionSliderChange:(UISlider *)slider{
    
    if (slider == _intentionSlider) {
        
        _intentionTF.textfield.text = [NSString stringWithFormat:@"%.0f",slider.value];
    }else{
        
        _urgentTF.textfield.text = [NSString stringWithFormat:@"%.0f",slider.value];
    }
}

- (void)ActionDropBtn:(UIButton *)btn{
    
    switch (btn.tag) {
        case 0:
        {
            AddressChooseView3 *addressChooseView = [[AddressChooseView3 alloc] initWithFrame:self.view.frame withdata:@[]];
            WS(weakself);
            addressChooseView.addressChooseView3ConfirmBlock = ^(NSString *city, NSString *area, NSString *cityid, NSString *areaid) {
                
                NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"region" ofType:@"json"]];
                
                NSError *err;
                NSArray *proArr = [NSJSONSerialization JSONObjectWithData:JSONData
                                                                  options:NSJSONReadingMutableContainers
                                                                    error:&err];
                NSString *pro = [cityid substringToIndex:2];
                pro = [NSString stringWithFormat:@"%@0000",pro];
                NSString *proName;
                if ([pro isEqualToString:@"000000"]) {
                    proName = @"海外";
                }
                else{
                    for (NSDictionary *dic in proArr) {
                        
                        if([dic[@"code"] isEqualToString:pro]){
                            
                            proName = dic[@"name"];
                            break;
                        }
                    }
                }
                
                if (_btnNum == 0) {
                    
                    weakself.addressBtn.content.text = [NSString stringWithFormat:@"%@/%@/%@",proName,city,area];
                    weakself.addressBtn->str = [NSString stringWithFormat:@"%@-%@-%@", pro, cityid, areaid];
                }
//                    _addBtn.hidden = NO;
//                }else if (_btnNum == 2){
//
//                    if ([weakself.addressBtn.str isEqualToString:[NSString stringWithFormat:@"%@-%@-%@",pro,cityid,areaid]]) {
//
//                        [self alertControllerWithNsstring:@"温馨提示" And:@"请不要选择相同区域" WithDefaultBlack:^{
//
//                        }];
//                    }else{
//
//                        weakself.addressBtn2.content.text = [NSString stringWithFormat:@"%@/%@/%@",proName,city,area];
//                        weakself.addressBtn2.str = [NSString stringWithFormat:@"%@-%@-%@",pro,cityid,areaid];
//                        _addBtn.hidden = NO;
//                    }
//                }else{
//
//                    if ([weakself.addressBtn.str isEqualToString:[NSString stringWithFormat:@"%@-%@-%@",pro,cityid,areaid]] || [weakself.addressBtn2.str isEqualToString:[NSString stringWithFormat:@"%@-%@-%@",pro,cityid,areaid]]) {
//
//                        [self alertControllerWithNsstring:@"温馨提示" And:@"请不要选择相同区域" WithDefaultBlack:^{
//
//                        }];
//                    }else{
//
//                        weakself.addressBtn3.content.text = [NSString stringWithFormat:@"%@/%@/%@",proName,city,area];
//                        weakself.addressBtn3.str = [NSString stringWithFormat:@"%@-%@-%@",pro,cityid,areaid];
//                        _addBtn.hidden = NO;
//                    }
//                }
            };
            [self.view addSubview:addressChooseView];
            break;
        }
        case 1:{
         
            break;
        }
        case 2:
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
        case 3:
        {
            SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:[self getDetailConfigArrByConfigState:AREA]];
            WS(weakself);
            view.selectedBlock = ^(NSString *MC, NSString *ID) {
                
                weakself.areaTF.content.text = MC;
                weakself.areaTF->str = [NSString stringWithFormat:@"%@", ID];
            };
            [self.view addSubview:view];
            break;
        }
        case 4:
        {
            SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:[self getDetailConfigArrByConfigState:BUY_USE]];
            WS(weakself);
            view.selectedBlock = ^(NSString *MC, NSString *ID) {
                
                weakself.useBtn.content.text = MC;
                weakself.useBtn->str = [NSString stringWithFormat:@"%@", ID];
            };
            [self.view addSubview:view];
            break;
        }
        case 5:
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
        default:
            break;
    }
}

#pragma mark -- Collection

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _storeArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CompleteSurveyCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CompleteSurveyCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[CompleteSurveyCollCell alloc] initWithFrame:CGRectMake(0, 0, 130 *SIZE, 20 *SIZE)];
    }
    
    [cell setIsSelect:[_selectArr[(NSUInteger) indexPath.item] integerValue]];
    cell.titleL.text = _storeArr[(NSUInteger) indexPath.item][@"param"];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([_selectArr[indexPath.item] integerValue] == 1) {
        
        [_selectArr replaceObjectAtIndex:indexPath.item withObject:@0];
    }else{
        
        [_selectArr replaceObjectAtIndex:indexPath.item withObject:@1];
    }
    [collectionView reloadData];
}

- (void)initUI{
    
    if (_model) {
        
        self.titleLabel.text = @"修改需求";
    }else{
        
        self.titleLabel.text = @"添加需求";
    }
    self.navBackgroundView.hidden = NO;
//    self.line.hidden = YES;
    
    _scrolleView = [[UIScrollView alloc] init];
    _scrolleView.backgroundColor = YJBackColor;
    _scrolleView.bounces = NO;
    [self.view addSubview:_scrolleView];
    
    _infoView = [[UIView alloc] init];
    _infoView.backgroundColor = [UIColor whiteColor];
    [_scrolleView addSubview:_infoView];
    
    BaseFrameHeader *header = [[BaseFrameHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
    header.titleL.text = @"需求信息";
    header.lineView.hidden = YES;
    [_infoView addSubview:header];
    
    for (NSUInteger i = 0; i < 10; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = YJTitleLabColor;
        label.font = [UIFont systemFontOfSize:12 *SIZE];
        label.text = _titleArr[i];
        
        switch (i) {
            case 0:
            {
                _addressL = label;
                [_infoView addSubview:_addressL];
                break;
            }
            case 1:
            {
                _typeL = label;
//                [_infoView addSubview:_typeL];
                break;
            }
            case 2:
            {
                _commercialL = label;
                [_infoView addSubview:_commercialL];
                break;
            }
            case 3:
            {
                _priceL = label;
                [_infoView addSubview:_priceL];
                break;
            }
            case 4:
            {
                _areaL = label;
                [_infoView addSubview:_areaL];
                break;
            }
            case 5:
            {
                _useL = label;
                [_infoView addSubview:_useL];
                break;
            }
            case 6:
            {
                _payWayL = label;
                [_infoView addSubview:_payWayL];
                break;
            }
            case 7:
            {
                _intentionL = label;
                [_infoView addSubview:_intentionL];
                break;
            }
            case 8:
            {
                _urgentL = label;
                [_infoView addSubview:_urgentL];
                break;
            }
            case 9:
            {
                _markL = label;
                [_infoView addSubview:_markL];
                break;
            }
            default:
                break;
        }
    }
    
    for (int i = 0; i < 6; i++) {
        
        DropDownBtn *btn = [[DropDownBtn alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
        btn.tag = i;
        [btn addTarget:self action:@selector(ActionDropBtn:) forControlEvents:UIControlEventTouchUpInside];
        switch (i) {
            case 0:
            {
                _addressBtn = btn;
                [_infoView addSubview:_addressBtn];
                break;
            }
            case 1:
            {
                _typeBtn = btn;
//                [_infoView addSubview:_typeBtn];
                break;
            }
            case 2:
            {
                _priceBtn = btn;
                [_infoView addSubview:_priceBtn];
                break;
            }
            case 3:
            {
                _areaTF = btn;
                [_infoView addSubview:_areaTF];
                break;
            }
            case 4:
            {
                _useBtn = btn;
                [_infoView addSubview:_useBtn];
                break;
            }
            case 5:
            {
                _payWayBtn = btn;
                [_infoView addSubview:_payWayBtn];
                break;
            }
            default:
                break;
        }
    }
    
    for (int i = 0; i < 2; i++) {
        
        BorderTF *textfield = [[BorderTF alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
        textfield.textfield.delegate = self;
        if (i == 0) {
            
            _intentionTF = textfield;
            if (_model.intent) {
                
                _intentionTF.textfield.text = [NSString stringWithFormat:@"%@",_model.intent];
            }
            _intentionTF.textfield.textAlignment = NSTextAlignmentRight;
            _intentionTF.textfield.keyboardType = UIKeyboardTypeNumberPad;
            [_infoView addSubview:_intentionTF];
        }else{
            
            _urgentTF = textfield;
            if (_model.urgency) {
                
                _urgentTF.textfield.text = [NSString stringWithFormat:@"%@",_model.urgency];
            }
            _urgentTF.textfield.textAlignment = NSTextAlignmentRight;
            _urgentTF.textfield.keyboardType = UIKeyboardTypeNumberPad;
            [_infoView addSubview:_urgentTF];
        }
    }
    
    for (int i = 0; i < 2; i++) {
        
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
                if (_model.intent) {
                    
                    _intentionSlider.value = [_model.intent integerValue];
                }
                [_infoView addSubview:_intentionSlider];
            }else{
                
                _urgentSlider = slider;
                if (_model.urgency) {
                    
                    _urgentSlider.value = [_model.urgency integerValue];
                }
                [_infoView addSubview:_urgentSlider];
            }
        }
    }
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.estimatedItemSize = CGSizeMake(120 *SIZE, 20 *SIZE);
    _flowLayout.minimumLineSpacing = 20 *SIZE;
    _flowLayout.minimumInteritemSpacing = 0;
    
    _comercialColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 100 *SIZE) collectionViewLayout:_flowLayout];
    _comercialColl.backgroundColor = [UIColor whiteColor];
    _comercialColl.allowsMultipleSelection = YES;
    _comercialColl.delegate = self;
    _comercialColl.dataSource = self;
    [_comercialColl registerClass:[CompleteSurveyCollCell class] forCellWithReuseIdentifier:@"CompleteSurveyCollCell"];
    [_infoView addSubview:_comercialColl];
    
    _markTV = [[UITextView alloc] init];
    _markTV.layer.borderWidth = SIZE;
    _markTV.layer.borderColor = COLOR(219, 219, 219, 1).CGColor;
    _markTV.layer.cornerRadius = 5 *SIZE;
    _markTV.clipsToBounds = YES;
    if (_model.comment) {
        
        _markTV.text = _model.comment;
    }
    [_infoView addSubview:_markTV];
    
    _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_nextBtn setBackgroundColor:YJBlueBtnColor];
    _nextBtn.layer.cornerRadius = 2 *SIZE;
    _nextBtn.clipsToBounds = YES;
    [_nextBtn addTarget:self action:@selector(ActionNextBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_nextBtn setTitle:@"确定" forState:UIControlStateNormal];
    [_scrolleView addSubview:_nextBtn];
    
    [self MasonryUI];
    

    NSArray *arrr = _model.region;
    if (arrr.count) {
            
        _addressBtn.content.text = [NSString stringWithFormat:@"%@-%@-%@",arrr[0][@"province_name"],arrr[0][@"city_name"],arrr[0][@"district_name"]];
        _addressBtn->str = [NSString stringWithFormat:@"%@-%@-%@", arrr[0][@"province"], arrr[0][@"city"], arrr[0][@"district"]];
    }

    
    if (_model.total_price.length) {
        
        NSDictionary *configdic = [UserModelArchiver unarchive].Configdic;
        NSDictionary *dic =  [configdic valueForKey:[NSString stringWithFormat:@"%d",25]];
        NSArray *typeArr = dic[@"param"];
        for (NSUInteger i = 0; i < typeArr.count; i++) {
            
            if ([typeArr[i][@"param"] isEqualToString:_model.total_price]) {
                
                _priceBtn.content.text = [NSString stringWithFormat:@"%@",typeArr[i][@"param"]];
                _priceBtn->str = [NSString stringWithFormat:@"%@", typeArr[i][@"id"]];
                break;
            }
        }
    }
    
    if ([_model.area integerValue]) {
        
        NSDictionary *configdic = [UserModelArchiver unarchive].Configdic;
        NSDictionary *dic =  [configdic valueForKey:[NSString stringWithFormat:@"%d",26]];
        NSArray *typeArr = dic[@"param"];
        for (NSUInteger i = 0; i < typeArr.count; i++) {
            
            if ([typeArr[i][@"id"] integerValue] == [_model.area integerValue]) {
                
                _areaTF.content.text = [NSString stringWithFormat:@"%@",typeArr[i][@"param"]];
                _areaTF->str = [NSString stringWithFormat:@"%@", typeArr[i][@"id"]];
                break;
            }
        }
    }
    
    if (_model.buy_use.length) {
        
        NSDictionary *configdic = [UserModelArchiver unarchive].Configdic;
        NSDictionary *dic =  [configdic valueForKey:[NSString stringWithFormat:@"%lu",(unsigned long)BUY_USE]];
        NSArray *typeArr = dic[@"param"];
        for (NSUInteger i = 0; i < typeArr.count; i++) {
            
            if ([typeArr[i][@"param"] isEqualToString:_model.buy_use]) {
                
                _useBtn.content.text = [NSString stringWithFormat:@"%@",typeArr[i][@"param"]];
                _useBtn->str = [NSString stringWithFormat:@"%@", typeArr[i][@"id"]];
                break;
            }
        }
    }
    
    if (_model.pay_type.length) {
        
        NSDictionary *configdic = [UserModelArchiver unarchive].Configdic;
        NSDictionary *dic =  [configdic valueForKey:[NSString stringWithFormat:@"%d",13]];
        NSArray *typeArr = dic[@"param"];
        for (NSUInteger i = 0; i < typeArr.count; i++) {
            
            if ([typeArr[i][@"param"] isEqualToString:_model.pay_type]) {
                
                _payWayBtn.content.text = [NSString stringWithFormat:@"%@",typeArr[i][@"param"]];
                _payWayBtn->str = [NSString stringWithFormat:@"%@", typeArr[i][@"id"]];
                break;
            }
        }
        
    }
}

- (void)MasonryUI{
    
    [_scrolleView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(NAVIGATION_BAR_HEIGHT);
        make.width.mas_equalTo(SCREEN_Width);
        make.bottom.equalTo(self.view).offset(0);
    }];
    
    [_infoView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_scrolleView).offset(0);
        make.top.equalTo(_scrolleView).offset(0);
        make.width.mas_equalTo(SCREEN_Width);
        make.bottom.equalTo(_scrolleView.mas_bottom).offset(-113 *SIZE);
    }];
    
    [_addressL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_infoView).offset(10 *SIZE);
        make.top.equalTo(_infoView).offset(58 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
 
    [_addressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_infoView).offset(80 *SIZE);
        make.top.equalTo(_infoView).offset(47 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_commercialL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_infoView).offset(10 *SIZE);
        make.top.equalTo(_addressBtn.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_comercialColl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_infoView).offset(80 *SIZE);
        make.top.equalTo(_addressBtn.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(290 *SIZE);
        make.height.mas_equalTo(_comercialColl.collectionViewLayout.collectionViewContentSize.height + 10 *SIZE);
    }];
    
    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_infoView).offset(10 *SIZE);
        make.top.equalTo(_comercialColl.mas_bottom).offset(41 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_priceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_infoView).offset(80 *SIZE);
        make.top.equalTo(_comercialColl.mas_bottom).offset(29 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_areaL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_infoView).offset(10 *SIZE);
        make.top.equalTo(_priceBtn.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_areaTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_infoView).offset(80 *SIZE);
        make.top.equalTo(_priceBtn.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_useL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_infoView).offset(10 *SIZE);
        make.top.equalTo(_areaTF.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_useBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_infoView).offset(80 *SIZE);
        make.top.equalTo(_areaTF.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_payWayL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_infoView).offset(10 *SIZE);
        make.top.equalTo(_useBtn.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_payWayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_infoView).offset(80 *SIZE);
        make.top.equalTo(_useBtn.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_intentionL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_infoView).offset(10 *SIZE);
        make.top.equalTo(_payWayBtn.mas_bottom).offset(29 *SIZE);
        make.width.equalTo(@(70 *SIZE));
        make.height.equalTo(@(13 *SIZE));
    }];
    
    [_intentionTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_infoView).offset(81 *SIZE);
        make.top.equalTo(_payWayBtn.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(258 *SIZE));
        make.height.equalTo(@(33 *SIZE));
        make.bottom.equalTo(_urgentTF.mas_top).offset(-62 *SIZE);
    }];
    
    [_intentionSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_infoView).offset(30 *SIZE);
        make.top.equalTo(_intentionTF.mas_bottom).offset(24 *SIZE);
        make.width.equalTo(@(300 *SIZE));
        make.height.equalTo(@(5 *SIZE));
    }];
    
    [_urgentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_infoView).offset(10 *SIZE);
        make.top.equalTo(_intentionTF.mas_bottom).offset(73 *SIZE);
        make.width.equalTo(@(70 *SIZE));
        make.height.equalTo(@(13 *SIZE));
    }];
    
    [_urgentTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_infoView).offset(81 *SIZE);
        make.top.equalTo(_intentionTF.mas_bottom).offset(62 *SIZE);
        make.width.equalTo(@(258 *SIZE));
        make.height.equalTo(@(33 *SIZE));
    }];
    
    [_urgentSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_infoView).offset(30 *SIZE);
        make.top.equalTo(_urgentTF.mas_bottom).offset(24 *SIZE);
        make.width.equalTo(@(300 *SIZE));
        make.height.equalTo(@(5 *SIZE));
    }];
    
    [_markL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_infoView).offset(10 *SIZE);
        make.top.equalTo(_urgentSlider.mas_bottom).offset(51 *SIZE);
        make.width.equalTo(@(70 *SIZE));
        make.height.equalTo(@(13 *SIZE));
    }];
    
    [_markTV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_infoView).offset(80 *SIZE);
        make.top.equalTo(_urgentSlider.mas_bottom).offset(52 *SIZE);
        make.height.equalTo(@(77  *SIZE));
        make.width.equalTo(@(258 *SIZE));
        make.bottom.equalTo(_infoView.mas_bottom).offset(-22 *SIZE);
    }];
    
    [_nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrolleView).offset(22 *SIZE);
        make.top.equalTo(_infoView.mas_bottom).offset(20 *SIZE);
//        make.right.equalTo(_scrolleView).offset(-22 *SIZE);
        make.height.equalTo(@(40 *SIZE));
        make.width.mas_offset(316 *SIZE);
        make.bottom.equalTo(_scrolleView.mas_bottom).offset(-48 *SIZE);
    }];
}

@end
