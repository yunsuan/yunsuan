//
//  CompleteSurveyOfficeVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/9/13.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "CompleteSurveyOfficeVC.h"

#import "CompleteSurveyInfoVC2.h"
#import "AddEquipmentVC.h"

#import "SinglePickView.h"
//#import "CompleteSurveyStoreCollView.h"
#import "DateChooseView.h"

//#import "SingleContentCell.h"
#import "BaseFrameHeader.h"
#import "CompleteSurveyCollCell.h"
#import "StoreViewCollCell.h"
#import "BlueTitleMoreHeader.h"
#import "BaseHeader.h"

#import "BorderTF.h"
#import "DropDownBtn.h"


@interface CompleteSurveyOfficeVC ()<UIScrollViewDelegate,UITextViewDelegate,UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    
    NSString *_titleStr;
    
    NSArray *_btnArr;
    NSArray *_titleArr;
    NSMutableArray *_selectArr;
    NSArray *_payArr;
    NSInteger _propertyBelong;
    NSInteger _isMortgage;
    NSMutableArray *_dataArr;
    NSInteger _isRent;
    NSString *_payWay;
    NSString *_seeWay;
}

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) BaseFrameHeader *titleHeader;

@property (nonatomic, strong) UILabel *publicL;

@property (nonatomic, strong) DropDownBtn *publicBtn;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) BorderTF *titleTF;

@property (nonatomic, strong) UILabel *maxPriceL;

@property (nonatomic, strong) BorderTF *maxPriceTF;

@property (nonatomic, strong) UILabel *minPriceL;

@property (nonatomic, strong) BorderTF *minPriceTF;

@property (nonatomic, strong) UILabel *payL;

@property (nonatomic, strong) UILabel *roomLevelL;

@property (nonatomic, strong) DropDownBtn *roomLevelBtn;

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

@property (nonatomic, strong) UILabel *floorL;

@property (nonatomic, strong) DropDownBtn *floorBtn;

@property (nonatomic, strong) UILabel *highL;

@property (nonatomic, strong) BorderTF *highTF;

@property (nonatomic, strong) UILabel *widthL;

@property (nonatomic, strong) BorderTF *widthTF;

@property (nonatomic, strong) UILabel *certNumL;

@property (nonatomic, strong) BorderTF *cerNumTF;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) DropDownBtn *timeBtn;

@property (nonatomic, strong) UILabel *levelL;

@property (nonatomic, strong) DropDownBtn *levelBtn;

@property (nonatomic, strong) UILabel *isRentL;

@property (nonatomic, strong) DropDownBtn *isRentBtn;

@property (nonatomic, strong) UILabel *rentalL;

@property (nonatomic, strong) BorderTF *rentalTF;

@property (nonatomic, strong) UILabel *endTimeL;

@property (nonatomic, strong) DropDownBtn *endTimeLBtn;

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

@implementation CompleteSurveyOfficeVC

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
    
    _isRent = 2;
    self.formatter = [[NSDateFormatter alloc] init];
    [self.formatter setDateFormat:@"yyyy-MM-dd"];
    _dataArr = [@[] mutableCopy];
    _payArr = [self getDetailConfigArrByConfigState:13];
    _selectArr = [@[] mutableCopy];
    for (int i = 0; i < _payArr.count; i++) {
        
        [_selectArr addObject:@0];
    }
    _btnArr = @[@"共有",@"非共有",@"有",@"无"];
    _titleArr = @[@"挂牌标题：",@"挂牌价格：",@"出售底价：",@"收款方式：",@"产权所属：",@"抵押信息：",@"楼层：",@"层高：",@"门宽：",@"房屋所有权证号：",@"拿证时间：",@"级别：",@"当前出租：",@"当前佣金：",@"租约结束时间：",@"房源等级",@"公开房源："];
}

- (void)ActionDropBtn:(UIButton *)btn{
    
    switch (btn.tag) {
        case 0:
        {
            SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:[self getDetailConfigArrByConfigState:FLOOR_TYPE]];
            WS(weakself);
            view.selectedBlock = ^(NSString *MC, NSString *ID) {
                
                weakself.floorBtn.content.text = MC;
                weakself.floorBtn->str = [NSString stringWithFormat:@"%@", ID];
            };
            [self.view addSubview:view];
            break;
        }
        case 1:{
            
            DateChooseView *view = [[DateChooseView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
            __weak __typeof(&*self)weakSelf = self;
            view.dateblock = ^(NSDate *date) {
                
                weakSelf.timeBtn.content.text = [weakSelf.formatter stringFromDate:date];
            };
            [self.view addSubview:view];
            break;
        }
        case 2:{
            
            SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:[self getDetailConfigArrByConfigState:OFFICE_GRADE]];
            WS(weakself);
            view.selectedBlock = ^(NSString *MC, NSString *ID) {
                
                weakself.levelBtn.content.text = MC;
                weakself.levelBtn->str = [NSString stringWithFormat:@"%@", ID];
            };
            [self.view addSubview:view];
            break;
        }
        case 3:{
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"当前出租" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
            
            UIAlertAction *rent = [UIAlertAction actionWithTitle:@"已出租" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                self->_isRentBtn.content.text = @"已出租";
                self->_isRent = 1;
                
                self->_rentalL.hidden = NO;
                self->_rentalTF.hidden = NO;
                self->_endTimeL.hidden = NO;
                self->_endTimeLBtn.hidden = NO;
                
                [self->_isRentBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                    
                    make.left.equalTo(self->_contentView).offset(81 *SIZE);
                    make.top.equalTo(self->_levelBtn.mas_bottom).offset(30 *SIZE);
                    make.width.mas_equalTo(257 *SIZE);
                    make.height.mas_equalTo(33 *SIZE);

                }];
                
                [self->_rentalL mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.left.equalTo(self->_contentView).offset(9 *SIZE);
                    make.top.equalTo(self->_isRentBtn.mas_bottom).offset(41 *SIZE);
                    make.height.mas_equalTo(12 *SIZE);
                    make.width.mas_equalTo(70 *SIZE);
                }];
                
                [self->_rentalTF mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.left.equalTo(self->_contentView).offset(81 *SIZE);
                    make.top.equalTo(self->_isRentBtn.mas_bottom).offset(30 *SIZE);
                    make.width.mas_equalTo(257 *SIZE);
                    make.height.mas_equalTo(33 *SIZE);
                }];
                
                [self->_endTimeL mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.left.equalTo(self->_contentView).offset(9 *SIZE);
                    make.top.equalTo(self->_rentalTF.mas_bottom).offset(41 *SIZE);
                    make.height.mas_equalTo(12 *SIZE);
                    make.width.mas_equalTo(70 *SIZE);
                }];
                
                [self->_endTimeLBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.left.equalTo(self->_contentView).offset(81 *SIZE);
                    make.top.equalTo(self->_rentalTF.mas_bottom).offset(30 *SIZE);
                    make.width.mas_equalTo(257 *SIZE);
                    make.height.mas_equalTo(33 *SIZE);
                    make.bottom.equalTo(self->_contentView).offset(-31 *SIZE);
                }];
            }];
            
            UIAlertAction *noRent = [UIAlertAction actionWithTitle:@"未出租" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                self->_isRentBtn.content.text = @"未出租";
                self->_isRent = 2;
                
                self->_rentalL.hidden = YES;
                self->_rentalTF.hidden = YES;
                self->_endTimeL.hidden = YES;
                self->_endTimeLBtn.hidden = YES;
                
                [self->_isRentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.left.equalTo(self->_contentView).offset(81 *SIZE);
                    make.top.equalTo(self->_levelBtn.mas_bottom).offset(30 *SIZE);
                    make.width.mas_equalTo(257 *SIZE);
                    make.height.mas_equalTo(33 *SIZE);
                    make.bottom.equalTo(self->_contentView).offset(-31 *SIZE);
                }];
            }];
            
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
                
            }];
            
            [alert addAction:rent];
            [alert addAction:noRent];
            [alert addAction:cancel];
            [self.navigationController presentViewController:alert animated:YES completion:^{
                
            }];
            break;
        }
        case 4:{
            
            DateChooseView *view = [[DateChooseView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
            __weak __typeof(&*self)weakSelf = self;
            view.dateblock = ^(NSDate *date) {
                
                weakSelf.endTimeLBtn.content.text = [weakSelf.formatter stringFromDate:date];
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

- (void)ActionSeeWayBtn:(UIButton *)btn{
    
    SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.frame WithData:[self getDetailConfigArrByConfigState:31]];
    SS(strongSelf);
    view.selectedBlock = ^(NSString *MC, NSString *ID) {
        
        strongSelf.seeWayBtn.content.text = [NSString stringWithFormat:@"%@",MC];
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

- (void)ActionNextBtn:(UIButton *)btn{
    
    if ([self isEmpty:_titleTF.textfield.text]) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请输入挂牌标题"];
        return;
    }
    if ([self isEmpty:_maxPriceTF.textfield.text]) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请输入挂牌价格"];
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
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请选择付款方式"];
        return;
    }
    
    if (!_floorBtn.content.text.length) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请选择楼层"];
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
    
    if ([self isEmpty:_cerNumTF.textfield.text]) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请输入所有权证号"];
        return;
    }
    if (!_timeBtn.content.text.length) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请选择拿证时间"];
        return;
    }
    
    if (!_levelBtn.content.text.length) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请选择级别"];
        return;
    }
    
    if (_isRent == 1) {
        
        if ([self isEmpty:_rentalTF.textfield.text]) {
            
            [self alertControllerWithNsstring:@"温馨提示" And:@"请输入当前佣金"];
            return;
        }
        
        if (!_endTimeLBtn.content.text.length) {
            
            [self alertControllerWithNsstring:@"温馨提示" And:@"请看租约结束时间"];
            return;
        }
    }
    
    if (!_seeWay.length) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请看房方式"];
        return;
    }
    [self.dataDic setObject:@(3) forKey:@"type"];
    [self.dataDic setValue:_titleTF.textfield.text forKey:@"title"];
    [self.dataDic setValue:_maxPriceTF.textfield.text forKey:@"price"];
    [self.dataDic setValue:_roomLevelBtn->str forKey:@"level"];
    [self.dataDic setValue:_payWay forKey:@"pay_way"];
    [self.dataDic setValue:@(_propertyBelong) forKey:@"property_belong"];
    [self.dataDic setValue:@(_isMortgage) forKey:@"is_mortgage"];
    [self.dataDic setValue:_highTF.textfield.text forKey:@"office_height"];
    [self.dataDic setValue:_widthTF.textfield.text forKey:@"office_width"];
    [self.dataDic setValue:_cerNumTF.textfield.text forKey:@"permit_code"];
    [self.dataDic setValue:_timeBtn.content.text forKey:@"permit_time"];
    [self.dataDic setValue:_floorBtn->str forKey:@"floor_type"];
    [self.dataDic setValue:_levelBtn->str forKey:@"grade"];
    [self.dataDic setObject:_publicBtn->str forKey:@"hide"];
    if (_isRent == 1) {
        
        [self.dataDic setObject:@(_isRent) forKey:@"is_rent"];
        [self.dataDic setObject:_rentalTF.textfield.text forKey:@"rent_money"];
        [self.dataDic setObject:_endTimeLBtn.content.text forKey:@"rent_over_time"];
    }else{
        
        [self.dataDic setObject:@(_isRent) forKey:@"is_rent"];
    }
    [self.dataDic setValue:_seeWay forKey:@"check_way"];
    if (![self isEmpty:_minPriceTF.textfield.text]) {
        
        [self.dataDic setValue:_minPriceTF.textfield.text forKey:@"minimum"];
    }
    if (![self isEmpty:_markView.text]) {
        
        [self.dataDic setValue:_markView.text forKey:@"comment"];
    }
    if (![self isEmpty:_leftTF.textfield.text]) {
        
        [self.dataDic setValue:_leftTF.textfield.text forKey:@"left_office"];
    }
    if (![self isEmpty:_rightTF.textfield.text]) {
        
        [self.dataDic setValue:_rightTF.textfield.text forKey:@"right_office"];
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
    CompleteSurveyInfoVC2 *nextVC = [[CompleteSurveyInfoVC2 alloc] init];
    nextVC.completeSurveyInfoVCBlock2 = ^{
        
        if (self.completeSurveyOfficeBlock) {
            
            self.completeSurveyOfficeBlock();
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
    
    for (int i = 0; i < 17; i++) {
        
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
                _floorL = label;
                [_contentView addSubview:_floorL];
                break;
            }
            case 7:
            {
                _highL = label;
                [_contentView addSubview:_highL];
                break;
            }
            case 8:
            {
                _widthL = label;
                [_contentView addSubview:_widthL];
                break;
            }
            case 9:
            {
                _certNumL = label;
                [_contentView addSubview:_certNumL];
                break;
            }
            case 10:
            {
                _timeL = label;
                [_contentView addSubview:_timeL];
                break;
            }
            case 11:
            {
                _levelL = label;
                [_contentView addSubview:_levelL];
                break;
            }
            case 12:
            {
                _isRentL = label;
                [_contentView addSubview:_isRentL];
                break;
            }
            case 13:
            {
                _rentalL = label;
                [_contentView addSubview:_rentalL];
                break;
            }
            case 14:
            {
                _endTimeL = label;
                [_contentView addSubview:_endTimeL];
                break;
            }
            case 15:{
                
                _roomLevelL = label;
                [_contentView addSubview:_roomLevelL];
                break;
            }
            case 16:
            {
                _publicL = label;
                [_contentView addSubview:_publicL];
                break;
            }
            default:
                break;
        }
    }
    
    for (int i = 0; i < 7; i++) {
        
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
                textField.textfield.keyboardType = UIKeyboardTypeNumberPad;
                _cerNumTF = textField;
                [_contentView addSubview:_cerNumTF];
                break;
            }
            case 4:
            {
                textField.textfield.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
                _highTF = textField;
                _highTF.unitL.text = @"米";
                [_contentView addSubview:_highTF];
                break;
            }
            case 5:
            {
                textField.textfield.keyboardType = UIKeyboardTypeNumberPad;
                _widthTF = textField;
                _widthTF.unitL.text = @"米";
                [_contentView addSubview:_widthTF];
                break;
            }
            case 6:
            {
                textField.textfield.keyboardType = UIKeyboardTypeNumberPad;
                _rentalTF = textField;
                _rentalTF.unitL.frame = CGRectMake(_rentalTF.frame.size.width - 30*SIZE, 10 *SIZE, 25 *SIZE, 14 *SIZE);
                _rentalTF.unitL.text = @"元/月";
                [_contentView addSubview:_rentalTF];
                break;
            }
            default:
                break;
        }
    }
    
    _roomLevelBtn = [[DropDownBtn alloc] initWithFrame:CGRectMake(81 *SIZE, 436 *SIZE, 257 *SIZE, 33 *SIZE)];
    [_roomLevelBtn addTarget:self action:@selector(ActionLevelBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_contentView addSubview:_roomLevelBtn];

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
    
    for (int i = 0; i < 5; i++) {
        
        DropDownBtn *btn = [[DropDownBtn alloc] initWithFrame:CGRectMake(81 *SIZE, 0 *SIZE, 257 *SIZE, 33 *SIZE)];
        btn.tag = i;
        [btn addTarget:self action:@selector(ActionDropBtn:) forControlEvents:UIControlEventTouchUpInside];
        switch (i) {
            case 0:
            {
                _floorBtn = btn;
                [_contentView addSubview:_floorBtn];
                break;
            }
            case 1:
            {
                _timeBtn = btn;
                [_contentView addSubview:_timeBtn];
                break;
            }
            case 2:
            {
                _levelBtn = btn;
                [_contentView addSubview:_levelBtn];
                break;
            }
            case 3:
            {
                _isRentBtn = btn;
                _isRentBtn.content.text = @"未出租";
                _isRent = 2;
                [_contentView addSubview:_isRentBtn];
                break;
            }
            case 4:
            {
                _endTimeLBtn = btn;
                [_contentView addSubview:_endTimeLBtn];
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
    //    _storeCollView = [[CompleteSurveyStoreCollView alloc] init];
    //    [_scrollView addSubview:_storeCollView];
    
    _nearView = [[UIView alloc] init];
    _nearView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:_nearView];
    
    _nearHeader = [[BaseHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
    _nearHeader.titleL.text = @"左云右算";
    [_nearView addSubview:_nearHeader];
    
    NSArray *nearArr = @[@"左边公司：",@"右边公司：",@"看房方式：",@"其他要求："];
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
    [_seeWayBtn addTarget:self action:@selector(ActionSeeWayBtn:) forControlEvents:UIControlEventTouchUpInside];
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
    
    self->_rentalL.hidden = YES;
    self->_rentalTF.hidden = YES;
    self->_endTimeL.hidden = YES;
    self->_endTimeLBtn.hidden = YES;
    
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
    
    [_publicL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_contentView).offset(9 *SIZE);
        make.top.equalTo(self->_contentView).offset(58 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_publicBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_contentView).offset(81 *SIZE);
        make.top.equalTo(self->_contentView).offset(47 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_contentView).offset(9 *SIZE);
        make.top.equalTo(_publicBtn.mas_bottom).offset(35 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_titleTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_contentView).offset(81 *SIZE);
        make.top.equalTo(_publicBtn.mas_bottom).offset(25 *SIZE);
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
    
    [_minPriceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_contentView).offset(9 *SIZE);
        make.top.equalTo(self->_maxPriceTF.mas_bottom).offset(31 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_minPriceTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_contentView).offset(81 *SIZE);
        make.top.equalTo(self->_maxPriceTF.mas_bottom).offset(20 *SIZE);
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
        
        make.left.equalTo(self->_contentView).offset(9 *SIZE);
        make.top.equalTo(self->_roomLevelBtn.mas_bottom).offset(31 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_payColl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_contentView).offset(81 *SIZE);
        make.top.equalTo(self->_roomLevelBtn.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(self->_payColl.collectionViewLayout.collectionViewContentSize.height + 3 *SIZE * 20);
    }];
    
    [_propertyL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_contentView).offset(9 *SIZE);
        make.top.equalTo(self->_payColl.mas_bottom).offset(28 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_propertyBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_contentView).offset(81 *SIZE);
        make.top.equalTo(self->_payColl.mas_bottom).offset(23 *SIZE);
        make.width.mas_equalTo(130 *SIZE);
        make.height.mas_equalTo(20 *SIZE);
    }];
    
    [_propertyBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_contentView).offset(226 *SIZE);
        make.top.equalTo(self->_payColl.mas_bottom).offset(23 *SIZE);
        make.width.mas_equalTo(130 *SIZE);
        make.height.mas_equalTo(20 *SIZE);
    }];
    
    [_mortgageL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_contentView).offset(9 *SIZE);
        make.top.equalTo(self->_propertyBtn1.mas_bottom).offset(30 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_mortgageBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_contentView).offset(81 *SIZE);
        make.top.equalTo(self->_propertyBtn1.mas_bottom).offset(25 *SIZE);
        make.width.mas_equalTo(130 *SIZE);
        make.height.mas_equalTo(20 *SIZE);
    }];
    
    [_mortgageBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_contentView).offset(226 *SIZE);
        make.top.equalTo(self->_propertyBtn1.mas_bottom).offset(25 *SIZE);
        make.width.mas_equalTo(130 *SIZE);
        make.height.mas_equalTo(20 *SIZE);
    }];
    
    [_floorL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_contentView).offset(9 *SIZE);
        make.top.equalTo(self->_mortgageBtn1.mas_bottom).offset(41 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_floorBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_contentView).offset(81 *SIZE);
        make.top.equalTo(self->_mortgageBtn1.mas_bottom).offset(30 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_highL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_contentView).offset(9 *SIZE);
        make.top.equalTo(self->_floorBtn.mas_bottom).offset(41 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_highTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_contentView).offset(81 *SIZE);
        make.top.equalTo(self->_floorBtn.mas_bottom).offset(30 *SIZE);
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
    
    [_certNumL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_contentView).offset(9 *SIZE);
        make.top.equalTo(self->_widthTF.mas_bottom).offset(41 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_cerNumTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_contentView).offset(81 *SIZE);
        make.top.equalTo(self->_widthTF.mas_bottom).offset(30 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_contentView).offset(9 *SIZE);
        make.top.equalTo(self->_cerNumTF.mas_bottom).offset(41 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_timeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_contentView).offset(81 *SIZE);
        make.top.equalTo(self->_cerNumTF.mas_bottom).offset(30 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_levelL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_contentView).offset(9 *SIZE);
        make.top.equalTo(self->_timeBtn.mas_bottom).offset(41 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_levelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_contentView).offset(81 *SIZE);
        make.top.equalTo(self->_timeBtn.mas_bottom).offset(30 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_isRentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_contentView).offset(9 *SIZE);
        make.top.equalTo(self->_levelBtn.mas_bottom).offset(41 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_isRentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_contentView).offset(81 *SIZE);
        make.top.equalTo(self->_levelBtn.mas_bottom).offset(30 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
        make.bottom.equalTo(self->_contentView).offset(-31 *SIZE);
    }];
    
//    [_rentalL mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self->_contentView).offset(9 *SIZE);
//        make.top.equalTo(self->_isRentBtn.mas_bottom).offset(41 *SIZE);
//        make.height.mas_equalTo(12 *SIZE);
//        make.width.mas_equalTo(70 *SIZE);
//    }];
//
//    [_rentalTF mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self->_contentView).offset(81 *SIZE);
//        make.top.equalTo(self->_isRentBtn.mas_bottom).offset(30 *SIZE);
//        make.width.mas_equalTo(257 *SIZE);
//        make.height.mas_equalTo(33 *SIZE);
//    }];
//
//    [_endTimeL mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self->_contentView).offset(9 *SIZE);
//        make.top.equalTo(self->_rentalTF.mas_bottom).offset(41 *SIZE);
//        make.height.mas_equalTo(12 *SIZE);
//        make.width.mas_equalTo(70 *SIZE);
//    }];
//
//    [_endTimeLBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self->_contentView).offset(81 *SIZE);
//        make.top.equalTo(self->_rentalTF.mas_bottom).offset(30 *SIZE);
//        make.width.mas_equalTo(257 *SIZE);
//        make.height.mas_equalTo(33 *SIZE);
//        make.bottom.equalTo(self->_contentView).offset(-31 *SIZE);
//    }];
    
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
