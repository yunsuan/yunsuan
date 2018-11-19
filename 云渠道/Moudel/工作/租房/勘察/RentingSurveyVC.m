//
//  RentingSurveyVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/7/26.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RentingSurveyVC.h"
#import "RentingSurveyWaitVC.h"
#import "RentingSurveyingVC.h"
#import "RentingSurveyFailVC.h"
#import "RentingSurveySuccessVC.h"
#import "RentingSurveyComplaitVC.h"

#import "RoomReportCollCell.h"

@interface RentingSurveyVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate,UITextFieldDelegate>
{
    
    NSArray *_titleArr;
}
@property (nonatomic, strong) UITextField *searchBar;

@property (nonatomic, strong) UICollectionView *segmentColl;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) RentingSurveyWaitVC *roomSurveyWaitVC;

@property (nonatomic, strong) RentingSurveyingVC *roomSurveyingVC;

@property (nonatomic, strong) RentingSurveyFailVC *roomSurveyFailVC;

@property (nonatomic, strong) RentingSurveyComplaitVC *roomSurveyComplaitVC;

@property (nonatomic, strong) RentingSurveySuccessVC *roomSurveySuccessVC;

@end

@implementation RentingSurveyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
    [_segmentColl selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:NO scrollPosition:0];
}

- (void)initDataSource{
    
    _titleArr = @[@"待确认",@"勘察中",@"勘察失败",@"申诉",@"勘察完成"];
}

#pragma mark -- collectionview
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _titleArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    RoomReportCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RoomReportCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[RoomReportCollCell alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width / 5, 40 *SIZE)];
    }
    cell.titleL.frame = CGRectMake(0, 14 *SIZE, SCREEN_Width / 5, 11 *SIZE);
    cell.line.frame = CGRectMake(22 *SIZE, 38 *SIZE, 28 *SIZE, 2 *SIZE);
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
    self.titleLabel.text = @"勘察";
    self.line.hidden = YES;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT + 40 *SIZE, SCREEN_Width, 40 *SIZE)];
    whiteView.backgroundColor = CH_COLOR_white;
    [self.view addSubview:whiteView];
    
    _searchBar = [[UITextField alloc] initWithFrame:CGRectMake(10 *SIZE, 3 *SIZE, 340 *SIZE, 33 *SIZE)];
    _searchBar.backgroundColor = YJBackColor;
    _searchBar.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 11 *SIZE, 0)];
    //设置显示模式为永远显示(默认不显示)
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
    _flowLayout.itemSize = CGSizeMake(SCREEN_Width / 5, 40 *SIZE);
    _flowLayout.minimumLineSpacing = 0;
    _flowLayout.minimumInteritemSpacing = 0;
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    
    _segmentColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, 40 *SIZE) collectionViewLayout:_flowLayout];
    _segmentColl.backgroundColor = CH_COLOR_white;
    _segmentColl.delegate = self;
    _segmentColl.dataSource = self;
    _segmentColl.showsHorizontalScrollIndicator = NO;
    _segmentColl.bounces = NO;
    [_segmentColl registerClass:[RoomReportCollCell class] forCellWithReuseIdentifier:@"RoomReportCollCell"];
    [self.view addSubview:_segmentColl];
    
    // 创建scrollView
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT + 80 *SIZE, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - NAVIGATION_BAR_HEIGHT - 80 *SIZE)];
    self.scrollView.scrollEnabled = NO;
    [self.view addSubview:self.scrollView];
    // 设置scrollView的内容
    self.scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * 5, [UIScreen mainScreen].bounds.size.height - NAVIGATION_BAR_HEIGHT);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.bounces = NO;
    
    // 创建控制器
    _roomSurveyWaitVC = [[RentingSurveyWaitVC alloc] init];
    _roomSurveyingVC = [[RentingSurveyingVC alloc] init];
    _roomSurveyFailVC = [[RentingSurveyFailVC alloc] init];
    _roomSurveyComplaitVC = [[RentingSurveyComplaitVC alloc] init];
    _roomSurveySuccessVC = [[RentingSurveySuccessVC alloc] init];
    // 添加为self的子控制器
    [self addChildViewController:_roomSurveyWaitVC];
    [self addChildViewController:_roomSurveyingVC];
    [self addChildViewController:_roomSurveyFailVC];
    [self addChildViewController:_roomSurveyComplaitVC];
    [self addChildViewController:_roomSurveySuccessVC];
    
    _roomSurveyWaitVC.view.frame = CGRectMake([UIScreen mainScreen].bounds.size.width * 0, 0, self.scrollView.frame.size.width, CGRectGetHeight(self.scrollView.frame));
    _roomSurveyingVC.view.frame = CGRectMake([UIScreen mainScreen].bounds.size.width * 1, 0, self.scrollView.frame.size.width, CGRectGetHeight(self.scrollView.frame));
    _roomSurveyFailVC.view.frame = CGRectMake([UIScreen mainScreen].bounds.size.width * 2, 0, self.scrollView.frame.size.width, CGRectGetHeight(self.scrollView.frame));
    _roomSurveyComplaitVC.view.frame = CGRectMake([UIScreen mainScreen].bounds.size.width * 3, 0, self.scrollView.frame.size.width, CGRectGetHeight(self.scrollView.frame));
    _roomSurveySuccessVC.view.frame = CGRectMake([UIScreen mainScreen].bounds.size.width * 4, 0, self.scrollView.frame.size.width, CGRectGetHeight(self.scrollView.frame));
    
    [self.scrollView addSubview:_roomSurveyWaitVC.view];
    [self.scrollView addSubview:_roomSurveyingVC.view];
    [self.scrollView addSubview:_roomSurveyFailVC.view];
    [self.scrollView addSubview:_roomSurveyComplaitVC.view];
    [self.scrollView addSubview:_roomSurveySuccessVC.view];
    // 设置scrollView的代理
    self.scrollView.delegate = self;
}

@end
