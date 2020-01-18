//
//  LookMaintainDetailAddFollowVC.m
//  云渠道
//
//  Created by 谷治墙 on 2019/1/25.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "LookMaintainDetailAddFollowVC.h"

#import "AddEquipmentVC.h"
#import "AddTagVC.h"
#import "LookMaintainDetailAddAppointVC.h"
#import "LookMaintainVC.h"

#import "SinglePickView.h"
#import "DateChooseView.h"
#import "AddTagView.h"
#import "HouseTypePickView.h"

#import "DropDownBtn.h"
#import "BorderTF.h"
#import "TTRangeSlider.h"

#import "LookMaintainDetailAddFollowCell.h"
#import "CompleteSurveyCollCell.h"
#import "BlueTitleMoreHeader.h"
#import "StoreViewCollCell.h"

@interface LookMaintainDetailAddFollowVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate,TTRangeSliderDelegate>
{
    
    NSInteger _way;
    NSInteger _level;
    
    
    NSString *_takeId;
    NSString *_payWay;
    NSString *_store;
    
    NSDictionary *_dataDic;
    
    NSArray *_wayArr;
    NSArray *_levelArr;
    NSArray *_payArr;
    NSMutableArray *_paySelectArr;
    NSMutableArray *_dataArr;
    NSMutableArray *_stairArr;
//    NSMutableArray *_houseArr1;
//    NSMutableArray *_houseArr2;
//    NSMutableArray *_houseArr3;
    NSArray *_storeArr;
    NSMutableArray *_selectStoreArr;
}
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UILabel *timeContentL;

@property (nonatomic, strong) UILabel *wayL;

@property (nonatomic, strong) UICollectionViewFlowLayout *wayFlowLayout;

@property (nonatomic, strong) UICollectionView *wayColl;

@property (nonatomic, strong) UILabel *levelL;

@property (nonatomic, strong) DropDownBtn *levelBtn;

@property (nonatomic, strong) UILabel *typeL;

@property (nonatomic, strong) DropDownBtn *typeBtn;

@property (nonatomic, strong) UILabel *priceL;

@property (nonatomic, strong) TTRangeSlider *priceBtn;

@property (nonatomic, strong) UILabel *areaL;

@property (nonatomic, strong) TTRangeSlider *areaBtn;

@property (nonatomic, strong) UILabel *purposeL;

@property (nonatomic, strong) DropDownBtn *purposeBtn;//置业目的、购买用途

@property (nonatomic, strong) UILabel *payWayL;

@property (nonatomic, strong) UICollectionViewFlowLayout *payFlowLayout;

@property (nonatomic, strong) UICollectionView *payColl;//付款方式

@property (nonatomic, strong) UIView *followView;

@property (nonatomic, strong) UILabel *contentL;

@property (nonatomic, strong) UITextView *contentTV;

@property (nonatomic, strong) UILabel *nextTimeL;

@property (nonatomic, strong) DropDownBtn *nextTimeBtn;

@property (nonatomic, strong) UIButton *commitBtn;

@property (nonatomic, strong) NSDateFormatter *formatter;

//写字楼

@property (nonatomic, strong) UILabel *yearL;

@property (nonatomic, strong) BorderTF *yearTF;//使用年限

@property (nonatomic, strong) UILabel *officeLevelL;

@property (nonatomic, strong) DropDownBtn *officeLevelBtn;//写字楼等级

//商铺
@property (nonatomic, strong) UILabel *commercialL;

@property (nonatomic, strong) UICollectionView *comercialColl;

@property (nonatomic, strong) UICollectionViewFlowLayout *comercialFlowLayout;//商铺类型

@property (nonatomic, strong) UIView *CollView;

@property (nonatomic, strong) BlueTitleMoreHeader *collHeader;

@property (nonatomic, strong) UICollectionViewFlowLayout *facilityLayout;

@property (nonatomic, strong) UICollectionView *facilityColl;//商铺、写字楼配套

//住宅
@property (nonatomic, strong) UILabel *houseTypeL;

@property (nonatomic, strong) DropDownBtn *houseBtn;//户型

//@property (nonatomic, strong) DropDownBtn *houseBtn1;//户型
//
//@property (nonatomic, strong) DropDownBtn *houseBtn2;//户型
//
//@property (nonatomic, strong) DropDownBtn *houseBtn3;//户型


@property (nonatomic, strong) UILabel *floorL;

@property (nonatomic, strong) DropDownBtn *floorTF1;

@property (nonatomic, strong) DropDownBtn *floorTF2;//楼层

@property (nonatomic, strong) UILabel *decorateL;

@property (nonatomic, strong) DropDownBtn *decorateBtn;//装修标准

@property (nonatomic, strong) AddTagView *tagView;//住宅需求标签

@end

@implementation LookMaintainDetailAddFollowVC

- (instancetype)initWithTakeId:(NSString *)takeId dataDic:(NSDictionary *)dataDic
{
    self = [super init];
    if (self) {
        
        _dataDic = dataDic;
        _takeId = takeId;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    if (_timeContentL) {
        
        [self.formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        _timeContentL.text = [self.formatter stringFromDate:[NSDate date]];
        [self.formatter setDateFormat:@"yyyy-MM-dd"];
    }
}

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
    _way = [self.status integerValue];
    
    self.formatter = [[NSDateFormatter alloc] init];
    [self.formatter setDateFormat:@"yyyy-MM-dd"];
    
    _wayArr = @[@{@"id":@"1",@"param":@"沟通"},@{@"id":@"2",@"param":@"预约带看"},@{@"id":@"3",@"param":@"带看"},@{@"id":@"4",@"param":@"带看跟进"}];
    _levelArr = [UserModelArchiver unarchive].Configdic[@"54"][@"param"];
    _payArr = [UserModelArchiver unarchive].Configdic[@"13"][@"param"];
    _paySelectArr = [@[] mutableCopy];
    for (int i = 0; i < _payArr.count; i++) {
        
        [_paySelectArr addObject:@0];
    }
    _storeArr = [self getDetailConfigArrByConfigState:SHOP_TYPE];
    _selectStoreArr = [@[] mutableCopy];
    for (int i = 0; i < _storeArr.count; i++) {
        
        [_selectStoreArr addObject:@(0)];
    }
    _stairArr = [[NSMutableArray alloc] init];
    for (int i = 1; i < 50; i++) {
        
        NSString *str = [NSString stringWithFormat:@"%d层",i];
        [_stairArr addObject:@{@"id":@(i),@"param":str}];
    }
    
//    _houseArr1 = [[NSMutableArray alloc] init];
//    _houseArr2 = [[NSMutableArray alloc] init];
//    _houseArr3 = [[NSMutableArray alloc] init];
//    for (int i = 1; i < 5; i++) {
//
//        NSString *str1 = [NSString stringWithFormat:@"%d室",i];
//        [_houseArr1 addObject:@{@"id":@(i),@"param":str1}];
//
//        NSString *str2 = [NSString stringWithFormat:@"%d厅",i];
//        [_houseArr2 addObject:@{@"id":@(i),@"param":str2}];
//
//        NSString *str3 = [NSString stringWithFormat:@"%d卫",i];
//        [_houseArr3 addObject:@{@"id":@(i),@"param":str3}];
//    }
}

- (void)ActionTagBtn:(UIButton *)btn{
    
    switch (btn.tag) {
        case 0:
        {
            if ([self.property isEqualToString:@"商铺"]) {
                
                SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:[self getDetailConfigArrByConfigState:BUY_USE]];
                WS(weakself);
                view.selectedBlock = ^(NSString *MC, NSString *ID) {
                    
                    weakself.purposeBtn.content.text = MC;
                    weakself.purposeBtn->str = [NSString stringWithFormat:@"%@", ID];
                };
                [self.view addSubview:view];
                break;
            }else if ([self.property isEqualToString:@"写字楼"]){
                
                SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:[self getDetailConfigArrByConfigState:BUY_USE]];
                WS(weakself);
                view.selectedBlock = ^(NSString *MC, NSString *ID) {
                    
                    weakself.purposeBtn.content.text = MC;
                    weakself.purposeBtn->str = [NSString stringWithFormat:@"%@", ID];
                };
                [self.view addSubview:view];
                break;
            }else{
                
                SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:[self getDetailConfigArrByConfigState:BUY_TYPE]];
                WS(weakself);
                view.selectedBlock = ^(NSString *MC, NSString *ID) {
                    
                    weakself.purposeBtn.content.text = MC;
                    weakself.purposeBtn->str = [NSString stringWithFormat:@"%@", ID];
                };
                [self.view addSubview:view];
                break;
            }
        }
        case 1:
        {
            SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:@[@{@"param":@"住宅",
                                                                                                       @"id":@"1"
                                                                                                       },@{@"param":@"商铺",
                                                                                                           @"id":@"2"
                                                                                                           },@{@"param":@"写字楼",
                                                                                                               @"id":@"3"
                                                                                                               }]];
            WS(weakself);
            view.selectedBlock = ^(NSString *MC, NSString *ID) {
                
                self.property = MC;
                weakself.typeBtn.content.text = MC;
                weakself.typeBtn->str = [NSString stringWithFormat:@"%@", ID];
                [self RemasonryUI];
            };
            [self.view addSubview:view];
            break;
        }
        case 2:
        {
            SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:[self getDetailConfigArrByConfigState:DECORATE]];
            WS(weakself);
            view.selectedBlock = ^(NSString *MC, NSString *ID) {
                
                weakself.decorateBtn.content.text = MC;
                weakself.decorateBtn->str = [NSString stringWithFormat:@"%@", ID];
            };
            [self.view addSubview:view];
            break;
        }
        case 3:
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
        case 4:
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
        case 5:
        {
//            SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:[self getDetailConfigArrByConfigState:HOUSE_TYPE]];
//            WS(weakself);
//            view.selectedBlock = ^(NSString *MC, NSString *ID) {
//
//                weakself.houseBtn.content.text = MC;
//                weakself.houseBtn->str = [NSString stringWithFormat:@"%@", ID];
//            };
//            [self.view addSubview:view];

            HouseTypePickView *view = [[HouseTypePickView alloc] initWithFrame:self.view.bounds];// WithData:[self getDetailConfigArrByConfigState:HOUSE_TYPE]];
            WS(weakself);
            view.houseTypePickViewBlock = ^(NSString * _Nonnull room, NSString * _Nonnull hall, NSString * _Nonnull bath) {

                weakself.houseBtn.content.text = [NSString stringWithFormat:@"%@室%@厅%@卫",room,hall,bath];
                weakself.houseBtn->str = [NSString stringWithFormat:@"%@,%@,%@",room,hall,bath];
            };
            [self.view addSubview:view];
            break;
        }
//        case 5:
//        {
//            SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:_houseArr1];
//            WS(weakself);
//            view.selectedBlock = ^(NSString *MC, NSString *ID) {
//
//                weakself.houseBtn1.content.text = MC;
//                weakself.houseBtn1->str = [NSString stringWithFormat:@"%@", ID];
//            };
//            [self.view addSubview:view];
//            break;
//        }
//        case 6:
//        {
//            SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:_houseArr2];
//            WS(weakself);
//            view.selectedBlock = ^(NSString *MC, NSString *ID) {
//
//                weakself.houseBtn2.content.text = MC;
//                weakself.houseBtn2->str = [NSString stringWithFormat:@"%@", ID];
//            };
//            [self.view addSubview:view];
//            break;
//        }
//        case 7:
//        {
//            SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:_houseArr3];
//            WS(weakself);
//            view.selectedBlock = ^(NSString *MC, NSString *ID) {
//
//                weakself.houseBtn3.content.text = MC;
//                weakself.houseBtn3->str = [NSString stringWithFormat:@"%@", ID];
//            };
//            [self.view addSubview:view];
//            break;
//        }
        case 6:
        {
            DateChooseView *view = [[DateChooseView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
            
            [view.pickerView setMinimumDate:[NSDate date]];
            [view.pickerView setCalendar:[NSCalendar currentCalendar]];
            NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
            NSDateComponents *comps = [[NSDateComponents alloc] init];
            [comps setDay:15];//设置最大时间为：当前时间推后10天
            [view.pickerView setMaximumDate:[calendar dateByAddingComponents:comps toDate:[NSDate date] options:0]];
            
            __weak __typeof(&*self)weakSelf = self;
            view.dateblock = ^(NSDate *date) {
                
                weakSelf.nextTimeBtn.content.text = [weakSelf.formatter stringFromDate:date];
            };
            [self.view addSubview:view];
            break;
        }
        case 7:
        {
            SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:[self getDetailConfigArrByConfigState:OFFICE_GRADE]];
            WS(weakself);
            view.selectedBlock = ^(NSString *MC, NSString *ID) {
                
                weakself.officeLevelBtn.content.text = MC;
                weakself.officeLevelBtn->str = [NSString stringWithFormat:@"%@", ID];
            };
            [self.view addSubview:view];
            break;
        }
        case 8:
        {
            SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:_levelArr];
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

- (void)ActionCommitBtn:(UIButton *)btn{
    
    if (self.isSelect) {
        
        NSMutableDictionary *dic = [@{} mutableCopy];
        [dic setObject:self.clientId forKey:@"client_id"];
        [dic setObject:@"1" forKey:@"type"];
        
        _payWay = @"";
        for (int i = 0; i < _paySelectArr.count; i++) {
            
            
            if ([_paySelectArr[i] integerValue]) {
                
                if (i == 0) {
                    
                    _payWay = [NSString stringWithFormat:@"%@",_payArr[i][@"id"]];
                }else{
                    
                    _payWay = [NSString stringWithFormat:@"%@,%@",_payWay,_payArr[i][@"id"]];
                }
            }
        }
        if ([_columnDic[@"house"][@"pay_type"] integerValue] == 1) {
            
            if (!_payWay.length) {
                
                [self alertControllerWithNsstring:@"温馨提示" And:@"请选择付款方式"];
                return;
            }
        }
        
        if (_dataArr.count) {
            
            NSString *str;
            for (int i = 0; i < _dataArr.count; i++) {
                
                if ([self.property isEqualToString:@"住宅"]) {
                    
                    if (i == 0) {
                        
                        str = [NSString stringWithFormat:@"%@",_dataArr[0][@"id"]];
                    }else{
                        
                        str = [NSString stringWithFormat:@"%@,%@",str,_dataArr[i][@"id"]];
                    }
                }else{
                    
                    if (i == 0) {
                        
                        str = [NSString stringWithFormat:@"%@",_dataArr[0][@"ui_id"]];
                    }else{
                        
                        str = [NSString stringWithFormat:@"%@,%@",str,_dataArr[i][@"ui_id"]];
                    }
                }
            }
            if(str){
                
                if ([self.property isEqualToString:@"住宅"]) {
                    
                    [dic setObject:str forKey:@"need_tags"];
                }else{
                    
                    [dic setObject:str forKey:@"match_tags"];
                }
            }
        }else{
            
            if ([self.property isEqualToString:@"住宅"]) {
                
                [dic setValue:@"" forKey:@"need_tags"];
            }else{
                
                [dic setValue:@"" forKey:@"match_tags"];
            }
        }
        
        if ([self isEmpty:_contentTV.text]) {
            
            [self alertControllerWithNsstring:@"温馨提示" And:@"请输入跟进内容"];
            return;
        }
        
        if (!_nextTimeBtn.content.text.length) {
            
            [self alertControllerWithNsstring:@"温馨提示" And:@"请选择下次回访时间"];
            return;
        }
        
        if ([self.property isEqualToString:@"商铺"]) {
            
            [dic setObject:@"2" forKey:@"property_type"];
            
            if (_purposeBtn.content.text.length) {
                
                [dic setObject:_purposeBtn->str forKey:@"buy_use"];
            }
            _store = @"";
            for (int i = 0; i < _selectStoreArr.count; i++) {
                
                
                if ([_selectStoreArr[i] integerValue]) {
                    
                    if (i == 0) {
                        
                        _store = [NSString stringWithFormat:@"%@",_storeArr[i][@"id"]];
                    }else{
                        
                        _store = [NSString stringWithFormat:@"%@,%@",_store,_storeArr[i][@"id"]];
                    }
                }
            }
            if (!_store.length) {
                
                [self alertControllerWithNsstring:@"温馨提示" And:@"请选择商铺类型"];
                return;
            }
            
            [dic setObject:_store forKey:@"shop_type"];
        }else if ([self.property isEqualToString:@"写字楼"]){
            
            [dic setObject:@"3" forKey:@"property_type"];

            if (_officeLevelBtn.content.text.length) {
                
                [dic setObject:_officeLevelBtn->str forKey:@"office_level"];
            }

            if (_purposeBtn.content.text.length) {
                
                [dic setObject:_purposeBtn->str forKey:@"buy_use"];
            }

            if (![self isEmpty:_yearTF.textfield.text]) {
                
                [dic setObject:_yearTF.textfield.text forKey:@"used_years"];
            }
            
        }else{
            
            [dic setObject:@"1" forKey:@"property_type"];
            
//            i
            
            if ([_columnDic[@"house"][@"floor"] integerValue] == 1) {
                
                if (!_floorTF1.content.text.length && !_floorTF2.content.text.length) {
                    
                    [self alertControllerWithNsstring:@"温馨提示" And:@"请选择楼层"];
                    return;
                }
            }
            if (_floorTF1.content.text.length) {
                
                [dic setObject:_floorTF1->str forKey:@"floor_min"];
            }
            
            if (_floorTF2.content.text.length) {
                
                [dic setObject:_floorTF2->str forKey:@"floor_max"];
            }
            if ([_columnDic[@"house"][@"house_type"] integerValue] == 1) {
                
                if (!_houseBtn->str) {
                    
                    [self alertControllerWithNsstring:@"温馨提示" And:@"请选择户型"];
                    return;
                }
            }
            if (_houseBtn->str) {
                
                [dic setValue:[NSString stringWithFormat:@"%@",_houseBtn->str] forKey:@"house_type"];
            }
            
            if ([_columnDic[@"house"][@"decorate"] integerValue] == 1) {
        
                if (!_decorateBtn->str) {
                    
                    [self alertControllerWithNsstring:@"温馨提示" And:@"请选择装修标准"];
                    return;
                }
            }
            
            if (_decorateBtn.content.text.length) {
                
                [dic setObject:_decorateBtn->str forKey:@"decorate"];
            }
            
            if ([_columnDic[@"house"][@"buy_purpose"] integerValue] == 1) {
            
                if (!_decorateBtn->str) {
                    
                    [self alertControllerWithNsstring:@"温馨提示" And:@"请选择置业目的"];
                    return;
                }
            }
            if (_purposeBtn.content.text.length) {
                
                [dic setObject:_purposeBtn->str forKey:@"buy_purpose"];
            }
        }
        if (_payWay.length) {
            
            [dic setObject:_payWay forKey:@"pay_type"];
        }
        dic[@"total_price"] = [NSString stringWithFormat:@"%.0f-%.0f",_priceBtn.selectedMinimum,_priceBtn.selectedMaximum];
//        [dic setObject:_priceBtn.textfield.text forKey:@"total_price"];
        dic[@"area"] = [NSString stringWithFormat:@"%.0f-%.0f",_areaBtn.selectedMinimum,_areaBtn.selectedMaximum];
//        [dic setObject:_areaBtn.textfield.text forKey:@"area"];
        [dic setObject:_timeContentL.text forKey:@"follow_time"];
        [dic setObject:_contentTV.text forKey:@"follow_comment"];
        [dic setObject:_nextTimeBtn.content.text forKey:@"next_follow_time"];
        if (_levelBtn.content.text.length) {
            
            [dic setObject:_levelBtn->str forKey:@"client_level"];
        }
        if (_way == 0) {
            
            [dic setObject:@"1" forKey:@"follow_type"];
            [BaseRequest POST:TakeMaintainAdd_URL parameters:dic success:^(id resposeObject) {
                
                NSLog(@"%@",resposeObject);
                if ([resposeObject[@"code"] integerValue] == 200) {
                    
                    if (self.lookMaintainDetailAddFollowVCBlock) {
                        
                        self.lookMaintainDetailAddFollowVCBlock();
                    }
                    for (UIViewController *vc in self.navigationController.viewControllers) {
                        
                        if ([vc isKindOfClass:[LookMaintainVC class]]) {
                            
                            [self.navigationController popToViewController:vc animated:YES];
                        }
                    }
//                    [self.navigationController popViewControllerAnimated:YES];
                }else{
                    
                    [self showContent:resposeObject[@"msg"]];
                }
            } failure:^(NSError *error) {
                
                NSLog(@"%@",error);
                [self showContent:@"网络错误"];
            }];
        }else if (_way == 1){
            
            [dic setObject:@"2" forKey:@"follow_type"];
            LookMaintainDetailAddAppointVC *nextVC = [[LookMaintainDetailAddAppointVC alloc] init];
            nextVC.isSelect = self.isSelect;
            nextVC.dataDic = dic;
            nextVC.status = [NSString stringWithFormat:@"%ld",_way];
            nextVC.lookMaintainDetailAddAppointVCBlock = ^{
                
                if (self.lookMaintainDetailAddFollowVCBlock) {
                    
                    self.lookMaintainDetailAddFollowVCBlock();
                }
            };
            [self.navigationController pushViewController:nextVC animated:YES];
        }else if (_way == 2){
            
            [dic setObject:@"3" forKey:@"follow_type"];
            LookMaintainDetailAddAppointVC *nextVC = [[LookMaintainDetailAddAppointVC alloc] init];
            nextVC.isSelect = self.isSelect;
            nextVC.dataDic = dic;
            nextVC.status = [NSString stringWithFormat:@"%ld",_way];
            nextVC.lookMaintainDetailAddAppointVCBlock = ^{
                
                if (self.lookMaintainDetailAddFollowVCBlock) {
                    
                    self.lookMaintainDetailAddFollowVCBlock();
                }
            };
            [self.navigationController pushViewController:nextVC animated:YES];
        }else{
            
            [dic setObject:@"4" forKey:@"follow_type"];
            LookMaintainDetailAddAppointVC *nextVC = [[LookMaintainDetailAddAppointVC alloc] init];
            nextVC.isSelect = self.isSelect;
            nextVC.dataDic = dic;
            nextVC.status = [NSString stringWithFormat:@"%ld",_way];
            nextVC.lookMaintainDetailAddAppointVCBlock = ^{
                
                if (self.lookMaintainDetailAddFollowVCBlock) {
                    
                    self.lookMaintainDetailAddFollowVCBlock();
                }
            };
            [self.navigationController pushViewController:nextVC animated:YES];
        }
    }else{
        
        NSMutableDictionary *dic = [@{} mutableCopy];
        [dic setObject:_takeId forKey:@"take_id"];
        [dic setObject:@"1" forKey:@"type"];
        
        
//        if ([self isEmpty:_priceBtn.textfield.text]) {
//
//            [self alertControllerWithNsstring:@"温馨提示" And:@"请输入总价"];
//            return;
//        }
//
//        if ([self isEmpty:_areaBtn.textfield.text]) {
//
//            [self alertControllerWithNsstring:@"温馨提示" And:@"请输入面积"];
//            return;
//        }
        _payWay = @"";
        for (int i = 0; i < _paySelectArr.count; i++) {
            
            
            if ([_paySelectArr[i] integerValue]) {
                
                if (i == 0) {
                    
                    _payWay = [NSString stringWithFormat:@"%@",_payArr[i][@"id"]];
                }else{
                    
                    _payWay = [NSString stringWithFormat:@"%@,%@",_payWay,_payArr[i][@"id"]];
                }
            }
        }
        if ([_columnDic[@"house"][@"pay_type"] integerValue] == 1) {
            
            if (!_payWay.length) {
                
                [self alertControllerWithNsstring:@"温馨提示" And:@"请选择付款方式"];
                return;
            }
        }
        
        if (_dataArr.count) {
            
            NSString *str;
            for (int i = 0; i < _dataArr.count; i++) {
                
                if ([self.property isEqualToString:@"住宅"]) {
                    
                    if (i == 0) {
                        
                        str = [NSString stringWithFormat:@"%@",_dataArr[0][@"id"]];
                    }else{
                        
                        str = [NSString stringWithFormat:@"%@,%@",str,_dataArr[i][@"id"]];
                    }
                }else{
                    
                    if (i == 0) {
                        
                        str = [NSString stringWithFormat:@"%@",_dataArr[0][@"ui_id"]];
                    }else{
                        
                        str = [NSString stringWithFormat:@"%@,%@",str,_dataArr[i][@"ui_id"]];
                    }
                }
            }
            if(str){
                
                if ([self.property isEqualToString:@"住宅"]) {
                    
                    [dic setObject:str forKey:@"need_tags"];
                }else{
                    
                    [dic setObject:str forKey:@"match_tags"];
                }
            }
        }else{
            
            if ([self.property isEqualToString:@"住宅"]) {
                
                [dic setValue:@"" forKey:@"need_tags"];
            }else{
                
                [dic setValue:@"" forKey:@"match_tags"];
            }
        }
        
        if ([self isEmpty:_contentTV.text]) {
            
            [self alertControllerWithNsstring:@"温馨提示" And:@"请输入跟进内容"];
            return;
        }
        
        if (!_nextTimeBtn.content.text.length) {
            
            [self alertControllerWithNsstring:@"温馨提示" And:@"请选择下次回访时间"];
            return;
        }
        
        if ([self.property isEqualToString:@"商铺"]) {
            
            [dic setObject:@"2" forKey:@"property_type"];
            
            if (_purposeBtn.content.text.length) {
                
                [dic setObject:_purposeBtn->str forKey:@"buy_use"];
            }
            _store = @"";
            for (int i = 0; i < _selectStoreArr.count; i++) {
                
                
                if ([_selectStoreArr[i] integerValue]) {
                    
                    if (i == 0) {
                        
                        _store = [NSString stringWithFormat:@"%@",_storeArr[i][@"id"]];
                    }else{
                        
                        _store = [NSString stringWithFormat:@"%@,%@",_store,_storeArr[i][@"id"]];
                    }
                }
            }
            if (!_store.length) {
                
                [self alertControllerWithNsstring:@"温馨提示" And:@"请选择商铺类型"];
                return;
            }
            
            [dic setObject:_store forKey:@"shop_type"];
        }else if ([self.property isEqualToString:@"写字楼"]){
            
            [dic setObject:@"3" forKey:@"property_type"];
            //            if (!_officeLevelBtn.content.text) {
            //
            //                [self alertControllerWithNsstring:@"温馨提示" And:@"请选择写字楼等级"];
            //                return;
            //            }
            if (_officeLevelBtn.content.text.length) {
                
                [dic setObject:_officeLevelBtn->str forKey:@"office_level"];
            }
            //            if (!_purposeBtn.content.text) {
            //
            //                [self alertControllerWithNsstring:@"温馨提示" And:@"请选择购买用途"];
            //                return;
            //            }
            if (_purposeBtn.content.text.length) {
                
                [dic setObject:_purposeBtn->str forKey:@"buy_use"];
            }
            //            if ([self isEmpty:_yearTF.textfield.text]) {
            //
            //                [self alertControllerWithNsstring:@"温馨提示" And:@"请输入使用年限"];
            //                return;
            //            }
            if (![self isEmpty:_yearTF.textfield.text]) {
                
                [dic setObject:_yearTF.textfield.text forKey:@"used_years"];
            }
            
        }else{
            
            [dic setObject:@"1" forKey:@"property_type"];
            
            if ([_columnDic[@"house"][@"floor"] integerValue] == 1) {
                    
                    if (!_floorTF1.content.text.length && !_floorTF2.content.text.length) {
                        
                        [self alertControllerWithNsstring:@"温馨提示" And:@"请选择楼层"];
                        return;
                    }
                }
                if (_floorTF1.content.text.length) {
                    
                    [dic setObject:_floorTF1->str forKey:@"floor_min"];
                }
                
                if (_floorTF2.content.text.length) {
                    
                    [dic setObject:_floorTF2->str forKey:@"floor_max"];
                }
                if ([_columnDic[@"house"][@"house_type"] integerValue] == 1) {
                    
                    if (!_houseBtn->str) {
                        
                        [self alertControllerWithNsstring:@"温馨提示" And:@"请选择户型"];
                        return;
                    }
                }
                if (_houseBtn->str) {
                    
                    [dic setValue:[NSString stringWithFormat:@"%@",_houseBtn->str] forKey:@"house_type"];
                }
                
                if ([_columnDic[@"house"][@"decorate"] integerValue] == 1) {
            
                    if (!_decorateBtn->str) {
                        
                        [self alertControllerWithNsstring:@"温馨提示" And:@"请选择装修标准"];
                        return;
                    }
                }
                
                if (_decorateBtn.content.text.length) {
                    
                    [dic setObject:_decorateBtn->str forKey:@"decorate"];
                }
                
                if ([_columnDic[@"house"][@"buy_purpose"] integerValue] == 1) {
                
                    if (!_decorateBtn->str) {
                        
                        [self alertControllerWithNsstring:@"温馨提示" And:@"请选择置业目的"];
                        return;
                    }
                }
                if (_purposeBtn.content.text.length) {
                    
                    [dic setObject:_purposeBtn->str forKey:@"buy_purpose"];
                }
        }
        if (_payWay.length) {
            
            [dic setObject:_payWay forKey:@"pay_type"];
        }
        dic[@"total_price"] = [NSString stringWithFormat:@"%.0f-%.0f",_priceBtn.selectedMinimum,_priceBtn.selectedMaximum];
//        [dic setObject:_priceBtn.textfield.text forKey:@"total_price"];
        dic[@"area"] = [NSString stringWithFormat:@"%.0f-%.0f",_areaBtn.selectedMinimum,_areaBtn.selectedMaximum];
//        [dic setObject:_areaBtn.textfield.text forKey:@"area"];
        [dic setObject:_timeContentL.text forKey:@"follow_time"];
        [dic setObject:_contentTV.text forKey:@"follow_comment"];
        [dic setObject:_nextTimeBtn.content.text forKey:@"next_follow_time"];
        if (_levelBtn.content.text.length) {
            
            [dic setObject:_levelBtn->str forKey:@"client_level"];
        }
        if (_way == 0) {
            
            [dic setObject:@"1" forKey:@"follow_type"];
            [BaseRequest POST:TakeMaintainFollowAdd_URL parameters:dic success:^(id resposeObject) {
                
                NSLog(@"%@",resposeObject);
                if ([resposeObject[@"code"] integerValue] == 200) {
                    
                    if (self.lookMaintainDetailAddFollowVCBlock) {
                        
                        self.lookMaintainDetailAddFollowVCBlock();
                    }
                    [self.navigationController popViewControllerAnimated:YES];
                }else{
                    
                    [self showContent:resposeObject[@"msg"]];
                }
            } failure:^(NSError *error) {
                
                NSLog(@"%@",error);
                [self showContent:@"网络错误"];
            }];
        }else if (_way == 1){
            
            [dic setObject:@"2" forKey:@"follow_type"];
            LookMaintainDetailAddAppointVC *nextVC = [[LookMaintainDetailAddAppointVC alloc] initWithTakeId:_takeId];
            nextVC.dataDic = dic;
            nextVC.status = [NSString stringWithFormat:@"%ld",_way];
            nextVC.lookMaintainDetailAddAppointVCBlock = ^{
                
                if (self.lookMaintainDetailAddFollowVCBlock) {
                    
                    self.lookMaintainDetailAddFollowVCBlock();
                }
            };
            [self.navigationController pushViewController:nextVC animated:YES];
        }else if (_way == 2){
            
            [dic setObject:@"3" forKey:@"follow_type"];
            LookMaintainDetailAddAppointVC *nextVC = [[LookMaintainDetailAddAppointVC alloc] initWithTakeId:_takeId];
            nextVC.dataDic = dic;
            nextVC.status = [NSString stringWithFormat:@"%ld",_way];
            nextVC.lookMaintainDetailAddAppointVCBlock = ^{
                
                if (self.lookMaintainDetailAddFollowVCBlock) {
                    
                    self.lookMaintainDetailAddFollowVCBlock();
                }
            };
            [self.navigationController pushViewController:nextVC animated:YES];
        }else{
            
            [dic setObject:@"4" forKey:@"follow_type"];
            LookMaintainDetailAddAppointVC *nextVC = [[LookMaintainDetailAddAppointVC alloc] initWithTakeId:_takeId];
            nextVC.dataDic = dic;
            nextVC.status = [NSString stringWithFormat:@"%ld",_way];
            nextVC.lookMaintainDetailAddAppointVCBlock = ^{
                
                if (self.lookMaintainDetailAddFollowVCBlock) {
                    
                    self.lookMaintainDetailAddFollowVCBlock();
                }
            };
            [self.navigationController pushViewController:nextVC animated:YES];
        }
    }
}

- (void)rangeSlider:(TTRangeSlider *)sender didChangeSelectedMinimumValue:(float)selectedMinimum andMaximumValue:(float)selectedMaximum{
    
//    if (sender == _priceBtn) {
//
//        if (selectedMaximum == 1000) {
//
//            _priceBtn.maxFormatter.positiveSuffix = @"万以上";
//        }else{
//
//            _priceBtn.maxFormatter.positiveSuffix = @"万";
//        }
//        _priceBtn.minFormatter.positiveSuffix = @"万";
//    }else{
//
//        if (selectedMaximum == 1000) {
//
//            _areaBtn.maxFormatter.positiveSuffix = @"㎡以上";
//        }else{
//
//            _areaBtn.maxFormatter.positiveSuffix = @"㎡";
//        }
//    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (collectionView == _wayColl) {
        
        return _wayArr.count;
    }else if (collectionView == _comercialColl){
        
        return _storeArr.count;
    }else if (collectionView == _facilityColl){
        
        return _dataArr.count;
    }else{
        
        return _payArr.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (collectionView == _wayColl) {
        
        LookMaintainDetailAddFollowCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LookMaintainDetailAddFollowCell" forIndexPath:indexPath];
        if (!cell) {
            
            cell = [[LookMaintainDetailAddFollowCell alloc] initWithFrame:CGRectMake(0, 0, 80 *SIZE, 20 *SIZE)];
        }
        
        cell.titleL.text = _wayArr[indexPath.row][@"param"];
        if (indexPath.row == _way) {
            
            [cell setIsSelect:1];
        }else{
            
            [cell setIsSelect:0];
        }
        return cell;
    }else if (collectionView == _comercialColl){
        
        CompleteSurveyCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CompleteSurveyCollCell" forIndexPath:indexPath];
        if (!cell) {
            
            cell = [[CompleteSurveyCollCell alloc] initWithFrame:CGRectMake(0, 0, 130 *SIZE, 20 *SIZE)];
        }
        
        [cell setIsSelect:[_selectStoreArr[(NSUInteger) indexPath.item] integerValue]];
        cell.titleL.text = _storeArr[(NSUInteger) indexPath.item][@"param"];
        return cell;
    }else if (collectionView == _facilityColl){
        
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
    }else{
        
        CompleteSurveyCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CompleteSurveyCollCell" forIndexPath:indexPath];
        if (!cell) {
            
            cell = [[CompleteSurveyCollCell alloc] initWithFrame:CGRectMake(0, 0, 100 *SIZE, 20 *SIZE)];
        }
        
        [cell setIsSelect:[_paySelectArr[indexPath.item] integerValue]];
        cell.titleL.text = _payArr[indexPath.row][@"param"];
        
        return cell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (collectionView == _wayColl) {
        
        _way = indexPath.item;
        if (_way == 0) {
            
            [_commitBtn setTitle:@"提 交" forState:UIControlStateNormal];
        }else{
            
            [_commitBtn setTitle:@"下一步" forState:UIControlStateNormal];
        }
    }else if (collectionView == _comercialColl){
        
        if ([_selectStoreArr[indexPath.item] integerValue] == 1) {
            
            [_selectStoreArr replaceObjectAtIndex:indexPath.item withObject:@0];
        }else{
            
            [_selectStoreArr replaceObjectAtIndex:indexPath.item withObject:@1];
        }
        [collectionView reloadData];
    }else{
        
        if ([_paySelectArr[indexPath.item] integerValue]) {
            
            [_paySelectArr replaceObjectAtIndex:indexPath.item withObject:@0];
        }else{
            
            [_paySelectArr replaceObjectAtIndex:indexPath.item withObject:@1];
        }
    }
    [collectionView reloadData];
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"跟进记录";
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.backgroundColor = YJBackColor;
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    
    _contentView = [[UIView alloc] init];
    _contentView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:_contentView];
    
    _CollView = [[UIView alloc] init];
    _CollView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:_CollView];
    
    _followView = [[UIView alloc] init];
    _followView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:_followView];
    
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = YJBackColor;
    [_contentView addSubview:_lineView];
    
    _timeContentL = [[UILabel alloc] init];
    _timeContentL.textColor = YJTitleLabColor;
    _timeContentL.font = [UIFont systemFontOfSize:12 *SIZE];
    [_contentView addSubview:_timeContentL];
    
    [self.formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    _timeContentL.text = [self.formatter stringFromDate:[NSDate date]];
    [self.formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSArray *titleArr = @[@"跟进时间",@"跟进方式：",@"客户等级：",@"物业类型：",@"总价：",@"面积：",@"置业目的：",@"付款方式：",@"跟进内容：",@"下次回访时间：",@"已使用年限：",@"写字楼等级：",@"商铺类型：",@"户型：",@"楼层：",@"装修标准："];
    for (int i = 0; i < 16; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = YJTitleLabColor;
        label.text = titleArr[i];
        label.adjustsFontSizeToFitWidth = YES;
        label.font = [UIFont systemFontOfSize:12 *SIZE];
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
                _levelL = label;
                [_contentView addSubview:_levelL];
                break;
            }
            case 3:
            {
                _typeL = label;
                [_contentView addSubview:_typeL];
                break;
            }
            case 4:
            {
                _priceL = label;
                [_contentView addSubview:_priceL];
                break;
            }
            case 5:
            {
                _areaL = label;
                [_contentView addSubview:_areaL];
                break;
            }
            case 6:
            {
                _purposeL = label;
                if ([_columnDic[@"house"][@"buy_purpose"] integerValue] == 1) {
                    
                    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"*%@",_purposeL.text]];
                    [attr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
                    _purposeL.attributedText = attr;
                }
                [_contentView addSubview:_purposeL];
                break;
            }
            case 7:
            {
                _payWayL = label;
                if ([_columnDic[@"house"][@"pay_type"] integerValue] == 1) {
                    
                    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"*%@",_payWayL.text]];
                    [attr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
                    _payWayL.attributedText = attr;
                }
                [_contentView addSubview:_payWayL];
                break;
            }
            case 8:
            {
                _contentL = label;
                [_followView addSubview:_contentL];
                break;
            }
            case 9:
            {
                _nextTimeL = label;
                [_followView addSubview:_nextTimeL];
                break;
            }
            case 10:
            {
                _yearL = label;
                [_contentView addSubview:_yearL];
                break;
            }
            case 11:
            {
                _officeLevelL = label;
                [_contentView addSubview:_officeLevelL];
                break;
            }
            case 12:
            {
                _commercialL = label;
                [_contentView addSubview:_commercialL];
                break;
            }
            case 13:
            {
                _houseTypeL = label;
                if ([_columnDic[@"house"][@"house_type"] integerValue] == 1) {
                    
                    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"*%@",_houseTypeL.text]];
                    [attr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
                    _houseTypeL.attributedText = attr;
                }
                [_contentView addSubview:_houseTypeL];
                break;
            }
            case 14:
            {
                _floorL = label;
                if ([_columnDic[@"house"][@"floor"] integerValue] == 1) {
                    
                    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"*%@",_floorL.text]];
                    [attr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
                    _floorL.attributedText = attr;
                }
                [_contentView addSubview:_floorL];
                break;
            }
            case 15:
            {
                _decorateL = label;
                if ([_columnDic[@"house"][@"decorate"] integerValue] == 1) {
                    
                    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"*%@",_decorateL.text]];
                    [attr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
                    _decorateL.attributedText = attr;
                }
                [_contentView addSubview:_decorateL];
                break;
            }
            default:
                break;
        }
    }
    
    for (int i = 0 ; i < 9; i++) {
        
        DropDownBtn *btn = [[DropDownBtn alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
        btn.tag = i;
        [btn addTarget:self action:@selector(ActionTagBtn:) forControlEvents:UIControlEventTouchUpInside];
        switch (i) {
            case 0:
            {
                _purposeBtn = btn;
                [_contentView addSubview:_purposeBtn];
                break;
            }
            case 1:
            {
                _typeBtn = btn;
                [_contentView addSubview:_typeBtn];
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
                _floorTF1 = btn;
                [_contentView addSubview:_floorTF1];
                break;
            }
            case 4:
            {
                _floorTF2 = btn;
                [_contentView addSubview:_floorTF2];
                break;
            }
            case 5:
            {
                _houseBtn = btn;
                [_contentView addSubview:_houseBtn];
//                _houseBtn1 = btn;
//                [_contentView addSubview:_houseBtn1];
                break;
            }
//            case 6:{
//
//                _houseBtn2 = btn;
//                [_contentView addSubview:_houseBtn2];
//                break;
//            }
//            case 7:{
//
//                _houseBtn3 = btn;
//                [_contentView addSubview:_houseBtn3];
//                break;
//            }
            case 6:
            {
                _nextTimeBtn = btn;
                [_followView addSubview:_nextTimeBtn];
                break;
            }
            case 7:
            {
                _officeLevelBtn = btn;
                [_contentView addSubview:_officeLevelBtn];
                break;
            }
            case 8:{
                
                _levelBtn = btn;
                [_contentView addSubview:_levelBtn];
                break;
            }
            default:
                break;
        }
    }
    
    for (int i = 0; i < 3; i++) {
        
        BorderTF *tf = [[BorderTF alloc] initWithFrame:CGRectMake(0, 0, 257 *SIZE, 33 *SIZE)];
        if (i == 0) {
            
//            _priceBtn = tf;
//            _priceBtn.unitL.text = @"万";
//            _priceBtn.textfield.keyboardType = UIKeyboardTypeNumberPad;
            _priceBtn = [[TTRangeSlider alloc] initWithFrame:tf.frame];
            _priceBtn.minValue = 0;
            _priceBtn.maxValue = 1000;
            _priceBtn.delegate = self;
            NSNumberFormatter *customFormatter = [[NSNumberFormatter alloc] init];
            customFormatter.positiveSuffix = @"万";
            _priceBtn.maxFormatter = customFormatter;
            _priceBtn.minFormatter = customFormatter;
            [_contentView addSubview:_priceBtn];
        }else if (i == 1){
            
//            _areaBtn = tf;
//            _areaBtn.unitL.text = @"㎡";
//            _areaBtn.textfield.keyboardType = UIKeyboardTypeNumberPad;
            _areaBtn = [[TTRangeSlider alloc] initWithFrame:tf.frame];
            _areaBtn.minValue = 0;
            _areaBtn.maxValue = 500;
            NSNumberFormatter *customFormatter = [[NSNumberFormatter alloc] init];
            customFormatter.positiveSuffix = @"㎡";
            _areaBtn.maxFormatter = customFormatter;
            _areaBtn.minFormatter = customFormatter;
            [_contentView addSubview:_areaBtn];
        }else{
            
            _yearTF = tf;
            _yearTF.unitL.text = @"年";
            _yearTF.textfield.keyboardType = UIKeyboardTypeNumberPad;
            [_contentView addSubview:_yearTF];
        }
    }
    
    for (int i = 0; i < 3; i++) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        if (i == 0) {
            
            _wayFlowLayout = flowLayout;
            _wayFlowLayout.estimatedItemSize = CGSizeMake(80 *SIZE, 20 *SIZE);
            _wayFlowLayout.minimumLineSpacing = 5 *SIZE;
            _wayFlowLayout.minimumInteritemSpacing = 0;
            
            _wayColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 240 *SIZE, 20 *SIZE) collectionViewLayout:_wayFlowLayout];
            _wayColl.backgroundColor = [UIColor whiteColor];
            _wayColl.bounces = NO;
            _wayColl.delegate = self;
            _wayColl.dataSource = self;
            [_wayColl registerClass:[LookMaintainDetailAddFollowCell class] forCellWithReuseIdentifier:@"LookMaintainDetailAddFollowCell"];
            [_contentView addSubview:_wayColl];
        }else if (i == 1){
            
            _comercialFlowLayout = flowLayout;
            _comercialFlowLayout.estimatedItemSize = CGSizeMake(100 *SIZE, 20 *SIZE);
            _comercialFlowLayout.minimumLineSpacing = 5 *SIZE;
            _comercialFlowLayout.minimumInteritemSpacing = 0;
            
            _comercialColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 240 *SIZE, 20 *SIZE) collectionViewLayout:_comercialFlowLayout];
            _comercialColl.backgroundColor = [UIColor whiteColor];
            _comercialColl.delegate = self;
            _comercialColl.dataSource = self;
            _comercialColl.bounces = NO;
            [_comercialColl registerClass:[CompleteSurveyCollCell class] forCellWithReuseIdentifier:@"CompleteSurveyCollCell"];
            [_contentView addSubview:_comercialColl];
        }else{
            
            _payFlowLayout = flowLayout;
            _payFlowLayout.estimatedItemSize = CGSizeMake(100 *SIZE, 20 *SIZE);
            _payFlowLayout.minimumLineSpacing = 5 *SIZE;
            _payFlowLayout.minimumInteritemSpacing = 0;
            
            _payColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 240 *SIZE, 20 *SIZE) collectionViewLayout:_payFlowLayout];
            _payColl.backgroundColor = [UIColor whiteColor];
            _payColl.delegate = self;
            _payColl.dataSource = self;
            _payColl.bounces = NO;
            [_payColl registerClass:[CompleteSurveyCollCell class] forCellWithReuseIdentifier:@"CompleteSurveyCollCell"];
            [_contentView addSubview:_payColl];
        }
    }
    
    _tagView = [[AddTagView alloc] initWithFrame:CGRectMake(0, 757 *SIZE, SCREEN_Width, 127 *SIZE)];
    if ([_dataDic[@"need_tags"] length]) {

        NSArray *arr = [_dataDic[@"need_tags"] componentsSeparatedByString:@","];
        NSMutableArray *tempArr = [@[] mutableCopy];
        NSArray *tagArr = [UserModelArchiver unarchive].Configdic[@"15"][@"param"];
        
        for (int i = 0; i < arr.count; i++) {
            
            [tagArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if ([obj[@"id"] integerValue] == [arr[i] integerValue]) {
                    [tempArr addObject:obj];
                    *stop = YES;
                }
            }];
        }
        _dataArr = [NSMutableArray arrayWithArray:tempArr];
    }
    _tagView.dataArr = [NSMutableArray arrayWithArray:_dataArr];
    [_tagView reloadInputViews];
    WS(weak);
    SS(strongSelf);
    _tagView.addBtnBlock = ^{
        
        AddTagVC *nextVC = [[AddTagVC alloc] initWithArray:weak.tagView.dataArr];
        
        nextVC.saveBtnBlock = ^(NSArray *array) {
            
            _dataArr = [NSMutableArray arrayWithArray:array];
            weak.tagView.dataArr = [NSMutableArray arrayWithArray:array];
            [weak.tagView.tagColl reloadData];
            [weak.tagView reloadInputViews];
        };
        [weak.navigationController pushViewController:nextVC animated:YES];
        
    };
    _tagView.deleteBtnBlock = ^(NSInteger idx) {
      
        [strongSelf->_dataArr removeObjectAtIndex:idx];
    };
    [_scrollView addSubview:_tagView];
    
    if ([_dataDic[@"match_tags"] count]) {
        
        _dataArr = [NSMutableArray arrayWithArray:[_dataDic[@"match_tags"] mutableCopy]];
    }
    
    _collHeader = [[BlueTitleMoreHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
    _collHeader.titleL.text = @"配套设施";
    [_collHeader.moreBtn setTitle:@"" forState:UIControlStateNormal];
    [_collHeader.moreBtn setImage:[UIImage imageNamed:@"add_40"] forState:UIControlStateNormal];
    WS(weakSelf);
//    SS(strongSelf);
    _collHeader.blueTitleMoreHeaderBlock = ^{
        
        AddEquipmentVC *nextVC;
        if ([strongSelf.property isEqualToString:@"商铺"]) {
            
            nextVC = [[AddEquipmentVC alloc] initWithType:2];
        }else if ([strongSelf.property isEqualToString:@"写字楼"]){
            
            nextVC = [[AddEquipmentVC alloc] initWithType:3];
        }
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
    
    _contentTV = [[UITextView alloc] init];
    _contentTV.layer.borderColor = YJBackColor.CGColor;
    _contentTV.layer.cornerRadius = 5 *SIZE;
    _contentTV.clipsToBounds = YES;
    _contentTV.layer.borderWidth = SIZE;
    [_followView addSubview:_contentTV];

    _commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _commitBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_commitBtn addTarget:self action:@selector(ActionCommitBtn:) forControlEvents:UIControlEventTouchUpInside];
    if (_way == 0) {
        
        [_commitBtn setTitle:@"提 交" forState:UIControlStateNormal];
    }else{
        
        [_commitBtn setTitle:@"下一步" forState:UIControlStateNormal];
    }
    [_commitBtn setBackgroundColor:YJBlueBtnColor];
    [_scrollView addSubview:_commitBtn];
    
    _typeBtn.content.text = self.property;
    if ([self.property isEqualToString:@"商铺"]) {
        
        _typeBtn->str = @"2";
        _purposeL.text = @"购买用途：";
    }else if ([self.property isEqualToString:@"写字楼"]){
        
        _typeBtn->str = @"3";
        _purposeL.text = @"购买用途：";
    }else{
        
        _typeBtn->str = @"1";
        _purposeL.text = @"置业目的：";
    }
    
    if ([self.status integerValue] == 2) {
        
        _wayColl.userInteractionEnabled = NO;
    }
    
    [self masonryUI];
    [self RemasonryUI];
    
    if ([_dataDic[@"client_level"] length]) {
        
        for (NSDictionary *dic in _levelArr) {
            
            if ([dic[@"param"] isEqualToString:_dataDic[@"client_level"]]) {
                
                _levelBtn.content.text = [NSString stringWithFormat:@"%@",dic[@"param"]];
                _levelBtn->str = [NSString stringWithFormat:@"%@",dic[@"id"]];
            }
        }
    }
    if ([_dataDic[@"total_price"] length]) {
        
        NSArray *arr = [_dataDic[@"total_price"] componentsSeparatedByString:@"-"];
        if (arr.count) {
            
            _priceBtn.selectedMinimum = [arr[0] doubleValue];
            if (arr.count > 1) {
                
                _priceBtn.selectedMaximum = [arr[1] doubleValue];
            }
        }
//        _priceBtn.textfield.text = _dataDic[@"total_price"];
    }
    if ([_dataDic[@"area"] length]) {
        
        NSArray *arr = [_dataDic[@"area"] componentsSeparatedByString:@"-"];
        if (arr.count) {
            
            _areaBtn.selectedMinimum = [arr[0] doubleValue];
            if (arr.count > 1) {
                
                _areaBtn.selectedMaximum = [arr[1] doubleValue];
            }
        }
//        _areaBtn.textfield.text = _dataDic[@"area"];
    }
    if ([_dataDic[@"used_years"] length]) {
        
        _yearTF.textfield.text = _dataDic[@"used_years"];
    }
    if ([_dataDic[@"office_level"] length]) {
        
        for (NSDictionary *dic in [self getDetailConfigArrByConfigState:OFFICE_GRADE]) {
            
            if ([dic[@"param"] isEqualToString:_dataDic[@"office_level"]]) {
                
                _officeLevelBtn.content.text = [NSString stringWithFormat:@"%@",dic[@"param"]];
                _officeLevelBtn->str = [NSString stringWithFormat:@"%@",dic[@"id"]];
            }
        }
    }
    
    if ([_dataDic[@"pay_type"] count]) {
        
        for (int i = 0; i < _payArr.count; i++) {
            
            for (int j = 0; j < [_dataDic[@"pay_type"] count]; j++) {
                
                if ([_dataDic[@"pay_type"][j] isEqualToString:_payArr[i][@"param"]]) {
                    
                    [_paySelectArr replaceObjectAtIndex:i withObject:@1];
                }
            }
        }
    }
    
    if ([_dataDic[@"shop_type"] count]) {
        
        for (int i = 0; i < _storeArr.count; i++) {
            
            for (int j = 0; j < [_dataDic[@"shop_type"] count]; j++) {
                
                if ([_dataDic[@"shop_type"][j] isEqualToString:_storeArr[i][@"param"]]) {
                    
                    [_selectStoreArr replaceObjectAtIndex:i withObject:@1];
                }
            }
            
        }
    }
    
    if ([self.property isEqualToString:@"住宅"]) {
        
        if ([_dataDic[@"buy_purpose"] length]) {
            
            for (NSDictionary *dic in [self getDetailConfigArrByConfigState:BUY_TYPE]) {
                
                if ([dic[@"param"] isEqualToString:_dataDic[@"buy_purpose"]]) {
                    
                    _purposeBtn.content.text = [NSString stringWithFormat:@"%@",dic[@"param"]];
                    _purposeBtn->str = [NSString stringWithFormat:@"%@",dic[@"id"]];
                }
            }
        }
    }else{
        
        if ([_dataDic[@"buy_use"] length]) {
            
            for (NSDictionary *dic in [self getDetailConfigArrByConfigState:BUY_USE]) {
                
                if ([dic[@"param"] isEqualToString:_dataDic[@"buy_use"]]) {
                    
                    _purposeBtn.content.text = [NSString stringWithFormat:@"%@",dic[@"param"]];
                    _purposeBtn->str = [NSString stringWithFormat:@"%@",dic[@"id"]];
                }
            }
        }
    }
    
    if ([_dataDic[@"decorate"] length]) {
        
        for (NSDictionary *dic in [self getDetailConfigArrByConfigState:DECORATE]) {
            
            if ([dic[@"param"] isEqualToString:_dataDic[@"decorate"]]) {
                
                _decorateBtn.content.text = [NSString stringWithFormat:@"%@",dic[@"param"]];
                _decorateBtn->str = [NSString stringWithFormat:@"%@",dic[@"id"]];
            }
        }
    }
    
    if ([_dataDic[@"floor_min"] length]) {
        
        for (NSDictionary *dic in _stairArr) {
            
            if ([[NSString stringWithFormat:@"%@",dic[@"id"]] isEqualToString:_dataDic[@"floor_min"]]) {
                
                _floorTF1.content.text = [NSString stringWithFormat:@"%@",dic[@"param"]];
                _floorTF1->str = [NSString stringWithFormat:@"%@",dic[@"id"]];
            }
        }
    }
    
    if ([_dataDic[@"floor_max"] length]) {
        
        for (NSDictionary *dic in _stairArr) {
            
            if ([[NSString stringWithFormat:@"%@",dic[@"id"]] isEqualToString:_dataDic[@"floor_max"]]) {
                
                _floorTF2.content.text = [NSString stringWithFormat:@"%@",dic[@"param"]];
                _floorTF2->str = [NSString stringWithFormat:@"%@",dic[@"id"]];
            }
        }
    }
    
    if ([_dataDic[@"house_type"] length]) {
        
        _houseBtn.content.text = [NSString stringWithFormat:@"%@",_dataDic[@"house_type"]];
        _houseBtn->str = [NSString stringWithFormat:@"%@",_dataDic[@"house_type_value"]];
    }
}

- (void)masonryUI{
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(NAVIGATION_BAR_HEIGHT);
        make.right.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view).offset(0);
    }];
    
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrollView).offset(0);
        make.top.equalTo(_scrollView).offset(0);
        make.right.equalTo(_scrollView).offset(0);
        make.width.mas_equalTo(SCREEN_Width);
    }];
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_contentView).offset(10 *SIZE);
        make.top.equalTo(_contentView).offset(19 *SIZE);
        make.width.mas_equalTo(65 *SIZE);
    }];
    
    [_timeContentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(78 *SIZE);
        make.top.equalTo(_contentView).offset(19 *SIZE);
        make.width.mas_equalTo(200 *SIZE);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_contentView).offset(0 *SIZE);
        make.top.equalTo(_timeL.mas_bottom).offset(19 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(2 *SIZE);
    }];
    
    [_wayL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_lineView.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(65 *SIZE);
    }];
    
    [_wayColl mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_contentView).offset(76 *SIZE);
        make.top.equalTo(_lineView.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(255 *SIZE);
        make.height.mas_equalTo(_wayColl.collectionViewLayout.collectionViewContentSize.height + 5 *SIZE);
    }];
    
    [_levelL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_wayColl.mas_bottom).offset(40 *SIZE);
        make.width.mas_equalTo(65 *SIZE);
    }];
    
    [_levelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(80 *SIZE);
        make.top.equalTo(_wayColl.mas_bottom).offset(29 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_typeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_levelBtn.mas_bottom).offset(30 *SIZE);
        make.width.mas_equalTo(65 *SIZE);
    }];
    
    [_typeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(80 *SIZE);
        make.top.equalTo(_levelBtn.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_typeBtn.mas_bottom).offset(30 *SIZE);
        make.width.mas_equalTo(65 *SIZE);
    }];
    
    [_priceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(80 *SIZE);
        make.top.equalTo(_typeBtn.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_areaL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_priceBtn.mas_bottom).offset(30 *SIZE);
        make.width.mas_equalTo(65 *SIZE);
    }];
    
    [_areaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(80 *SIZE);
        make.top.equalTo(_priceBtn.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
#pragma mark -- 区分 --
    
#pragma mark -- 住宅 --
    
    [_houseTypeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_areaBtn.mas_bottom).offset(30 *SIZE);
        make.width.mas_equalTo(65 *SIZE);
    }];
    
    [_houseBtn mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(_contentView).offset(80 *SIZE);
        make.top.equalTo(_areaBtn.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
//    [_houseBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(_contentView).offset(80 *SIZE);
//        make.top.equalTo(_areaBtn.mas_bottom).offset(20 *SIZE);
//        make.width.mas_equalTo(75 *SIZE);
//        make.height.mas_equalTo(33 *SIZE);
//    }];
//
//    [_houseBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(_contentView).offset(175.5 *SIZE);
//        make.top.equalTo(_areaBtn.mas_bottom).offset(20 *SIZE);
//        make.width.mas_equalTo(75 *SIZE);
//        make.height.mas_equalTo(33 *SIZE);
//    }];
//
//    [_houseBtn3 mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(_contentView).offset(263 *SIZE);
//        make.top.equalTo(_areaBtn.mas_bottom).offset(20 *SIZE);
//        make.width.mas_equalTo(75 *SIZE);
//        make.height.mas_equalTo(33 *SIZE);
//    }];
    
    [_floorL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(10 *SIZE);
        make.top.equalTo(_houseBtn.mas_bottom).offset(29 *SIZE);
        make.width.equalTo(@(70 *SIZE));
        make.height.equalTo(@(13 *SIZE));
    }];
    
    [_floorTF1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(81 *SIZE);
        make.top.equalTo(_houseBtn.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(117 *SIZE));
        make.height.equalTo(@(33 *SIZE));
    }];
    
    [_floorTF2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(222 *SIZE);
        make.top.equalTo(_houseBtn.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(117 *SIZE));
        make.height.equalTo(@(33 *SIZE));
    }];

    [_decorateL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_floorTF1.mas_bottom).offset(30 *SIZE);
        make.width.mas_equalTo(65 *SIZE);
    }];
    
    [_decorateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(80 *SIZE);
        make.top.equalTo(_floorTF1.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_purposeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_decorateBtn.mas_bottom).offset(30 *SIZE);
        make.width.mas_equalTo(65 *SIZE);
    }];
    
    [_purposeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(80 *SIZE);
        make.top.equalTo(_decorateBtn.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
#pragma mark -- 商铺 --
    
    [_commercialL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_areaBtn.mas_bottom).offset(26 *SIZE);
        make.width.mas_equalTo(65 *SIZE);
    }];
    
    [_comercialColl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(76 *SIZE);
        make.top.equalTo(_areaBtn.mas_bottom).offset(25 *SIZE);
        make.width.mas_equalTo(255 *SIZE);
        make.height.mas_equalTo(_payColl.collectionViewLayout.collectionViewContentSize.height + 15 *SIZE * (_payArr.count / 2 + 1));
        make.bottom.equalTo(_contentView.mas_bottom).offset(-10 *SIZE);
    }];
    
    [_purposeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_comercialColl.mas_bottom).offset(40 *SIZE);
        make.width.mas_equalTo(65 *SIZE);
    }];
    
    [_purposeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(80 *SIZE);
        make.top.equalTo(_comercialColl.mas_bottom).offset(30 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
#pragma mark -- 写字楼 --
    
    [_officeLevelL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_areaBtn.mas_bottom).offset(30 *SIZE);
        make.width.mas_equalTo(65 *SIZE);
    }];
    
    [_officeLevelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(80 *SIZE);
        make.top.equalTo(_areaBtn.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_purposeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_officeLevelBtn.mas_bottom).offset(30 *SIZE);
        make.width.mas_equalTo(65 *SIZE);
    }];
    
    [_purposeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(80 *SIZE);
        make.top.equalTo(_officeLevelBtn.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_yearL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_purposeBtn.mas_bottom).offset(30 *SIZE);
        make.width.mas_equalTo(65 *SIZE);
    }];
    
    [_yearTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(80 *SIZE);
        make.top.equalTo(_purposeBtn.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_payWayL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_yearTF.mas_bottom).offset(26 *SIZE);
        make.width.mas_equalTo(65 *SIZE);
    }];
    
    [_payColl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(76 *SIZE);
        make.top.equalTo(_yearTF.mas_bottom).offset(25 *SIZE);
        make.width.mas_equalTo(255 *SIZE);
        make.height.mas_equalTo(_payColl.collectionViewLayout.collectionViewContentSize.height + 15 *SIZE * (_payArr.count / 2 + 1));
        make.bottom.equalTo(_contentView.mas_bottom).offset(-10 *SIZE);
    }];
    
#pragma mark -- 区分 --
    [_payWayL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_purposeBtn.mas_bottom).offset(26 *SIZE);
        make.width.mas_equalTo(65 *SIZE);
    }];
    
    [_payColl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(76 *SIZE);
        make.top.equalTo(_purposeBtn.mas_bottom).offset(25 *SIZE);
        make.width.mas_equalTo(255 *SIZE);
        make.height.mas_equalTo(_payColl.collectionViewLayout.collectionViewContentSize.height + 15 *SIZE * (_payArr.count / 2 + 1));
        make.bottom.equalTo(_contentView.mas_bottom).offset(-10 *SIZE);
    }];
    
#pragma mark -- 区分 --
    
#pragma mark -- 住宅 --
    [_tagView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrollView).offset(0);
        make.top.equalTo(_contentView.mas_bottom).offset(10 *SIZE);
        make.right.equalTo(_scrollView).offset(0);
        make.width.equalTo(@(SCREEN_Width));
        make.height.equalTo(@(127 *SIZE));
    }];
    
#pragma mark -- 商铺、写字楼 --
    
    [_CollView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrollView).offset(0);
        make.top.equalTo(_contentView.mas_bottom).offset(10 *SIZE);
        make.right.equalTo(_scrollView).offset(0);
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
    
#pragma mark -- 区分 --
    
    [_followView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_scrollView).offset(0);
        make.top.equalTo(_tagView.mas_bottom).offset(10 *SIZE);
        make.right.equalTo(_scrollView).offset(0);
        make.width.equalTo(@(SCREEN_Width));
    }];
    
    [_contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_followView).offset(9 *SIZE);
        make.top.equalTo(_followView).offset(20 *SIZE);
        make.width.mas_equalTo(65 *SIZE);
    }];
    
    [_contentTV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_followView).offset(80 *SIZE);
        make.top.equalTo(_followView).offset(10 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(77 *SIZE);
    }];
    
    [_nextTimeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_followView).offset(9 *SIZE);
        make.top.equalTo(_contentTV.mas_bottom).offset(40 *SIZE);
        make.width.mas_equalTo(65 *SIZE);
    }];
    
    [_nextTimeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_followView).offset(80 *SIZE);
        make.top.equalTo(_contentTV.mas_bottom).offset(29 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
        make.bottom.equalTo(_followView.mas_bottom).offset(-33 *SIZE);
    }];
    
    [_commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_scrollView).offset(22 *SIZE);
        make.top.equalTo(_followView.mas_bottom).offset(28 *SIZE);
        make.bottom.equalTo(_scrollView).offset(-43 *SIZE);
        make.width.mas_equalTo(317 *SIZE);
        make.height.mas_equalTo(40 *SIZE);
    }];
}

- (void)RemasonryUI{
    
    _houseBtn.hidden = YES;
//    _houseBtn1.hidden = YES;
//    _houseBtn2.hidden = YES;
//    _houseBtn3.hidden = YES;
    _houseTypeL.hidden = YES;
    _floorL.hidden = YES;
    _floorTF1.hidden = YES;
    _floorTF2.hidden = YES;
    _decorateL.hidden = YES;
    _decorateBtn.hidden = YES;
    _tagView.hidden = YES;
    _commercialL.hidden = YES;
    _comercialColl.hidden = YES;
    _CollView.hidden = YES;
    _officeLevelL.hidden = YES;
    _officeLevelBtn.hidden = YES;
    _yearTF.hidden = YES;
    _yearL.hidden = YES;
    
    _purposeBtn.content.text = @"";
    [_dataArr removeAllObjects];
    
    if ([_dataDic[@"need_tags"] length]) {
        
        NSArray *arr = [_dataDic[@"need_tags"] componentsSeparatedByString:@","];
        NSMutableArray *tempArr = [@[] mutableCopy];
        NSArray *tagArr = [UserModelArchiver unarchive].Configdic[@"15"][@"param"];
        
        for (int i = 0; i < arr.count; i++) {
            
            [tagArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if ([obj[@"id"] integerValue] == [arr[i] integerValue]) {
                    [tempArr addObject:obj];
                    *stop = YES;
                }
            }];
        }
        _dataArr = [NSMutableArray arrayWithArray:tempArr];
    }
    if ([_dataDic[@"match_tags"] count]) {
        
        _dataArr = [NSMutableArray arrayWithArray:[_dataDic[@"match_tags"] mutableCopy]];
    }
    [_facilityColl reloadData];
    [_tagView.tagColl reloadData];
    
    if ([self.property isEqualToString:@"写字楼"]) {
        
        _purposeL.text = @"购买用途：";
        _officeLevelL.hidden = NO;
        _officeLevelBtn.hidden = NO;
        _yearTF.hidden = NO;
        _yearL.hidden = NO;
        _CollView.hidden = NO;
        [_officeLevelL mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(_contentView).offset(9 *SIZE);
            make.top.equalTo(_areaBtn.mas_bottom).offset(30 *SIZE);
            make.width.mas_equalTo(65 *SIZE);
        }];
        
        [_officeLevelBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(_contentView).offset(80 *SIZE);
            make.top.equalTo(_areaBtn.mas_bottom).offset(20 *SIZE);
            make.width.mas_equalTo(258 *SIZE);
            make.height.mas_equalTo(33 *SIZE);
        }];
        
        [_purposeL mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(_contentView).offset(9 *SIZE);
            make.top.equalTo(_officeLevelBtn.mas_bottom).offset(30 *SIZE);
            make.width.mas_equalTo(65 *SIZE);
        }];
        
        [_purposeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(_contentView).offset(80 *SIZE);
            make.top.equalTo(_officeLevelBtn.mas_bottom).offset(20 *SIZE);
            make.width.mas_equalTo(258 *SIZE);
            make.height.mas_equalTo(33 *SIZE);
        }];
        
        [_yearL mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(_contentView).offset(9 *SIZE);
            make.top.equalTo(_purposeBtn.mas_bottom).offset(30 *SIZE);
            make.width.mas_equalTo(65 *SIZE);
        }];
        
        [_yearTF mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(_contentView).offset(80 *SIZE);
            make.top.equalTo(_purposeBtn.mas_bottom).offset(20 *SIZE);
            make.width.mas_equalTo(258 *SIZE);
            make.height.mas_equalTo(33 *SIZE);
        }];
        
        [_payWayL mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(_contentView).offset(9 *SIZE);
            make.top.equalTo(_yearTF.mas_bottom).offset(26 *SIZE);
            make.width.mas_equalTo(65 *SIZE);
        }];
        
        [_payColl mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(_contentView).offset(76 *SIZE);
            make.top.equalTo(_yearTF.mas_bottom).offset(25 *SIZE);
            make.width.mas_equalTo(255 *SIZE);
            make.height.mas_equalTo(_payColl.collectionViewLayout.collectionViewContentSize.height + 15 *SIZE * (_payArr.count / 2 + 1));
            make.bottom.equalTo(_contentView.mas_bottom).offset(-10 *SIZE);
        }];
        
        [_CollView mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(_scrollView).offset(0);
            make.top.equalTo(_contentView.mas_bottom).offset(10 *SIZE);
            make.right.equalTo(_scrollView).offset(0);
            make.width.equalTo(@(SCREEN_Width));
            make.height.equalTo(@(127 *SIZE));
        }];
        
        [_facilityColl mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self->_CollView).offset(0 *SIZE);
            make.top.equalTo(self->_CollView).offset(40 *SIZE);
            make.width.mas_equalTo(SCREEN_Width);
            make.height.mas_equalTo(self->_facilityColl.collectionViewLayout.collectionViewContentSize.height);
            make.bottom.equalTo(self->_CollView.mas_bottom).offset(0 *SIZE);
        }];
    }else if ([self.property isEqualToString:@"商铺"]){
        
        _purposeL.text = @"购买用途：";
        _CollView.hidden = NO;
        _commercialL.hidden = NO;
        _comercialColl.hidden = NO;
        
        [_commercialL mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(_contentView).offset(9 *SIZE);
            make.top.equalTo(_areaBtn.mas_bottom).offset(26 *SIZE);
            make.width.mas_equalTo(65 *SIZE);
        }];
        
        [_comercialColl mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(_contentView).offset(76 *SIZE);
            make.top.equalTo(_areaBtn.mas_bottom).offset(25 *SIZE);
            make.width.mas_equalTo(255 *SIZE);
            make.height.mas_equalTo(_comercialColl.collectionViewLayout.collectionViewContentSize.height + 10 *SIZE * (_storeArr.count / 2 + 1));
//            make.bottom.equalTo(_contentView.mas_bottom).offset(-10 *SIZE);
        }];
        
        [_purposeL mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(_contentView).offset(9 *SIZE);
            make.top.equalTo(_comercialColl.mas_bottom).offset(40 *SIZE);
            make.width.mas_equalTo(65 *SIZE);
        }];
        
        [_purposeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(_contentView).offset(80 *SIZE);
            make.top.equalTo(_comercialColl.mas_bottom).offset(30 *SIZE);
            make.width.mas_equalTo(258 *SIZE);
            make.height.mas_equalTo(33 *SIZE);
        }];
        
        [_payWayL mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(_contentView).offset(9 *SIZE);
            make.top.equalTo(_purposeBtn.mas_bottom).offset(26 *SIZE);
            make.width.mas_equalTo(65 *SIZE);
        }];
        
        [_payColl mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(_contentView).offset(76 *SIZE);
            make.top.equalTo(_purposeBtn.mas_bottom).offset(25 *SIZE);
            make.width.mas_equalTo(255 *SIZE);
            make.height.mas_equalTo(_payColl.collectionViewLayout.collectionViewContentSize.height + 15 *SIZE * (_payArr.count / 2 + 1));
            make.bottom.equalTo(_contentView.mas_bottom).offset(-10 *SIZE);
        }];
        
        [_CollView mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(_scrollView).offset(0);
            make.top.equalTo(_contentView.mas_bottom).offset(10 *SIZE);
            make.right.equalTo(_scrollView).offset(0);
            make.width.equalTo(@(SCREEN_Width));
            make.height.equalTo(@(127 *SIZE));
        }];
        
        [_facilityColl mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self->_CollView).offset(0 *SIZE);
            make.top.equalTo(self->_CollView).offset(40 *SIZE);
            make.width.mas_equalTo(SCREEN_Width);
            make.height.mas_equalTo(self->_facilityColl.collectionViewLayout.collectionViewContentSize.height);
            make.bottom.equalTo(self->_CollView.mas_bottom).offset(0 *SIZE);
        }];
        
        [_followView mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(_scrollView).offset(0);
            make.top.equalTo(_CollView.mas_bottom).offset(10 *SIZE);
            make.right.equalTo(_scrollView).offset(0);
            make.width.equalTo(@(SCREEN_Width));
        }];

    }else{
        
        _purposeL.text = @"置业目的：";
        _houseBtn.hidden = NO;
//        _houseBtn1.hidden = NO;
//        _houseBtn2.hidden = NO;
//        _houseBtn3.hidden = NO;
        _houseTypeL.hidden = NO;
        _floorL.hidden = NO;
        _floorTF1.hidden = NO;
        _floorTF2.hidden = NO;
        _decorateL.hidden = NO;
        _decorateBtn.hidden = NO;
        _tagView.hidden = NO;
        [_houseTypeL mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(_contentView).offset(9 *SIZE);
            make.top.equalTo(_areaBtn.mas_bottom).offset(30 *SIZE);
            make.width.mas_equalTo(65 *SIZE);
        }];
        
        [_houseBtn mas_remakeConstraints:^(MASConstraintMaker *make) {

            make.left.equalTo(_contentView).offset(80 *SIZE);
            make.top.equalTo(_areaBtn.mas_bottom).offset(20 *SIZE);
            make.width.mas_equalTo(258 *SIZE);
            make.height.mas_equalTo(33 *SIZE);
        }];
//        [_houseBtn1 mas_remakeConstraints:^(MASConstraintMaker *make) {
//
//            make.left.equalTo(_contentView).offset(80 *SIZE);
//            make.top.equalTo(_areaBtn.mas_bottom).offset(20 *SIZE);
//            make.width.mas_equalTo(75 *SIZE);
//            make.height.mas_equalTo(33 *SIZE);
//        }];
//
//        [_houseBtn2 mas_remakeConstraints:^(MASConstraintMaker *make) {
//
//            make.left.equalTo(_contentView).offset(175.5 *SIZE);
//            make.top.equalTo(_areaBtn.mas_bottom).offset(20 *SIZE);
//            make.width.mas_equalTo(75 *SIZE);
//            make.height.mas_equalTo(33 *SIZE);
//        }];
//
//        [_houseBtn3 mas_remakeConstraints:^(MASConstraintMaker *make) {
//
//            make.left.equalTo(_contentView).offset(264 *SIZE);
//            make.top.equalTo(_areaBtn.mas_bottom).offset(20 *SIZE);
//            make.width.mas_equalTo(75 *SIZE);
//            make.height.mas_equalTo(33 *SIZE);
//        }];
        
        [_floorL mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(_contentView).offset(10 *SIZE);
            make.top.equalTo(_houseBtn.mas_bottom).offset(29 *SIZE);
            make.width.equalTo(@(70 *SIZE));
            make.height.equalTo(@(13 *SIZE));
        }];
        
        [_floorTF1 mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(_contentView).offset(81 *SIZE);
            make.top.equalTo(_houseBtn.mas_bottom).offset(19 *SIZE);
            make.width.equalTo(@(117 *SIZE));
            make.height.equalTo(@(33 *SIZE));
        }];
        
        [_floorTF2 mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(_contentView).offset(222 *SIZE);
            make.top.equalTo(_houseBtn.mas_bottom).offset(19 *SIZE);
            make.width.equalTo(@(117 *SIZE));
            make.height.equalTo(@(33 *SIZE));
        }];
        
        [_decorateL mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(_contentView).offset(9 *SIZE);
            make.top.equalTo(_floorTF1.mas_bottom).offset(30 *SIZE);
            make.width.mas_equalTo(65 *SIZE);
        }];
        
        [_decorateBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(_contentView).offset(80 *SIZE);
            make.top.equalTo(_floorTF1.mas_bottom).offset(20 *SIZE);
            make.width.mas_equalTo(258 *SIZE);
            make.height.mas_equalTo(33 *SIZE);
        }];
        
        [_purposeL mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(_contentView).offset(9 *SIZE);
            make.top.equalTo(_decorateBtn.mas_bottom).offset(30 *SIZE);
            make.width.mas_equalTo(65 *SIZE);
        }];
        
        [_purposeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(_contentView).offset(80 *SIZE);
            make.top.equalTo(_decorateBtn.mas_bottom).offset(20 *SIZE);
            make.width.mas_equalTo(258 *SIZE);
            make.height.mas_equalTo(33 *SIZE);
        }];
        
        [_payWayL mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(_contentView).offset(9 *SIZE);
            make.top.equalTo(_purposeBtn.mas_bottom).offset(26 *SIZE);
            make.width.mas_equalTo(65 *SIZE);
        }];
        
        [_payColl mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(_contentView).offset(76 *SIZE);
            make.top.equalTo(_purposeBtn.mas_bottom).offset(25 *SIZE);
            make.width.mas_equalTo(255 *SIZE);
            make.height.mas_equalTo(_payColl.collectionViewLayout.collectionViewContentSize.height + 15 *SIZE * (_payArr.count / 2 + 1));
            make.bottom.equalTo(_contentView.mas_bottom).offset(-10 *SIZE);
        }];
        
        [_tagView mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(_scrollView).offset(0);
            make.top.equalTo(_contentView.mas_bottom).offset(10 *SIZE);
            make.right.equalTo(_scrollView).offset(0);
            make.width.equalTo(@(SCREEN_Width));
            make.height.equalTo(@(127 *SIZE));
        }];

        [_followView mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(_scrollView).offset(0);
            make.top.equalTo(_tagView.mas_bottom).offset(10 *SIZE);
            make.right.equalTo(_scrollView).offset(0);
            make.width.equalTo(@(SCREEN_Width));
        }];
    }
}


@end
