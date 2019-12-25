//
//  QuickRoomVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/5/5.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "QuickRoomVC.h"
#import "CompanyCell.h"
#import "PeopleCell.h"
#import "BoxView.h"
#import "BoxAddressView.h"
#import "QuickSearchVC.h"
#import "PYSearchViewController.h"
#import "MoreView.h"
#import "CustomDetailVC.h"
#import "CityVC.h"
#import "QuickAddCustomVC.h"

#import "SelectWorkerView.h"
#import "ReportCustomSuccessView.h"
#import "ReportCustomConfirmView.h"
#import "LocationManager.h"

@interface QuickRoomVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,PYSearchViewControllerDelegate>
{
    CustomRequireModel *_model;
//    NSArray *_arr;
    BOOL _upAndDown;
    NSInteger _page;
//    NSMutableDictionary *_parameter;
    NSMutableArray *_dataArr;
//    NSString *_provice;
    NSString *_city;
    NSString *_cityName;
    NSString *_district;
    NSString *_price;
    NSString *_type;
//    NSString *_more;
    NSString *_tag;
    NSString *_houseType;
    NSString *_status;
    NSMutableArray *_searchArr;
    NSArray *_tagsArr;
    NSArray *_propertyArr;
    BOOL _is1;
    BOOL _is2;
    BOOL _is3;
    BOOL _is4;
    NSInteger _state;
    NSInteger _selected;
    BOOL _isLocation;
}

@property (nonatomic, strong) SelectWorkerView *selectWorkerView;

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

@implementation QuickRoomVC

- (instancetype)initWithModel:(CustomRequireModel *)model
{
    self = [super init];
    if (self) {
        
        _model = model;
    }
    return self;
}

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

- (void)ActionMaskBtn:(UIButton *)btn{
    
    _is1 = NO;
    _is2 = NO;
    _is3 = NO;
    _is4 = NO;
    _areaBtn.selected = NO;
    _priceBtn.selected = NO;
    _typeBtn.selected = NO;
    _moreBtn.selected = NO;
    [self.areaView removeFromSuperview];
    [self.priceView removeFromSuperview];
    [self.typeView removeFromSuperview];
    [self.moreView removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)initDateSouce
{
    
    _searchArr = [@[] mutableCopy];
    _dataArr = [@[] mutableCopy];
    _page = 1;
    _tagsArr = [self getDetailConfigArrByConfigState:PROJECT_TAGS_DEFAULT];
    _propertyArr = [self getDetailConfigArrByConfigState:PROPERTY_TYPE];
    NSArray *opencity =  [UserModel defaultModel].cityArr;
    NSMutableArray *citycode = [NSMutableArray array];
    for (int i=0; i<opencity.count; i++) {
        [citycode addObject:opencity[i][@"city_code"]];
    }
    
    if ([citycode containsObject:[LocationManager GetCityCode]]) {
        [_cityBtn setTitle:[LocationManager GetCityName] forState:UIControlStateNormal];
        _city = [LocationManager GetCityCode];
        _cityName = [LocationManager GetCityName];

    }
    else
    {
        [_cityBtn setTitle:@"成都市" forState:UIControlStateNormal];
        _city = [NSString stringWithFormat:@"510100"];
        _cityName = @"成都市";
    }
    [self RequestMethod];

}



- (void)SetSearch:(NSDictionary *)data{
    
    [_searchArr removeAllObjects];
    [data enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        [_searchArr addObject:key];
    }];
}

- (void)SetData:(NSArray *)data{
    
    for (int i = 0; i < data.count; i++) {
        
        NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:data[i]];
        [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            
            if ([obj isKindOfClass:[NSNull class]]) {
                
                [tempDic setObject:@"" forKey:key];
            }
        }];
        
        RoomListModel *model = [[RoomListModel alloc] initWithDictionary:tempDic];
        
        [_dataArr addObject:model];
    }
    
    [self.MainTableView reloadData];
}

- (void)RequestMethod{
    
    if (_page == 1) {
        
        self.MainTableView.mj_footer.state = MJRefreshStateIdle;
    }
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"page":@(_page)}];
    [dic setObject:[UserModel defaultModel].agent_id forKey:@"agent_id"];
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
    if (_status.length) {
        
        [dic setObject:[NSString stringWithFormat:@"%@",_status] forKey:@"sale_state"];
    }
    
    [BaseRequest GET:ProjectList_URL parameters:dic success:^(id resposeObject) {
        
        [self.MainTableView.mj_header endRefreshing];
        //        NSLog(@"%@",resposeObject);
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [_dataArr removeAllObjects];
            if ([resposeObject[@"data"] count]) {
                
                [self SetData:resposeObject[@"data"]];
            }else{
                
                self.MainTableView.mj_footer.state = MJRefreshStateNoMoreData;
            }
            [self.MainTableView reloadData];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
            self.MainTableView.mj_footer.state = MJRefreshStateNoMoreData;
        }
    } failure:^(NSError *error) {
        
        [self.MainTableView.mj_header endRefreshing];
        [self showContent:@"网路错误"];
        //        NSLog(@"%@",error.localizedDescription);
    }];
    
}

- (void)RequestAddMethod{
    
    _page += 1;
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"page":@(_page)}];
    [dic setObject:[UserModel defaultModel].agent_id forKey:@"agent_id"];
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
        
        [dic setObject:[NSString stringWithFormat:@"%@",_type] forKey:@"project_tags"];
    }
    if (_houseType.length) {
        
        [dic setObject:[NSString stringWithFormat:@"%@",_houseType] forKey:@"house_type"];
    }
    if (_status.length) {
        
        [dic setObject:[NSString stringWithFormat:@"%@",_status] forKey:@"sale_state"];
    }
    
    [BaseRequest GET:ProjectList_URL parameters:dic success:^(id resposeObject) {
        
        //        NSLog(@"%@",resposeObject);
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if ([resposeObject[@"data"] count]) {
                
                [self SetData:resposeObject[@"data"]];
                [self.MainTableView.mj_footer endRefreshing];
            }else{
                
                self.MainTableView.mj_footer.state = MJRefreshStateNoMoreData;
            }
        }else{
            
            _page -= 1;
            [self showContent:resposeObject[@"msg"]];
            self.MainTableView.mj_footer.state = MJRefreshStateNoMoreData;
        }
    } failure:^(NSError *error) {
        
        _page -= 1;
        [self showContent:@"网路错误"];
        [self.MainTableView.mj_footer endRefreshing];
        //        NSLog(@"%@",error.localizedDescription);
    }];
    
}

#pragma mark -- Method

- (void)RequestRecommend:(NSDictionary *)dic projectName:(NSString *)projectName{
    
    [BaseRequest POST:RecommendClient_URL parameters:dic success:^(id resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            ReportCustomSuccessView *reportCustomSuccessView = [[ReportCustomSuccessView alloc] initWithFrame:self.view.frame];
            NSDictionary *tempDic = @{@"project":projectName,
                                      @"sex":self.customerTableModel.sex,
                                      @"tel":self.customerTableModel.tel,
                                      @"name":self.customerTableModel.name
                                      };
            reportCustomSuccessView.state = _state;
            reportCustomSuccessView.dataDic = [NSMutableDictionary dictionaryWithDictionary:tempDic];
            reportCustomSuccessView.reportCustomSuccessViewBlock = ^{
                
                for (UIViewController *vc in self.navigationController.viewControllers) {
                    
                    if ([vc isKindOfClass:[CustomDetailVC class]]) {
                        
                        [self.navigationController popToViewController:vc animated:YES];
                    }
                }
            };
            [self.view addSubview:reportCustomSuccessView];
        }
        else{
            
            [self alertControllerWithNsstring:@"温馨提示" And:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        [self showContent:@"网络错误"];
    }];
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
                
                //                NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"region" ofType:@"json"]];
                //
                //                NSError *err;
                //                NSArray *pro = [NSJSONSerialization JSONObjectWithData:JSONData
                //                                                               options:NSJSONReadingMutableContainers
                //                                                                 error:&err];
                //                NSMutableArray * tempArr;
                //                for (NSDictionary *proDic in pro) {
                //
                //                    for (NSDictionary *cityDic in proDic[@"city"]) {
                //
                //                        if ([cityDic[@"code"] integerValue] == [_city integerValue]) {
                //
                //                            tempArr = [NSMutableArray arrayWithArray:cityDic[@"district"]];
                //                            break;
                //                        }
                //                    }
                //                }
                //                [tempArr insertObject:@{@"code":@"0",@"name":@"不限"} atIndex:0];
                //                self.areaView.dataArr = [NSMutableArray arrayWithArray:tempArr];
                //                [tempArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                //
                //                    if (idx == 0) {
                //
                //                        [tempArr replaceObjectAtIndex:idx withObject:@(1)];
                //                    }else{
                //
                //                        [tempArr replaceObjectAtIndex:idx withObject:@(0)];
                //                    }
                //
                //                }];
                //                self.areaView.selectArr = [NSMutableArray arrayWithArray:tempArr];
                //                [self.areaView.mainTable reloadData];
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
                //                NSArray *array = [self getDetailConfigArrByConfigState:AVERAGE];
                //                NSMutableArray * tempArr = [NSMutableArray arrayWithArray:array];
                //                [tempArr insertObject:@{@"id":@"0",@"param":@"不限"} atIndex:0];
                //                self.priceView.dataArr = [NSMutableArray arrayWithArray:tempArr];
                //                [tempArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                //
                //                    if (idx == 0) {
                //
                //                        [tempArr replaceObjectAtIndex:idx withObject:@(1)];
                //                    }else{
                //
                //                        [tempArr replaceObjectAtIndex:idx withObject:@(0)];
                //                    }
                //                }];
                //                self.priceView.selectArr = [NSMutableArray arrayWithArray:tempArr];
                //                [self.priceView.mainTable reloadData];
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
                
                //                NSMutableArray * tempArr = [NSMutableArray arrayWithArray:_propertyArr];
                //                [tempArr insertObject:@{@"id":@"0",@"param":@"不限"} atIndex:0];
                //                self.typeView.dataArr = [NSMutableArray arrayWithArray:tempArr];
                //                [tempArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                //
                //                    if (idx == 0) {
                //
                //                        [tempArr replaceObjectAtIndex:idx withObject:@(1)];
                //                    }else{
                //                        [tempArr replaceObjectAtIndex:idx withObject:@(0)];
                //                    }
                //                }];
                //                self.typeView.selectArr = [NSMutableArray arrayWithArray:tempArr];
                //                [self.typeView.mainTable reloadData];
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
    
    
    _is1 = NO;
    _is2 = NO;
    _is3 = NO;
    _is4 = NO;
    _areaBtn.selected = NO;
    _priceBtn.selected = NO;
    _typeBtn.selected = NO;
    _moreBtn.selected = NO;
    [self.areaView removeFromSuperview];
    [self.priceView removeFromSuperview];
    [self.typeView removeFromSuperview];
    [self.moreView removeFromSuperview];
    // 1.创建热门搜索
    //    NSArray *hotSeaches = @[@"Java", @"Python", @"Objective-C", @"Swift", @"C", @"C++", @"PHP", @"C#", @"Perl", @"Go", @"JavaScript", @"R", @"Ruby", @"MATLAB"];
    
    // 2. 创建控制器
    if (_city) {
        
        PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:_searchArr searchBarPlaceholder:@"请输入楼盘名或地址" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
            // 开始搜索执行以下代码
            // 如：跳转到指定控制器
            
            if ([self.ways isEqualToString:@"quickAdd"]) {
                
                
            }else{
                
                QuickSearchVC *vc = [[QuickSearchVC alloc] initWithTitle:searchText city:_city model:_model];
                vc.customerTableModel = self.customerTableModel;
                [searchViewController.navigationController pushViewController:vc animated:YES];
            }
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
    }else{
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请先选择城市" WithDefaultBlack:^{
            
            CityVC *nextVC = [[CityVC alloc] initWithLabel:@""];
            nextVC.cityVCSaveBlock = ^(NSString *code, NSString *city) {
                
                [_cityBtn setTitle:city forState:UIControlStateNormal];
                _city = [NSString stringWithFormat:@"%@",code];
                [self RequestMethod];
            };
            nextVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:nextVC animated:YES];
        }];
    }
    
    //    [self.navigationController presentViewController:nav animated:NO completion:nil];
    //    [self.navigationController pushViewController:nav animated:NO];
}


- (void)ActionCityBtn:(UIButton *)btn{
    
    _is1 = NO;
    _is2 = NO;
    _is3 = NO;
    _is4 = NO;
    _areaBtn.selected = NO;
    _priceBtn.selected = NO;
    _typeBtn.selected = NO;
    _moreBtn.selected = NO;
    [self.areaView removeFromSuperview];
    [self.priceView removeFromSuperview];
    [self.typeView removeFromSuperview];
    [self.moreView removeFromSuperview];
    
    CityVC *nextVC = [[CityVC alloc] initWithLabel:@""];
    nextVC.cityVCSaveBlock = ^(NSString *code, NSString *city) {
        
        [_cityBtn setTitle:city forState:UIControlStateNormal];
        _city = [NSString stringWithFormat:@"%@",code];
        
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
        
        [self RequestMethod];
    };
    nextVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (void)ActionUpAndDownBtn:(UIButton *)btn{
    
    _upAndDown = !_upAndDown;
    if (_upAndDown) {
        
        
    }else{
        
        
    }
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120*SIZE;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    RoomListModel *model = _dataArr[indexPath.row];
    if ([model.guarantee_brokerage integerValue] == 2) {
        
        static NSString *CellIdentifier = @"CompanyCell";
        
        CompanyCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[CompanyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        [cell SetTitle:model.project_name image:model.img_url contentlab:model.absolute_address statu:model.sale_state];
        NSMutableArray *tempArr = [@[] mutableCopy];
        for (int i = 0; i < model.property_tags.count; i++) {
            
            [_propertyArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if ([obj[@"id"] integerValue] == [model.property_tags[i] integerValue]) {
                    
                    [tempArr addObject:obj[@"param"]];
                    *stop = YES;
                }
            }];
        }
        
        NSArray *tempArr1 = model.project_tags;
        NSMutableArray *tempArr2 = [@[] mutableCopy];
        for (int i = 0; i < tempArr1.count; i++) {
            
            
            [_tagsArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if ([obj[@"id"] integerValue] == [tempArr1[i] integerValue]) {
                    
                    [tempArr2 addObject:obj[@"param"]];
                    *stop = YES;
                }
            }];
        }
        NSArray *tempArr3 = @[tempArr,tempArr2.count == 0 ? @[]:tempArr2];
        [cell settagviewWithdata:tempArr3];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else{
        
        static NSString *CellIdentifier = @"PeopleCell";
        
        PeopleCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[PeopleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        [cell SetTitle:model.project_name image:model.img_url contentlab:model.absolute_address statu:model.sale_state];
        
        if ([model.sort integerValue] == 0 && [model.cycle integerValue] == 0) {
            
            cell.statusImg.hidden = YES;
            cell.surelab.hidden = YES;
        }else{
            
            cell.statusImg.hidden = NO;
            if ([model.guarantee_brokerage integerValue] == 1) {
                
                cell.surelab.hidden = NO;
            }else{
                
                cell.surelab.hidden = YES;
            }
        }
        
        NSMutableArray *tempArr = [@[] mutableCopy];
        for (int i = 0; i < model.property_tags.count; i++) {
            
            [_propertyArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if ([obj[@"id"] integerValue] == [model.property_tags[i] integerValue]) {
                    
                    [tempArr addObject:obj[@"param"]];
                    *stop = YES;
                }
            }];
        }
        
        NSArray *tempArr1 = model.project_tags;
        NSMutableArray *tempArr2 = [@[] mutableCopy];
        for (int i = 0; i < tempArr1.count; i++) {
            
            [_tagsArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if ([obj[@"id"] integerValue] == [tempArr1[i] integerValue]) {
                    
                    [tempArr2 addObject:obj[@"param"]];
                    *stop = YES;
                }
            }];
        }
        NSArray *tempArr3 = @[tempArr,tempArr2.count == 0 ? @[]:tempArr2];
        [cell settagviewWithdata:tempArr3];
        
        if (model.sort) {
            
            cell.rankView.rankL.text = [NSString stringWithFormat:@"佣金:第%@名",model.sort];
        }else{
            
            cell.rankView.rankL.text = [NSString stringWithFormat:@"佣金:无排名"];
        }
        [cell.rankView.rankL mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(cell.rankView).offset(0);
            make.top.equalTo(cell.rankView).offset(0);
            make.height.equalTo(@(10 *SIZE));
            make.width.equalTo(@(cell.rankView.rankL.mj_textWith + 5 *SIZE));
        }];
        if ([model.brokerSortCompare integerValue] == 0) {
            
            cell.rankView.statusImg.image = nil;
        }else if ([model.brokerSortCompare integerValue] == 1){
            
            cell.rankView.statusImg.image = [UIImage imageNamed:@"rising"];
        }else if ([model.brokerSortCompare integerValue] == 2){
            
            cell.rankView.statusImg.image = [UIImage imageNamed:@"falling"];
        }
        [cell.getLevel SetImage:[UIImage imageNamed:@"lightning_1"] selectImg:[UIImage imageNamed:@"lightning"] num:[model.cycle integerValue]];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if ([[UserModel defaultModel].agent_identity integerValue] == 1) {
        
        if ([self.ways isEqualToString:@"quickAdd"]) {
            
            if (self.quickRoomVCSelectBlock) {
                
                RoomListModel *model = _dataArr[indexPath.row];
                self.quickRoomVCSelectBlock(model.project_id, model.project_name);
                [self.navigationController popViewControllerAnimated:YES];
            }
        }else{
            
            RoomListModel *model = _dataArr[indexPath.row];
            QuickAddCustomVC *nextVC = [[QuickAddCustomVC alloc] initWithProjectId:[NSString stringWithFormat:@"%@",model.project_id] clientId:_model.client_id];
            nextVC.projectName = model.project_name;
            [self.navigationController pushViewController:nextVC animated:YES];
        }
//    }else{
//        
//        [self alertControllerWithNsstring:@"温馨提示" And:@"到访确认人不可推荐客户"];
//    }
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
    if ([LocationManager GetCityName]) {
        
        [_cityBtn setTitle:[LocationManager GetCityName] forState:UIControlStateNormal];
    }else{
        
        [_cityBtn setTitle:@"选择城市" forState:UIControlStateNormal];
    }
    
    [_cityBtn setTitleColor:YJ86Color forState:UIControlStateNormal];
    [self.headerView addSubview:_cityBtn];
    
    
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
        btn.frame = CGRectMake(80 *SIZE * i, 62 *SIZE, 80 *SIZE, 40 *SIZE);
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
                btn.frame = CGRectMake(80 *SIZE * i, 62 *SIZE, 40 *SIZE, 40 *SIZE);
                [btn setImage:[UIImage imageNamed:@"reverseorder"] forState:UIControlStateNormal];
                [btn setImage:[UIImage imageNamed:@"reverseorder"] forState:UIControlStateSelected];
                _sortBtn = btn;
                [self.headerView addSubview:_sortBtn];
                break;
            }
            default:
                break;
        }
    }
    
    _upImg = [[UIImageView alloc] initWithFrame:CGRectMake(334 *SIZE, 74 *SIZE, 13 *SIZE, 16 *SIZE)];
    [self.headerView addSubview:_upImg];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(329 *SIZE, 69 *SIZE, 23 *SIZE, 26 *SIZE);
    [btn addTarget:self action:@selector(ActionUpAndDownBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:btn];
    
    [self.view addSubview:self.MainTableView];
    self.MainTableView.mj_footer.state = MJRefreshStateNoMoreData;
}

#pragma mark  ---  懒加载   ---
-(UITableView *)MainTableView
{
    if(!_MainTableView)
    {
        _MainTableView =   [[UITableView alloc]initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT + 105*SIZE, 360*SIZE, SCREEN_Height-STATUS_BAR_HEIGHT-105*SIZE) style:UITableViewStylePlain];
        _MainTableView.backgroundColor = YJBackColor;
        _MainTableView.delegate = self;
        _MainTableView.dataSource = self;
        [_MainTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        _MainTableView.mj_header = [GZQGifHeader headerWithRefreshingBlock:^{
            
            _page = 1;
            if (_city) {
                
                [self RequestMethod];
            }else{
                
                [_MainTableView.mj_header endRefreshing];
                [self alertControllerWithNsstring:@"温馨提示" And:@"请先选择城市" WithDefaultBlack:^{
                    
                    CityVC *nextVC = [[CityVC alloc] initWithLabel:@""];
                    nextVC.cityVCSaveBlock = ^(NSString *code, NSString *city) {
                        
                        [_cityBtn setTitle:city forState:UIControlStateNormal];
                        _city = [NSString stringWithFormat:@"%@",code];
                        [self RequestMethod];
                    };
                    nextVC.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:nextVC animated:YES];
                }];
            }
        }];
        
        _MainTableView.mj_footer = [GZQGifFooter footerWithRefreshingBlock:^{
            
            //            [self RequestAddMethod];
            
            if (_city) {
                
                [self RequestAddMethod];
            }else{
                
                [_MainTableView.mj_footer endRefreshing];
                [self alertControllerWithNsstring:@"温馨提示" And:@"请先选择城市" WithDefaultBlack:^{
                    
                    CityVC *nextVC = [[CityVC alloc] initWithLabel:@""];
                    nextVC.cityVCSaveBlock = ^(NSString *code, NSString *city) {
                        
                        [_cityBtn setTitle:city forState:UIControlStateNormal];
                        _city = [NSString stringWithFormat:@"%@",code];
                        [self RequestMethod];
                    };
                    nextVC.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:nextVC animated:YES];
                }];
            }
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
        _areaView.dataArr = [NSMutableArray arrayWithArray:tempArr];
        [tempArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if (idx == 0) {
                
                [tempArr replaceObjectAtIndex:idx withObject:@(1)];
            }else{
                
                [tempArr replaceObjectAtIndex:idx withObject:@(0)];
            }
            
        }];
        _areaView.selectArr = [NSMutableArray arrayWithArray:tempArr];
        [_areaView.mainTable reloadData];
        
        WS(weakSelf);
        SS(strongSelf);
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
            //            [weakSelf RequestMethod];
            if (strongSelf->_city) {
                
                [weakSelf RequestMethod];
            }else{
                
                [strongSelf->_MainTableView.mj_header endRefreshing];
                [weakSelf alertControllerWithNsstring:@"温馨提示" And:@"请先选择城市" WithDefaultBlack:^{
                    
                    CityVC *nextVC = [[CityVC alloc] initWithLabel:@""];
                    nextVC.cityVCSaveBlock = ^(NSString *code, NSString *city) {
                        
                        [strongSelf->_cityBtn setTitle:city forState:UIControlStateNormal];
                        strongSelf->_city = [NSString stringWithFormat:@"%@",code];
                        [weakSelf RequestMethod];
                    };
                    nextVC.hidesBottomBarWhenPushed = YES;
                    [weakSelf.navigationController pushViewController:nextVC animated:YES];
                }];
            }
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
        
        NSArray *array = [self getDetailConfigArrByConfigState:AVERAGE];
        NSMutableArray * tempArr = [NSMutableArray arrayWithArray:array];
        [tempArr insertObject:@{@"id":@"0",@"param":@"不限"} atIndex:0];
        _priceView.dataArr = [NSMutableArray arrayWithArray:tempArr];
        [tempArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if (idx == 0) {
                
                [tempArr replaceObjectAtIndex:idx withObject:@(1)];
            }else{
                
                [tempArr replaceObjectAtIndex:idx withObject:@(0)];
            }
        }];
        _priceView.selectArr = [NSMutableArray arrayWithArray:tempArr];
        [_priceView.mainTable reloadData];
        
        WS(weakSelf);
        SS(strongSelf);
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
            if (strongSelf->_city) {
                
                [weakSelf RequestMethod];
            }else{
                
                [strongSelf->_MainTableView.mj_header endRefreshing];
                [weakSelf alertControllerWithNsstring:@"温馨提示" And:@"请先选择城市" WithDefaultBlack:^{
                    
                    CityVC *nextVC = [[CityVC alloc] initWithLabel:@""];
                    nextVC.cityVCSaveBlock = ^(NSString *code, NSString *city) {
                        
                        [strongSelf->_cityBtn setTitle:city forState:UIControlStateNormal];
                        strongSelf->_city = [NSString stringWithFormat:@"%@",code];
                        [weakSelf RequestMethod];
                    };
                    nextVC.hidesBottomBarWhenPushed = YES;
                    [weakSelf.navigationController pushViewController:nextVC animated:YES];
                }];
            }
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
        
        NSMutableArray * tempArr = [NSMutableArray arrayWithArray:_propertyArr];
        [tempArr insertObject:@{@"id":@"0",@"param":@"不限"} atIndex:0];
        _typeView.dataArr = [NSMutableArray arrayWithArray:tempArr];
        [tempArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if (idx == 0) {
                
                [tempArr replaceObjectAtIndex:idx withObject:@(1)];
            }else{
                [tempArr replaceObjectAtIndex:idx withObject:@(0)];
            }
        }];
        _typeView.selectArr = [NSMutableArray arrayWithArray:tempArr];
        [_typeView.mainTable reloadData];
        
        WS(weakSelf);
        SS(strongSelf);
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
            //            [weakSelf RequestMethod];
            if (strongSelf->_city) {
                
                [weakSelf RequestMethod];
            }else{
                
                [strongSelf->_MainTableView.mj_header endRefreshing];
                [weakSelf alertControllerWithNsstring:@"温馨提示" And:@"请先选择城市" WithDefaultBlack:^{
                    
                    CityVC *nextVC = [[CityVC alloc] initWithLabel:@""];
                    nextVC.cityVCSaveBlock = ^(NSString *code, NSString *city) {
                        
                        [strongSelf->_cityBtn setTitle:city forState:UIControlStateNormal];
                        strongSelf->_city = [NSString stringWithFormat:@"%@",code];
                        [weakSelf RequestMethod];
                    };
                    nextVC.hidesBottomBarWhenPushed = YES;
                    [weakSelf.navigationController pushViewController:nextVC animated:YES];
                }];
            }
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
        SS(strongSelf);
        _moreView.moreBtnBlock = ^(NSString *tag, NSString *houseType, NSString *status) {
            
            _is4 = NO;
            weakSelf.moreBtn.selected = NO;
            
            if (tag) {
                
                _tag = [NSString stringWithFormat:@"%@",tag];
            }
            
            if (![houseType isEqualToString:@"0"]) {
                
                _houseType = [NSString stringWithFormat:@"%@",houseType];
            }else{
                
                _houseType = @"";
            }
            
            if (status) {

                _status = [NSString stringWithFormat:@"%@",status];
            }
            //
            //            [weakSelf RequestMethod];
            if (strongSelf->_city) {
                
                [weakSelf RequestMethod];
            }else{
                
                [strongSelf->_MainTableView.mj_header endRefreshing];
                [weakSelf alertControllerWithNsstring:@"温馨提示" And:@"请先选择城市" WithDefaultBlack:^{
                    
                    CityVC *nextVC = [[CityVC alloc] initWithLabel:@""];
                    nextVC.cityVCSaveBlock = ^(NSString *code, NSString *city) {
                        
                        [strongSelf->_cityBtn setTitle:city forState:UIControlStateNormal];
                        strongSelf->_city = [NSString stringWithFormat:@"%@",code];
                        [weakSelf RequestMethod];
                    };
                    nextVC.hidesBottomBarWhenPushed = YES;
                    [weakSelf.navigationController pushViewController:nextVC animated:YES];
                }];
            }
        };
        _moreView.moreViewClearBlock = ^{
            
            _is4 = NO;
            _tag = @"";
            _houseType = @"";
            _status = @"";
            weakSelf.moreBtn.selected = NO;
            [weakSelf RequestMethod];
        };
        
    }
    return _moreView;
}


@end
