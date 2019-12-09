//
//  AddAreaNeedVC.m
//  云渠道
//
//  Created by 谷治墙 on 2019/12/3.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "AddAreaNeedVC.h"

#import "AreaCustomListVC.h"

#import "DropDownBtn.h"
#import "BorderTF.h"
#import "TTRangeSlider.h"
#import "HouseTypePickView.h"


#import "BoxSelectCollCell.h"

@interface AddAreaNeedVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,TTRangeSliderDelegate,UITextFieldDelegate,UITextViewDelegate>
{
    
    NSMutableArray *_typeArr;
    NSMutableArray *_propertyArr;
    
    NSMutableArray *_typeSelectArr;
    NSMutableArray *_propertySelectArr;
    
    NSMutableDictionary *_DataDic;
}

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout1;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) UILabel *typeL;

@property (nonatomic, strong) UICollectionView *typeColl;

@property (nonatomic, strong) UILabel *propertyL;

@property (nonatomic, strong) UICollectionView *propertyColl;

@property (nonatomic, strong) UILabel *regionL;

@property (nonatomic, strong) UILabel *priceL;

@property (strong, nonatomic) TTRangeSlider *priceBtn;

@property (nonatomic, strong) UILabel *areaL;

@property (strong, nonatomic) TTRangeSlider *areaBtn;

@property (nonatomic, strong) UILabel *houseTypeL;

@property (nonatomic, strong) DropDownBtn *houseTypeBtn;

@property (nonatomic, strong) UILabel *markL;

@property (nonatomic, strong) UITextView *markTV;

@property (nonatomic, strong) UIButton *nextBtn;

@end

@implementation AddAreaNeedVC

- (instancetype)initWithDataDic:(NSDictionary *)dataDic
{
    self = [super init];
    if (self) {
        
        _DataDic = [[NSMutableDictionary alloc] initWithDictionary:dataDic];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
    [self RequestMethod];
}

- (void)initDataSource{
    
    _typeArr = [@[] mutableCopy];
    _propertyArr = [@[] mutableCopy];
    _typeSelectArr = [@[] mutableCopy];
    _propertySelectArr = [@[] mutableCopy];
}

- (void)RequestMethod{
    
    [BaseRequest GET:ForumFuncList_URL parameters:@{} success:^(id resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            _typeArr = [NSMutableArray arrayWithArray:resposeObject[@"data"]];
            for (int i = 0; i < _typeArr.count; i++) {
                
                if (i == 0) {
                    
                    [_typeSelectArr addObject:@1];
                }else{
                    
                    [_typeSelectArr addObject:@0];
                }
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [_typeColl reloadData];
                if (_typeArr.count) {
                    
                    [_typeColl mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.height.mas_equalTo(self->_typeColl.collectionViewLayout.collectionViewContentSize.height);
                    }];
                }else{
                 
                    [_typeColl mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.height.mas_equalTo(20 *SIZE);
                    }];
                }
            });
            
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [self showContent:@"网络错误"];
    }];
    
    [BaseRequest GET:ForumPropertyList_URL parameters:@{} success:^(id resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            _propertyArr = [NSMutableArray arrayWithArray:resposeObject[@"data"]];
            for (int i = 0; i < _propertyArr.count; i++) {
                
                if (i == 0) {
                    
                    [_propertySelectArr addObject:@1];
                }else{
                    
                    [_propertySelectArr addObject:@0];
                }
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [_propertyColl reloadData];
                
                if (_propertyArr.count) {
                    
                    [_propertyColl mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.height.mas_equalTo(self->_propertyColl.collectionViewLayout.collectionViewContentSize.height);
                    }];
                }else{
                 
                    [_propertyColl mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.height.mas_equalTo(20 *SIZE);
                    }];
                }
            });
            
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [self showContent:@"网络错误"];
    }];
}

- (void)ActionTagBtn:(UIButton *)btn{
    
    if (btn.tag == 2) {
        
        HouseTypePickView *view = [[HouseTypePickView alloc] initWithFrame:self.view.bounds];
        view.houseTypePickViewBlock = ^(NSString * _Nonnull room, NSString * _Nonnull hall, NSString * _Nonnull bath) {
            
            _houseTypeBtn.content.text = [NSString stringWithFormat:@"%@室%@厅%@卫",room,hall,bath];
            _houseTypeBtn->str = [NSString stringWithFormat:@"%@,%@,%@",room,hall,bath];
        };
        [self.view addSubview:view];
    }
}

- (void)ActionNextBtn:(UIButton *)btn{
    
    NSString *property = @"";;
    NSString *type = @"";
    for (int i = 0; i < _propertySelectArr.count; i++) {
        
        if ([_propertySelectArr[i] integerValue] == 1) {
            
            if (property.length) {
                
                property = [NSString stringWithFormat:@"%@,%@",property,_propertyArr[i][@"id"]];
            }else{
                
                property = [NSString stringWithFormat:@"%@",_propertyArr[i][@"id"]];
            }
        }
    }
    for (int i = 0; i < _typeSelectArr.count; i++) {
        
        if ([_typeSelectArr[i] integerValue] == 1) {
            
            if (type.length) {
                
                type = [NSString stringWithFormat:@"%@,%@",property,@"1"];
            }else{
                
                type = [NSString stringWithFormat:@"%@",@"1"];
            }
        }
    }
    if (property.length) {
        
        [_DataDic setValue:property forKey:@"property_type"];
    }
    if (type.length) {
        
        [_DataDic setValue:type forKey:@"type"];
    }
    _DataDic[@"price_min"] = [NSString stringWithFormat:@"%.0f",_priceBtn.selectedMinimum];
    _DataDic[@"price_max"] = [NSString stringWithFormat:@"%.0f",_priceBtn.selectedMaximum];
    _DataDic[@"area_min"] = [NSString stringWithFormat:@"%.0f",_areaBtn.selectedMinimum];
    _DataDic[@"area_max"] = [NSString stringWithFormat:@"%.0f",_areaBtn.selectedMaximum];
    if (_markTV.text.length) {
        
        [_DataDic setValue:_markTV.text forKey:@"comment"];
    }
    if (_houseTypeBtn.content.text.length) {
        
        [_DataDic setValue:_houseTypeBtn->str forKey:@"house_type"];
    }
    
    [BaseRequest POST:ClientOtherBuyAdd_URL parameters:_DataDic success:^(id resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if (self.addAreaNeedVCBlock) {
                
                self.addAreaNeedVCBlock();
            }
            for (UIViewController *vc in self.navigationController.viewControllers) {
                
                if ([vc isKindOfClass:[AreaCustomListVC class]]) {
                    
                    [self.navigationController popToViewController:vc animated:YES];
                }
            }
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
       
        [self showContent:@"网络错误"];
    }];
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

#pragma mark -- CollectionView


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (collectionView == _typeColl) {
        
        return _typeArr.count;
    }
    return _propertyArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    BoxSelectCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BoxSelectCollCell" forIndexPath:indexPath];
    if (!cell) {
    
        cell = [[BoxSelectCollCell alloc] initWithFrame:CGRectMake(0, 0, 60 *SIZE, 20 *SIZE)];
    }
    
    cell.tag = 1;
    
    if (collectionView == _typeColl) {
        
        [cell setIsSelect:[_typeSelectArr[indexPath.item] integerValue]];
        
        cell.titleL.text = _typeArr[indexPath.item];//[@"name"];
    }else{
        
        [cell setIsSelect:[_propertySelectArr[indexPath.item] integerValue]];
        
        cell.titleL.text = _propertyArr[indexPath.item][@"name"];//[@"config_name"];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (collectionView == _typeColl) {
        
        for (int i = 0; i < _typeSelectArr.count; i++) {
            
            [_typeSelectArr replaceObjectAtIndex:i withObject:@0];
        }
//        _followWay = [NSString stringWithFormat:@"%@",_followArr[indexPath.item][@"id"]];
        [_typeSelectArr replaceObjectAtIndex:indexPath.item withObject:@1];

    }else{
        
        for (int i = 0; i < _propertySelectArr.count; i++) {
            
            [_propertySelectArr replaceObjectAtIndex:i withObject:@0];
        }
//        _level = [NSString stringWithFormat:@"%@",_levelArr[indexPath.item][@"config_id"]];
        
//        NSDate *newDate = [[NSDate date] dateByAddingTimeInterval:24 * 60 * 60  * [_levelArr[indexPath.item][@"value_time"] integerValue]];
//        _nextTimeBtn.content.text = [NSString stringWithFormat:@"%@", [_formatter stringFromDate:newDate]];
        [_propertySelectArr replaceObjectAtIndex:indexPath.item withObject:@1];
    }
    
    [collectionView reloadData];
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"添加客户";
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.backgroundColor = CLWhiteColor;
    [self.view addSubview:_scrollView];
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.itemSize = CGSizeMake(100 *SIZE, 20 *SIZE);
    _flowLayout1 = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout1.itemSize = CGSizeMake(100 *SIZE, 20 *SIZE);
    
    _typeColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 255 *SIZE, 100 *SIZE) collectionViewLayout:_flowLayout];
    _typeColl.backgroundColor = CLWhiteColor;
    _typeColl.delegate = self;
    _typeColl.dataSource = self;
    [_typeColl registerClass:[BoxSelectCollCell class] forCellWithReuseIdentifier:@"BoxSelectCollCell"];
    [_scrollView addSubview:_typeColl];
    
    _propertyColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 255 *SIZE, 100 *SIZE) collectionViewLayout:_flowLayout1];
    _propertyColl.backgroundColor = CLWhiteColor;
    _propertyColl.delegate = self;
    _propertyColl.dataSource = self;
    [_propertyColl registerClass:[BoxSelectCollCell class] forCellWithReuseIdentifier:@"BoxSelectCollCell"];
    [_scrollView addSubview:_propertyColl];
    
    NSArray *titleArr = @[@"需求类型：",@"意向物业：",@"区域：",@"总价：",@"面积：",@"户型：",@"备注："];
    for (int i = 0; i < 7; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = YJTitleLabColor;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        label.text = titleArr[i];
        if (i == 0) {
            
            _typeL = label;
            [_scrollView addSubview:_typeL];
        }else if (i == 1){
            
            _propertyL = label;
            [_scrollView addSubview:_propertyL];
        }else if (i == 2){
            
            _regionL = label;
            _regionL.text = [NSString stringWithFormat:@"区域：%@%@",_DataDic[@"recommend_city_name"],_DataDic[@"recommend_district_name"]];
            [_scrollView addSubview:_regionL];
        }else if (i == 3){
            
            _priceL = label;
            [_scrollView addSubview:_priceL];
        }else if (i == 4){
            
            _areaL = label;
            [_scrollView addSubview:_areaL];
        }else if (i == 5){
            
            _houseTypeL = label;
            [_scrollView addSubview:_houseTypeL];
        }else{
            
            _markL = label;
            [_scrollView addSubview:_markL];
        }
    }
    
    for (int i = 0 ; i < 3; i++) {
        
        DropDownBtn *btn = [[DropDownBtn alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
        btn.tag = i;
        [btn addTarget:self action:@selector(ActionTagBtn:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0) {
            
            _priceBtn = [[TTRangeSlider alloc] initWithFrame:btn.frame];
            _priceBtn.minValue = 0;
            _priceBtn.maxValue = 1000;
            _priceBtn.delegate = self;
            NSNumberFormatter *customFormatter = [[NSNumberFormatter alloc] init];
            customFormatter.positiveSuffix = @"万";
            _priceBtn.maxFormatter = customFormatter;
            _priceBtn.minFormatter = customFormatter;
            [_scrollView addSubview:_priceBtn];
        }else if (i == 1){
            
            _areaBtn = [[TTRangeSlider alloc] initWithFrame:btn.frame];
            _areaBtn.minValue = 0;
            _areaBtn.maxValue = 500;
            NSNumberFormatter *customFormatter = [[NSNumberFormatter alloc] init];
            customFormatter.positiveSuffix = @"㎡";
            _areaBtn.maxFormatter = customFormatter;
            _areaBtn.minFormatter = customFormatter;
            [_scrollView addSubview:_areaBtn];
        }else{
            
            _houseTypeBtn = btn;
            [_scrollView addSubview:_houseTypeBtn];
        }
    }
    
    _markTV = [[UITextView alloc] init];
    _markTV.delegate = self;
    _markTV.contentInset = UIEdgeInsetsMake(10 *SIZE, 12 *SIZE, 12 *SIZE, 12 *SIZE);
    _markTV.layer.borderColor = _houseTypeBtn.layer.borderColor;
    _markTV.layer.borderWidth = SIZE;
    _markTV.layer.cornerRadius = _houseTypeBtn.layer.cornerRadius;
    _markTV.clipsToBounds = YES;
       
    [_scrollView addSubview:_markTV];
    
    _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_nextBtn setBackgroundColor:YJBlueBtnColor];
    _nextBtn.layer.cornerRadius = 2 *SIZE;
    _nextBtn.clipsToBounds = YES;
    [_nextBtn addTarget:self action:@selector(ActionNextBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_nextBtn setTitle:@"确定" forState:UIControlStateNormal];
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
    
    [_typeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrollView).offset(10 *SIZE);
        make.top.equalTo(_scrollView).offset(10 *SIZE);
        make.width.equalTo(@(70 *SIZE));
    }];
    
    [_typeColl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_scrollView).offset(12 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(self->_typeColl.collectionViewLayout.collectionViewContentSize.height);
    }];
    
    [_propertyL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrollView).offset(10 *SIZE);
        make.top.equalTo(_typeColl.mas_bottom).offset(20 *SIZE);
        make.width.equalTo(@(70 *SIZE));
    }];
    
    [_propertyColl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(_typeColl.mas_bottom).offset(16 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(self->_typeColl.collectionViewLayout.collectionViewContentSize.height);
    }];
    
    [_regionL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(10 *SIZE);
        make.top.equalTo(self->_propertyColl.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(300 *SIZE);
    }];
    
    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(_scrollView).offset(10 *SIZE);
        make.top.equalTo(_regionL.mas_bottom).offset(20 *SIZE);
        make.width.equalTo(@(70 *SIZE));
    }];
    
    [_priceBtn mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(_scrollView).offset(81 *SIZE);
        make.top.equalTo(_priceL.mas_bottom).offset(10 *SIZE);
        make.width.equalTo(@(258 *SIZE));
        make.height.equalTo(@(33 *SIZE));
    }];
    
    [_areaL mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(_scrollView).offset(10 *SIZE);
        make.top.equalTo(_priceBtn.mas_bottom).offset(20 *SIZE);
        make.width.equalTo(@(70 *SIZE));
    }];
    
    [_areaBtn mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(_scrollView).offset(81 *SIZE);
        make.top.equalTo(_priceBtn.mas_bottom).offset(10 *SIZE);
        make.width.equalTo(@(258 *SIZE));
        make.height.equalTo(@(33 *SIZE));
    }];
    
    [_houseTypeL mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(_scrollView).offset(10 *SIZE);
        make.top.equalTo(_areaBtn.mas_bottom).offset(20 *SIZE);
        make.width.equalTo(@(70 *SIZE));
    }];
    
    [_houseTypeBtn mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(_scrollView).offset(81 *SIZE);
        make.top.equalTo(_areaBtn.mas_bottom).offset(10 *SIZE);
        make.width.equalTo(@(258 *SIZE));
        make.height.equalTo(@(33 *SIZE));
    }];
    
    [_markL mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(_scrollView).offset(10 *SIZE);
        make.top.equalTo(_houseTypeBtn.mas_bottom).offset(20 *SIZE);
        make.width.equalTo(@(70 *SIZE));
    }];
    
    [_markTV mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(_scrollView).offset(80 *SIZE);
        make.top.equalTo(_houseTypeBtn.mas_bottom).offset(10 *SIZE);
        make.height.equalTo(@(117 *SIZE));
        make.width.equalTo(@(258 *SIZE));
    }];
    
    [_nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(_scrollView).offset(40 *SIZE);
        make.top.equalTo(_markTV.mas_bottom).offset(40 *SIZE);
        make.width.equalTo(@(280 *SIZE));
        make.height.equalTo(@(40 *SIZE));
        make.bottom.equalTo(_scrollView.mas_bottom).offset(-10 *SIZE);
    }];
}

@end
