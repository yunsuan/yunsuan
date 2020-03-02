//
//  MyShopProjectListVC.m
//  云渠道
//
//  Created by 谷治墙 on 2020/2/26.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "MyShopProjectListVC.h"

#import "CityVC.h"

#import "MyShopRoomListVC.h"

#import "CompanyCell.h"
#import "PeopleCell.h"

#import "RoomListModel.h"

#import "BoxView.h"
#import "BoxAddressView.h"

#import "PYSearchViewController.h"

@interface MyShopProjectListVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,PYSearchViewControllerDelegate>
{
    
    BOOL _upAndDown;
    NSInteger _page;
    
    NSString *_city;
    NSString *_cityName;
//    NSString *_district;
    
    NSArray *_tagsArr;
    NSArray *_propertyArr;
    
    NSMutableArray *_dataArr;
    
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


@end

@implementation MyShopProjectListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = YJBackColor;
    self.navBackgroundView.hidden = NO;
    [self initDateSouce];
    [self initUI];
}

- (void)initDateSouce{

    _page = 1;

    _tagsArr = [self getDetailConfigArrByConfigState:PROJECT_TAGS_DEFAULT];
    _propertyArr = [self getDetailConfigArrByConfigState:PROPERTY_TYPE];

    _dataArr = [@[] mutableCopy];
    
    NSArray *opencity =  [UserModel defaultModel].cityArr;
    NSMutableArray *citycode = [NSMutableArray array];
    for (int i = 0; i < opencity.count; i++) {
        
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

- (void)RequestMethod{
    
    if (_page == 1) {
        
        self.MainTableView.mj_footer.state = MJRefreshStateIdle;
    }
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"page":@(_page)}];
    [dic setObject:[UserModel defaultModel].agent_id forKey:@"agent_id"];
    if (_city.length) {
        
        [dic setObject:_city forKey:@"city"];
    }

    
    [BaseRequest GET:ProjectList_URL parameters:dic success:^(id resposeObject) {
        
        [self.MainTableView.mj_header endRefreshing];
        
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
    }];
    
}

- (void)RequestAddMethod{
    
    _page += 1;
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"page":@(_page)}];
    [dic setObject:[UserModel defaultModel].agent_id forKey:@"agent_id"];
    if (_city.length) {
        
        [dic setObject:_city forKey:@"city"];
    }
    
    [BaseRequest GET:ProjectList_URL parameters:dic success:^(id resposeObject) {
        
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

- (void)ActionCityBtn:(UIButton *)btn{
 
    CityVC *nextVC = [[CityVC alloc] initWithLabel:[LocationManager GetCityName]];
    nextVC.cityVCSaveBlock = ^(NSString *code, NSString *city) {
        
        _page = 1;
        [self.rightBtn setTitle:city forState:UIControlStateNormal];
        _city = [NSString stringWithFormat:@"%@",code];
        
        [self RequestMethod];
    };
    nextVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 120 *SIZE;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RoomListModel *model = _dataArr[indexPath.row];
    MyShopRoomListVC *nextVC = [[MyShopRoomListVC alloc] initWithProjectId:model.project_id info_id:model.info_id];
    nextVC.projectName = model.project_name;
    nextVC.myShopRoomListVCBlock = ^{
      
        self.myShopProjectListVCBlock();
    };
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (void)initUI{
    
    self.titleLabel.text = @"新增推荐";
    self.rightBtn.hidden = NO;
    self.rightBtn.titleLabel.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.rightBtn addTarget:self action:@selector(ActionCityBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.rightBtn.frame = CGRectMake(SCREEN_Width - 65 *SIZE, 7 *SIZE + STATUS_BAR_HEIGHT, 60 *SIZE, 30 *SIZE);
    if ([LocationManager GetCityName]) {
        
        [self.rightBtn setTitle:[LocationManager GetCityName] forState:UIControlStateNormal];
    }else{
        
        [self.rightBtn setTitle:@"选择城市" forState:UIControlStateNormal];
    }
    
    [self.rightBtn setTitleColor:YJContentLabColor forState:UIControlStateNormal];
    
    _MainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, 360 *SIZE, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    _MainTableView.backgroundColor = YJBackColor;
    _MainTableView.delegate = self;
    _MainTableView.dataSource = self;
    [_MainTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    _MainTableView.mj_header = [GZQGifHeader headerWithRefreshingBlock:^{
        
        _page = 1;
        [self RequestMethod];
    }];
    
    _MainTableView.mj_footer = [GZQGifFooter footerWithRefreshingBlock:^{
        
        _page += 1;
        [self RequestAddMethod];
    }];
    [self.view addSubview:_MainTableView];
}

@end
