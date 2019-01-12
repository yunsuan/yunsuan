//
//  MaintainAddFollowVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/6/20.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "MaintainAddFollowVC.h"

#import "CompleteSurveyCollCell.h"

#import "SinglePickView.h"
#import "DateChooseView.h"
#import "BorderTF.h"
#import "DropDownBtn.h"

@interface MaintainAddFollowVC ()<UIScrollViewDelegate,UITextViewDelegate,UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    
    NSString *_houseId;
    NSArray *_titleArr;
    NSArray *_followArr;
    NSArray *_payArr;
    NSMutableArray *_selectArr;
    NSMutableArray *_selectArr2;
    NSString *_seeWay;
    NSInteger _follow;
    NSString *_followTime;
    NSMutableDictionary *_dataDic;
    NSString *_payWay;
}
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UILabel *publicL;

@property (nonatomic, strong) DropDownBtn *publicBtn;

@property (nonatomic, strong) UILabel *wayL;

@property (nonatomic, strong) UICollectionView *wayColl;

@property (nonatomic, strong) UICollectionViewFlowLayout *layout;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) BorderTF *titleTF;

@property (nonatomic, strong) UILabel *seeWayL;

@property (nonatomic, strong) DropDownBtn *seeWayBtn;

@property (nonatomic, strong) UILabel *priceL;

@property (nonatomic, strong) BorderTF *priceTF;

@property (nonatomic, strong) UILabel *minPriceL;

@property (nonatomic, strong) BorderTF *minPriceTF;

@property (nonatomic, strong) UILabel *roomLevelL;

@property (nonatomic, strong) DropDownBtn *roomLevelBtn;

@property (nonatomic, strong) UILabel *payL;

@property (nonatomic, strong) UICollectionView *payColl;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) UILabel *intentL;

@property (nonatomic, strong) BorderTF *intentTF;

@property (nonatomic, strong) UISlider *intentSlider;

@property (nonatomic, strong) UILabel *urgentL;

@property (nonatomic, strong) BorderTF *urgentTF;

@property (nonatomic, strong) UISlider *urgentSlider;

@property (nonatomic, strong) UILabel *contentL;

@property (nonatomic, strong) UIView *timeView;

@property (nonatomic, strong) UITextView *markTV;

@property (nonatomic, strong) UILabel *nextTimeL;

@property (nonatomic, strong) DropDownBtn *timeBtn;

@property (nonatomic, strong) NSDateFormatter *formatter;

@property (nonatomic, strong) UIButton *nextBtn;
@end

@implementation MaintainAddFollowVC

- (instancetype)initWithHouseId:(NSString *)houseId dataDic:(NSDictionary *)dataDic
{
    self = [super init];
    if (self) {
        
        _houseId = houseId;
        _dataDic = [NSMutableDictionary dictionaryWithDictionary:dataDic];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
    _followArr = [self getDetailConfigArrByConfigState:23];
    _selectArr = [@[] mutableCopy];
    for (int i = 0; i < _followArr.count; i++) {
        
        [_selectArr addObject:@0];
    }
    _payArr = [self
               getDetailConfigArrByConfigState:13];
    _selectArr2 = [@[] mutableCopy];
    for (int i = 0; i < _payArr.count; i++) {
        
        [_selectArr2 addObject:@0];
    }
    
    for (int i = 0; i < _payArr.count; i++) {
        
        for (int j = 0; j < [_dataDic[@"pay_way"] count]; j++) {
            
            if ([_dataDic[@"pay_way"][j] isEqualToString:_payArr[i][@"param"]]) {
                
                [_selectArr2 replaceObjectAtIndex:i withObject:@1];
            }
        }
    }
    
    NSDate *date = [NSDate date];
    _formatter = [[NSDateFormatter alloc] init];
    [_formatter setDateFormat:@"YYYY/MM/dd HH:mm"];
    _followTime = [_formatter stringFromDate:date];
    _titleArr = @[[NSString stringWithFormat:@"跟进时间:%@",_followTime],@"跟进方式：",@"公开房源：",@"挂牌标题:",@"看房方式",@"挂牌价格",@"出售底价",@"收款方式",@"卖房意愿度",@"卖房紧急度",@"房源等级"];
}


#pragma mark -- ActionMethod --

- (void)ActionSeeWayBtn:(UIButton *)btn{
    
    SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.frame WithData:[self getDetailConfigArrByConfigState:31]];
    
    SS(strongSelf);
    view.selectedBlock = ^(NSString *MC, NSString *ID) {
        
        strongSelf->_seeWayBtn.content.text = [NSString stringWithFormat:@"%@",MC];
        strongSelf->_seeWay = [NSString stringWithFormat:@"%@",ID];
    };
    [self.view addSubview:view];
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

- (void)ActionPublicBtn:(UIButton *)btn{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否公开房源" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *pub = [UIAlertAction actionWithTitle:@"公开" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        _publicBtn.content.text = @"公开";
        _publicBtn->str = @"0";
    }];
    
    UIAlertAction *private = [UIAlertAction actionWithTitle:@"不公开" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        _publicBtn.content.text = @"不公开";
        _publicBtn->str = @"1";
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
//        _publicBtn.content.text = @"否";
    }];
    
    [alert addAction:pub];
    [alert addAction:private];
    [alert addAction:cancel];
    
    [self.navigationController presentViewController:alert animated:YES completion:nil];
}

- (void)ActionTimeBtn:(UIButton *)btn{
    
    DateChooseView *view = [[DateChooseView alloc] initWithFrame:self.view.frame];
    view.dateblock = ^(NSDate *date) {
        
        _timeBtn.content.text = [_formatter stringFromDate:date];
    };
    [self.view addSubview:view];
}

- (void)ActionNextBtn:(UIButton *)btn{
    

//    if ([self isEmpty:_titleL.text]) {
//
//        [self alertControllerWithNsstring:@"温馨提示" And:@"请填写挂牌标题"];
//        return;
//    }
    
    
    if ([self isEmpty:_titleL.text]) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请填写挂牌标题"];
        return;
    }
    
    if (!_seeWay.length) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请选择看房方式"];
        return;
    }
    
    if ([self isEmpty:_priceTF.textfield.text]) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请填写挂牌价格"];
        return;
    }
    
    if ([self isEmpty:_minPriceTF.textfield.text]) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请填写出售底价"];
        return;
    }
    
    if ([self isEmpty:_roomLevelBtn->str]) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请选择房源等级"];
        return;
    }
    
    _payWay = @"";
    for (int i = 0; i < _selectArr2.count; i++) {
        
        if ([_selectArr2[i] integerValue] == 1) {
            
            if (!_payWay.length) {
                
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
    
    if ([self isEmpty:_intentTF.textfield.text]) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请填写卖房意愿度"];
        return;
    }
    
    if ([self isEmpty:_urgentTF.textfield.text]) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请填写卖房紧急度"];
        return;
    }
    
    if ([self isEmpty:_markTV.text]) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请填写跟进内容"];
        return;
    }
    
    if (!_timeBtn.content.text.length) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请选择下次回访时间"];
        return;
    }
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"house_id":_houseId,
                                                                               @"follow_time":_followTime,
                                                                               @"follow_type":@([_followArr[_follow][@"id"] integerValue]),
                                                                               @"title":_titleTF.textfield.text,
                                                            @"hide":_publicBtn->str,                @"intent":_intentTF.textfield.text,
                                                                               @"urgency":_urgentTF.textfield.text,
                                                                               @"check_way":_seeWay,
                                                                               @"price":_priceTF.textfield.text,
                                                                               @"minimum":_minPriceTF.textfield.text,
                                                                               @"level":_roomLevelBtn->str,
                                                                               @"pay_way":_payWay,
                                                                               @"comment":_markTV.text,
                                                                               @"next_visit_time":_timeBtn.content.text
                                                                               }];
    
    [BaseRequest POST:HouseSurveyAddFollow_URL parameters:dic success:^(id resposeObject) {

        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [self alertControllerWithNsstring:@"温馨提示" And:@"添加跟进记录成功" WithDefaultBlack:^{
               
                if (self.maintainAddFollowVCBlock) {
                    
                    self.maintainAddFollowVCBlock();
                }
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {

        NSLog(@"%@",error);
        [self showContent:@"网络错误"];
    }];
}

- (void)ActionSliderChange:(UISlider *)slider{
    
    if (slider == _intentSlider) {
        
        _intentTF.textfield.text = [NSString stringWithFormat:@"%.0f",slider.value];
    }else{
        
        _urgentTF.textfield.text = [NSString stringWithFormat:@"%.0f",slider.value];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (textField == _minPriceTF.textfield) {
        
        if ([_minPriceTF.textfield.text integerValue] > [_priceTF.textfield.text integerValue]) {
            
            [self alertControllerWithNsstring:@"温馨提示" And:@"出售底价不能超过挂牌价格" WithDefaultBlack:^{
                
                _minPriceTF.textfield.text = self->_priceTF.textfield.text;
                [_minPriceTF.textfield becomeFirstResponder];
                return ;
            }];
        }
    }
    
    if (textField == _intentTF.textfield) {
        
        if ([_intentTF.textfield.text integerValue] > 100) {
            
            _intentTF.textfield.text = @"100";
        }
        _intentTF.textfield.text = [NSString stringWithFormat:@"%ld",[_intentTF.textfield.text integerValue]];
        _intentSlider.value =  [_intentTF.textfield.text floatValue] / 100.0 * 100;
    }else if (textField == _urgentTF.textfield){
        
        if ([_urgentTF.textfield.text integerValue] > 100) {
            
            _urgentTF.textfield.text = @"100";
        }
        _urgentTF.textfield.text = [NSString stringWithFormat:@"%ld",[_urgentTF.textfield.text integerValue]];
        _urgentSlider.value =  [_urgentTF.textfield.text floatValue] / 100.0 * 100;
    }
    if (textField == _minPriceTF.textfield) {
        
        if ([_minPriceTF.textfield.text integerValue] > [_priceTF.textfield.text integerValue]) {
            
            [self alertControllerWithNsstring:@"温馨提示" And:@"最低价格不能超过p挂牌价格" WithDefaultBlack:^{
                
                return ;
            }];
        }
    }
}

#pragma mark -- TextField;

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    if (textField == _minPriceTF.textfield) {
        
        if ([self isEmpty:_priceTF.textfield.text]) {
            
            [self alertControllerWithNsstring:@"温馨提示" And:@"请先输入挂牌价格" WithDefaultBlack:^{
                
                return ;
            }];
        }
    }
}

#pragma mark -- collection

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (collectionView == _wayColl) {
        
        return _followArr.count;
    }
    return _payArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (collectionView == _wayColl) {
        
        CompleteSurveyCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"wayColl" forIndexPath:indexPath];
        if (!cell) {
            
            cell = [[CompleteSurveyCollCell alloc] initWithFrame:CGRectMake(0, 0, 130 *SIZE, 20 *SIZE)];
        }
        
        cell.tag = 1;
        cell.selectImg.image = [UIImage imageNamed:@"default"];
        [cell setIsSelect:[_selectArr[indexPath.item] integerValue]];
        
        cell.titleL.text = _followArr[indexPath.item][@"param"];
//        cell.titleL.text = @"QQ";
        
        return cell;
    }else{
        
        CompleteSurveyCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CompleteSurveyCollCell" forIndexPath:indexPath];
        if (!cell) {
            
            cell = [[CompleteSurveyCollCell alloc] initWithFrame:CGRectMake(0, 0, 130 *SIZE, 20 *SIZE)];
        }
        
        cell.titleL.text = _payArr[indexPath.item][@"param"];
        cell.tag = 0;
        [cell setIsSelect:[_selectArr2[indexPath.item] integerValue]];
        
        return cell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (collectionView == _wayColl) {
        
        for (int i = 0; i < _selectArr.count; i++) {
            
            [_selectArr replaceObjectAtIndex:i withObject:@0];
        }
        _follow = indexPath.item;
        [_selectArr replaceObjectAtIndex:indexPath.item withObject:@1];
        [collectionView reloadData];
    }else{
        
        if ([_selectArr2[indexPath.item] integerValue]) {
            
            [_selectArr2 replaceObjectAtIndex:indexPath.item withObject:@0];
        }else{
            
            [_selectArr2 replaceObjectAtIndex:indexPath.item withObject:@1];
        }
        [collectionView reloadData];
    }
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"跟进记录";
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.backgroundColor = self.view.backgroundColor;
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    
    _contentView = [[UIView alloc] init];
    _contentView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:_contentView];
    
    for (int i = 0; i < 11; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = YJTitleLabColor;
        label.adjustsFontSizeToFitWidth = YES;
        label.text = _titleArr[i];
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        
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
                _publicL = label;
                [_contentView addSubview:_publicL];
                break;
            }
            case 3:
            {
                _titleL = label;
                [_contentView addSubview:_titleL];
                break;
            }
            case 4:
            {
                _seeWayL = label;
                [_contentView addSubview:_seeWayL];
                break;
            }
            case 5:
            {
                _priceL = label;
                [_contentView addSubview:_priceL];
                break;
            }
            case 6:
            {
                _minPriceL = label;
                [_contentView addSubview:_minPriceL];
                break;
            }
            case 7:
            {
                _payL = label;
                [_contentView addSubview:_payL];
                break;
            }
            case 8:
            {
                _intentL = label;
                [_contentView addSubview:_intentL];
                break;
            }
            case 9:
            {
                _urgentL = label;
                [_contentView addSubview:_urgentL];
                break;
            }
            case 10:
            {
                _roomLevelL = label;
                [_contentView addSubview:_roomLevelL];
                break;
            }
            default:
                break;
        }
    }
    
    for (int i = 0; i < 5; i++) {
        
        BorderTF *textField = [[BorderTF alloc] initWithFrame:CGRectMake(81 *SIZE, 47 *SIZE, 257 *SIZE, 33 *SIZE)];
        textField.textfield.delegate = self;
        switch (i) {
            case 0:
            {
                _titleTF = textField;
                if (_dataDic.count) {
                    
                    _titleTF.textfield.text = _dataDic[@"title"];
                }
                [_contentView addSubview:_titleTF];
                break;
            }
            case 1:
            {
                textField.unitL.text = @"万";
                _minPriceTF = textField;
                if (_dataDic.count) {
                    
                    _minPriceTF.textfield.text = _dataDic[@"minimum"];
                }
                [_contentView addSubview:_minPriceTF];
                break;
            }
            case 2:
            {
                textField.unitL.text = @"万";
                _priceTF = textField;
                if (_dataDic.count) {
                    
                    _priceTF.textfield.text = _dataDic[@"price"];
                }
                [_contentView addSubview:_priceTF];
                break;
            }
            case 3:
            {
                _intentTF = textField;
                if (_dataDic.count) {
                    
                    _intentTF.textfield.text = _dataDic[@"intent"];
                }
                [_contentView addSubview:_intentTF];
                break;
            }
            case 4:
            {
                _urgentTF = textField;
                if (_dataDic.count) {
                    
                    _urgentTF.textfield.text = _dataDic[@"urgency"];
                }
                [_contentView addSubview:_urgentTF];
                break;
            }
            default:
                break;
        }
    }
    
    _publicBtn = [[DropDownBtn alloc] initWithFrame:CGRectMake(81 *SIZE, 436 *SIZE, 257 *SIZE, 33 *SIZE)];
    [_publicBtn addTarget:self action:@selector(ActionPublicBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_contentView addSubview:_publicBtn];
    if (_dataDic.count) {
        
        if ([_dataDic[@"hides"] integerValue] == 1) {
            
            _publicBtn.content.text = @"不公开";
            _publicBtn->str = @"1";
        }else{
            
            _publicBtn.content.text = @"公开";
            _publicBtn->str = @"0";
        }
    }
    
    _seeWayBtn = [[DropDownBtn alloc] initWithFrame:CGRectMake(81 *SIZE, 436 *SIZE, 257 *SIZE, 33 *SIZE)];
    [_seeWayBtn addTarget:self action:@selector(ActionSeeWayBtn:) forControlEvents:UIControlEventTouchUpInside];
    if (_dataDic.count) {
        
        NSArray *arr = [self getDetailConfigArrByConfigState:31];
        for (int i = 0; i < arr.count; i++) {
            
            if ([_dataDic[@"check_way"] isEqualToString:arr[i][@"param"]]) {
                
                _seeWay = [NSString stringWithFormat:@"%@",arr[i][@"id"]];
            }
        }
        _seeWayBtn.content.text = _dataDic[@"check_way"];
    }
    [_contentView addSubview:_seeWayBtn];
    
    _roomLevelBtn = [[DropDownBtn alloc] initWithFrame:CGRectMake(81 *SIZE, 436 *SIZE, 257 *SIZE, 33 *SIZE)];
    [_roomLevelBtn addTarget:self action:@selector(ActionLevelBtn:) forControlEvents:UIControlEventTouchUpInside];
    if (_dataDic.count) {
        
        NSArray *arr = [self getDetailConfigArrByConfigState:50];
        for (int i = 0; i < arr.count; i++) {
            
            if ([_dataDic[@"level"] isEqualToString:arr[i][@"param"]]) {

                _roomLevelBtn->str = [NSString stringWithFormat:@"%@",arr[i][@"id"]];
            }
        }
        _roomLevelBtn.content.text = _dataDic[@"level"];
    }
    [_contentView addSubview:_roomLevelBtn];
    
    
    for (int i = 0; i < 2; i++) {
        
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
            
            _intentSlider = slider;
            if (_dataDic.count) {
                
                [_intentSlider setValue:[_dataDic[@"intent"] integerValue]];
            }
            [_contentView addSubview:_intentSlider];
        }else{
            
            _urgentSlider = slider;
            if (_dataDic.count) {
                
                [_urgentSlider setValue:[_dataDic[@"urgency"] integerValue]];
            }
            [_contentView addSubview:_urgentSlider];
        }
    }
    
    _layout = [[UICollectionViewFlowLayout alloc] init];
    _layout.estimatedItemSize = CGSizeMake(120 *SIZE, 20 *SIZE);
    _layout.minimumLineSpacing = 20 *SIZE;
    _layout.minimumInteritemSpacing = 0;
    //    _flowLayout.itemSize = CGSizeMake(140 *SIZE, 20 *SIZE);
    
    _wayColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 100 *SIZE) collectionViewLayout:_layout];
    _wayColl.backgroundColor = [UIColor whiteColor];
    _wayColl.allowsMultipleSelection = NO;
    _wayColl.delegate = self;
    _wayColl.dataSource = self;
    [_wayColl registerClass:[CompleteSurveyCollCell class] forCellWithReuseIdentifier:@"wayColl"];
    [_contentView addSubview:_wayColl];
    

    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.estimatedItemSize = CGSizeMake(120 *SIZE, 20 *SIZE);
    _flowLayout.minimumLineSpacing = 20 *SIZE;
    _flowLayout.minimumInteritemSpacing = 0;
    //    _flowLayout.itemSize = CGSizeMake(140 *SIZE, 20 *SIZE);
    
    _payColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 100 *SIZE) collectionViewLayout:_flowLayout];
    _payColl.backgroundColor = [UIColor whiteColor];
    _payColl.allowsMultipleSelection = YES;
    _payColl.delegate = self;
    _payColl.dataSource = self;
    [_payColl registerClass:[CompleteSurveyCollCell class] forCellWithReuseIdentifier:@"CompleteSurveyCollCell"];
    [_contentView addSubview:_payColl];
    
    _contentL = [[UILabel alloc] init];
    _contentL.textColor = YJTitleLabColor;
    _contentL.font = [UIFont systemFontOfSize:13 *SIZE];
    _contentL.text = @"跟进内容：";
    [_scrollView addSubview:_contentL];
    
    _timeView = [[UIView alloc] init];
    _timeView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:_timeView];
    
    _markTV = [[UITextView alloc] init];
    _markTV.delegate = self;
    if (_dataDic.count) {
        
        _markTV.text = _dataDic[@"comment"];
    }
    [_timeView addSubview:_markTV];
    
    _nextTimeL = [[UILabel alloc] init];
    _nextTimeL.textColor = YJTitleLabColor;
    _nextTimeL.adjustsFontSizeToFitWidth = YES;
    _nextTimeL.text = @"下次回访时间:";
    _nextTimeL.font = [UIFont systemFontOfSize:13 *SIZE];
    [_timeView addSubview:_nextTimeL];
    
    _timeBtn = [[DropDownBtn alloc] initWithFrame:CGRectMake(79 *SIZE, 142 *SIZE, 258 *SIZE, 33 *SIZE)];
    [_timeBtn addTarget:self action:@selector(ActionTimeBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_timeView addSubview:_timeBtn];
    
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
//        make.bottom.equalTo(_nextBtn.mas_top).offset(-28 *SIZE);
    }];
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_contentView).offset(15 *SIZE);
        make.right.equalTo(_contentView).offset(-15 *SIZE);
    }];
    
    [_wayL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_timeL.mas_bottom).offset(22 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(65 *SIZE);
    }];
    
    [_wayColl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(81 *SIZE);
        make.top.equalTo(_timeL.mas_bottom).offset(22 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(_wayColl.collectionViewLayout.collectionViewContentSize.height + 3 *SIZE * 20);
    }];
    
    [_publicL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_wayColl.mas_bottom).offset(35 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(65 *SIZE);
    }];
    
    [_publicBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(81 *SIZE);
        make.top.equalTo(_wayColl.mas_bottom).offset(25 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_publicBtn.mas_bottom).offset(35 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(65 *SIZE);
    }];
    
    [_titleTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(81 *SIZE);
        make.top.equalTo(_publicBtn.mas_bottom).offset(25 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];

    [_seeWayL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_titleTF.mas_bottom).offset(36 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(65 *SIZE);
    }];
    
    [_seeWayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(81 *SIZE);
        make.top.equalTo(_titleTF.mas_bottom).offset(25 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_seeWayBtn.mas_bottom).offset(36 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(65 *SIZE);
    }];
    
    [_priceTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(81 *SIZE);
        make.top.equalTo(_seeWayBtn.mas_bottom).offset(25 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_minPriceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_priceTF.mas_bottom).offset(36 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(65 *SIZE);
    }];
    
    [_minPriceTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(81 *SIZE);
        make.top.equalTo(_priceTF.mas_bottom).offset(25 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_roomLevelL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_minPriceTF.mas_bottom).offset(36 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(65 *SIZE);
    }];
    
    [_roomLevelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(81 *SIZE);
        make.top.equalTo(_minPriceTF.mas_bottom).offset(25 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_payL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_roomLevelBtn.mas_bottom).offset(33 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(65 *SIZE);
    }];
    
    [_payColl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(81 *SIZE);
        make.top.equalTo(_roomLevelBtn.mas_bottom).offset(33 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(_payColl.collectionViewLayout.collectionViewContentSize.height + 3 *SIZE * 20);
    }];
    
    
    [_intentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_payColl.mas_bottom).offset(32 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(65 *SIZE);
    }];
    
    [_intentTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(81 *SIZE);
        make.top.equalTo(_payColl.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_intentSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(30 *SIZE);
        make.top.equalTo(_intentTF.mas_bottom).offset(24 *SIZE);
        make.width.equalTo(@(300 *SIZE));
        make.height.equalTo(@(5 *SIZE));
    }];
    
    [_urgentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_intentSlider.mas_bottom).offset(40 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(65 *SIZE);
    }];
    
    [_urgentTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(81 *SIZE);
        make.top.equalTo(_intentSlider.mas_bottom).offset(28 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_urgentSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(30 *SIZE);
        make.top.equalTo(_urgentTF.mas_bottom).offset(24 *SIZE);
        make.width.equalTo(@(300 *SIZE));
        make.height.equalTo(@(5 *SIZE));
        make.bottom.equalTo(_contentView.mas_bottom).offset(-25 *SIZE);
    }];
    
    [_contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrollView).offset(10 *SIZE);
        make.top.equalTo(_contentView.mas_bottom).offset(12 *SIZE);
        make.right.equalTo(_scrollView).offset(-10 *SIZE);
    }];
    
    [_timeView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrollView).offset(0 *SIZE);
        make.top.equalTo(_contentView.mas_bottom).offset(31 *SIZE);
        make.width.equalTo(@(360 *SIZE));
        make.height.equalTo(@(189 *SIZE));
    }];
    
    [_markTV mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(_timeView).offset(0 *SIZE);
        make.top.equalTo(_timeView).offset(0 *SIZE);
        make.width.equalTo(@(360 *SIZE));
        make.height.equalTo(@(117 *SIZE));
    }];
    
    [_nextTimeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_timeView).offset(9 *SIZE);
        make.top.equalTo(_timeView).offset(154 *SIZE);
        make.width.equalTo(@(70 *SIZE));
        make.height.equalTo(@(10 *SIZE));
    }];
    
    [_timeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_timeView).offset(79 *SIZE);
        make.top.equalTo(_timeView).offset(142 *SIZE);
        make.width.equalTo(@(258 *SIZE));
        make.height.equalTo(@(33 *SIZE));
    }];
    
    [_nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrollView).offset(22 *SIZE);
        make.top.equalTo(_timeView.mas_bottom).offset(28 *SIZE);
        make.width.equalTo(@(317 *SIZE));
        make.height.equalTo(@(40 *SIZE));
        make.bottom.equalTo(_scrollView.mas_bottom).offset(-19 *SIZE);
    }];
}

@end
