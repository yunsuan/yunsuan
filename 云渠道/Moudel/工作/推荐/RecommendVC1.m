//
//  RecommendVC1.m
//  云渠道
//
//  Created by 谷治墙 on 2019/1/17.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "RecommendVC1.h"

#import "QuickAddCustomVC.h"
#import "RecommendUnConfirmVC.h"
#import "RecommendValidVC.h"
#import "RecommendInvalidVC.h"
#import "NewComplaintVC.h"

#import "RoomReportCollCell.h"

@interface RecommendVC1 ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate,UITextFieldDelegate>
{
    
    NSArray *_titleArr;
}
@property (nonatomic, strong) UITextField *searchBar;

@property (nonatomic, strong) UICollectionView *segmentColl;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) RecommendUnconfirmVC *recommendUnconfirmVC;

@property (nonatomic, strong) RecommendValidVC *recommendValidVC;

@property (nonatomic, strong) RecommendInvalidVC *recommendInvalidVC;

@property (nonatomic, strong) NewComplaintVC *recommendComplaintVC;

@end

@implementation RecommendVC1

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ActionRecommendReload) name:@"recommendReload" object:nil];
    [self initDataSource];
    [self initUI];
    [_segmentColl selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:NO scrollPosition:0];
}

- (void)initDataSource{
    
    _titleArr = @[@"确认中",@"有效",@"无效",@"申诉"];
}

- (void)action_add{
    
    QuickAddCustomVC *nextVC = [[QuickAddCustomVC alloc] initWithProjectId:[NSString stringWithFormat:@"%@",@""] clientId:@""];
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (void)ActionRecommendReload{
    
    [_recommendUnconfirmVC RequestMethod];
    [_recommendValidVC RequestMethod];
    [_recommendInvalidVC RequestMethod];
    [_recommendComplaintVC RequestMethod];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    NSInteger index = _scrollView.contentOffset.x / SCREEN_Width;
    switch (index) {
        case 0:
        {
            _recommendUnconfirmVC.search = textField.text;
            [_recommendUnconfirmVC RequestMethod];
            break;
        }
        case 1:
        {
            _recommendValidVC.search = textField.text;
            [_recommendValidVC RequestMethod];
            break;
        }
        case 2:
        {
            _recommendInvalidVC.search = textField.text;
            [_recommendInvalidVC RequestMethod];
            break;
        }
        case 3:
        {
            _recommendComplaintVC.search = textField.text;
            [_recommendComplaintVC RequestMethod];
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
    self.titleLabel.text = @"报备";
    self.line.hidden = YES;
    
    self.rightBtn.hidden = NO;
    [self.rightBtn setImage:[UIImage imageNamed:@"add_3"] forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(action_add) forControlEvents:UIControlEventTouchUpInside];
    
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
    _recommendUnconfirmVC = [[RecommendUnconfirmVC alloc] init];
    _recommendValidVC = [[RecommendValidVC alloc] init];
    _recommendInvalidVC = [[RecommendInvalidVC alloc] init];
    _recommendComplaintVC = [[NewComplaintVC alloc] init];
    
    // 添加为self的子控制器
    [self addChildViewController:_recommendUnconfirmVC];
    [self addChildViewController:_recommendValidVC];
    [self addChildViewController:_recommendInvalidVC];
    [self addChildViewController:_recommendComplaintVC];
    
    _recommendUnconfirmVC.view.frame = CGRectMake([UIScreen mainScreen].bounds.size.width * 0, 0, self.scrollView.frame.size.width, CGRectGetHeight(self.scrollView.frame));
    _recommendValidVC.view.frame = CGRectMake([UIScreen mainScreen].bounds.size.width * 1, 0, self.scrollView.frame.size.width, CGRectGetHeight(self.scrollView.frame));
    _recommendInvalidVC.view.frame = CGRectMake([UIScreen mainScreen].bounds.size.width * 2, 0, self.scrollView.frame.size.width, CGRectGetHeight(self.scrollView.frame));
    _recommendComplaintVC.view.frame = CGRectMake([UIScreen mainScreen].bounds.size.width * 3, 0, self.scrollView.frame.size.width, CGRectGetHeight(self.scrollView.frame));
    
    [self.scrollView addSubview:_recommendUnconfirmVC.view];
    [self.scrollView addSubview:_recommendValidVC.view];
    [self.scrollView addSubview:_recommendInvalidVC.view];
    [self.scrollView addSubview:_recommendComplaintVC.view];
    // 设置scrollView的代理
    self.scrollView.delegate = self;
}

@end
