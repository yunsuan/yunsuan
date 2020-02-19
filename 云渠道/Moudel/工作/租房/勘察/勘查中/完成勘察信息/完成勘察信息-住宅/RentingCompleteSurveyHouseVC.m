//
//  RentingCompleteSurveyHouseVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/12/4.
//  Copyright © 2018 xiaoq. All rights reserved.
//

#import "RentingCompleteSurveyHouseVC.h"

#import "RentingCompleteSurveyInfoVC2.h"
#import "RentingAddEquipmentVC.h"

#import "SinglePickView.h"
#import "DateChooseView.h"
#import "BlueTitleMoreHeader.h"
#import "HouseTypePickView.h"

#import "StoreViewCollCell.h"
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
    NSMutableArray *_dataArr;
    NSInteger _rentType;
    NSString *_payWay;
    
    NSArray *_periodArr;
}

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) BaseFrameHeader *titleHeader;

@property (nonatomic, strong) UILabel *publicL;

@property (nonatomic, strong) DropDownBtn *publicBtn;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) BorderTF *titleTF;

@property (nonatomic, strong) UILabel *priceL;

@property (nonatomic, strong) BorderTF *priceTF;

@property (nonatomic, strong) UILabel *depositL;

@property (nonatomic, strong) BorderTF *depositTF;

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

@property (nonatomic, strong) UILabel *decorateL;

@property (nonatomic, strong) DropDownBtn *decorateBtn;

@property (nonatomic, strong) UILabel *floorL;

@property (nonatomic, strong) DropDownBtn *floorBtn;

@property (nonatomic, strong) UILabel *liftL;

@property (nonatomic, strong) DropDownBtn *liftBtn;

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

@property (nonatomic, strong) UIView *CollView;

@property (nonatomic, strong) BlueTitleMoreHeader *collHeader;

@property (nonatomic, strong) UICollectionViewFlowLayout *facilityLayout;

@property (nonatomic, strong) UICollectionView *facilityColl;

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
    [self.formatter setDateFormat:@"yyyy-MM-dd"];
    
    _payArr = [self getDetailConfigArrByConfigState:RENT_HOUSE_RECEIVE_TYPE];
    _selectArr = [@[] mutableCopy];
    for (int i = 0; i < _payArr.count; i++) {
        
        [_selectArr addObject:@0];
    }
    _btnArr = @[@"整租",@"合租"];
    _titleArr = @[@"挂牌标题：",@"出租价格：",@"押金：",@"房源等级：",@"收款方式：",@"租赁类型：",@"户型：",@"装修：",@"楼层：",@"电梯：",@"最短租期：",@"最长租期：",@"可入住时间：",@"看房方式：",@"其他要求：",@"公开房源"];
    _periodArr = @[@{@"param":@"无限制",@"id":@"0"},
                   @{@"param":@"一天",@"id":@"1"},
                   @{@"param":@"七天",@"id":@"7"},
                   @{@"param":@"一月",@"id":@"30"},
                   @{@"param":@"二月",@"id":@"60"},
                   @{@"param":@"半年",@"id":@"180"},
                   @{@"param":@"一年",@"id":@"360"},
                   @{@"param":@"两年",@"id":@"720"}];
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
        case 1:
        {
//            SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:[self getDetailConfigArrByConfigState:HOUSE_TYPE]];
//            WS(weakself);
//            view.selectedBlock = ^(NSString *MC, NSString *ID) {
//
//                weakself.houseTypeBtn.content.text = [NSString stringWithFormat:@"%@",MC];
//                weakself.houseTypeBtn->str = [NSString stringWithFormat:@"%@",ID];
//            };
//            [self.view addSubview:view];
            HouseTypePickView *view = [[HouseTypePickView alloc] initWithFrame:self.view.bounds];// WithData:[self getDetailConfigArrByConfigState:HOUSE_TYPE]];
            WS(weakself);
            view.houseTypePickViewBlock = ^(NSString * _Nonnull room, NSString * _Nonnull hall, NSString * _Nonnull bath) {

                weakself.houseTypeBtn.content.text = [NSString stringWithFormat:@"%@室%@厅%@卫",room,hall,bath];
                weakself.houseTypeBtn->str = [NSString stringWithFormat:@"%@,%@,%@",room,hall,bath];
            };
            [self.view addSubview:view];
            break;
        }
        case 2:{
            
            SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:[self getDetailConfigArrByConfigState:DECORATE]];
            WS(weakself);
            view.selectedBlock = ^(NSString *MC, NSString *ID) {
                
                weakself.decorateBtn.content.text = [NSString stringWithFormat:@"%@",MC];
                weakself.decorateBtn->str = [NSString stringWithFormat:@"%@",ID];
            };
            [self.view addSubview:view];
            break;
        }
        case 3:{
            
            SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:[self getDetailConfigArrByConfigState:FLOOR_TYPE]];
            WS(weakself);
            view.selectedBlock = ^(NSString *MC, NSString *ID) {
                
                weakself.floorBtn.content.text = [NSString stringWithFormat:@"%@",MC];
                weakself.floorBtn->str = [NSString stringWithFormat:@"%@",ID];
            };
            [self.view addSubview:view];
            break;
        }
        case 4:{
            
//            SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:[self getDetailConfigArrByConfigState:FLOOR_TYPE]];
//            WS(weakself);
//            view.selectedBlock = ^(NSString *MC, NSString *ID) {
//
//                weakself.liftBtn.content.text = [NSString stringWithFormat:@"%@",MC];
//                weakself.liftBtn->str = [NSString stringWithFormat:@"%@",ID];
//            };
//            [self.view addSubview:view];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否有电梯" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction *liftY = [UIAlertAction actionWithTitle:@"有电梯" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                _liftBtn.content.text = @"有电梯";
                _liftBtn->str = @"1";
            }];
            UIAlertAction *liftN = [UIAlertAction actionWithTitle:@"无电梯" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                _liftBtn.content.text = @"无电梯";
                _liftBtn->str = @"0";
            }];
            [alert addAction:liftY];
            [alert addAction:liftN];
            [self.navigationController presentViewController:alert animated:YES completion:^{
                
            }];
            break;
        }
        case 5:{
            
            SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:_periodArr];
            WS(weakself);
            view.selectedBlock = ^(NSString *MC, NSString *ID) {
                
                weakself.minPeriodBtn.content.text = [NSString stringWithFormat:@"%@",MC];
                weakself.minPeriodBtn->str = [NSString stringWithFormat:@"%@",ID];
            };
            [self.view addSubview:view];
            break;
        }
        case 6:{
            
            SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:_periodArr];
            WS(weakself);
            view.selectedBlock = ^(NSString *MC, NSString *ID) {
                
                weakself.maxPeriodBtn.content.text = [NSString stringWithFormat:@"%@",MC];
                weakself.maxPeriodBtn->str = [NSString stringWithFormat:@"%@",ID];
            };
            [self.view addSubview:view];
            break;
        }
        case 7:{
            
            DateChooseView *view = [[DateChooseView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
            __weak __typeof(&*self)weakSelf = self;
            view.dateblock = ^(NSDate *date) {
                
                weakSelf.inTimeBtn.content.text = [weakSelf.formatter stringFromDate:date];
            };
            [self.view addSubview:view];
            break;
        }
        case 8:{
            
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
        NSDictionary *configdic = [UserModelArchiver unarchive].Configdic;
        NSDictionary *dic =  [configdic valueForKey:[NSString stringWithFormat:@"%d",47]];
        _rentType = [dic[@"param"][0][@"id"] integerValue];
    }else{
        
        _rentImg1.image = [UIImage imageNamed:@"default"];
        _rentImg2.image = [UIImage imageNamed:@"selected"];
        NSDictionary *configdic = [UserModelArchiver unarchive].Configdic;
        NSDictionary *dic =  [configdic valueForKey:[NSString stringWithFormat:@"%d",47]];
        _rentType = [dic[@"param"][1][@"id"] integerValue];
    }
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
    
    if ([_columnDic[@"title"] integerValue] == 1) {
        
        if ([self isEmpty:_titleTF.textfield.text]) {
        
            [self alertControllerWithNsstring:@"温馨提示" And:@"请输入挂牌标题"];
            return;
        }
    }
    if ([_columnDic[@"price"] integerValue] == 1) {
        
        if ([self isEmpty:_priceTF.textfield.text]) {
        
            [self alertControllerWithNsstring:@"温馨提示" And:@"请输入出租价格"];
            return;
        }
    }
    
    if ([_columnDic[@"minimum"] integerValue] == 1) {
        
        if ([self isEmpty:_depositTF.textfield.text]) {
        
            [self alertControllerWithNsstring:@"温馨提示" And:@"请输入押金"];
            return;
        }
    }
    
    if ([_columnDic[@"level"] integerValue] == 1) {
        
        if ([self isEmpty:_roomLevelBtn->str]) {
            
            [self alertControllerWithNsstring:@"温馨提示" And:@"请选择房源等级"];
            return;
        }
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

    if ([_columnDic[@"pay_way"] integerValue] == 1) {
        
        if (!_payWay.length) {
            
            [self alertControllerWithNsstring:@"温馨提示" And:@"请选择付款方式"];
            return;
        }
    }
    if ([_columnDic[@"house_type_id"] integerValue] == 1) {
        
        if (!_houseTypeBtn.content.text.length) {
        
            [self alertControllerWithNsstring:@"温馨提示" And:@"请选择户型"];
            return;
        }
    }
    
    
    if ([_columnDic[@"decoration"] integerValue] == 1) {
        
        if (!_decorateBtn.content.text.length) {
            
            [self alertControllerWithNsstring:@"温馨提示" And:@"请选择装修标准"];
            return;
        }
    }

    if (!_floorBtn.content.text.length) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请选择楼层信息"];
        return;
    }
    
    if ([_columnDic[@"check_in_time"] integerValue] == 1) {
    
        if (!_inTimeBtn.content.text.length) {

            [self alertControllerWithNsstring:@"温馨提示" And:@"请选择入住时间"];
            return;
        }
    }
    
    if ([_columnDic[@"check_way"] integerValue] == 1) {
        
        if (!_seeWayBtn.content.text.length) {
            
            [self alertControllerWithNsstring:@"温馨提示" And:@"请选择看房方式"];
            return;
        }
    }
    
    if ([_columnDic[@"comment"] integerValue] == 1) {
        
        if ([self isEmpty:_markView.text]) {
            
            [self alertControllerWithNsstring:@"温馨提示" And:@"请输入其他要求"];
            return;
        }
    }

    [self.dataDic setObject:@(1) forKey:@"type"];
    [self.dataDic setObject:@(_rentType) forKey:@"rent_type"];
    if (_titleTF.textfield.text.length) {
        
        [self.dataDic setValue:_titleTF.textfield.text forKey:@"title"];
    }else{
        
        [self.dataDic setValue:@" " forKey:@"title"];
    }
    
    if (_priceTF.textfield.text.length) {
        
        [self.dataDic setValue:_priceTF.textfield.text forKey:@"price"];
    }else{
        
        [self.dataDic setValue:@"0" forKey:@"price"];
    }
    if (_depositTF.textfield.text.length) {
        
        [self.dataDic setObject:_depositTF.textfield.text forKey:@"deposit"];
    }
    [self.dataDic setObject:_publicBtn->str forKey:@"hide"];
    if (_roomLevelBtn.content.text.length) {
            
        [self.dataDic setValue:_roomLevelBtn->str forKey:@"level"];
    }else{
            
    //        [self.dataDic setValue:@"0" forKey:@"price"];
    }
    
    if (_payWay.length) {
            
        [self.dataDic setValue:_payWay forKey:@"receive_way"];
    }else{
            

    }
    
    if (_houseTypeBtn.content.text.length) {
            
        [self.dataDic setValue:_houseTypeBtn->str forKey:@"house_type_id"];
    }else{
            

    }
    if (_decorateBtn.content.text.length) {
        
        [self.dataDic setObject:_decorateBtn->str forKey:@"decoration"];
    }
    
    if (_floorBtn.content.text.length) {
        
        [self.dataDic setObject:_floorBtn->str forKey:@"floor_type"];
    }
    
    if (_liftBtn.content.text.length) {
        
        [self.dataDic setObject:_liftBtn.content.text forKey:@"is_elevator"];
    }
    
    if (_minPeriodBtn.content.text.length) {
        
        [self.dataDic setObject:_minPeriodBtn.content.text forKey:@"rent_min_comment"];
    }
    
    if (_maxPeriodBtn.content.text.length) {
        
        [self.dataDic setObject:_maxPeriodBtn.content.text forKey:@"rent_max_comment"];
    }
  
    if (_seeWayBtn.content.text.length) {
            
        [self.dataDic setValue:_seeWayBtn->str forKey:@"check_way"];
    }else{
            
    //        [self.dataDic setValue:@"0" forKey:@"price"];
    }
    
    if (![_inTimeBtn.content.text isEqualToString:@"随时入住"]) {
        
        [self.dataDic setValue:_inTimeBtn.content.text forKey:@"check_in_time"];
    }
    if (![self isEmpty:_markView.text]) {
        
        [self.dataDic setValue:_markView.text forKey:@"comment"];
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
    
    if (collectionView == _payColl) {
        
        return _payArr.count;
    }else{
        
        return _dataArr.count;
    }
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
    
    for (int i = 0; i < 16; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = YJTitleLabColor;
        label.adjustsFontSizeToFitWidth = YES;
        label.text = _titleArr[i];
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        
        switch (i) {
            case 0:
            {
                _titleL = label;
                if ([_columnDic[@"title"] integerValue] == 1) {
                    
                    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"*%@",_titleL.text]];
                    [attr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
                    _titleL.attributedText = attr;
                }
                [_contentView addSubview:_titleL];
                break;
            }
            case 1:
            {
                _priceL = label;
                if ([_columnDic[@"price"] integerValue] == 1) {
                    
                    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"*%@",_priceL.text]];
                    [attr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
                    _priceL.attributedText = attr;
                }
                [_contentView addSubview:_priceL];
                break;
            }
            case 2:
            {
                _depositL = label;
                if ([_columnDic[@"minimum"] integerValue] == 1) {
                    
                    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"*%@",_depositL.text]];
                    [attr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
                    _depositL.attributedText = attr;
                }
                [_contentView addSubview:_depositL];
                break;
            }
            case 3:
            {
                _roomLevelL = label;
                if ([_columnDic[@"level"] integerValue] == 1) {
                    
                    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"*%@",_roomLevelL.text]];
                    [attr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
                    _roomLevelL.attributedText = attr;
                }
                [_contentView addSubview:_roomLevelL];
                break;
            }
            case 4:
            {
                _payL = label;
                if ([_columnDic[@"pay_way"] integerValue] == 1) {
                    
                    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"*%@",_payL.text]];
                    [attr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
                    _payL.attributedText = attr;
                }
                [_contentView addSubview:_payL];
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
                _houseTypeL = label;
                if ([_columnDic[@"house_type_id"] integerValue] == 1) {
                    
                    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"*%@",_houseTypeL.text]];
                    [attr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
                    _houseTypeL.attributedText = attr;
                }
                [_contentView addSubview:_houseTypeL];
                break;
            }
            case 7:
            {
                _decorateL = label;
                if ([_columnDic[@"decoration"] integerValue] == 1) {
                    
                    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"*%@",_decorateL.text]];
                    [attr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
                    _decorateL.attributedText = attr;
                }
                [_contentView addSubview:_decorateL];
                break;
            }
            case 8:
            {
                _floorL = label;
                [_contentView addSubview:_floorL];
                break;
            }
            case 9:
            {
                _liftL = label;
                [_contentView addSubview:_liftL];
                break;
            }
            case 10:
            {
                _minPeriodL = label;
                [_contentView addSubview:_minPeriodL];
                break;
            }
            case 11:
            {
                _maxPeriodL = label;
                [_contentView addSubview:_maxPeriodL];
                break;
            }
            case 12:
            {
                _inTimeL = label;
                if ([_columnDic[@"check_in_time"] integerValue] == 1) {
                    
                    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"*%@",_inTimeL.text]];
                    [attr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
                    _inTimeL.attributedText = attr;
                }
                [_contentView addSubview:_inTimeL];
                break;
            }
            case 13:
            {
                _seeWayL = label;
                if ([_columnDic[@"check_way"] integerValue] == 1) {
                    
                    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"*%@",_seeWayL.text]];
                    [attr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
                    _seeWayL.attributedText = attr;
                }
                [_contentView addSubview:_seeWayL];
                break;
            }
            case 14:
            {
                _markL = label;
                if ([_columnDic[@"comment"] integerValue] == 1) {
                    
                    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"*%@",_markL.text]];
                    [attr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
                    _markL.attributedText = attr;
                }
                [_contentView addSubview:_markL];
                break;
            }
            case 15:
            {
                _publicL = label;
                [_contentView addSubview:_publicL];
                break;
            }
            default:
                break;
        }
    }
    
    for (int i = 0; i < 3; i++) {
        
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
                _priceTF.unitL.text = @"元/月";
                [_contentView addSubview:_priceTF];
                break;
            }
            case 2:
            {
                textField.textfield.keyboardType = UIKeyboardTypeNumberPad;
                _depositTF = textField;
                _depositTF.unitL.text = @"元";
                [_contentView addSubview:_depositTF];
                break;
            }
            default:
                break;
        }
    }
    
//    _roomLevelBtn = [[DropDownBtn alloc] initWithFrame:CGRectMake(81 *SIZE, 0 *SIZE, 257 *SIZE, 33 *SIZE)];
//    [_roomLevelBtn addTarget:self action:@selector(ActionLevelBtn:) forControlEvents:UIControlEventTouchUpInside];
//    [_contentView addSubview:_roomLevelBtn];
    
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
    
    for (int i = 0; i < 9; i++) {
        
        DropDownBtn *btn = [[DropDownBtn alloc] initWithFrame:CGRectMake(81 *SIZE, 0 *SIZE, 257 *SIZE, 33 *SIZE)];
        btn.tag = i;
        [btn addTarget:self action:@selector(ActionDropBtn:) forControlEvents:UIControlEventTouchUpInside];
        switch (i) {
            case 0:{
                
                _roomLevelBtn = btn;
//                [_roomLevelBtn addTarget:self action:@selector(ActionLevelBtn:) forControlEvents:UIControlEventTouchUpInside];
                [_contentView addSubview:_roomLevelBtn];
            }
            case 1:
            {
                _houseTypeBtn = btn;
                [_contentView addSubview:_houseTypeBtn];
                break;
            }
            case 2:
            {
                _decorateBtn = btn;
                [_contentView addSubview:_decorateBtn];
                break;
            }
            case 3:
            {
                _floorBtn = btn;
                [_contentView addSubview:_floorBtn];
                break;
            }
            case 4:
            {
                _liftBtn = btn;
                [_contentView addSubview:_liftBtn];
                break;
            }
            case 5:
            {
                _minPeriodBtn = btn;
                _minPeriodBtn.content.text = @"无限制";
                [_contentView addSubview:_minPeriodBtn];
                break;
            }
            case 6:
            {
                _maxPeriodBtn = btn;
                _maxPeriodBtn.content.text = @"无限制";
                [_contentView addSubview:_maxPeriodBtn];
                break;
            }
            case 7:
            {
                _inTimeBtn = btn;
                _inTimeBtn.content.text = @"随时入住";
                [_contentView addSubview:_inTimeBtn];
                break;
            }
            case 8:
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
    NSDictionary *configdic = [UserModelArchiver unarchive].Configdic;
    NSDictionary *dic =  [configdic valueForKey:[NSString stringWithFormat:@"%d",47]];
    _rentType = [dic[@"param"][0][@"id"] integerValue];

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
        
        RentingAddEquipmentVC *nextVC = [[RentingAddEquipmentVC alloc] initWithType:1];
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
    
    [_publicL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_contentView).offset(58 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_publicBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(81 *SIZE);
        make.top.equalTo(_contentView).offset(47 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_publicBtn.mas_bottom).offset(35 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_titleTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(81 *SIZE);
        make.top.equalTo(_publicBtn.mas_bottom).offset(25 *SIZE);
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
    
    [_depositL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_priceTF.mas_bottom).offset(31 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_depositTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(81 *SIZE);
        make.top.equalTo(_priceTF.mas_bottom).offset(20 *SIZE);
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
    
    [_decorateL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_houseTypeBtn.mas_bottom).offset(41 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_decorateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(81 *SIZE);
        make.top.equalTo(_houseTypeBtn.mas_bottom).offset(30 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_floorL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_decorateBtn.mas_bottom).offset(41 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_floorBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(81 *SIZE);
        make.top.equalTo(_decorateBtn.mas_bottom).offset(30 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_liftL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_floorBtn.mas_bottom).offset(41 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_liftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(81 *SIZE);
        make.top.equalTo(_floorBtn.mas_bottom).offset(30 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_minPeriodL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_liftBtn.mas_bottom).offset(41 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_minPeriodBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(81 *SIZE);
        make.top.equalTo(_liftBtn.mas_bottom).offset(30 *SIZE);
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
    
    [_inTimeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_maxPeriodBtn.mas_bottom).offset(41 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_inTimeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(81 *SIZE);
        make.top.equalTo(_maxPeriodBtn.mas_bottom).offset(30 *SIZE);
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
    
    [_nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrollView).offset(22 *SIZE);
        make.top.equalTo(_CollView.mas_bottom).offset(28 *SIZE);
        make.width.equalTo(@(317 *SIZE));
        make.height.equalTo(@(40 *SIZE));
        make.bottom.equalTo(_scrollView.mas_bottom).offset(-19 *SIZE);
    }];
}

@end
