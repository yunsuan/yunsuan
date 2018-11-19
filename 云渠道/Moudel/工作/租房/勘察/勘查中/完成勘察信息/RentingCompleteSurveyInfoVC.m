//
//  RentingCompleteSurveyInfoVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/7/31.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RentingCompleteSurveyInfoVC.h"
#import "RentingCompleteSurveyInfoVC2.h"

#import "BaseFrameHeader.h"
#import "CompleteSurveyCollCell.h"

#import "BorderTF.h"
#import "DropDownBtn.h"

@interface RentingCompleteSurveyInfoVC ()<UIScrollViewDelegate,UITextViewDelegate,UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    
    NSString *_titleStr;
    NSArray *_titleArr;
    NSArray *_btnArr;
    NSMutableArray *_selectArr;
    //    NSArray *_btnImgArr;
}
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIView *codeView;

@property (nonatomic, strong) UILabel *codeL;

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) BaseFrameHeader *titleHeader;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) BorderTF *titleTF;

@property (nonatomic, strong) UILabel *maxPriceL;

@property (nonatomic, strong) BorderTF *maxPriceTF;

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

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) DropDownBtn *timeBtn;

@property (nonatomic, strong) UILabel *intentL;

@property (nonatomic, strong) BorderTF *intentTF;

@property (nonatomic, strong) UISlider *intentSlider;

@property (nonatomic, strong) UILabel *urgentL;

@property (nonatomic, strong) BorderTF *urgentTF;

@property (nonatomic, strong) UISlider *urgentSlider;

@property (nonatomic, strong) UILabel *markL;

@property (nonatomic, strong) UITextView *markTV;

@property (nonatomic, strong) UIButton *nextBtn;

@end

@implementation RentingCompleteSurveyInfoVC

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
    
    _selectArr = [@[] mutableCopy];
    for (int i = 0; i < 6; i++) {
        
        [_selectArr addObject:@0];
    }
    _btnArr = @[@"整租",@"合租"];
    _titleArr = @[@"挂牌标题",@"挂牌价格",@"付款方式",@"租赁类型",@"最短租期",@"最长租期",@"看房方式",@"入住时间",@"出租意愿度",@"出租急迫度"];
}

- (void)ActionNextBtn:(UIButton *)btn{
    
    RentingCompleteSurveyInfoVC2 *nextVC = [[RentingCompleteSurveyInfoVC2 alloc] init];
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (void)ActionTagBtn:(UIButton *)btn{
    
//    if (btn.tag < 3) {
//
//        if (btn.tag == 1) {
//
//            _propertyImg1.image = [UIImage imageNamed:@"selected"];
//            _propertyImg2.image = [UIImage imageNamed:@"default"];
//
//        }else{
//
//            _propertyImg1.image = [UIImage imageNamed:@"default"];
//            _propertyImg2.image = [UIImage imageNamed:@"selected"];
//
//        }
//    }else{
//
//        if (btn.tag == 3) {
//
//            _mortgageImg1.image = [UIImage imageNamed:@"selected"];
//            _mortgageImg2.image = [UIImage imageNamed:@"default"];
//
//        }else{
//
//            _mortgageImg1.image = [UIImage imageNamed:@"default"];
//            _mortgageImg2.image = [UIImage imageNamed:@"selected"];
//
//        }
//    }
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
    
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CompleteSurveyCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CompleteSurveyCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[CompleteSurveyCollCell alloc] initWithFrame:CGRectMake(0, 0, 130 *SIZE, 20 *SIZE)];
    }
    
    [cell setIsSelect:[_selectArr[indexPath.item] integerValue]];
    cell.titleL.text = @"押一付三";
    
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
    self.titleLabel.text = @"完成勘察信息";
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.backgroundColor = self.view.backgroundColor;
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    
    _codeView = [[UIView alloc] init];
    _codeView.backgroundColor = CH_COLOR_white;
    [_scrollView addSubview:_codeView];
    
    _codeL = [[UILabel alloc] init];
    _codeL.font = [UIFont systemFontOfSize:13.3*SIZE];
    _codeL.numberOfLines = 0;
    _codeL.text = @"房源编号：SCCDPDHPXQ-0302102";
    _codeL.textColor = YJTitleLabColor;
    [_codeView addSubview:_codeL];
    
    _contentView = [[UIView alloc] init];
    _contentView.backgroundColor = CH_COLOR_white;
    [_scrollView addSubview:_contentView];
    
    _titleHeader = [[BaseFrameHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
    _titleHeader.titleL.text = @"挂牌信息";
    [_contentView addSubview:_titleHeader];
    
    for (int i = 0; i < 10; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = YJTitleLabColor;
        label.adjustsFontSizeToFitWidth = YES;
        label.text = _titleArr[i];
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        
        BorderTF *textField = [[BorderTF alloc] initWithFrame:CGRectMake(81 *SIZE, 47 *SIZE, 257 *SIZE, 33 *SIZE)];
        textField.textfield.delegate = self;
        switch (i) {
            case 0:
            {
                _titleL = label;
                [_contentView addSubview:_titleL];
                _titleTF = textField;
                [_contentView addSubview:_titleTF];
                break;
            }
            case 1:
            {
                _maxPriceL = label;
                _maxPriceTF = textField;
                [_contentView addSubview:_maxPriceTF];
                [_contentView addSubview:_maxPriceL];
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
                _intentTF = textField;
                [_contentView addSubview:_intentTF];
                break;
            }
            case 4:
            {
                _minPeriodL = label;
                [_contentView addSubview:_minPeriodL];
                _urgentTF = textField;
                [_contentView addSubview:_urgentTF];
                _minPeriodBtn = [[DropDownBtn alloc] initWithFrame:textField.frame];
                [_contentView addSubview:_minPeriodBtn];
                break;
            }
            case 5:
            {
                _maxPeriodL = label;
                [_contentView addSubview:_maxPeriodL];
                _maxPeriodBtn = [[DropDownBtn alloc] initWithFrame:textField.frame];
                [_contentView addSubview:_maxPeriodBtn];
                break;
            }
            case 6:
            {
                _seeWayL = label;
                [_contentView addSubview:_seeWayL];
                _timeBtn = [[DropDownBtn alloc] initWithFrame:textField.frame];
                [_contentView addSubview:_timeBtn];
                break;
            }
            case 7:
            {
                _timeL = label;
                [_contentView addSubview:_timeL];
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
    
    _seeWayBtn = [[DropDownBtn alloc] initWithFrame:CGRectMake(81 *SIZE, 436 *SIZE, 257 *SIZE, 33 *SIZE)];
    [_contentView addSubview:_seeWayBtn];
    
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
    
    _markL = [[UILabel alloc] init];
    _markL.textColor = YJTitleLabColor;
    _markL.font = [UIFont systemFontOfSize:13 *SIZE];
    _markL.text = @"业主自荐:";
    [_scrollView addSubview:_markL];
    
    _markTV = [[UITextView alloc] init];
    _markTV.delegate = self;
    [_scrollView addSubview:_markTV];
    
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
    
    [_codeView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrollView).offset(0);
        make.top.equalTo(_scrollView).offset(0);
        make.right.equalTo(_scrollView).offset(0);
        make.width.equalTo(@(SCREEN_Width));
        //        make.height.equalTo(@(50 *SIZE));
    }];
    
    [_codeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_codeView).offset(10 *SIZE);
        make.top.equalTo(_codeView).offset(19 *SIZE);
        make.right.equalTo(_codeView).offset(-10 *SIZE);
        make.bottom.equalTo(_codeView).offset(-17 *SIZE);
        //        make.width.equalTo(@(SCREEN_Width));
    }];
    
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrollView).offset(0);
        make.top.equalTo(_codeView.mas_bottom).offset(7 *SIZE);
        make.right.equalTo(_scrollView).offset(0);
        make.width.equalTo(@(SCREEN_Width));
        //        make.bottom.equalTo(—.mas_top).offset(-28 *SIZE);
    }];
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_contentView).offset(58 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(65 *SIZE);
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
        make.width.mas_equalTo(65 *SIZE);
    }];
    
    [_maxPriceTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(81 *SIZE);
        make.top.equalTo(_titleTF.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_payL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_maxPriceTF.mas_bottom).offset(31 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(65 *SIZE);
    }];
    
    [_payColl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(81 *SIZE);
        make.top.equalTo(_maxPriceTF.mas_bottom).offset(31 *SIZE);
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
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_seeWayBtn.mas_bottom).offset(41 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(65 *SIZE);
    }];
    
    [_timeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(81 *SIZE);
        make.top.equalTo(_seeWayBtn.mas_bottom).offset(30 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_intentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_timeBtn.mas_bottom).offset(41 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(65 *SIZE);
    }];
    
    [_intentTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(81 *SIZE);
        make.top.equalTo(_timeBtn.mas_bottom).offset(30 *SIZE);
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

    
    [_nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrollView).offset(22 *SIZE);
        make.top.equalTo(_contentView.mas_bottom).offset(28 *SIZE);
        make.width.equalTo(@(317 *SIZE));
        make.height.equalTo(@(40 *SIZE));
        make.bottom.equalTo(_scrollView.mas_bottom).offset(-19 *SIZE);
    }];
}

@end
