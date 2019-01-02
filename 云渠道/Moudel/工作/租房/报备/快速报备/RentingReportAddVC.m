//
//  RentingReportAddVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/7/24.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RentingReportAddVC.h"

#import "RentingComRoomDetailVC.h"
//#import "DistributVC.h"
#import "SecDistributVC.h"
#import "CityVC.h"
#import "RentingComAllRoomListVC.h"
#import "PYSearchViewController.h"
#import "BoxView.h"
#import "BoxAddressView.h"
//#import "AdressChooseView.h"
#import "MoreView.h"
//#import "SecdaryComTableCell.h"
#import "RentingComTableCell.h"

#import <BaiduMapAPI_Location/BMKLocationService.h>

@interface RentingReportAddVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,BMKLocationServiceDelegate,PYSearchViewControllerDelegate>
{
    
    NSInteger _page;
    NSMutableArray *_dataArr;
    //    NSString *_provice;
    NSString *_city;
    NSString *_district;
    NSString *_price;
    NSString *_type;
    //    NSString *_more;
    NSString *_tag;
    NSString *_houseType;
    //    NSString *_status;
    NSString *_asc;
    NSMutableArray *_searchArr;
    //    NSArray *_tagsArr;
    NSArray *_propertyArr;
    BOOL _is1;
    BOOL _is2;
    BOOL _is3;
    BOOL _is4;
}

@property (nonatomic , strong) UITableView *MainTableView;

@property (nonatomic , strong) UIView *headerView;

@property (nonatomic, strong) UIButton *cityBtn;

@property (nonatomic, strong) UIView *searchBar;

@property (nonatomic, strong) UIButton *areaBtn;

@property (nonatomic, strong) UIButton *priceBtn;

@property (nonatomic, strong) UIButton *typeBtn;

@property (nonatomic, strong) UIButton *moreBtn;

@property (nonatomic, strong) UIButton *sortBtn;

@property (nonatomic, strong) BoxAddressView *areaView;

@property (nonatomic, strong) BoxView *priceView;

@property (nonatomic, strong) BoxView *typeView;

@property (nonatomic, strong) UIImageView *upImg;

@property (nonatomic, strong) MoreView *moreView;

@end

@implementation RentingReportAddVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = YJBackColor;
    self.navBackgroundView.hidden = NO;
    [self initDateSouce];
    [self initUI];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)initDateSouce
{
    
    _searchArr = [@[] mutableCopy];
    _dataArr = [@[] mutableCopy];
    _page = 1;
    _asc = @"asc";
    //    _tagsArr = [self getDetailConfigArrByConfigState:PROJECT_TAGS_DEFAULT];
    _propertyArr = [self getDetailConfigArrByConfigState:PROPERTY_TYPE];
    //    [self RequestMethod];
}

- (void)SetSearch:(NSDictionary *)data{
    
    [_searchArr removeAllObjects];
    [data enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        [_searchArr addObject:key];
    }];
}

- (void)RequestMethod{
    
    _page = 1;
    if (_page == 1) {
        
        self.MainTableView.mj_footer.state = MJRefreshStateIdle;
    }
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"page":@(_page)}];
    if (_city.length) {
        
        [dic setObject:_city forKey:@"city"];
    }
    if (_district.length && [_district isEqualToString:@"0"]) {
        
        [dic setObject:_district forKey:@"district"];
    }
    if (![_price isEqualToString:@"0"] && _price) {
        
        [dic setObject:[NSString stringWithFormat:@"%@",_price] forKey:@"average_price"];
    }
    if (![_type isEqualToString:@"0"] && _type) {
        
        [dic setObject:[NSString stringWithFormat:@"%@",_type] forKey:@"property_id"];
    }
    if (_tag.length) {
        
        [dic setObject:[NSString stringWithFormat:@"%@",_tag] forKey:@"project_tags"];
    }
    if (_houseType.length) {
        
        [dic setObject:[NSString stringWithFormat:@"%@",_houseType] forKey:@"house_type"];
    }
    [dic setObject:_asc forKey:@"sort_type"];
    [BaseRequest GET:RentProjectList_URL parameters:dic success:^(id resposeObject) {
        
        
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [_dataArr removeAllObjects];
            if ([resposeObject[@"data"][@"data"] count]) {
                
                [self SetData:resposeObject[@"data"][@"data"]];
                [_MainTableView.mj_header endRefreshing];
            }else{
                
                _MainTableView.mj_footer.state = MJRefreshStateNoMoreData;
            }
        }else{
            
            [_MainTableView.mj_header endRefreshing];
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [_MainTableView.mj_header endRefreshing];
        NSLog(@"%@",error);
    }];
}

- (void)SetData:(NSArray *)data{
    
    for (int i = 0; i < data.count; i++) {
        
        NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:data[i]];
        [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            
            if ([obj isKindOfClass:[NSNull class]]) {
                
                [tempDic setObject:@"" forKey:key];
            }
            [tempDic setObject:[NSString stringWithFormat:@"%@",obj] forKey:key];
        }];
        
        
        RentingComModel *model = [[RentingComModel alloc] initWithDictionary:tempDic];
        [_dataArr addObject:model];
    }
    
    [self.MainTableView reloadData];
}

- (void)RequestAddMethod{
    
    _page += 1;
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"page":@(_page)}];
    if (_city.length) {
        
        [dic setObject:_city forKey:@"city"];
    }
    if (_district.length && [_district isEqualToString:@"0"]) {
        
        [dic setObject:_district forKey:@"district"];
    }
    if (![_price isEqualToString:@"0"] && _price) {
        
        [dic setObject:[NSString stringWithFormat:@"%@",_price] forKey:@"average_price"];
    }
    if (![_type isEqualToString:@"0"] && _type) {
        
        [dic setObject:[NSString stringWithFormat:@"%@",_type] forKey:@"property_id"];
    }
    if (_tag.length) {
        
        [dic setObject:[NSString stringWithFormat:@"%@",_tag] forKey:@"project_tags"];
    }
    if (_houseType.length) {
        
        [dic setObject:[NSString stringWithFormat:@"%@",_houseType] forKey:@"house_type"];
    }
    [dic setObject:_asc forKey:@"sort_type"];
    [BaseRequest GET:HouseProjectList_URL parameters:dic success:^(id resposeObject) {
        
        
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if ([resposeObject[@"data"][@"data"] count]) {
                
                [self SetData:resposeObject[@"data"][@"data"]];
                [_MainTableView.mj_footer endRefreshing];
            }else{
                
                _page -= 1;
                _MainTableView.mj_footer.state = MJRefreshStateNoMoreData;
            }
        }else{
            
            [self showContent:resposeObject[@"msg"]];
            [_MainTableView.mj_footer endRefreshing];
        }
    } failure:^(NSError *error) {
        
        _page -= 1;
        [_MainTableView.mj_footer endRefreshing];
        NSLog(@"%@",error);
    }];
    
}

#pragma mark -- Method

- (void)ActionCityBtn:(UIButton *)btn{
    
    CityVC *nextVC = [[CityVC alloc] initWithLabel:@""];
    nextVC.cityVCSaveBlock = ^(NSString *code, NSString *city) {
        
        [_cityBtn setTitle:city forState:UIControlStateNormal];
        _city = [NSString stringWithFormat:@"%@",code];
        [self RequestMethod];
    };
    nextVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (void)ActionTagBtn:(UIButton *)btn{
    
    btn.selected = !btn.selected;
    
    switch (btn.tag) {
        case 1:
        {
            _is2 = NO;
            _is3 = NO;
            _is4 = NO;
            _priceBtn.selected = NO;
            _typeBtn.selected = NO;
            _moreBtn.selected = NO;
            [self.priceView removeFromSuperview];
            [self.typeView removeFromSuperview];
            [self.moreView removeFromSuperview];
            if (_is1) {
                
                _is1 = !_is1;
                [_areaView removeFromSuperview];
            }else{
                
                _is1 = YES;
                _district = @"0";
                
                NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"region" ofType:@"json"]];
                
                NSError *err;
                NSArray *pro = [NSJSONSerialization JSONObjectWithData:JSONData
                                                               options:NSJSONReadingMutableContainers
                                                                 error:&err];
                NSMutableArray * tempArr;
                for (NSDictionary *proDic in pro) {
                    
                    for (NSDictionary *cityDic in proDic[@"city"]) {
                        
                        if ([cityDic[@"code"] integerValue] == [_city integerValue]) {
                            
                            tempArr = [NSMutableArray arrayWithArray:cityDic[@"district"]];
                            break;
                        }
                    }
                }
                [tempArr insertObject:@{@"code":@"0",@"name":@"不限"} atIndex:0];
                self.areaView.dataArr = [NSMutableArray arrayWithArray:tempArr];
                [tempArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    if (idx == 0) {
                        
                        [tempArr replaceObjectAtIndex:idx withObject:@(1)];
                    }else{
                        
                        [tempArr replaceObjectAtIndex:idx withObject:@(0)];
                    }
                    
                }];
                self.areaView.selectArr = [NSMutableArray arrayWithArray:tempArr];
                [self.areaView.mainTable reloadData];
                [[UIApplication sharedApplication].keyWindow addSubview:self.areaView];
            }
            break;
        }
        case 2:
        {
            _is1 = NO;
            _is3 = NO;
            _is4 = NO;
            _areaBtn.selected = NO;
            _typeBtn.selected = NO;
            _moreBtn.selected = NO;
            [self.areaView removeFromSuperview];
            [self.typeView removeFromSuperview];
            [self.moreView removeFromSuperview];
            if (_is2) {
                
                _is2 = !_is2;
                [self.priceView removeFromSuperview];
            }else{
                
                _is2 = YES;
                _price = @"0";
                NSArray *array = [self getDetailConfigArrByConfigState:AVERAGE];
                NSMutableArray * tempArr = [NSMutableArray arrayWithArray:array];
                [tempArr insertObject:@{@"id":@"0",@"param":@"不限"} atIndex:0];
                self.priceView.dataArr = [NSMutableArray arrayWithArray:tempArr];
                [tempArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    if (idx == 0) {
                        
                        [tempArr replaceObjectAtIndex:idx withObject:@(1)];
                    }else{
                        
                        [tempArr replaceObjectAtIndex:idx withObject:@(0)];
                    }
                }];
                self.priceView.selectArr = [NSMutableArray arrayWithArray:tempArr];
                [self.priceView.mainTable reloadData];
                [[UIApplication sharedApplication].keyWindow addSubview:self.priceView];
            }
            break;
        }
        case 3:
        {
            _is1 = NO;
            _is2 = NO;
            _is4 = NO;
            _areaBtn.selected = NO;
            _priceBtn.selected = NO;
            _moreBtn.selected = NO;
            [self.areaView removeFromSuperview];
            [self.priceView removeFromSuperview];
            [self.moreView removeFromSuperview];
            if (_is3) {
                
                _is3 = !_is3;
                [self.typeView removeFromSuperview];
            }else{
                
                _is3 = YES;
                _type = @"0";
                
                NSMutableArray * tempArr = [NSMutableArray arrayWithArray:_propertyArr];
                [tempArr insertObject:@{@"id":@"0",@"param":@"不限"} atIndex:0];
                self.typeView.dataArr = [NSMutableArray arrayWithArray:tempArr];
                [tempArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    if (idx == 0) {
                        
                        [tempArr replaceObjectAtIndex:idx withObject:@(1)];
                    }else{
                        [tempArr replaceObjectAtIndex:idx withObject:@(0)];
                    }
                }];
                self.typeView.selectArr = [NSMutableArray arrayWithArray:tempArr];
                [self.typeView.mainTable reloadData];
                [[UIApplication sharedApplication].keyWindow addSubview:self.typeView];
            }
            break;
        }
        case 4:
        {
            _is1 = NO;
            _is2 = NO;
            _is3 = NO;
            _areaBtn.selected = NO;
            _priceBtn.selected = NO;
            _typeBtn.selected = NO;
            [self.areaView removeFromSuperview];
            [self.priceView removeFromSuperview];
            [self.typeView removeFromSuperview];
            if (_is4) {
                
                _is4 = !_is4;
                [self.moreView removeFromSuperview];
            }else{
                
                _is4 = YES;
                //                _more = @"0";
                
                [self.moreView.moreColl reloadData];
                [[UIApplication sharedApplication].keyWindow addSubview:self.moreView];
            }
            break;
        }
        case 5:
        {
            break;
        }
        default:
            break;
    }
}


- (void)ActionSearchBtn:(UIButton *)btn{
    
    // 1.创建热门搜索
    //    NSArray *hotSeaches = @[@"Java", @"Python", @"Objective-C", @"Swift", @"C", @"C++", @"PHP", @"C#", @"Perl", @"Go", @"JavaScript", @"R", @"Ruby", @"MATLAB"];
    
    // 2. 创建控制器
    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:_searchArr searchBarPlaceholder:@"请输入楼盘名或地址" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        // 开始搜索执行以下代码
        // 如：跳转到指定控制器
        
        //            if ([self.ways isEqualToString:@"quickAdd"]) {
        //
        //
        //            }else{
        //
        //                [searchViewController.navigationController pushViewController:[[QuickSearchVC alloc] initWithTitle:searchText city:_city model:_model] animated:YES];
        //            }
    }];
    // 3. 设置风格
    searchViewController.searchBar.returnKeyType = UIReturnKeySearch;
    searchViewController.hotSearchStyle = 3; // 热门搜索风格根据选择
    searchViewController.searchHistoryStyle = PYHotSearchStyleDefault; // 搜索历史风格为
    // 4. 设置代理
    searchViewController.delegate = self;
    // 5. 跳转到搜索控制器
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:searchViewController];
    [self presentViewController:nav  animated:NO completion:nil];
    
}


//textfieldDelegate;
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    return YES;
}


#pragma mark  ---  delegate   ---

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _dataArr.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    RentingComTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RentingComTableCell"];
    if (!cell) {
        
        cell = [[RentingComTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RentingComTableCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.model = _dataArr[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RentingComModel *model = _dataArr[indexPath.row];
    if ([self.status isEqualToString:@"detail"]) {
        
        RentingComRoomDetailVC *nextVC = [[RentingComRoomDetailVC alloc] init];
        nextVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:nextVC animated:YES];
    }else{
        
        if ([self.status isEqualToString:@"挂牌信息编辑"]) {
            
            SecDistributVC *nextVC = [[SecDistributVC alloc] init];
            nextVC.projiect_id = model.project_id;
            nextVC.img_name = model.img_url;
            nextVC.status = @"挂牌信息编辑";
            [self.navigationController pushViewController:nextVC animated:YES];
        }else if ([self.status isEqualToString:@"protocol"] || [self.status isEqualToString:@"complete"]){
            
            SecDistributVC *nextVC = [[SecDistributVC alloc] init];
            nextVC.secDistributAddHouseBlock = ^(NSDictionary *dic) {
                
                if (self.rentingRoomReportAddHouseBlock) {
                    
                    self.rentingRoomReportAddHouseBlock(dic);
                }
            };
            nextVC.projiect_id = model.project_id;
            nextVC.img_name = model.img_url;
            nextVC.status = self.status;
            nextVC.comName = model.project_name;
            [self.navigationController pushViewController:nextVC animated:YES];
        }else if ([self.status isEqualToString:@"selectSec"]){
            
            RentingComAllRoomListVC *nextVC = [[RentingComAllRoomListVC alloc] initWithProjectId:model.project_id city:@""];
            nextVC.status = @"protocol";
            nextVC.rentingComAllRoomListVCBlock = ^(RentingAllTableModel *model) {
                
                self.rentingRoomReportAddModelBlock(model);
                [self.navigationController popViewControllerAnimated:YES];
            };
            [self.navigationController pushViewController:nextVC animated:YES];
        }else{
            
            SecDistributVC *nextVC = [[SecDistributVC alloc] init];
            nextVC.projiect_id = model.project_id;
            nextVC.img_name = model.img_url;
            nextVC.status = @"release";
            nextVC.comName = model.project_name;
            [self.navigationController pushViewController:nextVC animated:YES];
        }
    }
}


#pragma mark -- 界面初始化

-(void)initUI
{
    [self.view addSubview:self.headerView];
    self.leftButton.center = CGPointMake(25 * SIZE,  30 *SIZE);
    self.leftButton.bounds = CGRectMake(0, 0, 80 * SIZE, 33 * SIZE);
    self.maskButton.frame = CGRectMake(0, 0, 60 * SIZE, 44 *SIZE);
    
    [self.headerView addSubview:self.leftButton];
    [self.headerView addSubview:self.maskButton];
    
    _cityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _cityBtn.frame = CGRectMake(300 *SIZE, 19 *SIZE, 50 *SIZE, 21 *SIZE);
    _cityBtn.titleLabel.font = [UIFont systemFontOfSize:12 *SIZE];
    [_cityBtn addTarget:self action:@selector(ActionCityBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_cityBtn setTitle:@"选择城市" forState:UIControlStateNormal];
    [_cityBtn setTitleColor:YJ86Color forState:UIControlStateNormal];
    [self.headerView addSubview:_cityBtn];
    //
    
    _searchBar = [[UIView alloc] initWithFrame:CGRectMake(58 *SIZE, 13 *SIZE, 242 *SIZE, 33 *SIZE)];
    _searchBar.backgroundColor = YJBackColor;
    [self.headerView addSubview:_searchBar];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(11 *SIZE, 11 *SIZE, 100 *SIZE, 12 *SIZE)];
    label.textColor = COLOR(147, 147, 147, 1);
    label.text = @"小区/楼盘/商铺";
    label.font = [UIFont systemFontOfSize:11 *SIZE];
    [_searchBar addSubview:label];
    
    UIImageView *rightImg = [[UIImageView alloc] initWithFrame:CGRectMake(206 *SIZE, 8 *SIZE, 17 *SIZE, 17 *SIZE)];
    rightImg.image = [UIImage imageNamed:@"search_2"];
    [_searchBar addSubview:rightImg];
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame = _searchBar.bounds;
    [searchBtn addTarget:self action:@selector(ActionSearchBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_searchBar addSubview:searchBtn];
    
    for (int i = 0; i < 5; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(80 * i, 62 *SIZE, 80 *SIZE, 40 *SIZE);
        btn.tag = i + 1;
        [btn setBackgroundColor:[UIColor whiteColor]];
        [btn addTarget:self action:@selector(ActionTagBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        switch (i) {
            case 0:
            {
                [btn setTitle:@"区域" forState:UIControlStateNormal];
                [btn setTitleColor:YJ86Color forState:UIControlStateNormal];
                btn.titleLabel.font = [UIFont systemFontOfSize:12 *SIZE];
                [btn setImage:[UIImage imageNamed:@"downarrow1"] forState:UIControlStateNormal];
                [btn setImage:[UIImage imageNamed:@"uparrow2"] forState:UIControlStateSelected];
                _areaBtn = btn;
                [self.headerView addSubview:_areaBtn];
                break;
            }
            case 1:
            {
                [btn setTitle:@"均价" forState:UIControlStateNormal];
                [btn setTitleColor:YJ86Color forState:UIControlStateNormal];
                btn.titleLabel.font = [UIFont systemFontOfSize:12 *SIZE];
                [btn setImage:[UIImage imageNamed:@"downarrow1"] forState:UIControlStateNormal];
                [btn setImage:[UIImage imageNamed:@"uparrow2"] forState:UIControlStateSelected];
                _priceBtn = btn;
                [self.headerView addSubview:_priceBtn];
                break;
            }
            case 2:
            {
                [btn setTitle:@"类型" forState:UIControlStateNormal];
                [btn setTitleColor:YJ86Color forState:UIControlStateNormal];
                btn.titleLabel.font = [UIFont systemFontOfSize:12 *SIZE];
                [btn setImage:[UIImage imageNamed:@"downarrow1"] forState:UIControlStateNormal];
                [btn setImage:[UIImage imageNamed:@"uparrow2"] forState:UIControlStateSelected];
                _typeBtn = btn;
                [self.headerView addSubview:_typeBtn];
                break;
            }
            case 3:
            {
                [btn setTitle:@"更多" forState:UIControlStateNormal];
                [btn setTitleColor:YJ86Color forState:UIControlStateNormal];
                btn.titleLabel.font = [UIFont systemFontOfSize:12 *SIZE];
                [btn setImage:[UIImage imageNamed:@"downarrow1"] forState:UIControlStateNormal];
                [btn setImage:[UIImage imageNamed:@"uparrow2"] forState:UIControlStateSelected];
                _moreBtn = btn;
                [self.headerView addSubview:_moreBtn];
                break;
            }
            case 4:
            {
                btn.frame = CGRectMake(80 * i, 62 *SIZE, 40 *SIZE, 40 *SIZE);
                [btn setImage:[UIImage imageNamed:@"downarrow1"] forState:UIControlStateNormal];
                [btn setImage:[UIImage imageNamed:@"uparrow2"] forState:UIControlStateSelected];
                _sortBtn = btn;
                [self.headerView addSubview:_sortBtn];
                break;
            }
            default:
                break;
        }
    }
    
    
    [self.view addSubview:self.MainTableView];
    self.MainTableView.mj_footer.state = MJRefreshStateNoMoreData;
}

#pragma mark  ---  懒加载   ---
-(UITableView *)MainTableView
{
    if(!_MainTableView)
    {
        
        _MainTableView =   [[UITableView alloc]initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT + 105*SIZE, 360*SIZE, SCREEN_Height-STATUS_BAR_HEIGHT-105*SIZE) style:UITableViewStylePlain];
        _MainTableView.rowHeight = UITableViewAutomaticDimension;
        _MainTableView.estimatedRowHeight = 120 *SIZE;
        _MainTableView.backgroundColor = YJBackColor;
        _MainTableView.delegate = self;
        _MainTableView.dataSource = self;
        [_MainTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        _MainTableView.mj_header = [GZQGifHeader headerWithRefreshingBlock:^{
            
            [self RequestMethod];
        }];
        
        _MainTableView.mj_footer = [GZQGifFooter footerWithRefreshingBlock:^{
            
            [self RequestAddMethod];
        }];
    }
    return _MainTableView;
}

-(UIView *)headerView
{
    if (!_headerView ) {
        _headerView = [[UIView alloc ]initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT,360*SIZE , 102*SIZE)];
        _headerView.backgroundColor = [UIColor whiteColor];
    }
    return _headerView;
}

- (BoxAddressView *)areaView{
    
    if (!_areaView) {
        
        _areaView = [[BoxAddressView alloc] initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT + 102 *SIZE, SCREEN_Width, SCREEN_Height - 102 *SIZE)];
        WS(weakSelf);
        _areaView.boxAddressComfirmBlock = ^(NSString *ID, NSString *str, NSInteger index) {
            
            if ([str isEqualToString:@"不限"]) {
                
                [weakSelf.areaBtn setTitle:@"区域" forState:UIControlStateNormal];
                _district = @"";
            }else{
                
                if (str.length) {
                    
                    [weakSelf.areaBtn setTitle:str forState:UIControlStateNormal];
                }else{
                    
                    [weakSelf.areaBtn setTitle:@"区域" forState:UIControlStateNormal];
                }
                if ([ID integerValue]) {
                    
                    _district = [NSString stringWithFormat:@"%@",ID];
                }
            }
            _is1 = NO;
            weakSelf.areaBtn.selected = NO;
            [weakSelf.areaView removeFromSuperview];
            [weakSelf RequestMethod];
        };
        
        _areaView.boxAddressCancelBlock = ^{
            
            _is1 = NO;
            weakSelf.areaBtn.selected = NO;
        };
    }
    return _areaView;
}

- (BoxView *)priceView{
    
    if (!_priceView) {
        
        _priceView = [[BoxView alloc] initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT + 102 *SIZE, SCREEN_Width, SCREEN_Height - 102 *SIZE)];
        WS(weakSelf);
        _priceView.confirmBtnBlock = ^(NSString *ID, NSString *str) {
            
            if ([str isEqualToString:@"不限"]) {
                
                [weakSelf.priceBtn setTitle:@"均价" forState:UIControlStateNormal];
            }else{
                
                [weakSelf.priceBtn setTitle:str forState:UIControlStateNormal];
            }
            _is2 = NO;
            _price = [NSString stringWithFormat:@"%@",ID];
            weakSelf.priceBtn.selected = NO;
            [weakSelf.priceView removeFromSuperview];
            
        };
        
        _priceView.cancelBtnBlock = ^{
            
            _is2 = NO;
            weakSelf.priceBtn.selected = NO;
        };
    }
    return _priceView;
}

- (BoxView *)typeView{
    
    if (!_typeView) {
        
        _typeView = [[BoxView alloc] initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT + 102 *SIZE, SCREEN_Width, SCREEN_Height - 102 *SIZE)];
        WS(weakSelf);
        _typeView.confirmBtnBlock = ^(NSString *ID, NSString *str) {
            
            if ([str isEqualToString:@"不限"]) {
                
                [weakSelf.typeBtn setTitle:@"类型" forState:UIControlStateNormal];
            }else{
                
                [weakSelf.typeBtn setTitle:str forState:UIControlStateNormal];
            }
            _is3 = NO;
            _type = [NSString stringWithFormat:@"%@",ID];
            weakSelf.typeBtn.selected = NO;
            [weakSelf.typeView removeFromSuperview];
            [weakSelf RequestMethod];
            
        };
        
        _typeView.cancelBtnBlock = ^{
            
            _is3 = NO;
            weakSelf.typeBtn.selected = NO;
        };
    }
    return _typeView;
}

- (MoreView *)moreView{
    
    if (!_moreView) {
        
        _moreView = [[MoreView alloc] initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT + 103 *SIZE, SCREEN_Width, SCREEN_Height - 103 *SIZE - STATUS_BAR_HEIGHT - TAB_BAR_MORE)];
        
        WS(weakSelf);
        _moreView.moreBtnBlock = ^(NSString *tag, NSString *houseType, NSString *status) {
            
            if (tag) {
                
                _tag = [NSString stringWithFormat:@"%@",tag];
            }
            
            if (houseType) {
                
                _houseType = [NSString stringWithFormat:@"%@",houseType];
            }
            
            //            if (status) {
            //
            //                _status = [NSString stringWithFormat:@"%@",status];
            //            }
            //
            [weakSelf RequestMethod];
            
        };
        
    }
    return _moreView;
}

@end
