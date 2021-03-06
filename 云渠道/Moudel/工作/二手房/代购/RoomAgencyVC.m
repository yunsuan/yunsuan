//
//  RoomAgencyVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/6/19.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RoomAgencyVC.h"
#import "RoomAgencyProtocolVC.h"
#import "RoomAgencyDoneVC.h"
//#import "SecdaryCommunityRoomVC.h"
#import "RoomAgencyAddProtocolVC.h"

#import "RoomAgencyCollCell.h"

@interface RoomAgencyVC ()<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UIScrollViewDelegate,UITextFieldDelegate>
{
    
    NSArray *_titleArr;

}

@property (nonatomic, strong) UITextField *searchBar;

@property (nonatomic, strong) UICollectionView *segmentColl;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) RoomAgencyProtocolVC *roomAgencyProtocolVC;

@property (nonatomic, strong) RoomAgencyDoneVC *roomAgencyDoneVC;

@end

@implementation RoomAgencyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
    [_segmentColl selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:NO scrollPosition:0];
}



- (void)initDataSource{
    
    _titleArr = @[@"已代购",@"挞定"];

}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (_scrollView.contentOffset.x == 0) {
        
        _roomAgencyDoneVC.search = textField.text;
        [_roomAgencyDoneVC postWithpage:@"1"];
    }else{
        
        _roomAgencyProtocolVC.search = textField.text;
        [_roomAgencyProtocolVC RequestMethod];
    }
    return YES;
}


- (void)action_add{
    
    [BaseRequest GET:HouseSubNeedAgent_URL parameters:nil success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            RoomAgencyAddProtocolVC *nextVC = [[RoomAgencyAddProtocolVC alloc] initWithDataArr:@[]];
            NSMutableDictionary *dic = [resposeObject[@"data"] mutableCopy];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"YYYY/MM/dd"];
            [dic setObject:[formatter stringFromDate:[NSDate date]] forKey:@"regist_time"];
            [dic setObject:dic[@"name"] forKey:@"agent_name"];
            [dic setObject:dic[@"tel"] forKey:@"agent_tel"];
            
            
            nextVC.handleDic = [[NSMutableDictionary alloc] initWithDictionary:dic];
//            nextVC.handleDic 
            nextVC.housedic = [NSMutableDictionary dictionaryWithDictionary:[@{} mutableCopy]];
//            nextVC.roomAgencyAddProtocolVCBlock = ^{
//                
//                if (self.maintainDetailVCBlock) {
//                    
//                    self.maintainDetailVCBlock();
//                }
//            };
            [self.navigationController pushViewController:nextVC animated:YES];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        [self showContent:@"网络错误"];
    }];
//    RoomAgencyAddProtocolVC *nextVC = [[RoomAgencyAddProtocolVC alloc] initWithDataArr:@[]];
////    nextVC.hidesBottomBarWhenPushed = YES;
//    nextVC.housedic = [@{} mutableCopy];
//    [self.navigationController pushViewController:nextVC animated:YES];
}

#pragma mark -- collectionview
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _titleArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    RoomAgencyCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RoomAgencyCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[RoomAgencyCollCell alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width / 2, 40 *SIZE)];
    }
    cell.titleL.frame = CGRectMake(0, 14 *SIZE, SCREEN_Width / 2, 11 *SIZE);
    cell.line.frame = CGRectMake(75 *SIZE, 38 *SIZE, 30 *SIZE, 2 *SIZE);
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
    self.titleLabel.text = @"代购";
    self.line.hidden = YES;
    
    self.rightBtn.hidden = NO;
    [self.rightBtn setImage:[UIImage imageNamed:@"add_3"] forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(action_add) forControlEvents:UIControlEventTouchUpInside];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.itemSize = CGSizeMake(SCREEN_Width / 2, 40 *SIZE);
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
    _searchBar.placeholder = @"输入编号";
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
    self.scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * 2, [UIScreen mainScreen].bounds.size.height - NAVIGATION_BAR_HEIGHT - 81 *SIZE);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.bounces = NO;
    
    // 创建控制器
//    WS(weakSelf);
    SS(strongSelf);
    _roomAgencyDoneVC = [[RoomAgencyDoneVC alloc] init];
    _roomAgencyDoneVC.roomAgencyDoneVCBlock = ^{
      
        [strongSelf->_segmentColl selectItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"AgencyProtocol" object:nil];
    };
    _roomAgencyProtocolVC = [[RoomAgencyProtocolVC alloc] init];

    // 添加为self的子控制器
    [self addChildViewController:_roomAgencyDoneVC];
    [self addChildViewController:_roomAgencyProtocolVC];
    
    _roomAgencyDoneVC.view.frame = CGRectMake([UIScreen mainScreen].bounds.size.width * 0, 0, self.scrollView.frame.size.width, CGRectGetHeight(self.scrollView.frame));
    _roomAgencyProtocolVC.view.frame = CGRectMake([UIScreen mainScreen].bounds.size.width * 1, 0, self.scrollView.frame.size.width, CGRectGetHeight(self.scrollView.frame));
   
    
    [self.scrollView addSubview:_roomAgencyDoneVC.view];
    [self.scrollView addSubview:_roomAgencyProtocolVC.view];
    
    // 设置scrollView的代理
    self.scrollView.delegate = self;
}
@end
