//
//  RentingCompleteSurveyStoreVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/12/18.
//  Copyright © 2018 xiaoq. All rights reserved.
//

#import "RentingCompleteSurveyStoreVC.h"

#import "RentingCompleteSurveyInfoVC2.h"
#import "RentingAddEquipmentVC.h"

#import "SinglePickView.h"
#import "DateChooseView.h"

#import "BaseFrameHeader.h"
#import "CompleteSurveyCollCell.h"
#import "StoreViewCollCell.h"
#import "BaseHeader.h"
#import "BlueTitleMoreHeader.h"

#import "BorderTF.h"
#import "DropDownBtn.h"

@interface RentingCompleteSurveyStoreVC ()<UIScrollViewDelegate,UITextViewDelegate,UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    NSArray *_btnArr;
    NSArray *_titleArr;
    NSMutableArray *_selectArr;
    NSArray *_payArr;
    NSMutableArray *_dataArr;
    NSArray *_periodArr;
    NSArray *_freeArr;
    
    NSString *_payWay;
    NSString *_titleStr;

    NSInteger _rentType;
    
}

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) BaseFrameHeader *titleHeader;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) BorderTF *titleTF;

@property (nonatomic, strong) UILabel *maxPriceL;

@property (nonatomic, strong) BorderTF *maxPriceTF;

@property (nonatomic, strong) UILabel *transferL;

@property (nonatomic, strong) BorderTF *transferTF;

@property (nonatomic, strong) UILabel *depositL;

@property (nonatomic, strong) BorderTF *depositTF;

@property (nonatomic, strong) UILabel *roomLevelL;

@property (nonatomic, strong) DropDownBtn *roomLevelBtn;

@property (nonatomic, strong) UILabel *rentTypeL;

@property (nonatomic, strong) UIButton *rentBtn1;

@property (nonatomic, strong) UIImageView *rentImg1;

@property (nonatomic, strong) UIButton *rentBtn2;

@property (nonatomic, strong) UIImageView *rentImg2;

@property (nonatomic, strong) UILabel *payL;

@property (nonatomic, strong) UICollectionView *payColl;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) UILabel *minPeriodL;

@property (nonatomic, strong) DropDownBtn *minPeriodBtn;

@property (nonatomic, strong) UILabel *maxPeriodL;

@property (nonatomic, strong) DropDownBtn *maxPeriodBtn;

@property (nonatomic, strong) UILabel *highL;

@property (nonatomic, strong) BorderTF *highTF;

@property (nonatomic, strong) UILabel *widthL;

@property (nonatomic, strong) BorderTF *widthTF;

@property (nonatomic, strong) UILabel *inTimeL;

@property (nonatomic, strong) DropDownBtn *inTimeBtn;

@property (nonatomic, strong) UILabel *commercialL;

@property (nonatomic, strong) DropDownBtn *commercialBtn;

@property (nonatomic, strong) UILabel *typeL;

@property (nonatomic, strong) DropDownBtn *typeBtn;

@property (nonatomic, strong) UILabel *rentFreeL;

@property (nonatomic, strong) DropDownBtn *rentFreeBtn;

@property (nonatomic, strong) UIView *CollView;

@property (nonatomic, strong) BlueTitleMoreHeader *collHeader;

@property (nonatomic, strong) UICollectionViewFlowLayout *facilityLayout;

@property (nonatomic, strong) UICollectionView *facilityColl;

@property (nonatomic, strong) UIView *nearView;

@property (nonatomic, strong) BaseHeader *nearHeader;

@property (nonatomic, strong) UILabel *leftL;

@property (nonatomic, strong) BorderTF *leftTF;

@property (nonatomic, strong) UILabel *rightL;

@property (nonatomic, strong) BorderTF *rightTF;

@property (nonatomic, strong) UILabel *seeWayL;

@property (nonatomic, strong) DropDownBtn *seeWayBtn;

@property (nonatomic, strong) UILabel *markL;

@property (nonatomic, strong) UITextView *markView;

@property (nonatomic, strong) UIButton *nextBtn;

@property (nonatomic, strong) NSDateFormatter *formatter;

@end

@implementation RentingCompleteSurveyStoreVC

- (instancetype)initWithTitle:(NSString *)titleStr
{
    self = [super init];
    if (self) {
        
        _titleStr = titleStr;
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
    [self.formatter setDateFormat:@"YYYY/MM/dd"];
    
    _payArr = [self getDetailConfigArrByConfigState:RENT_SHOP_OFFICE_RECEIVE_TYPE];
    _selectArr = [@[] mutableCopy];
    for (int i = 0; i < _payArr.count; i++) {
        
        [_selectArr addObject:@0];
    }
    
    _btnArr = @[@"整租",@"合租"];
    _titleArr = @[@"挂牌标题：",@"出租价格：",@"转让费：",@"押金：",@"房源等级：",@"租赁类型：",@"收款方式：",@"最短租期：",@"最长租期：",@"层高：",@"门宽：",@"可入住时间：",@"商铺类型：",@"适合业态：",@"免租期："];
    _periodArr = @[@{@"param":@"无限制",@"id":@"0"},
                   @{@"param":@"一天",@"id":@"1"},
                   @{@"param":@"七天",@"id":@"7"},
                   @{@"param":@"一月",@"id":@"30"},
                   @{@"param":@"二月",@"id":@"60"},
                   @{@"param":@"半年",@"id":@"180"},
                   @{@"param":@"一年",@"id":@"360"},
                   @{@"param":@"两年",@"id":@"720"}];
    _freeArr = @[@{@"param":@"无免租期",@"id":@"0"},
                   @{@"param":@"一个月",@"id":@"1"},
                   @{@"param":@"二个月",@"id":@"2"},
                   @{@"param":@"三个月",@"id":@"3"},
                   @{@"param":@"六个月",@"id":@"6"},
                   @{@"param":@"九个月",@"id":@"9"},
                   @{@"param":@"十二个月",@"id":@"12"}];
}

- (void)ActionDropBtn:(UIButton *)btn{
    
    switch (btn.tag) {
        case 0:{
            
            SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.frame WithData:[self getDetailConfigArrByConfigState:50]];
            SS(strongSelf);
            view.selectedBlock = ^(NSString *MC, NSString *ID) {
                
                strongSelf->_roomLevelBtn.content.text = [NSString stringWithFormat:@"%@",MC];
                strongSelf->_roomLevelBtn->str = [NSString stringWithFormat:@"%@",ID];
            };
            [self.view addSubview:view];
            break;
        }
        case 1:{
            
            SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:_periodArr];
            WS(weakself);
            view.selectedBlock = ^(NSString *MC, NSString *ID) {
                
                weakself.minPeriodBtn.content.text = [NSString stringWithFormat:@"%@",MC];
                weakself.minPeriodBtn->str = [NSString stringWithFormat:@"%@",ID];
            };
            [self.view addSubview:view];
            break;
        }
        case 2:{
            
            SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:_periodArr];
            WS(weakself);
            view.selectedBlock = ^(NSString *MC, NSString *ID) {
                
                weakself.maxPeriodBtn.content.text = [NSString stringWithFormat:@"%@",MC];
                weakself.maxPeriodBtn->str = [NSString stringWithFormat:@"%@",ID];
            };
            [self.view addSubview:view];
            break;
        }
        case 3:{
            
            DateChooseView *view = [[DateChooseView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
            __weak __typeof(&*self)weakSelf = self;
            view.dateblock = ^(NSDate *date) {
                
                weakSelf.inTimeBtn.content.text = [weakSelf.formatter stringFromDate:date];
            };
            [self.view addSubview:view];
            break;
        }
        case 4:
        {
            SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:[self getDetailConfigArrByConfigState:SHOP_TYPE]];
            WS(weakself);
            view.selectedBlock = ^(NSString *MC, NSString *ID) {
                
                weakself.typeBtn.content.text = MC;
                weakself.typeBtn->str = [NSString stringWithFormat:@"%@", ID];
            };
            [self.view addSubview:view];
            break;
        }
        case 5:{
            
            SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:[self getDetailConfigArrByConfigState:FORMAT_TAG]];
            WS(weakself);
            view.selectedBlock = ^(NSString *MC, NSString *ID) {
                
                weakself.commercialBtn.content.text = MC;
                weakself.commercialBtn->str = [NSString stringWithFormat:@"%@", ID];
            };
            [self.view addSubview:view];
            break;
        }
        case 6:{
            
            SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:_freeArr];
            WS(weakself);
            view.selectedBlock = ^(NSString *MC, NSString *ID) {
                
                weakself.rentFreeBtn.content.text = MC;
                weakself.rentFreeBtn->str = [NSString stringWithFormat:@"%@", ID];
            };
            [self.view addSubview:view];
            break;
        }
        case 7:{
            
            SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:[self getDetailConfigArrByConfigState:CHECK_WAY]];
            WS(weakself);
            view.selectedBlock = ^(NSString *MC, NSString *ID) {
                
                weakself.seeWayBtn.content.text = MC;
                weakself.seeWayBtn->str = [NSString stringWithFormat:@"%@", ID];
            };
            [self.view addSubview:view];
            break;
        }
        default:
            break;
    }
}

- (void)ActionTagBtn:(UIButton *)btn{
    
    if (btn.tag == 1) {
        
        _rentImg1.image = [UIImage imageNamed:@"selected"];
        _rentImg2.image = [UIImage imageNamed:@"default"];
        _rentType = 245;
    }else{
        
        _rentImg1.image = [UIImage imageNamed:@"default"];
        _rentImg2.image = [UIImage imageNamed:@"selected"];
        _rentType = 246;
    }
}

- (void)ActionNextBtn:(UIButton *)btn{
    
    if ([self isEmpty:_titleTF.textfield.text]) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请输入挂牌标题"];
        return;
    }
    if ([self isEmpty:_maxPriceTF.textfield.text]) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请输入挂牌价格"];
        return;
    }
    
    if ([self isEmpty:_transferTF.textfield.text]) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请输入转让费"];
        return;
    }
    
    if ([self isEmpty:_roomLevelBtn->str]) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请选择房源等级"];
        return;
    }
    
    _payWay = @"";
    for (int i = 0; i < _selectArr.count; i++) {
        
        if ([_selectArr[i] integerValue]) {
            
            if (i == 0) {
                
                _payWay = [NSString stringWithFormat:@"%@",_payArr[i][@"id"]];
            }else{
                
                _payWay = [NSString stringWithFormat:@"%@,%@",_payWay,_payArr[i][@"id"]];
            }
        }
    }
    
    if (!_payWay.length) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请选择收款方式"];
        return;
    }
    
    if ([self isEmpty:_highTF.textfield.text]) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请输入层高"];
        return;
    }
    if ([self isEmpty:_widthTF.textfield.text]) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请输入门宽"];
        return;
    }
    if (!_typeBtn.content.text.length) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请选择商铺类型"];
        return;
    }
    if (!_commercialBtn.content.text.length) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请选择适合业态"];
        return;
    }
    
    if (!_seeWayBtn.content.text.length) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请看房方式"];
        return;
    }
    [self.dataDic setObject:@(2) forKey:@"type"];
    [self.dataDic setObject:@(_rentType) forKey:@"rent_type"];
    [self.dataDic setValue:_titleTF.textfield.text forKey:@"title"];
    [self.dataDic setValue:_maxPriceTF.textfield.text forKey:@"price"];
    [self.dataDic setObject:_transferTF.textfield.text forKey:@"transfer_money"];
    if (_depositTF.textfield.text.length) {
        
        [self.dataDic setObject:_depositTF.textfield.text forKey:@"deposit"];
    }
    [self.dataDic setValue:_roomLevelBtn->str forKey:@"level"];
    [self.dataDic setValue:_payWay forKey:@"receive_way"];
    if (_minPeriodBtn.content.text.length) {
        
        [self.dataDic setObject:_minPeriodBtn.content.text forKey:@"rent_min_comment"];
    }
    
    if (_maxPeriodBtn.content.text.length) {
        
        [self.dataDic setObject:_maxPeriodBtn.content.text forKey:@"rent_max_comment"];
    }
    if (![_inTimeBtn.content.text isEqualToString:@"随时入住"]) {
        
        [self.dataDic setValue:_inTimeBtn.content.text forKey:@"check_in_time"];
    }
    [self.dataDic setValue:_highTF.textfield.text forKey:@"shop_height"];
    [self.dataDic setValue:_widthTF.textfield.text forKey:@"shop_width"];
    [self.dataDic setValue:_typeBtn->str forKey:@"shop_type"];
    [self.dataDic setValue:_commercialBtn->str forKey:@"format_tags"];
    
    [self.dataDic setValue:_seeWayBtn->str forKey:@"check_way"];

    if (![self isEmpty:_markView.text]) {
        
        [self.dataDic setValue:_markView.text forKey:@"comment"];
    }
    if (![self isEmpty:_leftTF.textfield.text]) {
        
        [self.dataDic setValue:_leftTF.textfield.text forKey:@"left_shop"];
    }
    if (![self isEmpty:_rightTF.textfield.text]) {
        
        [self.dataDic setValue:_rightTF.textfield.text forKey:@"right_shop"];
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
            [self.dataDic setObject:str forKey:@"match_tags"];
    }
    RentingCompleteSurveyInfoVC2 *nextVC = [[RentingCompleteSurveyInfoVC2 alloc] init];
    nextVC.rentCompleteSurveyInfoVCBlock2 = ^{
        
        if (self.rentingCompleteSurveyStoreVCBlock) {
            
            self.rentingCompleteSurveyStoreVCBlock();
        }
    };
    nextVC.dic = [NSMutableDictionary dictionaryWithDictionary:self.dataDic];
    [self.navigationController pushViewController:nextVC animated:YES];
}


#pragma mark -- Collection

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (collectionView == _payColl) {
        
        return _payArr.count;
    }
    return _dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (collectionView == _payColl) {
        
        CompleteSurveyCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CompleteSurveyCollCell" forIndexPath:indexPath];
        if (!cell) {
            
            cell = [[CompleteSurveyCollCell alloc] initWithFrame:CGRectMake(0, 0, 130 *SIZE, 20 *SIZE)];
        }
        
        [cell setIsSelect:[_selectArr[indexPath.item] integerValue]];
        cell.titleL.text = _payArr[indexPath.item][@"param"];
        
        return cell;
    }else{
        
        StoreViewCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"StoreViewCollCell" forIndexPath:indexPath];
        if (!cell) {
            
            cell = [[StoreViewCollCell alloc] initWithFrame:CGRectMake(0, 0, 72 *SIZE, 72 *SIZE)];
        }
        
        
        cell.titleL.text = _dataArr[indexPath.item][@"name"];
        NSString *imageurl = _dataArr[indexPath.item][@"url"];
        
        if (imageurl.length>0) {
            
            [cell.typeImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,_dataArr[indexPath.item][@"url"]]] placeholderImage:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                
            }];
            cell.titleL.text = _dataArr[indexPath.item][@"name"];
            
        }
        else{
#warning 默认图片？？
        }
 
        return cell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (collectionView == _payColl) {
        
        if ([_selectArr[indexPath.item] integerValue]) {
            
            [_selectArr replaceObjectAtIndex:indexPath.item withObject:@0];
        }else{
            
            [_selectArr replaceObjectAtIndex:indexPath.item withObject:@1];
        }
        [collectionView reloadData];
    }
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = _titleStr;
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.backgroundColor = self.view.backgroundColor;
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    
    _contentView = [[UIView alloc] init];
    _contentView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:_contentView];
    
    _titleHeader = [[BaseFrameHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
    _titleHeader.titleL.text = @"挂牌信息";
    [_contentView addSubview:_titleHeader];
    
//    _roomLevelL = [[UILabel alloc] init];
//    _roomLevelL.textColor = YJTitleLabColor;
//    _roomLevelL.adjustsFontSizeToFitWidth = YES;
//    _roomLevelL.text = @"房源等级";
//    _roomLevelL.font = [UIFont systemFontOfSize:13 *SIZE];
//    [_contentView addSubview:_roomLevelL];
    
    for (int i = 0; i < 15; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = YJTitleLabColor;
        label.adjustsFontSizeToFitWidth = YES;
        label.text = _titleArr[i];
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        
        switch (i) {
            case 0:
            {
                _titleL = label;
                [_contentView addSubview:_titleL];
                break;
            }
            case 1:
            {
                _maxPriceL = label;
                [_contentView addSubview:_maxPriceL];
                break;
            }
            case 2:
            {
                _transferL = label;
                [_contentView addSubview:_transferL];
                break;
            }
            case 3:
            {
                _depositL = label;
                [_contentView addSubview:_depositL];
                break;
            }
            case 4:
            {
                _roomLevelL = label;
                [_contentView addSubview:_roomLevelL];
                break;
            }
            case 5:
            {
                _rentTypeL = label;
                [_contentView addSubview:_rentTypeL];
                break;
            }
            case 6:
            {
                _payL = label;
                [_contentView addSubview:_payL];
                break;
            }
            case 7:
            {
                _minPeriodL = label;
                [_contentView addSubview:_minPeriodL];
                break;
            }
            case 8:
            {
                _maxPeriodL = label;
                [_contentView addSubview:_maxPeriodL];
                break;
            }
            case 9:
            {
                _highL = label;
                [_contentView addSubview:_highL];
                break;
            }
            case 10:
            {
                _widthL = label;
                [_contentView addSubview:_widthL];
                break;
            }
            case 11:
            {
                _inTimeL = label;
                [_contentView addSubview:_inTimeL];
                break;
            }
            case 12:
            {
                _typeL = label;
                [_contentView addSubview:_typeL];
                break;
            }
            case 13:
            {
                _commercialL = label;
                [_contentView addSubview:_commercialL];
                break;
            }
            case 14:
            {
                _rentFreeL = label;
                [_contentView addSubview:_rentFreeL];
                break;
            }
            default:
                break;
        }
    }
    
    for (int i = 0; i < 6; i++) {
        
        BorderTF *textField = [[BorderTF alloc] initWithFrame:CGRectMake(81 *SIZE, 47 *SIZE, 258 *SIZE, 33 *SIZE)];
        textField.textfield.delegate = self;
        
        switch (i) {
            case 0:
            {
                _titleTF = textField;
                [_contentView addSubview:_titleTF];
                break;
            }
            case 1:
            {
                textField.textfield.keyboardType = UIKeyboardTypeNumberPad;
                _maxPriceTF = textField;
                _maxPriceTF.unitL.text = @"元/月";
                [_contentView addSubview:_maxPriceTF];
                break;
            }
            case 2:
            {
                textField.textfield.keyboardType = UIKeyboardTypeNumberPad;
                _transferTF = textField;
                _transferTF.unitL.text = @"元";
                [_contentView addSubview:_transferTF];
                break;
            }
            case 3:
            {
                textField.textfield.keyboardType = UIKeyboardTypeNumberPad;
                _depositTF = textField;
                _depositTF.unitL.text = @"元";
                [_contentView addSubview:_depositTF];
                break;
            }
            case 4:
            {
                _highTF = textField;
                _highTF.unitL.text = @"米";
                [_contentView addSubview:_highTF];
                break;
            }
            case 5:
            {
                _widthTF = textField;
                _widthTF.unitL.text = @"米";
                [_contentView addSubview:_widthTF];
                break;
            }
            default:
                break;
        }
    }
    
    for (int i = 0; i < 7; i++) {
        
        DropDownBtn *btn = [[DropDownBtn alloc] initWithFrame:CGRectMake(81 *SIZE, 0 *SIZE, 257 *SIZE, 33 *SIZE)];
        btn.tag = i;
        [btn addTarget:self action:@selector(ActionDropBtn:) forControlEvents:UIControlEventTouchUpInside];
        switch (i) {
            case 0:
            {
                _roomLevelBtn = btn;
                [_contentView addSubview:_roomLevelBtn];
                break;
            }
            case 1:
            {
                _minPeriodBtn = btn;
                _minPeriodBtn.content.text = @"无限制";
                [_contentView addSubview:_minPeriodBtn];
                break;
            }
            case 2:
            {
                _maxPeriodBtn = btn;
                _maxPeriodBtn.content.text = @"无限制";
                [_contentView addSubview:_maxPeriodBtn];
                break;
            }
            case 3:
            {
                _inTimeBtn = btn;
                _inTimeBtn.content.text = @"随时入住";
                [_contentView addSubview:_inTimeBtn];
                break;
            }
            case 4:
            {
                _typeBtn = btn;
                [_contentView addSubview:_typeBtn];
                break;
            }
            case 5:
            {
                _commercialBtn = btn;
                [_contentView addSubview:_commercialBtn];
                break;
            }
            case 6:
            {
                _rentFreeBtn = btn;
                _rentFreeBtn.content.text = @"无免租期";
                [_contentView addSubview:_rentFreeBtn];
                break;
            }
            default:
                break;
        }
    }
    
    for (int i = 0; i < 2; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 15 *SIZE, 15 *SIZE)];
        img.image = [UIImage imageNamed:@"default"];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(25 *SIZE, 0, 100 *SIZE, 13 *SIZE)];
        label.textColor = YJContentLabColor;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        label.text = _btnArr[i];
        [btn addSubview:label];
        
        btn.tag = i + 1;
        [btn addTarget:self action:@selector(ActionTagBtn:) forControlEvents:UIControlEventTouchUpInside];
        switch (i) {
            case 0:
            {
                _rentImg1 = img;
                [btn addSubview:_rentImg1];
                _rentBtn1 = btn;
                [_contentView addSubview:_rentBtn1];
                break;
            }
            case 1:
            {
                _rentImg2 = img;
                [btn addSubview:_rentImg2];
                _rentBtn2 = btn;
                [_contentView addSubview:_rentBtn2];
                break;
            }
            default:
                break;
        }
    }
    _rentImg1.image = [UIImage imageNamed:@"selected"];
    _rentType = 245;
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.estimatedItemSize = CGSizeMake(120 *SIZE, 20 *SIZE);
    _flowLayout.minimumLineSpacing = 20 *SIZE;
    _flowLayout.minimumInteritemSpacing = 0;
    
    _payColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 100 *SIZE) collectionViewLayout:_flowLayout];
    _payColl.backgroundColor = [UIColor whiteColor];
    _payColl.allowsMultipleSelection = YES;
    _payColl.delegate = self;
    _payColl.dataSource = self;
    [_payColl registerClass:[CompleteSurveyCollCell class] forCellWithReuseIdentifier:@"CompleteSurveyCollCell"];
    [_contentView addSubview:_payColl];
    
    _CollView = [[UIView alloc] init];
    _CollView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:_CollView];
    
    _collHeader = [[BlueTitleMoreHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
    _collHeader.titleL.text = @"配套设施";
    [_collHeader.moreBtn setTitle:@"" forState:UIControlStateNormal];
    [_collHeader.moreBtn setImage:[UIImage imageNamed:@"add_40"] forState:UIControlStateNormal];
    
    WS(weakSelf);
    SS(strongSelf);
    _collHeader.blueTitleMoreHeaderBlock = ^{
        
        RentingAddEquipmentVC *nextVC = [[RentingAddEquipmentVC alloc] initWithType:2];
        nextVC.data = strongSelf->_dataArr;
        nextVC.rentingAddEquipmentVCBlock = ^(NSArray * _Nonnull data) {
            
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
    //    _storeCollView = [[CompleteSurveyStoreCollView alloc] init];
    //    [_scrollView addSubview:_storeCollView];
    
    _nearView = [[UIView alloc] init];
    _nearView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:_nearView];
    
    _nearHeader = [[BaseHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
    _nearHeader.titleL.text = @"左云右算";
    [_nearView addSubview:_nearHeader];
    
    NSArray *nearArr = @[@"左边店铺：",@"右边店铺：",@"看房方式：",@"其他要求："];
    for (int i = 0; i < 4; i++) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(8 *SIZE, 20 *SIZE, 70 *SIZE, 13 *SIZE)];
        label.textColor = YJTitleLabColor;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        label.text = nearArr[i];
        switch (i) {
            case 0:
            {
                _leftL = label;
                [_nearView addSubview:_leftL];
                break;
            }
            case 1:
            {
                _rightL = label;
                [_nearView addSubview:_rightL];
                break;
            }
            case 2:
            {
                _seeWayL = label;
                [_nearView addSubview:_seeWayL];
                break;
            }
            case 3:
            {
                _markL = label;
                [_nearView addSubview:_markL];
                break;
            }
            default:
                break;
        }
    }
    
    for (int i = 0; i < 2; i++) {
        
        BorderTF *textFeild = [[BorderTF alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
        if (i == 0) {
            
            _leftTF = textFeild;
            [_nearView addSubview:_leftTF];
        }else{
            
            _rightTF = textFeild;
            [_nearView addSubview:_rightTF];
        }
    }
    
    _seeWayBtn = [[DropDownBtn alloc] initWithFrame:CGRectMake(81 *SIZE, 118 *SIZE, 257 *SIZE, 33 *SIZE)];
    _seeWayBtn.tag = 7;
    [_seeWayBtn addTarget:self action:@selector(ActionDropBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_nearView addSubview:_seeWayBtn];
    
    _markView = [[UITextView alloc] initWithFrame:CGRectMake(79 *SIZE, 171 *SIZE, 258 *SIZE, 100 *SIZE)];
    _markView.layer.borderColor = COLOR(219, 219, 219, 1).CGColor;
    _markView.layer.borderWidth = SIZE;
    _markView.layer.cornerRadius = 5 *SIZE;
    _markView.clipsToBounds = YES;
    [_nearView addSubview:_markView];
    
    _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _nextBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
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
    
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(0);
        make.top.equalTo(self->_scrollView).offset(0 *SIZE);
        make.right.equalTo(self->_scrollView).offset(0);
        make.width.equalTo(@(SCREEN_Width));
    }];
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_contentView).offset(9 *SIZE);
        make.top.equalTo(self->_contentView).offset(58 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_titleTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_contentView).offset(81 *SIZE);
        make.top.equalTo(self->_contentView).offset(47 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_maxPriceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_contentView).offset(9 *SIZE);
        make.top.equalTo(self->_titleTF.mas_bottom).offset(31 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_maxPriceTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_contentView).offset(81 *SIZE);
        make.top.equalTo(self->_titleTF.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_transferL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_contentView).offset(9 *SIZE);
        make.top.equalTo(self->_maxPriceTF.mas_bottom).offset(31 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_transferTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_contentView).offset(81 *SIZE);
        make.top.equalTo(self->_maxPriceTF.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_depositL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_contentView).offset(9 *SIZE);
        make.top.equalTo(self->_transferTF.mas_bottom).offset(31 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_depositTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_contentView).offset(81 *SIZE);
        make.top.equalTo(self->_transferTF.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_roomLevelL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_depositTF.mas_bottom).offset(36 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(65 *SIZE);
    }];
    
    [_roomLevelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(81 *SIZE);
        make.top.equalTo(_depositTF.mas_bottom).offset(25 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_rentTypeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_roomLevelBtn.mas_bottom).offset(28 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_rentBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(81 *SIZE);
        make.top.equalTo(_roomLevelBtn.mas_bottom).offset(23 *SIZE);
        make.width.mas_equalTo(130 *SIZE);
        make.height.mas_equalTo(20 *SIZE);
    }];
    
    [_rentBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(226 *SIZE);
        make.top.equalTo(_roomLevelBtn.mas_bottom).offset(23 *SIZE);
        make.width.mas_equalTo(130 *SIZE);
        make.height.mas_equalTo(20 *SIZE);
    }];
    
    [_payL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_contentView).offset(9 *SIZE);
        make.top.equalTo(self->_rentBtn2.mas_bottom).offset(31 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_payColl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_contentView).offset(81 *SIZE);
        make.top.equalTo(self->_rentBtn2.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(self->_payColl.collectionViewLayout.collectionViewContentSize.height + 3 *SIZE * 20);
    }];
    
    [_minPeriodL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_payColl.mas_bottom).offset(41 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_minPeriodBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(81 *SIZE);
        make.top.equalTo(_payColl.mas_bottom).offset(30 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_maxPeriodL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_minPeriodBtn.mas_bottom).offset(41 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_maxPeriodBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(81 *SIZE);
        make.top.equalTo(_minPeriodBtn.mas_bottom).offset(30 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_highL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_contentView).offset(9 *SIZE);
        make.top.equalTo(self->_maxPeriodBtn.mas_bottom).offset(41 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_highTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_contentView).offset(81 *SIZE);
        make.top.equalTo(self->_maxPeriodBtn.mas_bottom).offset(30 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_widthL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_contentView).offset(9 *SIZE);
        make.top.equalTo(self->_highTF.mas_bottom).offset(41 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_widthTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_contentView).offset(81 *SIZE);
        make.top.equalTo(self->_highTF.mas_bottom).offset(30 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_inTimeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_contentView).offset(9 *SIZE);
        make.top.equalTo(self->_widthTF.mas_bottom).offset(41 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_inTimeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_contentView).offset(81 *SIZE);
        make.top.equalTo(self->_widthTF.mas_bottom).offset(30 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_typeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_contentView).offset(9 *SIZE);
        make.top.equalTo(self->_inTimeBtn.mas_bottom).offset(41 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_typeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_contentView).offset(81 *SIZE);
        make.top.equalTo(self->_inTimeBtn.mas_bottom).offset(30 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_commercialL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_contentView).offset(9 *SIZE);
        make.top.equalTo(self->_typeBtn.mas_bottom).offset(41 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_commercialBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_contentView).offset(81 *SIZE);
        make.top.equalTo(self->_typeBtn.mas_bottom).offset(30 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_rentFreeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_contentView).offset(9 *SIZE);
        make.top.equalTo(self->_commercialBtn.mas_bottom).offset(41 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_rentFreeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_contentView).offset(81 *SIZE);
        make.top.equalTo(self->_commercialBtn.mas_bottom).offset(30 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
        make.bottom.equalTo(self->_contentView).offset(-31 *SIZE);
    }];
    
    [_CollView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(0);
        make.top.equalTo(self->_contentView.mas_bottom).offset(6 *SIZE);
        make.width.mas_equalTo(360 *SIZE);
    }];
    
    [_facilityColl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_CollView).offset(0 *SIZE);
        make.top.equalTo(self->_CollView).offset(40 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(self->_facilityColl.collectionViewLayout.collectionViewContentSize.height);
        make.bottom.equalTo(self->_CollView.mas_bottom).offset(0 *SIZE);
    }];
    
    [_nearView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(0);
        make.top.equalTo(self->_CollView.mas_bottom).offset(6 *SIZE);
        make.width.mas_equalTo(360 *SIZE);
    }];
    
    [_leftL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_nearView).offset(8 *SIZE);
        make.top.equalTo(self->_nearView).offset(60 *SIZE);
        make.height.mas_equalTo(13 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_leftTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_nearView).offset(81 *SIZE);
        make.top.equalTo(self->_nearView).offset(50 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_rightL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_nearView).offset(8 *SIZE);
        make.top.equalTo(self->_leftTF.mas_bottom).offset(30 *SIZE);
        make.height.mas_equalTo(13 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_rightTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_nearView).offset(81 *SIZE);
        make.top.equalTo(self->_leftTF.mas_bottom).offset(19 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_seeWayL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_nearView).offset(8 *SIZE);
        make.top.equalTo(self->_rightTF.mas_bottom).offset(30 *SIZE);
        make.height.mas_equalTo(13 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_seeWayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_nearView).offset(81 *SIZE);
        make.top.equalTo(self->_rightTF.mas_bottom).offset(19 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_markL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_nearView).offset(8 *SIZE);
        make.top.equalTo(self->_seeWayBtn.mas_bottom).offset(30 *SIZE);
        make.height.mas_equalTo(13 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_markView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_nearView).offset(81 *SIZE);
        make.top.equalTo(self->_seeWayBtn.mas_bottom).offset(19 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(100 *SIZE);
        make.bottom.equalTo(self->_nearView.mas_bottom).offset(-29 *SIZE);
    }];
    
    [_nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(22 *SIZE);
        make.top.equalTo(self->_nearView.mas_bottom).offset(32 *SIZE);
        make.width.equalTo(@(317 *SIZE));
        make.height.equalTo(@(40 *SIZE));
        make.bottom.equalTo(self->_scrollView.mas_bottom).offset(-19 *SIZE);
    }];
}

@end
