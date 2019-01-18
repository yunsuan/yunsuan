//
//  BarginVC1.m
//  云渠道
//
//  Created by 谷治墙 on 2019/1/18.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "BarginVC1.h"

#import "BarginDealVC.h"
#import "BarginUndealVC.h"
#import "BarginFailDealVC.h"
#import "BarginDealComplaintVC.h"

#import "RoomReportCollCell.h"

@interface BarginVC1 ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate,UITextFieldDelegate>
{
    
    NSArray *_titleArr;
}
@property (nonatomic, strong) UITextField *searchBar;

@property (nonatomic, strong) UICollectionView *segmentColl;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) BarginUndealVC *barginUndealVC;

@property (nonatomic, strong) BarginDealVC *barginDealVC;

@property (nonatomic, strong) BarginFailDealVC *barginFailDealVC;

@property (nonatomic, strong) BarginDealComplaintVC *barginDealComplaintVC;

@end

@implementation BarginVC1

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
    [_segmentColl selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:NO scrollPosition:0];
}

- (void)initDataSource{
    
    _titleArr = @[@"待成交",@"成交",@"未成交",@"申诉"];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    NSInteger index = _scrollView.contentOffset.x / SCREEN_Width;
    switch (index) {
        case 0:
        {
            _barginUndealVC.search = textField.text;
            [_barginUndealVC RequestMethod];
            break;
        }
        case 1:
        {
            _barginDealVC.search = textField.text;
            [_barginDealVC RequestMethod];
            break;
        }
        case 2:
        {
            _barginUndealVC.search = textField.text;
            [_barginUndealVC RequestMethod];
            break;
        }
        case 3:
        {
            _barginDealComplaintVC.search = textField.text;
            [_barginDealComplaintVC RequestMethod];
            break;
        }
        default:
            break;
    }
    return YES;
}


#pragma mark -- collectionview
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _titleArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    RoomReportCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RoomReportCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[RoomReportCollCell alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width / 4, 40 *SIZE)];
    }
    cell.titleL.text = _titleArr[indexPath.item];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [_scrollView setContentOffset:CGPointMake(SCREEN_Width * indexPath.item, 0) animated:NO];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NSInteger index = scrollView.contentOffset.x / SCREEN_Width;
    [_segmentColl selectItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionLeft];
}
- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"客源成交";
    self.line.hidden = YES;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, 40 *SIZE)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiteView];
    
    _searchBar = [[UITextField alloc] initWithFrame:CGRectMake(10 *SIZE, 3 *SIZE, 340 *SIZE, 33 *SIZE)];
    _searchBar.backgroundColor = YJBackColor;
    _searchBar.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 11 *SIZE, 0)];
    //设置显示模式为永远显示(默认不显示)
    _searchBar.delegate = self;
    _searchBar.leftViewMode = UITextFieldViewModeAlways;
    _searchBar.placeholder = @"输入电话/姓名";
    _searchBar.font = [UIFont systemFontOfSize:12 *SIZE];
    _searchBar.layer.cornerRadius = 2 *SIZE;
    _searchBar.returnKeyType = UIReturnKeySearch;
    
    UIImageView *rightImg = [[UIImageView alloc] initWithFrame:CGRectMake(0 *SIZE, 8 *SIZE, 17 *SIZE, 17 *SIZE)];
    //    rightImg.backgroundColor = [UIColor whiteColor];
    rightImg.image = [UIImage imageNamed:@"search"];
    _searchBar.rightView = rightImg;
    _searchBar.rightViewMode = UITextFieldViewModeUnlessEditing;
    _searchBar.clearButtonMode = UITextFieldViewModeWhileEditing;
    _searchBar.delegate = self;
    [whiteView addSubview:_searchBar];
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.itemSize = CGSizeMake(SCREEN_Width / 4, 40 *SIZE);
    _flowLayout.minimumLineSpacing = 0;
    _flowLayout.minimumInteritemSpacing = 0;
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    
    _segmentColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT + 40 *SIZE, SCREEN_Width, 40 *SIZE) collectionViewLayout:_flowLayout];
    _segmentColl.backgroundColor = [UIColor whiteColor];
    _segmentColl.delegate = self;
    _segmentColl.dataSource = self;
    _segmentColl.showsHorizontalScrollIndicator = NO;
    _segmentColl.bounces = NO;
    [_segmentColl registerClass:[RoomReportCollCell class] forCellWithReuseIdentifier:@"RoomReportCollCell"];
    [self.view addSubview:_segmentColl];
    
    // 创建scrollView
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT + 81 *SIZE, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - NAVIGATION_BAR_HEIGHT - 81 *SIZE)];
    self.scrollView.scrollEnabled = NO;
    [self.view addSubview:self.scrollView];
    // 设置scrollView的内容
    self.scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * 4, [UIScreen mainScreen].bounds.size.height - NAVIGATION_BAR_HEIGHT - 80 *SIZE);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.bounces = NO;
    
    // 创建控制器
    _barginUndealVC = [[BarginUndealVC alloc] init];
    _barginDealVC = [[BarginDealVC alloc] init];
    _barginFailDealVC = [[BarginFailDealVC alloc] init];
    _barginDealComplaintVC = [[BarginDealComplaintVC alloc] init];
    
    // 添加为self的子控制器
    [self addChildViewController:_barginUndealVC];
    [self addChildViewController:_barginDealVC];
    [self addChildViewController:_barginFailDealVC];
    [self addChildViewController:_barginDealComplaintVC];
    
    _barginUndealVC.view.frame = CGRectMake([UIScreen mainScreen].bounds.size.width * 0, 0, self.scrollView.frame.size.width, CGRectGetHeight(self.scrollView.frame));
    _barginDealVC.view.frame = CGRectMake([UIScreen mainScreen].bounds.size.width * 1, 0, self.scrollView.frame.size.width, CGRectGetHeight(self.scrollView.frame));
    _barginFailDealVC.view.frame = CGRectMake([UIScreen mainScreen].bounds.size.width * 2, 0, self.scrollView.frame.size.width, CGRectGetHeight(self.scrollView.frame));
    _barginDealComplaintVC.view.frame = CGRectMake([UIScreen mainScreen].bounds.size.width * 3, 0, self.scrollView.frame.size.width, CGRectGetHeight(self.scrollView.frame));
    
    [self.scrollView addSubview:_barginUndealVC.view];
    [self.scrollView addSubview:_barginDealVC.view];
    [self.scrollView addSubview:_barginFailDealVC.view];
    [self.scrollView addSubview:_barginDealComplaintVC.view];
    // 设置scrollView的代理
    self.scrollView.delegate = self;
}

@end
