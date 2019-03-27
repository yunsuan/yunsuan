//
//  AddOfficeRequireMentVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/9/20.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "AddOfficeRequireMentVC.h"

#import "CustomerListVC.h"
#import "CustomDetailVC.h"
#import "AddEquipmentVC.h"

#import "BaseFrameHeader.h"
#import "SinglePickView.h"
#import "AddressChooseView3.h"
#import "BlueTitleMoreHeader.h"
#import "StoreViewCollCell.h"
//#import "AddTagView2.h"

#import "DropDownBtn.h"
#import "BorderTF.h"
#import "TTRangeSlider.h"

@interface AddOfficeRequireMentVC ()<UITextViewDelegate,UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    NSInteger _btnNum;
    
    CustomRequireModel *_model;
    NSArray *_titleArr;
    NSMutableArray *_dataArr;
}

@property (nonatomic, strong) UIScrollView *scrolleView;

@property (nonatomic, strong) UIView *infoView;

@property (nonatomic, strong) UILabel *addressL;

@property (nonatomic, strong) DropDownBtn *addressBtn;

//@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) UILabel *priceL;

//@property (nonatomic, strong) DropDownBtn *priceBtn;
@property (strong, nonatomic) TTRangeSlider *priceBtn;

@property (nonatomic, strong) UILabel *areaL;

//@property (nonatomic, strong) DropDownBtn *areaTF;
@property (strong, nonatomic) TTRangeSlider *areaBtn;

@property (nonatomic, strong) UILabel *useL;

@property (nonatomic, strong) DropDownBtn *useBtn;

//@property (nonatomic, strong) UILabel *roomLevelL;
//
//@property (nonatomic, strong) DropDownBtn *roomLevelBtn;

@property (nonatomic, strong) UILabel *payWayL;

@property (nonatomic, strong) DropDownBtn *payWayBtn;

@property (nonatomic, strong) UILabel *yearL;

@property (nonatomic, strong) BorderTF *yearTF;

@property (nonatomic, strong) UILabel *levelL;

@property (nonatomic, strong) DropDownBtn *levelBtn;

@property (nonatomic, strong) UILabel *intentionL;

@property (nonatomic, strong) UILabel *urgentL;

@property (nonatomic, strong) BorderTF *intentionTF;

@property (nonatomic, strong) BorderTF *urgentTF;

@property (nonatomic, strong) UISlider *intentionSlider;

@property (nonatomic, strong) UISlider *urgentSlider;

@property (nonatomic, strong) UIView *CollView;

@property (nonatomic, strong) BlueTitleMoreHeader *collHeader;

@property (nonatomic, strong) UICollectionViewFlowLayout *facilityLayout;

@property (nonatomic, strong) UICollectionView *facilityColl;

@property (nonatomic, strong) UITextView *markTV;

@property (nonatomic, strong) UILabel *placeL;

@property (nonatomic, strong) UIButton *nextBtn;

@end

@implementation AddOfficeRequireMentVC

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
    
    _titleArr = @[@"区域：",@"意向总价：",@"意向面积：",@"购买用途：",@"付款方式：",@"已使用年限：",@"等级：",@"购房意向度：",@"购房紧迫度：",@"其他要求："];
    _dataArr = [@[] mutableCopy];
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

- (void)ActionLevelBtn:(UIButton *)btn{
    

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
                if ([pro isEqualToString:@"900000"]) {
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
            };
            [self.view addSubview:addressChooseView];
            break;
        }
        case 1:
        {
//            SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:[self getDetailConfigArrByConfigState:TOTAL_PRICE]];
//            WS(weakself);
//            view.selectedBlock = ^(NSString *MC, NSString *ID) {
//
//                weakself.priceBtn.content.text = [NSString stringWithFormat:@"%@万",MC];
//                weakself.priceBtn->str = [NSString stringWithFormat:@"%@", ID];
//            };
//            [self.view addSubview:view];
            break;
        }
        case 2:
        {
//            SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:[self getDetailConfigArrByConfigState:AREA]];
//            WS(weakself);
//            view.selectedBlock = ^(NSString *MC, NSString *ID) {
//
//                weakself.areaTF.content.text = [NSString stringWithFormat:@"%@㎡",MC];;
//                weakself.areaTF->str = [NSString stringWithFormat:@"%@", ID];
//            };
//            [self.view addSubview:view];
            break;
        }
        case 3:
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
        case 4:
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
        case 5:
        {

            break;
        }
        case 6:
        {
            SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:[self getDetailConfigArrByConfigState:OFFICE_GRADE]];
            WS(weakself);
            view.selectedBlock = ^(NSString *MC, NSString *ID) {
                
                weakself.levelBtn.content.text = MC;
                weakself.levelBtn->str = [NSString stringWithFormat:@"%@", ID];
            };
            [self.view addSubview:view];
            break;
        }
        default:
            break;
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

        
//        if (_priceBtn->str.length) {
//
//            dic[@"total_price"] = _priceBtn->str;
//        }
        dic[@"total_price"] = [NSString stringWithFormat:@"%.0f-%.0f",_priceBtn.selectedMinimum,_priceBtn.selectedMaximum];
//        if (_areaTF->str.length) {
//
//            dic[@"area"] = _areaTF->str;
//        }
        
        dic[@"area"] = [NSString stringWithFormat:@"%.0f-%.0f",_areaBtn.selectedMinimum,_areaBtn.selectedMaximum];

        if (_useBtn->str.length) {
            
            dic[@"buy_use"] = _useBtn->str;
        }
        if (_yearTF.textfield.text) {
            
            dic[@"used_years"] = _yearTF.textfield.text;
        }
        
        if (_payWayBtn->str.length) {
            
            dic[@"pay_type"] = _payWayBtn->str;
        }
        if (_levelBtn->str.length) {
            
            dic[@"office_level"] = _levelBtn->str;
        }
        if (_intentionTF.textfield.text.length) {
            
            dic[@"intent"] = _intentionTF.textfield.text;
        }
        if (_urgentTF.textfield.text.length) {
            
            dic[@"urgency"] = _urgentTF.textfield.text;
        }
        if (_markTV.text.length) {
            
            dic[@"comment"] = _markTV.text;
        }
        
        if (_dataArr.count) {
            
            NSString *str;
            for (int i = 0; i < _dataArr.count; i++) {
                
                if (i == 0) {
                    
                    str = [NSString stringWithFormat:@"%@",_dataArr[0][@"ui_id"]];
                }else{
                    
                    str = [NSString stringWithFormat:@"%@,%@",str,_dataArr[i][@"ui_id"]];
                }
            }
            if(str)
                [dic setObject:str forKey:@"match_tags"];
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
//        if (_priceBtn->str.length) {
//
//            dic[@"total_price"] = _priceBtn->str;
//        }
        dic[@"total_price"] = [NSString stringWithFormat:@"%.0f-%.0f",_priceBtn.selectedMinimum,_priceBtn.selectedMaximum];
//        if (_areaTF->str.length) {
//
//            dic[@"area"] = _areaTF->str;
//        }
        
        dic[@"area"] = [NSString stringWithFormat:@"%.0f-%.0f",_areaBtn.selectedMinimum,_areaBtn.selectedMaximum];

        if (_useBtn->str.length) {
            
            dic[@"buy_use"] = _useBtn->str;
        }
        if (_yearTF.textfield.text) {
            
            dic[@"used_years"] = _yearTF.textfield.text;
        }
        
        if (_payWayBtn->str.length) {
            
            dic[@"pay_type"] = _payWayBtn->str;
        }
        if (_levelBtn->str.length) {
            
            dic[@"office_level"] = _levelBtn->str;
        }
        if (_intentionTF.textfield.text.length) {
            
            dic[@"intent"] = _intentionTF.textfield.text;
        }
        if (_urgentTF.textfield.text.length) {
            
            dic[@"urgency"] = _urgentTF.textfield.text;
        }
        if (_markTV.text.length) {
            
            dic[@"comment"] = _markTV.text;
        }
        
        if (_dataArr.count) {
            
            NSString *str;
            for (int i = 0; i < _dataArr.count; i++) {
                
                if (i == 0) {
                    
                    str = [NSString stringWithFormat:@"%@",_dataArr[0][@"ui_id"]];
                }else{
                    
                    str = [NSString stringWithFormat:@"%@,%@",str,_dataArr[i][@"ui_id"]];
                }
            }
            if(str)
                [dic setObject:str forKey:@"match_tags"];
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
            }else{
                
                [self showContent:resposeObject[@"msg"]];
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

#pragma mark -- Collection

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    StoreViewCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"StoreViewCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[StoreViewCollCell alloc] initWithFrame:CGRectMake(0, 0, 72 *SIZE, 72 *SIZE)];
    }
    NSString *imageurl = _dataArr[indexPath.item][@"url"];
    if (imageurl.length>0) {
        
        [cell.typeImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,_dataArr[indexPath.item][@"url"]]] placeholderImage:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            
        }];
        cell.titleL.text = _dataArr[indexPath.item][@"name"];
        
    }
    else
    {
#warning 默认图片？？
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

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
        label.adjustsFontSizeToFitWidth = YES;
        switch (i) {
            case 0:
            {
                _addressL = label;
                [_infoView addSubview:_addressL];
                break;
            }
            case 1:
            {
                _priceL = label;
                [_infoView addSubview:_priceL];
                break;
            }
            case 2:
            {
                _areaL = label;
                [_infoView addSubview:_areaL];
                break;
            }
            case 3:
            {
                _useL = label;
                [_infoView addSubview:_useL];
                break;
            }
            case 4:
            {
                _payWayL = label;
                [_infoView addSubview:_payWayL];
                break;
            }
            case 5:
            {
                _yearL = label;
                [_infoView addSubview:_yearL];
                break;
            }
            case 6:
            {
                _levelL = label;
                [_infoView addSubview:_levelL];
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
//                _markL = label;
//                [_infoView addSubview:_markL];
                break;
            }
            default:
                break;
        }
    }

    
    for (int i = 0; i < 7; i++) {
        
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
//                _priceBtn = btn;
                _priceBtn = [[TTRangeSlider alloc] initWithFrame:btn.frame];
                _priceBtn.minValue = 0;
                _priceBtn.maxValue = 1000;
                NSNumberFormatter *customFormatter = [[NSNumberFormatter alloc] init];
                customFormatter.positiveSuffix = @"万";
                _priceBtn.numberFormatterOverride = customFormatter;
                [_infoView addSubview:_priceBtn];
                break;
            }
            case 2:
            {
//                _areaTF = btn;
                _areaBtn = [[TTRangeSlider alloc] initWithFrame:btn.frame];
                _areaBtn.minValue = 0;
                _areaBtn.maxValue = 500;
                NSNumberFormatter *customFormatter = [[NSNumberFormatter alloc] init];
                customFormatter.positiveSuffix = @"㎡";
                _areaBtn.numberFormatterOverride = customFormatter;
                [_infoView addSubview:_areaBtn];
                break;
            }
            case 3:
            {
                _useBtn = btn;
                [_infoView addSubview:_useBtn];
                break;
            }
            case 4:
            {
                _payWayBtn = btn;
                [_infoView addSubview:_payWayBtn];
                break;
            }
            case 5:
            {
                _yearTF = [[BorderTF alloc] initWithFrame:btn.frame];
                _yearTF.unitL.text = @"年";
                _yearTF.textfield.keyboardType = UIKeyboardTypeNumberPad;
                [_infoView addSubview:_yearTF];
//                _yearBtn = btn;
//                [_infoView addSubview:_yearBtn];
                break;
            }
            case 6:
            {
                _levelBtn = btn;
                [_infoView addSubview:_levelBtn];
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
    
    NSArray *arr =  _model.match_tags;
    
    _dataArr = [NSMutableArray arrayWithArray:[arr mutableCopy]];
    
    _CollView = [[UIView alloc] init];
    _CollView.backgroundColor = [UIColor whiteColor];
    [_scrolleView addSubview:_CollView];
    
    _collHeader = [[BlueTitleMoreHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
    _collHeader.titleL.text = @"配套设施";
    [_collHeader.moreBtn setTitle:@"" forState:UIControlStateNormal];
    [_collHeader.moreBtn setImage:[UIImage imageNamed:@"add_40"] forState:UIControlStateNormal];
    WS(weakSelf);
    SS(strongSelf);
    _collHeader.blueTitleMoreHeaderBlock = ^{
        
        AddEquipmentVC *nextVC = [[AddEquipmentVC alloc] initWithType:3];
        nextVC.data = strongSelf->_dataArr;
        nextVC.addEquipmentVCBlock = ^(NSArray * _Nonnull data) {
            
            strongSelf->_dataArr = [NSMutableArray arrayWithArray:data];
            [strongSelf->_facilityColl reloadData];
            [strongSelf->_facilityColl mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(strongSelf->_CollView).offset(0 *SIZE);
                make.top.equalTo(strongSelf->_CollView).offset(40 *SIZE);
                make.width.mas_equalTo(SCREEN_Width);
                make.height.mas_equalTo(strongSelf->_facilityColl.collectionViewLayout.collectionViewContentSize.height);
                make.bottom.equalTo(strongSelf->_CollView.mas_bottom).offset(0 *SIZE);
            }];
            
        };
        [weakSelf.navigationController pushViewController:nextVC animated:YES];
    };
    [_CollView addSubview:_collHeader];
    
    _facilityLayout = [[UICollectionViewFlowLayout alloc] init];
    _facilityLayout.estimatedItemSize = CGSizeMake(72 *SIZE, 72 *SIZE);
    _facilityLayout.minimumLineSpacing = 20 *SIZE;
    _facilityLayout.minimumInteritemSpacing = 0;
    
    _facilityColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 40 *SIZE, SCREEN_Width, 87 *SIZE) collectionViewLayout:_facilityLayout];
    _facilityColl.backgroundColor = [UIColor whiteColor];
    _facilityColl.delegate = self;
    _facilityColl.dataSource = self;
    [_facilityColl registerClass:[StoreViewCollCell class] forCellWithReuseIdentifier:@"StoreViewCollCell"];
    [_CollView addSubview:_facilityColl];

    
    _markTV = [[UITextView alloc] init];
    _markTV.delegate = self;
    _markTV.contentInset = UIEdgeInsetsMake(10 *SIZE, 12 *SIZE, 12 *SIZE, 12 *SIZE);
    
    [_scrolleView addSubview:_markTV];
    
    _placeL = [[UILabel alloc] initWithFrame:CGRectMake(6 *SIZE, 7 *SIZE, 40 *SIZE, 11 *SIZE)];
    _placeL.textColor = YJContentLabColor;
    _placeL.font = [UIFont systemFontOfSize:12 *SIZE];
    _placeL.text = @"备注...";
    [_markTV addSubview:_placeL];
    
    if (_model.comment) {
        
        _markTV.text = _model.comment;
        _placeL.hidden = YES;
    }
    
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
        
        NSArray *arr = [_model.total_price componentsSeparatedByString:@"-"];
        if (arr.count == 2) {
            
            _priceBtn.selectedMinimum = [arr[0] floatValue];
            _priceBtn.selectedMaximum = [arr[1] floatValue];
        }else if (arr.count == 1){
            
            _priceBtn.selectedMinimum = [arr[0] floatValue];
            _priceBtn.selectedMaximum = 1000.00;
        }else{
            
            _priceBtn.selectedMaximum = 1000.00;
            _priceBtn.selectedMinimum = 0.00;
        }
//        NSDictionary *configdic = [UserModelArchiver unarchive].Configdic;
//        NSDictionary *dic =  [configdic valueForKey:[NSString stringWithFormat:@"%d",25]];
//        NSArray *typeArr = dic[@"param"];
//        for (NSUInteger i = 0; i < typeArr.count; i++) {
//
//            if ([typeArr[i][@"param"] isEqualToString:_model.total_price]) {
//
//                _priceBtn.content.text = [NSString stringWithFormat:@"%@万",typeArr[i][@"param"]];
//                _priceBtn->str = [NSString stringWithFormat:@"%@", typeArr[i][@"id"]];
//                break;
//            }
//        }
    }

    
    if ([_model.area length]) {
        
        NSArray *arr = [_model.area componentsSeparatedByString:@"-"];
        if (arr.count == 2) {
            
            _areaBtn.selectedMinimum = [arr[0] floatValue];
            _areaBtn.selectedMaximum = [arr[1] floatValue];
        }else if (arr.count == 1){
            
            _areaBtn.selectedMinimum = [arr[0] floatValue];
            _areaBtn.selectedMaximum = 500.00;
        }else{
            
            _areaBtn.selectedMaximum = 500.00;
            _areaBtn.selectedMinimum = 0.00;
        }
//        NSDictionary *configdic = [UserModelArchiver unarchive].Configdic;
//        NSDictionary *dic =  [configdic valueForKey:[NSString stringWithFormat:@"%d",26]];
//        NSArray *typeArr = dic[@"param"];
//        for (NSUInteger i = 0; i < typeArr.count; i++) {
//
//            if ([typeArr[i][@"param"] isEqualToString:_model.area]) {
//
//                _areaTF.content.text = [NSString stringWithFormat:@"%@㎡",typeArr[i][@"param"]];
//                _areaTF->str = [NSString stringWithFormat:@"%@", typeArr[i][@"id"]];
//                break;
//            }
//        }
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
    
    if (_model.pay_type.count) {
        
        NSDictionary *configdic = [UserModelArchiver unarchive].Configdic;
        NSDictionary *dic =  [configdic valueForKey:[NSString stringWithFormat:@"%d",13]];
        NSArray *typeArr = dic[@"param"];
        for (NSUInteger i = 0; i < typeArr.count; i++) {
            
            if ([typeArr[i][@"param"] isEqualToString:_model.pay_type[0]]) {
                
                _payWayBtn.content.text = [NSString stringWithFormat:@"%@",typeArr[i][@"param"]];
                _payWayBtn->str = [NSString stringWithFormat:@"%@", typeArr[i][@"id"]];
                break;
            }
        }
        
    }
    
    if ([_model.used_years integerValue]) {
        
        _yearTF.textfield.text = [NSString stringWithFormat:@"%@",_model.used_years];
    }
    
    if (_model.office_level.length) {
        
        NSDictionary *configdic = [UserModelArchiver unarchive].Configdic;
        NSDictionary *dic =  [configdic valueForKey:[NSString stringWithFormat:@"%lu",(unsigned long)OFFICE_GRADE]];
        NSArray *typeArr = dic[@"param"];
        for (NSUInteger i = 0; i < typeArr.count; i++) {
            
            if ([typeArr[i][@"param"] isEqualToString:_model.office_level]) {
                
                _levelBtn.content.text = [NSString stringWithFormat:@"%@",typeArr[i][@"param"]];
                _levelBtn->str = [NSString stringWithFormat:@"%@", typeArr[i][@"id"]];
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
//        make.bottom.equalTo(_scrolleView.mas_bottom).offset(-113 *SIZE);
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
    
    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_infoView).offset(10 *SIZE);
        make.top.equalTo(_addressBtn.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_priceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_infoView).offset(80 *SIZE);
        make.top.equalTo(_addressBtn.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_areaL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_infoView).offset(10 *SIZE);
        make.top.equalTo(_priceBtn.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_areaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_infoView).offset(80 *SIZE);
        make.top.equalTo(_priceBtn.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_useL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_infoView).offset(10 *SIZE);
        make.top.equalTo(_areaBtn.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_useBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_infoView).offset(80 *SIZE);
        make.top.equalTo(_areaBtn.mas_bottom).offset(20 *SIZE);
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
    
    [_yearL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_infoView).offset(10 *SIZE);
        make.top.equalTo(_payWayBtn.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_yearTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_infoView).offset(80 *SIZE);
        make.top.equalTo(_payWayBtn.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_levelL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_infoView).offset(10 *SIZE);
        make.top.equalTo(_yearTF.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_levelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_infoView).offset(80 *SIZE);
        make.top.equalTo(_yearTF.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_intentionL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_infoView).offset(10 *SIZE);
        make.top.equalTo(_levelBtn.mas_bottom).offset(29 *SIZE);
        make.width.equalTo(@(70 *SIZE));
        make.height.equalTo(@(13 *SIZE));
    }];
    
    [_intentionTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_infoView).offset(81 *SIZE);
        make.top.equalTo(_levelBtn.mas_bottom).offset(19 *SIZE);
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
        make.bottom.equalTo(_infoView).offset(-69 *SIZE);
    }];
    
    [_urgentSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_infoView).offset(30 *SIZE);
        make.top.equalTo(_urgentTF.mas_bottom).offset(24 *SIZE);
        make.width.equalTo(@(300 *SIZE));
        make.height.equalTo(@(5 *SIZE));
    }];
    
    [_CollView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrolleView).offset(0);
        make.top.equalTo(_infoView.mas_bottom).offset(9 *SIZE);
        make.right.equalTo(_scrolleView).offset(0);
        make.width.equalTo(@(SCREEN_Width));
        make.height.equalTo(@(127 *SIZE));
    }];
    
    [_facilityColl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_CollView).offset(0 *SIZE);
        make.top.equalTo(self->_CollView).offset(40 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(self->_facilityColl.collectionViewLayout.collectionViewContentSize.height);
        make.bottom.equalTo(self->_CollView.mas_bottom).offset(0 *SIZE);
    }];
    
    [_markTV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrolleView).offset(0);
        make.top.equalTo(_CollView.mas_bottom).offset(7 *SIZE);
        make.right.equalTo(_scrolleView).offset(0);
        make.height.equalTo(@(117 *SIZE));
        make.width.equalTo(@(SCREEN_Width));
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
