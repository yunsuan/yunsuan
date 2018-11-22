//
//  RoomVC2.m
//  云渠道
//
//  Created by xiaoq on 2018/10/23.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import<BaiduMapAPI_Location/BMKLocationService.h>
#import<BaiduMapAPI_Search/BMKGeocodeSearch.h>
#import<BaiduMapAPI_Map/BMKMapComponent.h>
#import<BaiduMapAPI_Search/BMKPoiSearchType.h>
#import <CoreLocation/CoreLocation.h>

#import "PYSearchViewController.h"

#import "RoomChildVC.h"
#import "RoomVC.h"
#import "CityVC.h"
#import "RoomDetailVC1.h"
#import "SecAllRoomDetailVC.h"
#import "SecComRoomDetailVC.h"
#import "SecProhectSearchVC.h"
#import "SecHouseSearchVC.h"

#import "HouseSearchVC.h"

#import "HNChannelView.h"


@interface RoomVC ()<BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate,WMPageControllerDataSource,WMPageControllerDelegate,PYSearchViewControllerDelegate>
{
    
    BOOL _isLocation;
    BMKLocationService *_locService;  //定位
    BMKGeoCodeSearch *_geocodesearch; //地理编码主类，用来查询、返回结果信息
    NSMutableArray *_searchArr;
    NSString *_city;
    NSString *_cityName;
    //    NSMutableArray *_typeArr;
    NSMutableArray *_titlearr;
    
}

@property (nonatomic , strong) UIView *headerView;

@property (nonatomic, strong) UIButton *cityBtn;

@property (nonatomic, strong) UIView *searchBar;

@property (nonatomic, strong) UIButton *moreBtn;

@end

@implementation RoomVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    [self initDataSource];
    [self initUI];
    
    
}

- (void)initDataSource{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ActionGoto:) name:@"goto" object:nil];
    
    _titlearr = [UserModel defaultModel].tagSelectArr;
    
    _geocodesearch = [[BMKGeoCodeSearch alloc] init];
    _geocodesearch.delegate = self;
    
    if ([CLLocationManager locationServicesEnabled] && [CLLocationManager authorizationStatus] != kCLAuthorizationStatusDenied) {
        
        if (!_isLocation) {
            
            [self startLocation];
        }else{
            
            
        }
    }else{
        
        _isLocation = YES;
        [_cityBtn setTitle:@"成都市" forState:UIControlStateNormal];
        _city = [NSString stringWithFormat:@"510100"];
        _cityName = @"成都市";
        //        [self RequestMethod];
        
        
        [self alertControllerWithNsstring:@"打开[定位服务权限]来允许[云渠道]确定您的位置" And:@"请在系统设置中开启定位服务(设置>隐私>定位服务>开启)" WithCancelBlack:^{
            
            
        } WithDefaultBlack:^{
            
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if( [[UIApplication sharedApplication]canOpenURL:url] ) {
                [[UIApplication sharedApplication] openURL:url];
            }
        }];
    }
}



#pragma mark -- 百度SDK
-(void)startLocation

{
    
    //初始化BMKLocationService
    
    _locService = [[BMKLocationService alloc]init];
    
    _locService.delegate = self;
    
    _locService.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    
    //启动LocationService
    
    [_locService startUserLocationService];
    
}

- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation

{
    
    NSLog(@"heading is %@",userLocation.heading);
    
    
}

//处理位置坐标更新

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    
    reverseGeocodeSearchOption.reverseGeoPoint = userLocation.location.coordinate;
    
    BOOL flag = [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
    
    if(flag){
        
        //        NSLog(@"反geo检索发送成功");
        
        [_locService stopUserLocationService];
        
    }else{
        
        //        NSLog(@"反geo检索发送失败");
        
    }
    
}

#pragma mark -------------地理反编码的delegate---------------

-(void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error

{
    
    [_cityBtn setTitle:result.addressDetail.city forState:UIControlStateNormal];
    NSInteger disInteger = [result.addressDetail.adCode integerValue];
    NSInteger cityInteger = disInteger / 100 * 100;
    _city = [NSString stringWithFormat:@"%ld",cityInteger];
    _cityName = result.addressDetail.city;
    
    [self pageController:self willEnterViewController:self.childViewControllers[0] withInfo:@{}];
    if (error) {
        
        [self alertControllerWithNsstring:@"定位失败" And:@"是否要重新定位" WithCancelBlack:^{
            
        } WithDefaultBlack:^{
            
            [self startLocation];
        }];
    }
}

//定位失败

- (void)didFailToLocateUserWithError:(NSError *)error{
    
    //    NSLog(@"error:%@",error);
    [self alertControllerWithNsstring:@"定位失败" And:@"请检查定位设置"];
    
}


#pragma mark -- Method

- (void)ActionGoto:(NSNotification *)noti{
    
    [self.navigationController.tabBarController setSelectedIndex:1];
}

- (void)ActionSearchBtn:(UIButton *)btn{
    
    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:_searchArr searchBarPlaceholder:@"请输入楼盘名或地址" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        // 开始搜索执行以下代码
        // 如：跳转到指定控制器
        if (![self isEmpty:searchText]) {
            
            RoomChildVC *vc = self.childViewControllers[0];
            if ([vc.status containsString:@"新房"]) {
                
                HouseSearchVC *nextVC = [[HouseSearchVC alloc] initWithTitle:searchText city:_city];
                [searchViewController.navigationController pushViewController:nextVC animated:YES];
            }else if ([vc.status containsString:@"推荐"] || [vc.status containsString:@"关注"]){
                
                HouseSearchVC *nextVC = [[HouseSearchVC alloc] initWithTitle:searchText city:_city];
                [searchViewController.navigationController pushViewController:nextVC animated:YES];
            }else if ([vc.status containsString:@"小区"]){
                
                SecProhectSearchVC *nextVC = [[SecProhectSearchVC alloc] initWithTitle:searchText city:_city];
//                nextVC.type = self
                [searchViewController.navigationController pushViewController:nextVC animated:YES];
            }else{
                
                SecHouseSearchVC *nextVC = [[SecHouseSearchVC alloc] initWithTitle:searchText city:_city];
                [searchViewController.navigationController pushViewController:nextVC animated:YES];
            }
            
        }
    }];
    // 3. 设置风格
    searchViewController.searchBar.returnKeyType = UIReturnKeySearch;
    searchViewController.hotSearchStyle = 3; // 热门搜索风格根据选择
    searchViewController.searchHistoryStyle = PYHotSearchStyleDefault; // 搜索历史风格为
    // 4. 设置代理
    searchViewController.delegate = self;
    // 5. 跳转到搜索控制器
    //    [self.navigationController pushViewController:searchViewController animated:YES];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:searchViewController];
    [self.navigationController presentViewController:nav  animated:NO completion:nil];
}

- (void)ActionCityBtn:(UIButton *)btn{
    
    
    CityVC *nextVC = [[CityVC alloc] initWithLabel:_cityName];
    nextVC.cityVCSaveBlock = ^(NSString *code, NSString *city) {
        
        _isLocation = YES;
        [_cityBtn setTitle:city forState:UIControlStateNormal];
        _city = [NSString stringWithFormat:@"%@",code];
        
        [self pageController:self willEnterViewController:self.childViewControllers[0] withInfo:@{}];
    };
    nextVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (void)ActionMoreBtn:(UIButton *)btn{
    
    HNChannelView *view = [[HNChannelView alloc]initWithFrame:CGRectMake(0, SCREEN_Height, SCREEN_Width, SCREEN_Height -STATUS_BAR_HEIGHT)];
    
    view.clickblook = ^(int selctnum) {
        _titlearr = [UserModel defaultModel].tagSelectArr;
        
        self.selectIndex = selctnum;
        [self reloadData];
    };
    
    view.hideblook = ^{
        _titlearr = [UserModel defaultModel].tagSelectArr;
        //        self.selectIndex = 0;
        [self reloadData];
        [self forceLayoutSubviews];
    };
    [[UIApplication sharedApplication].keyWindow addSubview:view];
    [view show];
}





- (void)initUI{
    
    self.delegate = self;
    self.dataSource = self;
    self.automaticallyCalculatesItemWidths = YES;
    self.itemMargin = 10;
    self.titleColorSelected = [UIColor colorWithRed:27.0/255.0 green:155.0/255.0 blue:255.0/255.0 alpha:1];
    self.menuView.backgroundColor   = [UIColor colorWithRed:244.0/255.0 green:244.0/255.0 blue:244.0/255.0 alpha:1.0];
    
    //    self.menuViewContentMargin = 20*SIZE;
    [self reloadData];
    
    
    self.navBackgroundView.hidden = YES;
    
    _headerView = [[UIView alloc ]initWithFrame:CGRectMake(0, 0,360 *SIZE , 46*SIZE + STATUS_BAR_HEIGHT)];
    _headerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_headerView];
    
    _cityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _cityBtn.frame = CGRectMake(0, 19 *SIZE + STATUS_BAR_HEIGHT, 50 *SIZE, 21 *SIZE);
    _cityBtn.titleLabel.font = [UIFont systemFontOfSize:12 *SIZE];
    [_cityBtn addTarget:self action:@selector(ActionCityBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_cityBtn setTitleColor:YJ86Color forState:UIControlStateNormal];
    [_cityBtn setTitle:@"定位中" forState:UIControlStateNormal];
    [self.headerView addSubview:_cityBtn];
    
    _searchBar = [[UIView alloc] initWithFrame:CGRectMake(58 *SIZE, 13 *SIZE + STATUS_BAR_HEIGHT, 291 *SIZE, 33 *SIZE)];
    _searchBar.backgroundColor = YJBackColor;
    [self.headerView addSubview:_searchBar];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(11 *SIZE, 11 *SIZE, 100 *SIZE, 12 *SIZE)];
    label.textColor = COLOR(147, 147, 147, 1);
    label.text = @"小区/楼盘/商铺";
    label.font = [UIFont systemFontOfSize:11 *SIZE];
    [_searchBar addSubview:label];
    
    UIImageView *rightImg = [[UIImageView alloc] initWithFrame:CGRectMake(267 *SIZE, 8 *SIZE, 17 *SIZE, 17 *SIZE)];
    rightImg.image = [UIImage imageNamed:@"search_2"];
    [_searchBar addSubview:rightImg];
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame = _searchBar.bounds;
    [searchBtn addTarget:self action:@selector(ActionSearchBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_searchBar addSubview:searchBtn];
    
    
    _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _moreBtn.backgroundColor = COLOR(255, 255, 255, 0.9);
    _moreBtn.frame = CGRectMake(320 *SIZE, NAVIGATION_BAR_HEIGHT+20*SIZE, 40 *SIZE, 40 *SIZE);
    [_moreBtn addTarget:self action:@selector(ActionMoreBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_moreBtn setImage:[UIImage imageNamed:@"add_50"] forState:UIControlStateNormal];
    [self.view addSubview:_moreBtn];
    
    
}

- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    
    if (_titlearr.count == 0) {
        return 0;
    }
    else{
        return _titlearr.count;
    }
    
}

- (void)pageController:(WMPageController *)pageController willEnterViewController:(__kindof UIViewController *)viewController withInfo:(NSDictionary *)info{
    
    if ([viewController isKindOfClass:[RoomChildVC class]]) {
        NSLog(@"%@",viewController);
        if ([((RoomChildVC *)viewController).city isEqualToString:_city]) {
            
            
        }else{
            
            ((RoomChildVC *)viewController).city = _city;
            if (![((RoomChildVC *)viewController).status isEqualToString:@"推荐"]) {
                
                [(RoomChildVC *) viewController RequestMethod];
            }
            
        }
    }
    else{
        
        
    }
}


- (__kindof UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    
    
    NSString *tempStr = _titlearr[index];
    NSDictionary *dic;
    dic = [UserModel defaultModel].tagDic[tempStr];
    RoomChildVC *vc;
    if ([((NSString *)dic[@"tag"]) containsString:@"新房"]) {
        
        vc = [[RoomChildVC alloc] initWithType:2];
    }else if(/*[((NSString *)dic[@"tag"]) containsString:@"推荐"] || */[((NSString *)dic[@"tag"]) containsString:@"关注"]) {
        
        vc = [[RoomChildVC alloc] initWithType:1];
    }else{
        
        vc = [[RoomChildVC alloc] initWithType:0];
    }
    vc.status = dic[@"tag"];
    vc.typeId = [NSString stringWithFormat:@"%@",dic[@"type_id"]];
    vc.param = [NSString stringWithFormat:@"%@",dic[@"param"]];
    vc.city = _city;
    vc.roomChildVCRoomModelBlock = ^(RoomListModel *model) {
        
        RoomDetailVC1 *nextVC = [[RoomDetailVC1 alloc] initWithModel:model];
        if ([model.guarantee_brokerage integerValue] == 2) {
            
            nextVC.brokerage = @"no";
        }else{
            
            nextVC.brokerage = @"yes";
        }
        nextVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:nextVC animated:YES];
        
    };
    
    vc.roomChildVCSecModelBlock = ^(SecdaryAllTableModel *model) {
        
        SecAllRoomDetailVC *nextVC = [[SecAllRoomDetailVC alloc] initWithHouseId:model.house_id city:_city];
        nextVC.type = [model.type integerValue];
        nextVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:nextVC animated:YES];
        
    };
    
    //        vc.roomChildVCSecComModelBlock = ^(SecdaryComModel *model) {
    //
    //            SecComRoomDetailVC *nextVC = [[SecComRoomDetailVC alloc] initWithProjectId:model.project_id city:_city];
    //            nextVC.type = vc.typeId;
    //            nextVC.hidesBottomBarWhenPushed = YES;
    //            [self.navigationController pushViewController:nextVC animated:YES];
    //        };
    
    __weak RoomChildVC *weakvc = vc;
    vc.roomChildVCSecComModelBlock = ^(SecdaryComModel *model) {
        
        SecComRoomDetailVC *nextVC = [[SecComRoomDetailVC alloc] initWithProjectId:model.project_id infoid:model.info_id city:_city];
        
        nextVC.type = weakvc.typeId;
        nextVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:nextVC animated:YES];
    };
    return vc;
    
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {

    return _titlearr[index];
}


#pragma mark - WMPageControllerDataSource

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    
    return CGRectMake(0, NAVIGATION_BAR_HEIGHT+20*SIZE, 320*SIZE, 40*SIZE);
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {

    return CGRectMake(0, NAVIGATION_BAR_HEIGHT+60*SIZE, 360*SIZE, SCREEN_Height-NAVIGATION_BAR_HEIGHT-60*SIZE);
    
}


@end
