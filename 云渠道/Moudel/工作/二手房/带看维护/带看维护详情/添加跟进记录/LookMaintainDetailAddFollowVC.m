//
//  LookMaintainDetailAddFollowVC.m
//  云渠道
//
//  Created by 谷治墙 on 2019/1/25.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "LookMaintainDetailAddFollowVC.h"

#import "DropDownBtn.h"
#import "CompleteSurveyCollCell.h"

@interface LookMaintainDetailAddFollowVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
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

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UILabel *wayL;

@property (nonatomic, strong) UICollectionViewFlowLayout *wayFlowLayout;

@property (nonatomic, strong) UICollectionView *wayColl;

//@property (nonatomic, strong) UIButton *wayBtn1;
//
//@property (nonatomic, strong) UIButton *wayBtn2;
//
//@property (nonatomic, strong) UIButton *wayBtn3;

@property (nonatomic, strong) UILabel *progressL;

@property (nonatomic, strong) UILabel *purposeL;

@property (nonatomic, strong) DropDownBtn *purposeBtn;

@property (nonatomic, strong) UILabel *levelL;

@property (nonatomic, strong) UICollectionViewFlowLayout *levelFlowLayout;

@property (nonatomic, strong) UICollectionView *levelColl;

//@property (nonatomic, strong) UIButton *levelBtn1;
//
//@property (nonatomic, strong) UIButton *levelBtn2;
//
//@property (nonatomic, strong) UIButton *levelBtn3;
//
//@property (nonatomic, strong) UIButton *levelBtn4;

@property (nonatomic, strong) UILabel *typeL;

@property (nonatomic, strong) DropDownBtn *typeBtn;

@property (nonatomic, strong) UILabel *decorateL;

@property (nonatomic, strong) DropDownBtn *decorateBtn;

@property (nonatomic, strong) UILabel *areaL;

@property (nonatomic, strong) DropDownBtn *areaBtn;

@property (nonatomic, strong) UILabel *priceL;

@property (nonatomic, strong) DropDownBtn *priceBtn;

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

@end

@implementation LookMaintainDetailAddFollowVC

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self initUI];
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
        
        return cell;
    }else if (collectionView == _levelColl){
        
        CompleteSurveyCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CompleteSurveyCollCell" forIndexPath:indexPath];
        if (!cell) {
            
            cell = [[CompleteSurveyCollCell alloc] initWithFrame:CGRectMake(0, 0, 80 *SIZE, 20 *SIZE)];
        }
        
        return cell;
    }else{
        
        CompleteSurveyCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CompleteSurveyCollCell" forIndexPath:indexPath];
        if (!cell) {
            
            cell = [[CompleteSurveyCollCell alloc] initWithFrame:CGRectMake(0, 0, 80 *SIZE, 20 *SIZE)];
        }
        
        return cell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

- (void)initUI{
    
    self.titleLabel.text = @"跟进记录";
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.backgroundColor = YJBackColor;
    [self.view addSubview:_scrollView];
    
    _contentView = [[UIView alloc] init];
    [_scrollView addSubview:_contentView];
    
    for (int i = 0; i < 13; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = YJTitleLabColor;
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
    
    for (int i = 0; i < 3; i++) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        if (i == 0) {
            
            _wayFlowLayout = flowLayout;
            _wayFlowLayout.estimatedItemSize = CGSizeMake(80 *SIZE, 20 *SIZE);
            _wayFlowLayout.minimumLineSpacing = 20 *SIZE;
            _wayFlowLayout.minimumInteritemSpacing = 0;
            
            _wayColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 240 *SIZE, 20 *SIZE) collectionViewLayout:_wayFlowLayout];
            _wayColl.delegate = self;
            _wayColl.dataSource = self;
            [_wayColl registerClass:[CompleteSurveyCollCell class] forCellWithReuseIdentifier:@"CompleteSurveyCollCell"];
            [_contentView addSubview:_wayColl];
        }else if (i == 1){
            
            _levelFlowLayout = flowLayout;
            _levelFlowLayout.estimatedItemSize = CGSizeMake(80 *SIZE, 20 *SIZE);
            _levelFlowLayout.minimumLineSpacing = 20 *SIZE;
            _levelFlowLayout.minimumInteritemSpacing = 0;
            
            _levelColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 240 *SIZE, 20 *SIZE) collectionViewLayout:_levelFlowLayout];
            _levelColl.delegate = self;
            _levelColl.dataSource = self;
            [_levelColl registerClass:[CompleteSurveyCollCell class] forCellWithReuseIdentifier:@"CompleteSurveyCollCell"];
            [_contentView addSubview:_levelColl];
        }else{
            
            _payFlowLayout = flowLayout;
            _payFlowLayout.estimatedItemSize = CGSizeMake(80 *SIZE, 20 *SIZE);
            _payFlowLayout.minimumLineSpacing = 20 *SIZE;
            _payFlowLayout.minimumInteritemSpacing = 0;
            
            _payColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 240 *SIZE, 20 *SIZE) collectionViewLayout:_payFlowLayout];
            _payColl.delegate = self;
            _payColl.dataSource = self;
            [_payColl registerClass:[CompleteSurveyCollCell class] forCellWithReuseIdentifier:@"CompleteSurveyCollCell"];
            [_contentView addSubview:_payColl];
        }
        
//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        btn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
//        [btn addTarget:self action:@selector(<#selector#>) forControlEvents:UIControlEventTouchUpInside];
//        [btn setTitle:<#(nullable NSString *)#> forState:UIControlStateNormal];
//        [btn setBackgroundImage:[UIImage imageNamed:<#(nonnull NSString *)#>] forState:UIControlStateNormal];
    }
    
    
    [self masonryUI];
}

- (void)masonryUI{
    
    
}



@end
