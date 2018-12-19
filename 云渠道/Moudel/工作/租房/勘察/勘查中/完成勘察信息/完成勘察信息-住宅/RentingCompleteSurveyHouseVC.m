//
//  RentingCompleteSurveyHouseVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/12/4.
//  Copyright © 2018 xiaoq. All rights reserved.
//

#import "RentingCompleteSurveyHouseVC.h"

#import "RentingCompleteSurveyInfoVC2.h"

#import "SinglePickView.h"
#import "DateChooseView.h"

//#import "SingleContentCell.h"
#import "BaseFrameHeader.h"
#import "CompleteSurveyCollCell.h"

#import "BorderTF.h"
#import "DropDownBtn.h"

@interface RentingCompleteSurveyHouseVC ()<UIScrollViewDelegate,UITextViewDelegate,UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    
    NSString *_titleStr;
    
    NSArray *_btnArr;
    NSArray *_titleArr;
    NSMutableArray *_selectArr;
    NSArray *_payArr;
    NSInteger _rentType;
    NSString *_payWay;
}

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) BaseFrameHeader *titleHeader;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) BorderTF *titleTF;

@property (nonatomic, strong) UILabel *priceL;

@property (nonatomic, strong) BorderTF *priceTF;

@property (nonatomic, strong) UILabel *roomLevelL;

@property (nonatomic, strong) DropDownBtn *roomLevelBtn;

@property (nonatomic, strong) UILabel *payL;

@property (nonatomic, strong) UICollectionView *payColl;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) UILabel *rentTypeL;

@property (nonatomic, strong) UIButton *rentBtn1;

@property (nonatomic, strong) UIImageView *rentImg1;

@property (nonatomic, strong) UIButton *rentBtn2;

@property (nonatomic, strong) UIImageView *rentImg2;

@property (nonatomic, strong) UILabel *houseTypeL;

@property (nonatomic, strong) DropDownBtn *houseTypeBtn;

@property (nonatomic, strong) UILabel *floorL;

@property (nonatomic, strong) DropDownBtn *floorBtn;

@property (nonatomic, strong) UILabel *minPeriodL;

@property (nonatomic, strong) DropDownBtn *minPeriodBtn;

@property (nonatomic, strong) UILabel *maxPeriodL;

@property (nonatomic, strong) DropDownBtn *maxPeriodBtn;

@property (nonatomic, strong) UILabel *inTimeL;

@property (nonatomic, strong) DropDownBtn *inTimeBtn;

@property (nonatomic, strong) UILabel *seeWayL;

@property (nonatomic, strong) DropDownBtn *seeWayBtn;

@property (nonatomic, strong) UILabel *markL;

@property (nonatomic, strong) UITextView *markView;

@property (nonatomic, strong) UIButton *nextBtn;

@property (nonatomic, strong) NSDateFormatter *formatter;

@end

@implementation RentingCompleteSurveyHouseVC

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
    
    _payArr = [self getDetailConfigArrByConfigState:RENT_HOUSE_RECEIVE_TYPE];
    _selectArr = [@[] mutableCopy];
    for (int i = 0; i < _payArr.count; i++) {
        
        [_selectArr addObject:@0];
    }
    _btnArr = @[@"整租",@"合租"];
    _titleArr = @[@"挂牌标题：",@"出租价格：",@"付款方式：",@"租赁类型：",@"户型：",@"楼层：",@"最短租期：",@"最长租期：",@"可入住时间：",@"看房方式：",@"其他要求"];
}

- (void)ActionDropBtn:(UIButton *)btn{
    
    switch (btn.tag) {
        case 0:
        {
            SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:[self getDetailConfigArrByConfigState:HOUSE_TYPE]];
            WS(weakself);
            view.selectedBlock = ^(NSString *MC, NSString *ID) {
                
                
            };
            [self.view addSubview:view];
            break;
        }
        case 1:{
            
            SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:[self getDetailConfigArrByConfigState:FLOOR_TYPE]];
            WS(weakself);
            view.selectedBlock = ^(NSString *MC, NSString *ID) {
                
            };
            [self.view addSubview:view];
            break;
        }
        case 2:{
            
            DateChooseView *view = [[DateChooseView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
            WS(weakSelf);
            view.dateblock = ^(NSDate *date) {
                
                weakSelf.inTimeBtn.content.text = [weakSelf.formatter stringFromDate:date];
                weakSelf.inTimeBtn->str = [weakSelf.formatter stringFromDate:date];
            };
            [self.view addSubview:view];
            break;
        }
        case 3:{
            
            SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:[self getDetailConfigArrByConfigState:CHECK_WAY]];
            WS(weakself);
            view.selectedBlock = ^(NSString *MC, NSString *ID) {
                
                weakself.seeWayBtn.content.text = MC;
                weakself.seeWayBtn->str = [NSString stringWithFormat:@"%@", ID];
            };
            [self.view addSubview:view];
            break;
        }
        case 4:{
            

            break;
        }
        case 5:{
            

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

- (void)ActionLevelBtn:(UIButton *)btn{
    
    SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.frame WithData:[self getDetailConfigArrByConfigState:50]];
    
    SS(strongSelf);
    view.selectedBlock = ^(NSString *MC, NSString *ID) {
        
        strongSelf->_roomLevelBtn.content.text = [NSString stringWithFormat:@"%@",MC];
        strongSelf->_roomLevelBtn->str = [NSString stringWithFormat:@"%@",ID];
    };
    [self.view addSubview:view];
}

- (void)ActionNextBtn:(UIButton *)btn{
    
    if ([self isEmpty:_titleTF.textfield.text]) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请输入挂牌标题"];
        return;
    }
    if ([self isEmpty:_priceTF.textfield.text]) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请输入出租价格"];
        return;
    }
 
    _payWay = @"";
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

    if (!_seeWayBtn.content.text.length) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请看房方式"];
        return;
    }
    [self.dataDic setObject:@(1) forKey:@"type"];
    [self.dataDic setObject:@(_rentType) forKey:@"rent_type"];
    [self.dataDic setValue:_titleTF.textfield.text forKey:@"title"];
    [self.dataDic setValue:_priceTF.textfield.text forKey:@"price"];
    [self.dataDic setValue:_payWay forKey:@"receive_way"];

    if (_minPeriodBtn.content.text.length) {
        
        [self.dataDic setObject:_minPeriodBtn.content.text forKey:@"rent_min_comment"];
    }
    
    if (_maxPeriodBtn.content.text.length) {
        
        [self.dataDic setObject:_maxPeriodBtn.content.text forKey:@"rent_max_comment"];
    }
  
    [self.dataDic setValue:_seeWayBtn->str forKey:@"check_way"];
    if (![_inTimeBtn.content.text isEqualToString:@"随时入住"]) {
        
        [self.dataDic setValue:_inTimeBtn.content.text forKey:@"check_in_time"];
    }
    if (![self isEmpty:_markView.text]) {
        
        [self.dataDic setValue:_markView.text forKey:@"comment"];
    }
    
    RentingCompleteSurveyInfoVC2 *nextVC = [[RentingCompleteSurveyInfoVC2 alloc] init];
    nextVC.rentCompleteSurveyInfoVCBlock2 = ^{
        
        if (self.rentingCompleteSurveyHouseVCBlock) {
            
            self.rentingCompleteSurveyHouseVCBlock();
        }
    };
    nextVC.dic = [NSMutableDictionary dictionaryWithDictionary:self.dataDic];
    [self.navigationController pushViewController:nextVC animated:YES];
}

#pragma mark -- TextField;

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    if (textField == _priceTF.textfield) {
        
        if (!_priceTF.textfield.text) {
            
            [self alertControllerWithNsstring:@"温馨提示" And:@"请先输入出租价格" WithDefaultBlack:^{
                
                return ;
            }];
        }
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    
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
    
    _roomLevelL = [[UILabel alloc] init];
    _roomLevelL.textColor = YJTitleLabColor;
    _roomLevelL.adjustsFontSizeToFitWidth = YES;
    _roomLevelL.text = @"房源等级";
    _roomLevelL.font = [UIFont systemFontOfSize:13 *SIZE];
    [_contentView addSubview:_roomLevelL];
    
    for (int i = 0; i < 11; i++) {
        
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
                _priceL = label;
                [_contentView addSubview:_priceL];
                break;
            }
            case 2:
            {
                _payL = label;
                [_contentView addSubview:_payL];
                break;
            }
            case 3:
            {
                _rentTypeL = label;
                [_contentView addSubview:_rentTypeL];
                break;
            }
            case 4:
            {
                _houseTypeL = label;
                [_contentView addSubview:_houseTypeL];
                break;
            }
            case 5:
            {
                _floorL = label;
                [_contentView addSubview:_floorL];
                break;
            }
            case 6:
            {
                _minPeriodL = label;
                [_contentView addSubview:_minPeriodL];
                break;
            }
            case 7:
            {
                _maxPeriodL = label;
                [_contentView addSubview:_maxPeriodL];
                break;
            }
            case 8:
            {
                _inTimeL = label;
                [_contentView addSubview:_inTimeL];
                break;
            }
            case 9:
            {
                _seeWayL = label;
                [_contentView addSubview:_seeWayL];
                break;
            }
            case 10:
            {
                _markL = label;
                [_contentView addSubview:_markL];
                break;
            }
            default:
                break;
        }
    }
    
    for (int i = 0; i < 2; i++) {
        
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
                _priceTF = textField;
                _priceTF.unitL.text = @"元";
                [_contentView addSubview:_priceTF];
                break;
            }
            default:
                break;
        }
    }
    
    _roomLevelBtn = [[DropDownBtn alloc] initWithFrame:CGRectMake(81 *SIZE, 0 *SIZE, 257 *SIZE, 33 *SIZE)];
    [_roomLevelBtn addTarget:self action:@selector(ActionLevelBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_contentView addSubview:_roomLevelBtn];
    
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
                _minPeriodBtn = btn;
                [_contentView addSubview:_minPeriodBtn];
                break;
            }
            case 3:
            {
                _maxPeriodBtn = btn;
                [_contentView addSubview:_maxPeriodBtn];
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
    
    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_titleTF.mas_bottom).offset(31 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_priceTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(81 *SIZE);
        make.top.equalTo(_titleTF.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_roomLevelL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_priceTF.mas_bottom).offset(36 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(65 *SIZE);
    }];
    
    [_roomLevelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(81 *SIZE);
        make.top.equalTo(_priceTF.mas_bottom).offset(25 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_payL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_roomLevelBtn.mas_bottom).offset(31 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_payColl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(81 *SIZE);
        make.top.equalTo(_roomLevelBtn.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(_payColl.collectionViewLayout.collectionViewContentSize.height + 3 *SIZE * 20);
    }];
    
    [_rentTypeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_payColl.mas_bottom).offset(28 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_rentBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(81 *SIZE);
        make.top.equalTo(_payColl.mas_bottom).offset(23 *SIZE);
        make.width.mas_equalTo(130 *SIZE);
        make.height.mas_equalTo(20 *SIZE);
    }];
    
    [_rentBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(226 *SIZE);
        make.top.equalTo(_payColl.mas_bottom).offset(23 *SIZE);
        make.width.mas_equalTo(130 *SIZE);
        make.height.mas_equalTo(20 *SIZE);
    }];

    [_houseTypeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_rentBtn1.mas_bottom).offset(41 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_houseTypeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(81 *SIZE);
        make.top.equalTo(_rentBtn1.mas_bottom).offset(30 *SIZE);
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
    
    [_minPeriodL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_floorBtn.mas_bottom).offset(41 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_minPeriodBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(81 *SIZE);
        make.top.equalTo(_floorBtn.mas_bottom).offset(30 *SIZE);
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
    
    [_seeWayL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_maxPeriodBtn.mas_bottom).offset(41 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_seeWayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(81 *SIZE);
        make.top.equalTo(_maxPeriodBtn.mas_bottom).offset(30 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_inTimeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_seeWayBtn.mas_bottom).offset(41 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_inTimeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(81 *SIZE);
        make.top.equalTo(_seeWayBtn.mas_bottom).offset(30 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    
    
//    [_markL mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(_contentView).offset(9 *SIZE);
//        make.top.equalTo(_seeWayBtn.mas_bottom).offset(41 *SIZE);
//        make.height.mas_equalTo(12 *SIZE);
//        make.width.mas_equalTo(70 *SIZE);
//    }];
    
    [_markView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(81 *SIZE);
        make.top.equalTo(_inTimeBtn.mas_bottom).offset(30 *SIZE);
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
