//
//  CompleteSurveyHouseVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/9/13.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "CompleteSurveyHouseVC.h"

#import "CompleteSurveyInfoVC2.h"

#import "SinglePickView.h"
#import "DateChooseView.h"

//#import "SingleContentCell.h"
#import "BaseFrameHeader.h"
#import "CompleteSurveyCollCell.h"

#import "BorderTF.h"
#import "DropDownBtn.h"

@interface CompleteSurveyHouseVC ()<UIScrollViewDelegate,UITextViewDelegate,UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    
    NSString *_titleStr;
    
    NSArray *_btnArr;
    NSArray *_titleArr;
    NSMutableArray *_selectArr;
    NSArray *_payArr;
    NSInteger _propertyBelong;
    NSInteger _isMortgage;
    NSString *_payWay;
}

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) BaseFrameHeader *titleHeader;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) BorderTF *titleTF;

@property (nonatomic, strong) UILabel *maxPriceL;

@property (nonatomic, strong) BorderTF *maxPriceTF;

@property (nonatomic, strong) UILabel *minPriceL;

@property (nonatomic, strong) BorderTF *minPriceTF;

@property (nonatomic, strong) UILabel *payL;

@property (nonatomic, strong) UICollectionView *payColl;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) UILabel *propertyL;

@property (nonatomic, strong) UIButton *propertyBtn1;

@property (nonatomic, strong) UIImageView *propertyImg1;

@property (nonatomic, strong) UIButton *propertyBtn2;

@property (nonatomic, strong) UIImageView *propertyImg2;

@property (nonatomic, strong) UILabel *mortgageL;

@property (nonatomic, strong) UIButton *mortgageBtn1;

@property (nonatomic, strong) UIImageView *mortgageImg1;

@property (nonatomic, strong) UIButton *mortgageBtn2;

@property (nonatomic, strong) UIImageView *mortgageImg2;

@property (nonatomic, strong) UILabel *houseTypeL;

@property (nonatomic, strong) DropDownBtn *houseTypeBtn;

@property (nonatomic, strong) UILabel *floorL;

@property (nonatomic, strong) DropDownBtn *floorBtn;

@property (nonatomic, strong) UILabel *certNumL;

@property (nonatomic, strong) BorderTF *cerNumTF;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) DropDownBtn *timeBtn;

@property (nonatomic, strong) UILabel *decorateL;

@property (nonatomic, strong) DropDownBtn *decorateBtn;

@property (nonatomic, strong) UILabel *inTimeL;

@property (nonatomic, strong) DropDownBtn *inTimeBtn;

@property (nonatomic, strong) UILabel *seeWayL;

@property (nonatomic, strong) DropDownBtn *seeWayBtn;

@property (nonatomic, strong) UILabel *markL;

@property (nonatomic, strong) UITextView *markView;

@property (nonatomic, strong) UIButton *nextBtn;

@property (nonatomic, strong) NSDateFormatter *formatter;

@end

@implementation CompleteSurveyHouseVC

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
    
    _payArr = [self getDetailConfigArrByConfigState:13];
    _selectArr = [@[] mutableCopy];
    for (int i = 0; i < _payArr.count; i++) {
        
        [_selectArr addObject:@0];
    }
    _btnArr = @[@"共有",@"非共有",@"有",@"无"];
    _titleArr = @[@"挂牌标题：",@"挂牌价格：",@"出售底价：",@"收款方式：",@"产权所属：",@"抵押信息：",@"户型：",@"楼层：",@"房屋所有权证号：",@"拿证时间：",@"装修：",@"可入住时间：",@"看房方式：",@"其他要求"];
}

- (void)ActionDropBtn:(UIButton *)btn{
    
    switch (btn.tag) {
        case 0:
        {
            SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:[self getDetailConfigArrByConfigState:HOUSE_TYPE]];
            WS(weakself);
            view.selectedBlock = ^(NSString *MC, NSString *ID) {
                
                weakself.houseTypeBtn.content.text = MC;
                weakself.houseTypeBtn->str = [NSString stringWithFormat:@"%@", ID];
            };
            [self.view addSubview:view];
            break;
        }
        case 1:{
            
            SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:[self getDetailConfigArrByConfigState:FLOOR_TYPE]];
            WS(weakself);
            view.selectedBlock = ^(NSString *MC, NSString *ID) {
                
                weakself.floorBtn.content.text = MC;
                weakself.floorBtn->str = [NSString stringWithFormat:@"%@", ID];
            };
            [self.view addSubview:view];
            break;
        }
        case 2:{
            
            DateChooseView *view = [[DateChooseView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
            __weak __typeof(&*self)weakSelf = self;
            view.dateblock = ^(NSDate *date) {
                
                weakSelf.timeBtn.content.text = [weakSelf.formatter stringFromDate:date];
            };
            [self.view addSubview:view];
            break;
        }
        case 3:{
            
            SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:[self getDetailConfigArrByConfigState:DECORATE]];
            WS(weakself);
            view.selectedBlock = ^(NSString *MC, NSString *ID) {
                
                weakself.decorateBtn.content.text = MC;
                weakself.decorateBtn->str = [NSString stringWithFormat:@"%@", ID];
            };
            [self.view addSubview:view];
            break;
        }
        case 4:{
            
            DateChooseView *view = [[DateChooseView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
            __weak __typeof(&*self)weakSelf = self;
            view.dateblock = ^(NSDate *date) {
                
                weakSelf.inTimeBtn.content.text = [weakSelf.formatter stringFromDate:date];
            };
            [self.view addSubview:view];
            break;
        }
        case 5:{
            
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
    
    if (btn.tag < 3) {
        
        if (btn.tag == 1) {
            
            _propertyImg1.image = [UIImage imageNamed:@"selected"];
            _propertyImg2.image = [UIImage imageNamed:@"default"];
            _propertyBelong = 1;
        }else{
            
            _propertyImg1.image = [UIImage imageNamed:@"default"];
            _propertyImg2.image = [UIImage imageNamed:@"selected"];
            _propertyBelong = 2;
        }
    }else{
        
        if (btn.tag == 3) {
            
            _mortgageImg1.image = [UIImage imageNamed:@"selected"];
            _mortgageImg2.image = [UIImage imageNamed:@"default"];
            _isMortgage = 1;
        }else{
            
            _mortgageImg1.image = [UIImage imageNamed:@"default"];
            _mortgageImg2.image = [UIImage imageNamed:@"selected"];
            _isMortgage = 2;
        }
    }
}

//- (void)ActionSeeWayBtn:(UIButton *)btn{
//
//    SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.frame WithData:[self getDetailConfigArrByConfigState:31]];
//    SS(strongSelf);
//    view.selectedBlock = ^(NSString *MC, NSString *ID) {
//
//        strongSelf.seeWayBtn.content.text = [NSString stringWithFormat:@"%@",MC];
////                strongSelf->_seeWay = [NSString stringWithFormat:@"%@",ID];
//    };
//    [self.view addSubview:view];
//}

- (void)ActionNextBtn:(UIButton *)btn{
    
    if ([self isEmpty:_titleTF.textfield.text]) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请输入挂牌标题"];
        return;
    }
    if ([self isEmpty:_maxPriceTF.textfield.text]) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请输入挂牌价格"];
        return;
    }
    
    for (int i = 0; i < _selectArr.count; i++) {
        
        if ([_selectArr[i] integerValue]) {
            
            if (!_payWay.length) {
                
                _payWay = [NSString stringWithFormat:@"%@",_payArr[0][@"id"]];
            }else{
                
                _payWay = [NSString stringWithFormat:@"%@,%@",_payWay,_payArr[i][@"id"]];
            }
        }
    }
    
    if (!_payWay.length) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请选择付款方式"];
        return;
    }
    
    if (!_houseTypeBtn.content.text.length) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请选择户型"];
        return;
    }
//    if (!_floorBtn.content.text.length) {
//
//        [self alertControllerWithNsstring:@"温馨提示" And:@"请选择楼层"];
//        return;
//    }
    if ([self isEmpty:_cerNumTF.textfield.text]) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请输入所有权证号"];
        return;
    }
    if (!_timeBtn.content.text.length) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请选择拿证时间"];
        return;
    }
    if (!_decorateBtn.content.text.length) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请选择装修标准"];
        return;
    }
//    if (!_inTimeBtn.content.text.length) {
//
//        [self alertControllerWithNsstring:@"温馨提示" And:@"请选择入住时间"];
//        return;
//    }
    if (!_seeWayBtn.content.text.length) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请看房方式"];
        return;
    }
    [self.dataDic setObject:@(1) forKey:@"type"];
    [self.dataDic setValue:_titleTF.textfield.text forKey:@"title"];
    [self.dataDic setValue:_maxPriceTF.textfield.text forKey:@"price"];
    [self.dataDic setValue:_payWay forKey:@"pay_way"];
    [self.dataDic setValue:@(_propertyBelong) forKey:@"property_belong"];
    [self.dataDic setValue:@(_isMortgage) forKey:@"is_mortgage"];
    [self.dataDic setValue:_houseTypeBtn->str forKey:@"house_type_id"];
//    [self.dataDic setValue:_floorBtn.str forKey:@"floor_type"];
    [self.dataDic setValue:_cerNumTF.textfield.text forKey:@"permit_code"];
    [self.dataDic setValue:_timeBtn.content.text forKey:@"permit_time"];
    [self.dataDic setValue:_decorateBtn->str forKey:@"decoration"];
    
    [self.dataDic setValue:_seeWayBtn->str forKey:@"check_way"];
    if (![_inTimeBtn.content.text isEqualToString:@"随时入住"]) {
        
        [self.dataDic setValue:_inTimeBtn.content.text forKey:@"check_in_time"];
    }
    if (![self isEmpty:_minPriceTF.textfield.text]) {
        
        [self.dataDic setValue:_minPriceTF.textfield.text forKey:@"minimum"];
    }
    if (![self isEmpty:_markView.text]) {
        
        [self.dataDic setValue:_markView.text forKey:@"comment"];
    }
    if (_floorBtn.content.text.length) {
        
        [self.dataDic setValue:_floorBtn->str forKey:@"floor_type"];
    }

    CompleteSurveyInfoVC2 *nextVC = [[CompleteSurveyInfoVC2 alloc] init];
    nextVC.completeSurveyInfoVCBlock2 = ^{
        
        if (self.completeSurveyHouseVCBlock) {
            
            self.completeSurveyHouseVCBlock();
        }
    };
    nextVC.dic = [NSMutableDictionary dictionaryWithDictionary:self.dataDic];
    [self.navigationController pushViewController:nextVC animated:YES];
}

#pragma mark -- TextField;

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    if (textField == _minPriceTF.textfield) {
        
        if (!_maxPriceTF.textfield.text) {
            
            [self alertControllerWithNsstring:@"温馨提示" And:@"请先输入挂牌价格" WithDefaultBlack:^{
                
                return ;
            }];
        }
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (textField == _minPriceTF.textfield) {
        
        if ([_minPriceTF.textfield.text integerValue] > [_maxPriceTF.textfield.text integerValue]) {
            
            [self alertControllerWithNsstring:@"温馨提示" And:@"出售底价不能超过挂牌价格" WithDefaultBlack:^{
                
                _minPriceTF.textfield.text = self->_maxPriceTF.textfield.text;
                [_minPriceTF.textfield becomeFirstResponder];
                return ;
            }];
        }
    }
}

#pragma mark -- collectionview

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _payArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CompleteSurveyCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CompleteSurveyCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[CompleteSurveyCollCell alloc] initWithFrame:CGRectMake(0, 0, 130 *SIZE, 20 *SIZE)];
    }
    
    [cell setIsSelect:[_selectArr[indexPath.item] integerValue]];
    cell.titleL.text = _payArr[indexPath.item][@"param"];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([_selectArr[indexPath.item] integerValue]) {
        
        [_selectArr replaceObjectAtIndex:indexPath.item withObject:@0];
    }else{
        
        [_selectArr replaceObjectAtIndex:indexPath.item withObject:@1];
    }
    [collectionView reloadData];
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
    
    for (int i = 0; i < 14; i++) {
        
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
                _minPriceL = label;
                [_contentView addSubview:_minPriceL];
                break;
            }
            case 3:
            {
                _payL = label;
                [_contentView addSubview:_payL];
                break;
            }
            case 4:
            {
                _propertyL = label;
                [_contentView addSubview:_propertyL];
                break;
            }
            case 5:
            {
                _mortgageL = label;
                [_contentView addSubview:_mortgageL];
                break;
            }
            case 6:
            {
                _houseTypeL = label;
                [_contentView addSubview:_houseTypeL];
                break;
            }
            case 7:
            {
                _floorL = label;
                [_contentView addSubview:_floorL];
                break;
            }
            case 8:
            {
                _certNumL = label;
                [_contentView addSubview:_certNumL];
                break;
            }
            case 9:
            {
                _timeL = label;
                [_contentView addSubview:_timeL];
                break;
            }
            case 10:
            {
                _decorateL = label;
                [_contentView addSubview:_decorateL];
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
                _seeWayL = label;
                [_contentView addSubview:_seeWayL];
                break;
            }
            case 13:
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
                _maxPriceTF.unitL.text = @"万";
                [_contentView addSubview:_maxPriceTF];
                break;
            }
            case 2:
            {
                textField.textfield.keyboardType = UIKeyboardTypeNumberPad;
                _minPriceTF = textField;
                _minPriceTF.unitL.text = @"万";
                [_contentView addSubview:_minPriceTF];
                break;
            }
            case 3:
            {
                textField.textfield.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
                _cerNumTF = textField;
                [_contentView addSubview:_cerNumTF];
                break;
            }
            default:
                break;
        }
    }
    
    for (int i = 0; i < 6; i++) {
        
        DropDownBtn *btn = [[DropDownBtn alloc] initWithFrame:CGRectMake(81 *SIZE, 0 *SIZE, 257 *SIZE, 33 *SIZE)];
        btn.tag = i;
        [btn addTarget:self action:@selector(ActionDropBtn:) forControlEvents:UIControlEventTouchUpInside];
        switch (i) {
            case 0:
            {
                _houseTypeBtn = btn;
                [_contentView addSubview:_houseTypeBtn];
                break;
            }
            case 1:
            {
                _floorBtn = btn;
                [_contentView addSubview:_floorBtn];
                break;
            }
            case 2:
            {
                _timeBtn = btn;
                [_contentView addSubview:_timeBtn];
                break;
            }
            case 3:
            {
                _decorateBtn = btn;
                [_contentView addSubview:_decorateBtn];
                break;
            }
            case 4:
            {
                _inTimeBtn = btn;
                _inTimeBtn.content.text = @"随时入住";
                [_contentView addSubview:_inTimeBtn];
                break;
            }
            case 5:
            {
                _seeWayBtn = btn;
                [_contentView addSubview:_seeWayBtn];
                break;
            }
            default:
                break;
        }
    }
    
    for (int i = 0; i < 4; i++) {
        
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
                _propertyImg1 = img;
                [btn addSubview:_propertyImg1];
                _propertyBtn1 = btn;
                [_contentView addSubview:_propertyBtn1];
                break;
            }
            case 1:
            {
                _propertyImg2 = img;
                [btn addSubview:_propertyImg2];
                _propertyBtn2 = btn;
                [_contentView addSubview:_propertyBtn2];
                break;
            }
            case 2:
            {
                _mortgageImg1 = img;
                [btn addSubview:_mortgageImg1];
                _mortgageBtn1 = btn;
                [_contentView addSubview:_mortgageBtn1];
                break;
            }
            case 3:
            {
                _mortgageImg2 = img;
                [btn addSubview:_mortgageImg2];
                _mortgageBtn2 = btn;
                [_contentView addSubview:_mortgageBtn2];
                break;
            }
            default:
                break;
        }
    }
    _propertyImg2.image = [UIImage imageNamed:@"selected"];
    _propertyBelong = 2;
    _mortgageImg2.image = [UIImage imageNamed:@"selected"];
    _isMortgage = 2;
    
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
    
    _markView = [[UITextView alloc] init];
    _markView.delegate = self;
    _markView.layer.cornerRadius = 5 *SIZE;
    _markView.clipsToBounds = YES;
    _markView.layer.borderColor = COLOR(219, 219, 219, 1).CGColor;
    _markView.layer.borderWidth = SIZE;
    [_scrollView addSubview:_markView];
    
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
        
        make.left.equalTo(_scrollView).offset(0);
        make.top.equalTo(_scrollView).offset(0 *SIZE);
        make.right.equalTo(_scrollView).offset(0);
        make.width.equalTo(@(SCREEN_Width));
    }];
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_contentView).offset(58 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_titleTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(81 *SIZE);
        make.top.equalTo(_contentView).offset(47 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_maxPriceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_titleTF.mas_bottom).offset(31 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_maxPriceTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(81 *SIZE);
        make.top.equalTo(_titleTF.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_minPriceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_maxPriceTF.mas_bottom).offset(31 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_minPriceTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(81 *SIZE);
        make.top.equalTo(_maxPriceTF.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_payL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_minPriceTF.mas_bottom).offset(31 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_payColl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(81 *SIZE);
        make.top.equalTo(_minPriceTF.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(_payColl.collectionViewLayout.collectionViewContentSize.height + 3 *SIZE * 20);
    }];
    
    [_propertyL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_payColl.mas_bottom).offset(28 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_propertyBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(81 *SIZE);
        make.top.equalTo(_payColl.mas_bottom).offset(23 *SIZE);
        make.width.mas_equalTo(130 *SIZE);
        make.height.mas_equalTo(20 *SIZE);
    }];
    
    [_propertyBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(226 *SIZE);
        make.top.equalTo(_payColl.mas_bottom).offset(23 *SIZE);
        make.width.mas_equalTo(130 *SIZE);
        make.height.mas_equalTo(20 *SIZE);
    }];
    
    [_mortgageL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_propertyBtn1.mas_bottom).offset(30 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_mortgageBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(81 *SIZE);
        make.top.equalTo(_propertyBtn1.mas_bottom).offset(25 *SIZE);
        make.width.mas_equalTo(130 *SIZE);
        make.height.mas_equalTo(20 *SIZE);
    }];
    
    [_mortgageBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(226 *SIZE);
        make.top.equalTo(_propertyBtn1.mas_bottom).offset(25 *SIZE);
        make.width.mas_equalTo(130 *SIZE);
        make.height.mas_equalTo(20 *SIZE);
    }];
    
    [_houseTypeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_mortgageBtn1.mas_bottom).offset(41 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_houseTypeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(81 *SIZE);
        make.top.equalTo(_mortgageBtn1.mas_bottom).offset(30 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_floorL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_houseTypeBtn.mas_bottom).offset(41 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_floorBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(81 *SIZE);
        make.top.equalTo(_houseTypeBtn.mas_bottom).offset(30 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_certNumL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_floorBtn.mas_bottom).offset(41 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_cerNumTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(81 *SIZE);
        make.top.equalTo(_floorBtn.mas_bottom).offset(30 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_cerNumTF.mas_bottom).offset(41 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_timeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(81 *SIZE);
        make.top.equalTo(_cerNumTF.mas_bottom).offset(30 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_decorateL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_timeBtn.mas_bottom).offset(41 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_decorateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(81 *SIZE);
        make.top.equalTo(_timeBtn.mas_bottom).offset(30 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_inTimeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_decorateBtn.mas_bottom).offset(41 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_inTimeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(81 *SIZE);
        make.top.equalTo(_decorateBtn.mas_bottom).offset(30 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_seeWayL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_inTimeBtn.mas_bottom).offset(41 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_seeWayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(81 *SIZE);
        make.top.equalTo(_inTimeBtn.mas_bottom).offset(30 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_markL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_seeWayBtn.mas_bottom).offset(41 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_markView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(81 *SIZE);
        make.top.equalTo(_seeWayBtn.mas_bottom).offset(30 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(100 *SIZE);
        make.bottom.equalTo(_contentView.mas_bottom).offset(-29 *SIZE);
    }];
    
    [_nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrollView).offset(22 *SIZE);
        make.top.equalTo(_contentView.mas_bottom).offset(28 *SIZE);
        make.width.equalTo(@(317 *SIZE));
        make.height.equalTo(@(40 *SIZE));
        make.bottom.equalTo(_scrollView.mas_bottom).offset(-19 *SIZE);
    }];
}

@end
