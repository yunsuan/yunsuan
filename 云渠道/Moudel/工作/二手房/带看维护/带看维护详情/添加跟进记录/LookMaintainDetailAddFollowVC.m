//
//  LookMaintainDetailAddFollowVC.m
//  云渠道
//
//  Created by 谷治墙 on 2019/1/25.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "LookMaintainDetailAddFollowVC.h"

#import "SinglePickView.h"
#import "DateChooseView.h"

#import "DropDownBtn.h"
#import "BorderTF.h"
#import "CompleteSurveyCollCell.h"

@interface LookMaintainDetailAddFollowVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>
{
    
    NSArray *_wayArr;
    NSInteger _way;
    NSArray *_levelArr;
    NSInteger _level;
    NSArray *_payArr;
    NSMutableArray *_paySelectArr;
}
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UILabel *timeContentL;

@property (nonatomic, strong) UILabel *wayL;

@property (nonatomic, strong) UICollectionViewFlowLayout *wayFlowLayout;

@property (nonatomic, strong) UICollectionView *wayColl;

//@property (nonatomic, strong) UIButton *wayBtn1;
//
//@property (nonatomic, strong) UIButton *wayBtn2;
//
//@property (nonatomic, strong) UIButton *wayBtn3;

@property (nonatomic, strong) UILabel *progressL;

@property (nonatomic, strong) UILabel *progressContentL;

@property (nonatomic, strong) UILabel *purposeL;

@property (nonatomic, strong) DropDownBtn *purposeBtn;

@property (nonatomic, strong) UILabel *levelL;

@property (nonatomic, strong) UICollectionViewFlowLayout *levelFlowLayout;

@property (nonatomic, strong) UICollectionView *levelColl;

@property (nonatomic, strong) UILabel *typeL;

@property (nonatomic, strong) DropDownBtn *typeBtn;

@property (nonatomic, strong) UILabel *decorateL;

@property (nonatomic, strong) DropDownBtn *decorateBtn;

@property (nonatomic, strong) UILabel *areaL;

@property (nonatomic, strong) BorderTF *areaBtn;

@property (nonatomic, strong) UILabel *priceL;

@property (nonatomic, strong) BorderTF *priceBtn;

@property (nonatomic, strong) UILabel *houseTypeL;

@property (nonatomic, strong) DropDownBtn *houseBtn;

@property (nonatomic, strong) UILabel *payWayL;

@property (nonatomic, strong) UICollectionViewFlowLayout *payFlowLayout;

@property (nonatomic, strong) UICollectionView *payColl;

@property (nonatomic, strong) UILabel *contentL;

@property (nonatomic, strong) UITextView *contentTV;

@property (nonatomic, strong) UILabel *nextTimeL;

@property (nonatomic, strong) DropDownBtn *nextTimeBtn;

@property (nonatomic, strong) UIButton *commitBtn;

@property (nonatomic, strong) NSDateFormatter *formatter;

@end

@implementation LookMaintainDetailAddFollowVC

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
    _way = [self.status integerValue];
    
    self.formatter = [[NSDateFormatter alloc] init];
    [self.formatter setDateFormat:@"YYYY/MM/dd"];
    
    _wayArr = @[@{@"id":@"1",@"param":@"沟通"},@{@"id":@"2",@"param":@"预约带看"},@{@"id":@"3",@"param":@"带看"}];
    _levelArr = [UserModelArchiver unarchive].Configdic[@"54"][@"param"];
    _payArr = [UserModelArchiver unarchive].Configdic[@"13"][@"param"];
    _paySelectArr = [@[] mutableCopy];
    for (int i = 0; i < _payArr.count; i++) {
        
        [_paySelectArr addObject:@0];
    }
}

- (void)ActionTagBtn:(UIButton *)btn{
    
    switch (btn.tag) {
        case 0:
        {
            SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:[self getDetailConfigArrByConfigState:BUY_TYPE]];
            WS(weakself);
            view.selectedBlock = ^(NSString *MC, NSString *ID) {
                
                weakself.purposeBtn.content.text = MC;
                weakself.purposeBtn->str = [NSString stringWithFormat:@"%@", ID];
            };
            [self.view addSubview:view];
            break;
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
                
                weakself.typeBtn.content.text = MC;
                weakself.typeBtn->str = [NSString stringWithFormat:@"%@", ID];
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
//            SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:[self getDetailConfigArrByConfigState:AREA]];
//            WS(weakself);
//            view.selectedBlock = ^(NSString *MC, NSString *ID) {
//
//                weakself.areaBtn.content.text = MC;
//                weakself.areaBtn->str = [NSString stringWithFormat:@"%@", ID];
//            };
//            [self.view addSubview:view];
            break;
        }
        case 4:
        {
//            SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:[self getDetailConfigArrByConfigState:TOTAL_PRICE]];
//            WS(weakself);
//            view.selectedBlock = ^(NSString *MC, NSString *ID) {
//
//                weakself.priceBtn.content.text = MC;
//                weakself.priceBtn->str = [NSString stringWithFormat:@"%@", ID];
//            };
//            [self.view addSubview:view];
            break;
        }
        case 5:
        {
            SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:[self getDetailConfigArrByConfigState:HOUSE_TYPE]];
            WS(weakself);
            view.selectedBlock = ^(NSString *MC, NSString *ID) {
                
                weakself.houseBtn.content.text = MC;
                weakself.houseBtn->str = [NSString stringWithFormat:@"%@", ID];
            };
            [self.view addSubview:view];
            break;
        }
        case 6:
        {
            DateChooseView *view = [[DateChooseView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
            __weak __typeof(&*self)weakSelf = self;
            view.dateblock = ^(NSDate *date) {
                
                weakSelf.nextTimeBtn.content.text = [weakSelf.formatter stringFromDate:date];
            };
            [self.view addSubview:view];
            break;
            break;
        }
        default:
            break;
    }
}

- (void)ActionCommitBtn:(UIButton *)btn{
    
    if (!_purposeBtn->str.length) {
        
//        self alertControllerWithNsstring:@"温馨提示" And:@"请选择"
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (collectionView == _wayColl) {
        
        return _wayArr.count;
    }else if (collectionView == _levelColl){
        
        return _levelArr.count;
    }else{
        
        return _payArr.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (collectionView == _wayColl) {
        
        CompleteSurveyCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CompleteSurveyCollCell" forIndexPath:indexPath];
        if (!cell) {
            
            cell = [[CompleteSurveyCollCell alloc] initWithFrame:CGRectMake(0, 0, 80 *SIZE, 20 *SIZE)];
        }
        
        cell.titleL.text = _wayArr[indexPath.row][@"param"];
        if (indexPath.row == _way) {
            
            [cell setIsSelect:1];
        }else{
            
            [cell setIsSelect:0];
        }
        return cell;
    }else if (collectionView == _levelColl){
        
        CompleteSurveyCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CompleteSurveyCollCell" forIndexPath:indexPath];
        if (!cell) {
            
            cell = [[CompleteSurveyCollCell alloc] initWithFrame:CGRectMake(0, 0, 80 *SIZE, 20 *SIZE)];
        }
        
        cell.titleL.text = _levelArr[indexPath.row][@"param"];
        if (indexPath.row == _level) {
            
            [cell setIsSelect:1];
        }else{
            
            [cell setIsSelect:0];
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
    }else if (collectionView == _levelColl){
        
        _level = indexPath.item;
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
    
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = YJBackColor;
    [_contentView addSubview:_lineView];
    
    
    _timeContentL = [[UILabel alloc] init];
    _timeContentL.textColor = YJTitleLabColor;
    _timeContentL.font = [UIFont systemFontOfSize:12 *SIZE];
    [_contentView addSubview:_timeContentL];
    
    [self.formatter setDateFormat:@"YYYY/MM/dd HH:mm"];
    _timeContentL.text = [self.formatter stringFromDate:[NSDate date]];
    [self.formatter setDateFormat:@"YYYY/MM/dd"];
    
    _progressContentL = [[UILabel alloc] init];
    _progressContentL.textColor = YJTitleLabColor;
    _progressContentL.font = [UIFont systemFontOfSize:12 *SIZE];
    _progressContentL.text = @"首看";
    [_contentView addSubview:_progressContentL];
    
    NSArray *titleArr = @[@"跟进时间",@"跟进方式：",@"进度：",@"置业目的：",@"客户等级：",@"物业类型：",@"装修状况：",@"面积：",@"总价：",@"户型：",@"付款方式：",@"跟进内容：",@"下次回访时间："];
    for (int i = 0; i < 13; i++) {
        
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
                _progressL = label;
                [_contentView addSubview:_progressL];
                break;
            }
            case 3:
            {
                _purposeL = label;
                [_contentView addSubview:_purposeL];
                break;
            }
            case 4:
            {
                _levelL = label;
                [_contentView addSubview:_levelL];
                break;
            }
            case 5:
            {
                _typeL = label;
                [_contentView addSubview:_typeL];
                break;
            }
            case 6:
            {
                _decorateL = label;
                [_contentView addSubview:_decorateL];
                break;
            }
            case 7:
            {
                _areaL = label;
                [_contentView addSubview:_areaL];
                break;
            }
            case 8:
            {
                _priceL = label;
                [_contentView addSubview:_priceL];
                break;
            }
            case 9:
            {
                _houseTypeL = label;
                [_contentView addSubview:_houseTypeL];
                break;
            }
            case 10:
            {
                _payWayL = label;
                [_contentView addSubview:_payWayL];
                break;
            }
            case 11:
            {
                _contentL = label;
                [_contentView addSubview:_contentL];
                break;
            }
            case 12:
            {
                _nextTimeL = label;
                [_contentView addSubview:_nextTimeL];
                break;
            }
            default:
                break;
        }
    }
    
    for (int i = 0 ; i < 7; i++) {
        
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
                _areaBtn = [[BorderTF alloc] initWithFrame:btn.frame];
                _areaBtn.unitL.text = @"㎡";
                [_contentView addSubview:_areaBtn];
                break;
            }
            case 4:
            {
                _priceBtn = [[BorderTF alloc] initWithFrame:btn.frame];
                _priceBtn.unitL.text = @"万";
                [_contentView addSubview:_priceBtn];
                break;
            }
            case 5:
            {
                _houseBtn = btn;
                [_contentView addSubview:_houseBtn];
                break;
            }
            case 6:
            {
                _nextTimeBtn = btn;
                [_contentView addSubview:_nextTimeBtn];
                break;
            }
            default:
                break;
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
            [_wayColl registerClass:[CompleteSurveyCollCell class] forCellWithReuseIdentifier:@"CompleteSurveyCollCell"];
            [_contentView addSubview:_wayColl];
        }else if (i == 1){
            
            _levelFlowLayout = flowLayout;
            _levelFlowLayout.estimatedItemSize = CGSizeMake(80 *SIZE, 20 *SIZE);
            _levelFlowLayout.minimumLineSpacing = 5 *SIZE;
            _levelFlowLayout.minimumInteritemSpacing = 0;
            
            _levelColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 240 *SIZE, 20 *SIZE) collectionViewLayout:_levelFlowLayout];
            _levelColl.backgroundColor = [UIColor whiteColor];
            _levelColl.delegate = self;
            _levelColl.dataSource = self;
            _levelColl.bounces = NO;
            [_levelColl registerClass:[CompleteSurveyCollCell class] forCellWithReuseIdentifier:@"CompleteSurveyCollCell"];
            [_contentView addSubview:_levelColl];
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
    
    _contentTV = [[UITextView alloc] init];
    _contentTV.layer.borderColor = YJBackColor.CGColor;
    _contentTV.layer.cornerRadius = 5 *SIZE;
    _contentTV.clipsToBounds = YES;
    _contentTV.layer.borderWidth = SIZE;
    [_contentView addSubview:_contentTV];

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
    
    [self masonryUI];
}

- (void)masonryUI{
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(NAVIGATION_BAR_HEIGHT);
//        make.width.mas_equalTo(SCREEN_Width);
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
    
    [_progressL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_wayColl.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(65 *SIZE);
    }];
    
    [_progressContentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(78 *SIZE);
        make.top.equalTo(_wayColl.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(200 *SIZE);
    }];
    
    [_purposeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_progressContentL.mas_bottom).offset(40 *SIZE);
        make.width.mas_equalTo(65 *SIZE);
    }];
    
    [_purposeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(80 *SIZE);
        make.top.equalTo(_progressContentL.mas_bottom).offset(29 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_levelL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_purposeBtn.mas_bottom).offset(26 *SIZE);
        make.width.mas_equalTo(65 *SIZE);
    }];
    
    [_levelColl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(76 *SIZE);
        make.top.equalTo(_purposeBtn.mas_bottom).offset(25 *SIZE);
        make.width.mas_equalTo(255 *SIZE);
        make.height.mas_equalTo(_levelColl.collectionViewLayout.collectionViewContentSize.height + 5 *SIZE * (_levelArr.count / 3 + 1) + 5 *SIZE);
    }];
    
    [_typeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_levelColl.mas_bottom).offset(40 *SIZE);
        make.width.mas_equalTo(65 *SIZE);
    }];
    
    [_typeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(80 *SIZE);
        make.top.equalTo(_levelColl.mas_bottom).offset(29 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_decorateL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_typeBtn.mas_bottom).offset(30 *SIZE);
        make.width.mas_equalTo(65 *SIZE);
    }];
    
    [_decorateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(80 *SIZE);
        make.top.equalTo(_typeBtn.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_areaL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_decorateBtn.mas_bottom).offset(30 *SIZE);
        make.width.mas_equalTo(65 *SIZE);
    }];
    
    [_areaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(80 *SIZE);
        make.top.equalTo(_decorateBtn.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_areaBtn.mas_bottom).offset(30 *SIZE);
        make.width.mas_equalTo(65 *SIZE);
    }];
    
    [_priceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(80 *SIZE);
        make.top.equalTo(_areaBtn.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_houseTypeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_priceBtn.mas_bottom).offset(30 *SIZE);
        make.width.mas_equalTo(65 *SIZE);
    }];
    
    [_houseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(80 *SIZE);
        make.top.equalTo(_priceBtn.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_payWayL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_houseBtn.mas_bottom).offset(26 *SIZE);
        make.width.mas_equalTo(65 *SIZE);
    }];
    
    [_payColl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(76 *SIZE);
        make.top.equalTo(_houseBtn.mas_bottom).offset(25 *SIZE);
        make.width.mas_equalTo(255 *SIZE);
        make.height.mas_equalTo(_payColl.collectionViewLayout.collectionViewContentSize.height + 10 *SIZE * (_payArr.count / 2 + 1));
    }];
    
    [_contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_payColl.mas_bottom).offset(40 *SIZE);
        make.width.mas_equalTo(65 *SIZE);
    }];
    
    [_contentTV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(80 *SIZE);
        make.top.equalTo(_payColl.mas_bottom).offset(29 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(77 *SIZE);
    }];
    
    [_nextTimeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_contentTV.mas_bottom).offset(40 *SIZE);
        make.width.mas_equalTo(65 *SIZE);
    }];
    
    [_nextTimeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(80 *SIZE);
        make.top.equalTo(_contentTV.mas_bottom).offset(29 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
        make.bottom.equalTo(_contentView.mas_bottom).offset(-33 *SIZE);
    }];
    
    [_commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_scrollView).offset(22 *SIZE);
        make.top.equalTo(_contentView.mas_bottom).offset(28 *SIZE);
        make.bottom.equalTo(_scrollView).offset(-43 *SIZE);
        make.width.mas_equalTo(317 *SIZE);
        make.height.mas_equalTo(40 *SIZE);
    }];
}



@end
