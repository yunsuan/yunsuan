//
//  ContractSignVC.m
//  云渠道
//
//  Created by 谷治墙 on 2019/1/10.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "ContractSignVC.h"

#import "ContractSignWaitVC.h"
#import "ContractSignDoneVC.h"
#import "ContractSignListVC.h"
#import "AddContractVC.h"

#import "RoomAgencyCollCell.h"

@interface ContractSignVC ()<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UIScrollViewDelegate,UITextFieldDelegate>
{
    
    NSArray *_titleArr;
    
}

@property (nonatomic, strong) UITextField *searchBar;

@property (nonatomic, strong) UICollectionView *segmentColl;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) ContractSignWaitVC *contractSignWaitVC;

@property (nonatomic, strong) ContractSignDoneVC *contractSignDoneVC;

@property (nonatomic, strong) ContractSignListVC *contractSignListVC;

@end

@implementation ContractSignVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
    [_segmentColl selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:NO scrollPosition:0];
}



- (void)initDataSource{
    
    _titleArr = @[@"待审核",@"已审核",@"合同列表"];
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (_scrollView.contentOffset.x == 0) {
        
        _contractSignWaitVC.search = textField.text;
        [_contractSignWaitVC postWithpage:@"1"];
    }else if (_scrollView.contentOffset.x == 1) {
        
        _contractSignDoneVC.search = textField.text;
        [_contractSignDoneVC postWithpage:@"1"];
    }else{
        
        _contractSignListVC.search = textField.text;
        [_contractSignListVC postWithpage:@"1"];

    }
    return YES;
}


- (void)action_add{
    
    AddContractVC *nextVC = [[AddContractVC alloc] init];
    [self.navigationController pushViewController:nextVC animated:YES];
//    [BaseRequest GET:HouseSubNeedAgent_URL parameters:nil success:^(id resposeObject) {
//
//        NSLog(@"%@",resposeObject);
//        if ([resposeObject[@"code"] integerValue] == 200) {
//
////            RoomAgencyAddProtocolVC *nextVC = [[RoomAgencyAddProtocolVC alloc] initWithDataArr:@[]];
////            NSMutableDictionary *dic = [resposeObject[@"data"] mutableCopy];
////            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
////            [formatter setDateFormat:@"YYYY/MM/dd"];
////            [dic setObject:[formatter stringFromDate:[NSDate date]] forKey:@"regist_time"];
////            [dic setObject:dic[@"name"] forKey:@"agent_name"];
////            [dic setObject:dic[@"tel"] forKey:@"agent_tel"];
////
////
////            nextVC.handleDic = [[NSMutableDictionary alloc] initWithDictionary:dic];
////            //            nextVC.handleDic
////            nextVC.housedic = [NSMutableDictionary dictionaryWithDictionary:[@{} mutableCopy]];
////            //            nextVC.roomAgencyAddProtocolVCBlock = ^{
////            //
////            //                if (self.maintainDetailVCBlock) {
////            //
////            //                    self.maintainDetailVCBlock();
////            //                }
////            //            };
////            [self.navigationController pushViewController:nextVC animated:YES];
//        }else{
//
//            [self showContent:resposeObject[@"msg"]];
//        }
//    } failure:^(NSError *error) {
//
//        NSLog(@"%@",error);
//        [self showContent:@"网络错误"];
//    }];
}

#pragma mark -- collectionview
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _titleArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    RoomAgencyCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RoomAgencyCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[RoomAgencyCollCell alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width / 3, 40 *SIZE)];
    }
    cell.titleL.frame = CGRectMake(0, 14 *SIZE, SCREEN_Width / 3, 11 *SIZE);
    cell.line.frame = CGRectMake(38 *SIZE, 38 *SIZE, 46 *SIZE, 2 *SIZE);
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
    self.titleLabel.text = @"合同";
    self.line.hidden = YES;
    
    self.rightBtn.hidden = NO;
    [self.rightBtn setImage:[UIImage imageNamed:@"add_3"] forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(action_add) forControlEvents:UIControlEventTouchUpInside];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.itemSize = CGSizeMake(SCREEN_Width / 3, 40 *SIZE);
    _flowLayout.minimumLineSpacing = 0;
    _flowLayout.minimumInteritemSpacing = 0;
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    
    _segmentColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT + 40 *SIZE, SCREEN_Width, 40 *SIZE) collectionViewLayout:_flowLayout];
    _segmentColl.backgroundColor = [UIColor whiteColor];
    _segmentColl.delegate = self;
    _segmentColl.dataSource = self;
    _segmentColl.showsHorizontalScrollIndicator = NO;
    _segmentColl.bounces = NO;
    [_segmentColl registerClass:[RoomAgencyCollCell class] forCellWithReuseIdentifier:@"RoomAgencyCollCell"];
    [self.view addSubview:_segmentColl];
    
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, 40 *SIZE)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiteView];
    
    _searchBar = [[UITextField alloc] initWithFrame:CGRectMake(10 *SIZE, 3 *SIZE, 340 *SIZE, 33 *SIZE)];
    _searchBar.backgroundColor = YJBackColor;
    _searchBar.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 11 *SIZE, 0)];
    //设置显示模式为永远显示(默认不显示)
    _searchBar.leftViewMode = UITextFieldViewModeAlways;
    _searchBar.placeholder = @"搜索编号";
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
    
    // 创建scrollView
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT + 81 *SIZE, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - NAVIGATION_BAR_HEIGHT - 81 *SIZE)];
    self.scrollView.scrollEnabled = NO;
    [self.view addSubview:self.scrollView];
    // 设置scrollView的内容
    self.scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * 3, [UIScreen mainScreen].bounds.size.height - NAVIGATION_BAR_HEIGHT - 81 *SIZE);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.bounces = NO;
    
    // 创建控制器
    //    WS(weakSelf);
    SS(strongSelf);
    _contractSignWaitVC = [[ContractSignWaitVC alloc] init];
    _contractSignWaitVC.contractSignWaitVCBlock = ^{
        
        [strongSelf->_segmentColl selectItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"AgencyProtocol" object:nil];
    };
    _contractSignDoneVC = [[ContractSignDoneVC alloc] init];
    _contractSignListVC = [[ContractSignListVC alloc] init];
    
    // 添加为self的子控制器
    [self addChildViewController:_contractSignWaitVC];
    [self addChildViewController:_contractSignDoneVC];
    [self addChildViewController:_contractSignListVC];
    
    _contractSignWaitVC.view.frame = CGRectMake([UIScreen mainScreen].bounds.size.width * 0, 0, self.scrollView.frame.size.width, CGRectGetHeight(self.scrollView.frame));
    _contractSignDoneVC.view.frame = CGRectMake([UIScreen mainScreen].bounds.size.width * 1, 0, self.scrollView.frame.size.width, CGRectGetHeight(self.scrollView.frame));
    _contractSignListVC.view.frame = CGRectMake([UIScreen mainScreen].bounds.size.width * 2, 0, self.scrollView.frame.size.width, CGRectGetHeight(self.scrollView.frame));
    
    
    [self.scrollView addSubview:_contractSignWaitVC.view];
    [self.scrollView addSubview:_contractSignDoneVC.view];
    [self.scrollView addSubview:_contractSignListVC.view];
    
    // 设置scrollView的代理
    self.scrollView.delegate = self;
}

@end
