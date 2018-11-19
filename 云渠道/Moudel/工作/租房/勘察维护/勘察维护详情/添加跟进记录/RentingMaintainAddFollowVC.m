//
//  RentingMaintainAddFollowVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/8/6.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RentingMaintainAddFollowVC.h"

#import "CompleteSurveyCollCell.h"
#import "BaseFrameHeader.h"

#import "BorderTF.h"
#import "DropDownBtn.h"

@interface RentingMaintainAddFollowVC ()<UIScrollViewDelegate,UITextViewDelegate,UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
{
    
    NSArray *_titleArr;
    NSArray *_btnArr;
    NSMutableArray *_selectArr;
    NSMutableArray *_selectArr2;
}
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UILabel *wayL;

@property (nonatomic, strong) UICollectionView *wayColl;

@property (nonatomic, strong) UICollectionViewFlowLayout *layout;

@property (nonatomic, strong) BaseFrameHeader *titleHeader;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) BorderTF *titleTF;

@property (nonatomic, strong) UILabel *priceL;

@property (nonatomic, strong) BorderTF *PriceTF;

@property (nonatomic, strong) UILabel *payL;

@property (nonatomic, strong) UICollectionView *payColl;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) UILabel *propertyL;

@property (nonatomic, strong) UIButton *propertyBtn1;

@property (nonatomic, strong) UIImageView *propertyImg1;

@property (nonatomic, strong) UIButton *propertyBtn2;

@property (nonatomic, strong) UIImageView *propertyImg2;

@property (nonatomic, strong) UILabel *minPeriodL;

@property (nonatomic, strong) DropDownBtn *minPeriodBtn;

@property (nonatomic, strong) UILabel *maxPeriodL;

@property (nonatomic, strong) DropDownBtn *maxPeriodBtn;

@property (nonatomic, strong) UILabel *seeWayL;

@property (nonatomic, strong) DropDownBtn *seeWayBtn;

@property (nonatomic, strong) UILabel *inTimeL;

@property (nonatomic, strong) DropDownBtn *inTimeBtn;

@property (nonatomic, strong) UILabel *intentL;

@property (nonatomic, strong) BorderTF *intentTF;

@property (nonatomic, strong) UISlider *intentSlider;

@property (nonatomic, strong) UILabel *urgentL;

@property (nonatomic, strong) BorderTF *urgentTF;

@property (nonatomic, strong) UISlider *urgentSlider;

@property (nonatomic, strong) UILabel *contentL;

@property (nonatomic, strong) UIView *timeView;

@property (nonatomic, strong) UILabel *markL;

@property (nonatomic, strong) UITextView *markTV;

@property (nonatomic, strong) UIButton *nextBtn;

@end

@implementation RentingMaintainAddFollowVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
    _selectArr = [@[] mutableCopy];
    for (int i = 0; i < 5; i++) {
        
        [_selectArr addObject:@0];
    }
    
    _selectArr2 = [@[] mutableCopy];
    for (int i = 0; i < 5; i++) {
        
        [_selectArr2 addObject:@0];
    }
    _titleArr = @[@"挂牌标题：",@"出租价格：",@"付款方式：",@"租赁类型：",@"最短租期：",@"最长租期：",@"看房方式：",@"入住时间",@"卖房意愿度",@"卖房紧急度"];
    _btnArr = @[@"整租",@"合租"];
}

- (void)ActionNextBtn:(UIButton *)btn{
    
    
}

- (void)ActionTagBtn:(UIButton *)btn{
    
    
}

- (void)ActionSliderChange:(UISlider *)slider{
    
    if (slider == _intentSlider) {
        
        _intentTF.textfield.text = [NSString stringWithFormat:@"%.0f",slider.value];
    }else{
        
        _urgentTF.textfield.text = [NSString stringWithFormat:@"%.0f",slider.value];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
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
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 5;
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
        
        cell.titleL.text = @"QQ";
        
        return cell;
    }else{
        
        CompleteSurveyCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CompleteSurveyCollCell" forIndexPath:indexPath];
        if (!cell) {
            
            cell = [[CompleteSurveyCollCell alloc] initWithFrame:CGRectMake(0, 0, 130 *SIZE, 20 *SIZE)];
        }
        
        cell.titleL.text = @"一次性付款";
        cell.tag = 0;
        [cell setIsSelect:[_selectArr2[indexPath.item] integerValue]];
        
        return cell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (collectionView == _wayColl) {
        
        if ([_selectArr[indexPath.item] integerValue]) {
            
            [_selectArr replaceObjectAtIndex:indexPath.item withObject:@0];
        }else{
            
            [_selectArr replaceObjectAtIndex:indexPath.item withObject:@1];
        }
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
    
    _timeL = [[UILabel alloc] init];
    _timeL.textColor = YJTitleLabColor;
    _timeL.adjustsFontSizeToFitWidth = YES;
    _timeL.font = [UIFont systemFontOfSize:13 *SIZE];
    _timeL.text = @"跟进时间：2017/11/29 14:23";
    [_scrollView addSubview:_timeL];
    
    _contentView = [[UIView alloc] init];
    _contentView.backgroundColor = CH_COLOR_white;
    [_scrollView addSubview:_contentView];
    
    _wayL = [[UILabel alloc] init];
    _wayL.textColor = YJTitleLabColor;
    _wayL.adjustsFontSizeToFitWidth = YES;
    _wayL.font = [UIFont systemFontOfSize:13 *SIZE];
    _wayL.text = @"跟进方式";
    [_contentView addSubview:_wayL];
    
    _titleHeader = [[BaseFrameHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
    _titleHeader.titleL.text = @"挂牌信息";
    [_contentView addSubview:_titleHeader];
    
    for (int i = 0; i < 10; i++) {
        
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
                _propertyL = label;
                [_contentView addSubview:_propertyL];
                break;
            }
            case 4:
            {
                _minPeriodL = label;
                [_contentView addSubview:_minPeriodL];
                break;
            }
            case 5:
            {
                _maxPeriodL = label;
                [_contentView addSubview:_maxPeriodL];
                break;
            }
            case 6:
            {
                _seeWayL = label;
                [_contentView addSubview:_seeWayL];
                break;
            }
            case 7:
            {
                _inTimeL = label;
                [_contentView addSubview:_inTimeL];
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
            default:
                break;
        }
    }
    
    for (int i = 0; i < 4; i++) {
        
        BorderTF *textField = [[BorderTF alloc] initWithFrame:CGRectMake(81 *SIZE, 47 *SIZE, 257 *SIZE, 33 *SIZE)];
        textField.textfield.delegate = self;
        
        DropDownBtn *btn = [[DropDownBtn alloc] initWithFrame:CGRectMake(81 *SIZE, 436 *SIZE, 257 *SIZE, 33 *SIZE)];
        switch (i) {
            case 0:
            {
                _titleTF = textField;
                [_contentView addSubview:_titleTF];
                _minPeriodBtn = btn;
                [_contentView addSubview:_minPeriodBtn];
                break;
            }
            case 1:
            {
                 _PriceTF = textField;
                [_contentView addSubview:_PriceTF];
                _maxPeriodBtn = btn;
                [_contentView addSubview:_maxPeriodBtn];
                break;
            }
            case 2:
            {
                _intentTF = textField;
                [_contentView addSubview:_intentTF];
                _seeWayBtn = btn;
                [_contentView addSubview:_seeWayBtn];
                break;
            }
            case 3:
            {
                _urgentTF = textField;
                [_contentView addSubview:_urgentTF];
                _inTimeBtn = btn;
                [_contentView addSubview:_inTimeBtn];
                break;
            }
            default:
                break;
        }
    }
    
    
    
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
            
            [_contentView addSubview:_intentSlider];
        }else{
            
            _urgentSlider = slider;
            
            [_contentView addSubview:_urgentSlider];
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
        //        [btn setImage:[UIImage imageNamed:@"default"] forState:UIControlStateNormal];
        //        [btn setTitle:_btnArr[i] forState:UIControlStateNormal];
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
                
            default:
                break;
        }
    }
    
    _layout = [[UICollectionViewFlowLayout alloc] init];
    _layout.estimatedItemSize = CGSizeMake(120 *SIZE, 20 *SIZE);
    _layout.minimumLineSpacing = 20 *SIZE;
    _layout.minimumInteritemSpacing = 0;
    //    _flowLayout.itemSize = CGSizeMake(140 *SIZE, 20 *SIZE);
    
    _wayColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 100 *SIZE) collectionViewLayout:_layout];
    _wayColl.backgroundColor = CH_COLOR_white;
    //    _wayColl.allowsMultipleSelection = YES;
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
    _payColl.backgroundColor = CH_COLOR_white;
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
    _timeView.backgroundColor = CH_COLOR_white;
    [_scrollView addSubview:_timeView];
    
    _markTV = [[UITextView alloc] init];
    _markTV.delegate = self;
    [_timeView addSubview:_markTV];

    
    _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _nextBtn.titleLabel.font = [UIFont systemFontOfSize:14 *sIZE];
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
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrollView).offset(9 *SIZE);
        make.top.equalTo(_scrollView).offset(15 *SIZE);
        make.right.equalTo(_scrollView).offset(-15 *SIZE);
    }];
    
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrollView).offset(0);
        make.top.equalTo(_scrollView).offset(40 *SIZE);
        make.right.equalTo(_scrollView).offset(0);
        make.width.equalTo(@(SCREEN_Width));
    }];
    
    [_wayL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_contentView).offset(11 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(65 *SIZE);
    }];
    
    [_wayColl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(81 *SIZE);
        make.top.equalTo(_contentView).offset(10 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(_wayColl.collectionViewLayout.collectionViewContentSize.height + 3 *SIZE * 20);
    }];
    
    [_titleHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_wayColl.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(40 *SIZE);
    }];
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_titleHeader.mas_bottom).offset(35 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(65 *SIZE);
    }];
    
    [_titleTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(81 *SIZE);
        make.top.equalTo(_titleHeader.mas_bottom).offset(25 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_titleTF.mas_bottom).offset(35 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(65 *SIZE);
    }];
    
    [_PriceTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(81 *SIZE);
        make.top.equalTo(_titleTF.mas_bottom).offset(25 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_payL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_PriceTF.mas_bottom).offset(33 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(65 *SIZE);
    }];
    
    [_payColl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(81 *SIZE);
        make.top.equalTo(_PriceTF.mas_bottom).offset(33 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(_payColl.collectionViewLayout.collectionViewContentSize.height + 3 *SIZE * 20);
    }];
    
    [_propertyL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_payColl.mas_bottom).offset(28 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(65 *SIZE);
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
    
    [_minPeriodL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_propertyBtn1.mas_bottom).offset(41 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(65 *SIZE);
    }];
    
    [_minPeriodBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(81 *SIZE);
        make.top.equalTo(_propertyBtn1.mas_bottom).offset(30 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_maxPeriodL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_minPeriodBtn.mas_bottom).offset(41 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(65 *SIZE);
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
        make.width.mas_equalTo(65 *SIZE);
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
        make.width.mas_equalTo(65 *SIZE);
    }];
    
    [_inTimeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(81 *SIZE);
        make.top.equalTo(_seeWayBtn.mas_bottom).offset(30 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_intentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_inTimeBtn.mas_bottom).offset(41 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(65 *SIZE);
    }];
    
    [_intentTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(81 *SIZE);
        make.top.equalTo(_inTimeBtn.mas_bottom).offset(30 *SIZE);
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
        make.top.equalTo(_intentSlider.mas_bottom).offset(24 *SIZE);
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
    
    [_nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrollView).offset(22 *SIZE);
        make.top.equalTo(_timeView.mas_bottom).offset(28 *SIZE);
        make.width.equalTo(@(317 *SIZE));
        make.height.equalTo(@(40 *SIZE));
        make.bottom.equalTo(_scrollView.mas_bottom).offset(-19 *SIZE);
    }];
}

@end
