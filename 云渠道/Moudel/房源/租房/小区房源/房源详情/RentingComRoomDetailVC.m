//
//  RentingComRoomDetailVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/7/23.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RentingComRoomDetailVC.h"
#import "RentingComRoomProjectVC.h"
#import "SecComRoomBrokerageVC.h"
#import "RoomAnalyzeVC.h"

#import "RoomDetailCollCell.h"

@interface RentingComRoomDetailVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>
{
    
    NSArray *_titleArr;
    NSString *_projectId;
    NSString *_info_id;
    NSString *_city;
}
@property (nonatomic, strong) UICollectionView *segmentColl;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) UISegmentedControl *segmentedControl;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) RentingComRoomProjectVC *roomProjectVC;

@property (nonatomic, strong) RoomAnalyzeVC *roomAnalyzeVC;

@property (nonatomic, strong) SecComRoomBrokerageVC *roomBrokerageVC;

@property (nonatomic, strong) TransmitView *transmitView;

@end

@implementation RentingComRoomDetailVC

- (instancetype)initWithProjectId:(NSString *)projectId infoid:(NSString *)infoid city:(NSString *)city
{
    self = [super init];
    if (self) {
        
        _projectId = projectId;
        _city = city;
        _info_id = infoid;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //    [self GetFollowRequestMethod];
    [self.navigationController setNavigationBarHidden:YES animated:YES]; //设置隐藏
}

- (void)ActionMaskBtn:(UIButton *)btn{
    
    [self.navigationController popViewControllerAnimated:YES];
    //    for (UIViewController *vc in self.navigationController.viewControllers) {
    
    //        if ([vc isKindOfClass:[HouseSearchVC class]]) {
    //
    //            [self.navigationController setNavigationBarHidden:NO animated:YES];
    //            [self.navigationController popToViewController:vc animated:YES];
    //        }else{
    
    //            if ([vc isKindOfClass:[RoomVC class]]) {
    //
    //                [self.navigationController popViewControllerAnimated:YES];
    //            }
    //            if ([vc isKindOfClass:[BrokerageDetailVC class]]) {
    //                [self.navigationController popViewControllerAnimated:YES];
    //            }
    //            if ([vc isKindOfClass:[MyAttentionVC class]]) {
    //                [self.navigationController popViewControllerAnimated:YES];
    //            }
    //        }
    //    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
    [_segmentColl selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:NO scrollPosition:0];
}

- (void)initDataSource{
    
    _titleArr = @[@"小区",@"渠道",@"分析"];
}

- (void)ActionLeftBtn:(UIButton *)btn{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"mapViewDismiss" object:nil];
}


#pragma mark -- collectionview
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _titleArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    RoomDetailCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RoomDetailCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[RoomDetailCollCell alloc] initWithFrame:CGRectMake(0, 0, 66 *SIZE, 44)];
    }
    cell.titleL.text = _titleArr[indexPath.item];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [_scrollView setContentOffset:CGPointMake(SCREEN_Width * indexPath.item, 0) animated:NO];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NSInteger index = scrollView.contentOffset.x / SCREEN_Width;
    [_segmentColl selectItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] animated:NO scrollPosition:UICollectionViewScrollPositionLeft];
}

- (void)ActionRightBtn:(UIButton *)btn{
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.transmitView];
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.hidden = YES;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.maskButton addTarget:self action:@selector(ActionLeftBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.rightBtn.hidden = YES;
    [self.rightBtn setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    self.rightBtn.titleLabel.font = [UIFont systemFontOfSize:15 *SIZE];
    [self.rightBtn setTitleColor:YJTitleLabColor forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(ActionRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.itemSize = CGSizeMake(66 *SIZE, 44);
    _flowLayout.minimumLineSpacing = 0;
    _flowLayout.minimumInteritemSpacing = 0;
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    
    _segmentColl = [[UICollectionView alloc] initWithFrame:CGRectMake(80 *SIZE, STATUS_BAR_HEIGHT, 200 *SIZE, 43) collectionViewLayout:_flowLayout];
    _segmentColl.backgroundColor = [UIColor whiteColor];
    _segmentColl.delegate = self;
    _segmentColl.dataSource = self;
    _segmentColl.showsHorizontalScrollIndicator = NO;
    _segmentColl.bounces = NO;
    [_segmentColl registerClass:[RoomDetailCollCell class] forCellWithReuseIdentifier:@"RoomDetailCollCell"];
    [self.navBackgroundView addSubview:_segmentColl];
    
    // 创建scrollView
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - NAVIGATION_BAR_HEIGHT)];
    self.scrollView.scrollEnabled = NO;
    [self.view addSubview:self.scrollView];
    // 设置scrollView的内容
    self.scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * 3, [UIScreen mainScreen].bounds.size.height - NAVIGATION_BAR_HEIGHT);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.bounces = NO;
    
    // 创建控制器
    _roomProjectVC = [[RentingComRoomProjectVC alloc] initWithProjectId:_projectId infoid:_info_id city:_city];
    _roomProjectVC.type = self.type;
    
    _roomBrokerageVC = [[SecComRoomBrokerageVC alloc] initWithProjectId:_projectId];
    
    _roomAnalyzeVC = [[RoomAnalyzeVC alloc] initWithinfo_Id:_info_id];
    
    //添加子控制器
    [self addChildViewController:_roomProjectVC];
    
    [self addChildViewController:_roomBrokerageVC];
    
    [self addChildViewController:_roomAnalyzeVC];
    
    _roomProjectVC.view.frame = CGRectMake(0, 0, self.scrollView.frame.size.width, CGRectGetHeight(self.scrollView.frame));
    
    _roomBrokerageVC.view.frame = CGRectMake([UIScreen mainScreen].bounds.size.width, 0, self.scrollView.frame.size.width, CGRectGetHeight(self.scrollView.frame));
    
    _roomAnalyzeVC.view.frame = CGRectMake([UIScreen mainScreen].bounds.size.width * 2, 0, self.scrollView.frame.size.width, CGRectGetHeight(self.scrollView.frame));
    
    [self.scrollView addSubview:_roomProjectVC.view];
    [self.scrollView addSubview:_roomBrokerageVC.view];
    [self.scrollView addSubview:_roomAnalyzeVC.view];
    
    // 设置scrollView的代理
    self.scrollView.delegate = self;
}

- (TransmitView *)transmitView{
    
    if (!_transmitView) {
        
        _transmitView = [[TransmitView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
        WS(weakSelf);
        _transmitView.transmitTagBtnBlock = ^(NSInteger index) {
            
            if (index == 0) {
                
                if ([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_QQ]) {
                    
                    [weakSelf shareWebPageToPlatformType];
                }else{
                    
                    [weakSelf alertControllerWithNsstring:@"温馨提示" And:@"请先安装手机QQ"];
                }
            }else if (index == 1){
                
                if ([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_QQ]) {
                    
                    [weakSelf shareWebPageToPlatformType];
                }else{
                    
                    [weakSelf alertControllerWithNsstring:@"温馨提示" And:@"请先安装手机QQ"];
                }
            }else if (index == 2){
                
                if ([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_WechatSession]) {
                    
                    [weakSelf shareWebPageToPlatformType];
                }else{
                    
                    [weakSelf alertControllerWithNsstring:@"温馨提示" And:@"请先安装微信"];
                }
            }else{
                
                if ([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_WechatSession]) {
                    
                    [weakSelf shareWebPageToPlatformType];
                }else{
                    
                    [weakSelf alertControllerWithNsstring:@"温馨提示" And:@"请先安装微信"];
                }
            }
        };
    }
    return _transmitView;
}

//
- (void)shareWebPageToPlatformType {
    //创建分享消息对象
    //    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //    //创建网页内容对象
    //    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:_model.project_name descr:_model.district_name thumImage:[NSString stringWithFormat:@"%@%@",Base_Net,_model.img_url]];
    //    //设置网页地址
    
    
    //创建网页内容对象
    //    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"云渠道" descr:@"房产渠道专业平台" thumImage:[UIImage imageNamed:@"shareimg"]];
    //设置网页地址
    
    
    //    [BaseRequest GET:@"user/project/getShare" parameters:@{@"project_id":_model.project_id} success:^(id resposeObject) {
    //
    //        NSLog(@"%@",resposeObject);
    //        if ([resposeObject[@"code"] integerValue] == 200) {
    //
    //            shareObject.webpageUrl =@"http://itunes.apple.com/app/id1371978352?mt=8";
    //            //            shareObject.webpageUrl = resposeObject[@"data"];
    //            //分享消息对象设置分享内容对象
    //            messageObject.shareObject = shareObject;
    //
    //            //调用分享接口
    //            [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
    //                if (error) {
    //
    //                    [self alertControllerWithNsstring:@"分享失败" And:nil];
    //                }else{
    //
    //                    [self showContent:@"分享成功"];
    //                    [self.transmitView removeFromSuperview];
    //                }
    //            }];
    //        }else{
    //
    //            [self alertControllerWithNsstring:@"温馨提示" And:@"获取分享链接失败"];
    //        }
    //    } failure:^(NSError *error) {
    //
    //        [self alertControllerWithNsstring:@"温馨提示" And:@"获取分享链接失败"];
    //        NSLog(@"%@",error);
    //    }];
    
    
}

@end
