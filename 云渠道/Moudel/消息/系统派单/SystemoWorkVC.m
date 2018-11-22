//
//  SystemoWorkVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/10/24.
//  Copyright © 2018 xiaoq. All rights reserved.
//

#import "SystemoWorkVC.h"

#import "SystemWorkWaitVC.h"
#import "SystemWorkConfrimVC.h"
#import "SystemWorkDisabledVC.h"

#import "RoomReportCollCell.h"

@interface SystemoWorkVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate,UITextFieldDelegate>
{
    
    NSArray *_titleArr;
}
@property (nonatomic, strong) UICollectionView *segmentColl;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) SystemWorkWaitVC *systemWorkWaitVC;

@property (nonatomic, strong) SystemWorkConfrimVC *systemWorkConfrimVC;

@property (nonatomic, strong) SystemWorkDisabledVC *systemWorkDisabledVC;

@end

@implementation SystemoWorkVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
    [_segmentColl selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:NO scrollPosition:0];
    [self RequestMethod];
}

- (void)initDataSource{
    
     _titleArr = @[@"待确认",@"已接单",@"已失效"];
}

- (void)RequestMethod{
    
//    [BaseRequest GET:HouseRecordList_URL parameters:nil success:^(id resposeObject) {
//
//        NSLog(@"%@",resposeObject);
//        if ([resposeObject[@"code"] integerValue] == 200) {
//
//            [_dataArr removeAllObjects];
//            [self SetData:resposeObject[@"data"]];
//        }else{
//
//            [self showContent:resposeObject[@"msg"]];
//        }
//        [_waitTable reloadData];
//    } failure:^(NSError *error) {
//
//        NSLog(@"%@",error);
//        [self showContent:@"网络错误"];
//    }];
}

//- (void)SetData:(NSArray *)data{
//
//
//    _dataArr = [NSMutableArray arrayWithArray:data];
//    for (int i = 0; i < _dataArr.count; i++) {
//
//        NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:_dataArr[i]];
//        [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
//
//            if ([obj isKindOfClass:[NSNull class]]) {
//
//                [tempDic setObject:@"" forKey:key];
//            }
//        }];
//        [_dataArr replaceObjectAtIndex:i withObject:tempDic];
//    }
//
//    [_waitTable reloadData];
//}

#pragma mark -- collectionview
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _titleArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    RoomReportCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RoomReportCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[RoomReportCollCell alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width / 3, 40 *SIZE)];
    }
    cell.titleL.frame = CGRectMake(0, 14 *SIZE, SCREEN_Width / 3, 11 *SIZE);
    cell.line.frame = CGRectMake(46 *SIZE, 38 *SIZE, 28 *SIZE, 2 *SIZE);
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
    self.titleLabel.text = @"系统派单";
    self.line.hidden = YES;
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.itemSize = CGSizeMake(SCREEN_Width / 3, 40 *SIZE);
    _flowLayout.minimumLineSpacing = 0;
    _flowLayout.minimumInteritemSpacing = 0;
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _segmentColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, 40 *SIZE) collectionViewLayout:_flowLayout];
    _segmentColl.backgroundColor = [UIColor whiteColor];
    _segmentColl.delegate = self;
    _segmentColl.dataSource = self;
    _segmentColl.showsHorizontalScrollIndicator = NO;
    _segmentColl.bounces = NO;
    [_segmentColl registerClass:[RoomReportCollCell class] forCellWithReuseIdentifier:@"RoomReportCollCell"];
    [self.view addSubview:_segmentColl];
    
    // 创建scrollView
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT + 41 *SIZE, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - NAVIGATION_BAR_HEIGHT - 41 *SIZE)];
    self.scrollView.scrollEnabled = NO;
    [self.view addSubview:self.scrollView];
    // 设置scrollView的内容
    self.scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * 4, [UIScreen mainScreen].bounds.size.height - NAVIGATION_BAR_HEIGHT - 41 *SIZE);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.bounces = NO;
    
    // 创建控制器
    _systemWorkWaitVC = [[SystemWorkWaitVC alloc] init];
    _systemWorkConfrimVC = [[SystemWorkConfrimVC alloc] init];
    _systemWorkDisabledVC = [[SystemWorkDisabledVC alloc] init];
//    _roomReportComplaitVC = [[RoomReportComplaitVC alloc] init];
//
//    // 添加为self的子控制器
    [self addChildViewController:_systemWorkWaitVC];
    [self addChildViewController:_systemWorkConfrimVC];
    [self addChildViewController:_systemWorkDisabledVC];
//    [self addChildViewController:_roomReportComplaitVC];
//
    _systemWorkWaitVC.view.frame = CGRectMake([UIScreen mainScreen].bounds.size.width * 0, 0, self.scrollView.frame.size.width, CGRectGetHeight(self.scrollView.frame));
    _systemWorkConfrimVC.view.frame = CGRectMake([UIScreen mainScreen].bounds.size.width * 1, 0, self.scrollView.frame.size.width, CGRectGetHeight(self.scrollView.frame));
    _systemWorkDisabledVC.view.frame = CGRectMake([UIScreen mainScreen].bounds.size.width * 2, 0, self.scrollView.frame.size.width, CGRectGetHeight(self.scrollView.frame));
//    _roomReportComplaitVC.view.frame = CGRectMake([UIScreen mainScreen].bounds.size.width * 3, 0, self.scrollView.frame.size.width, CGRectGetHeight(self.scrollView.frame));
//
    [self.scrollView addSubview:_systemWorkWaitVC.view];
    [self.scrollView addSubview:_systemWorkConfrimVC.view];
    [self.scrollView addSubview:_systemWorkDisabledVC.view];
//    [self.scrollView addSubview:_roomReportComplaitVC.view];
    // 设置scrollView的代理
    self.scrollView.delegate = self;
}

@end
