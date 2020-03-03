//
//  CustomerVC.m
//  云渠道
//
//  Created by xiaoq on 2018/3/13.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "CustomerListVC.h"

//新房客户详情
#import "NewCustomDetailVC.h"

#import "CustomDetailVC.h"
#import "AddCustomerVC.h"
#import "PYSearchViewController.h"
#import "CustomSearchVC.h"
#import "CustomLookConfirmSuccessVC.h"
#import "LookMaintainDetailAddFollowVC.h"

#import "CustomerTableCell.h"
#import "BoxView.h"
#import "AddressChooseView2.h"

@interface CustomerListVC ()<UITableViewDelegate,UITableViewDataSource,PYSearchViewControllerDelegate>
{
    NSMutableArray *_dataArr;
    NSInteger _page;
    NSString *_type;
    NSString *_district;
    NSString *_sortType;
    NSString *_asc;
    NSArray *_propertyArr;
    BOOL _is1;
    BOOL _is2;
}
@property (nonatomic, strong) UITableView *customerTable;

@property (nonatomic, strong) BoxView *boxView;

@property (nonatomic, strong) UIView *searchBar;

@property (nonatomic, strong) UIButton *propertyBtn;

@property (nonatomic, strong) UIButton *areaBtn;

@property (nonatomic, strong) UIButton *intentBtn;

@property (nonatomic, strong) UIButton *urgencyBtn;

@property (nonatomic, strong) AddressChooseView2 *adressView;


@end

@implementation CustomerListVC

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
    [self RequestMethod];
}

- (void)initDataSource{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(RequestMethod) name:@"reloadCustom" object:nil];
    _page = 1;
    _dataArr = [@[] mutableCopy];
    _propertyArr = [self getDetailConfigArrByConfigState:PROPERTY_TYPE];
}

- (void)RequestMethod{
    
    _customerTable.mj_footer.state = MJRefreshStateIdle;
    NSMutableDictionary *dic = [@{} mutableCopy];
    if (_sortType.length) {
        
        [dic setObject:_sortType forKey:@"sort_type"];
        [dic setObject:_asc forKey:@"sort"];
    }
    if (self.status == 0) {
        
        [dic setObject:@"184" forKey:@"client_type"];
    }else if (self.status == 1){
        
        [dic setObject:@"185" forKey:@"client_type"];
    }else{
        
        [dic setObject:@"186" forKey:@"client_type"];
    }
    if ([_type integerValue]) {
        
        [dic setObject:_type forKey:@"property_type"];
    }
    if (_district.length) {
        
        [dic setObject:_district forKey:@"district"];
    }
    
    [BaseRequest GET:ListClient_URL parameters:dic success:^(id resposeObject) {
        
        //        NSLog(@"%@",resposeObject);
        [_customerTable.mj_header endRefreshing];
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if ([resposeObject[@"data"] isKindOfClass:[NSDictionary class]]) {
                
                if (_page == [resposeObject[@"data"][@"last_page"] integerValue]) {
                    
                    [_dataArr removeAllObjects];
                    [_customerTable reloadData];
                    _customerTable.mj_footer.state = MJRefreshStateNoMoreData;
                }
                
                if ([resposeObject[@"data"][@"data"] isKindOfClass:[NSArray class]]) {
                    
                    if ([resposeObject[@"data"][@"data"] count]) {
                        
                        [self SetData:resposeObject[@"data"][@"data"]];
                        
                    }else{
                        
                        [_dataArr removeAllObjects];
                        _customerTable.mj_footer.state = MJRefreshStateNoMoreData;
                        //                        [self showContent:@"暂无数据"];
                    }
                }else{
                    
                    [_dataArr removeAllObjects];
                    //                    [self showContent:@"暂无数据"];
                }
            }else{
                
                [_dataArr removeAllObjects];
                //                [self showContent:@"暂无数据"];
            }
            [_customerTable reloadData];
        }        else{
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [_customerTable.mj_header endRefreshing];
        //        NSLog(@"%@",error.localizedDescription);
        [self showContent:@"网络错误"];
    }];
}

- (void)RequestAddMethod{
    
    _page += 1;
    NSDictionary *tempDic = @{@"page":@(_page)};
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:tempDic];
    if (_sortType.length) {
        
        dic[@"sort_type"] = _sortType;
        dic[@"sort"] = _asc;
    }
    if (self.status == 0) {
        
        [dic setObject:@"184" forKey:@"client_type"];
    }else if (self.status == 1){
        
        [dic setObject:@"185" forKey:@"client_type"];
    }else{
        
        [dic setObject:@"186" forKey:@"client_type"];
    }
    if (_type) {
        
        dic[@"property_type"] = _type;
    }
    if (_district.length) {
        
        dic[@"district"] = _district;
    }
    [BaseRequest GET:ListClient_URL parameters:dic success:^(id resposeObject) {
        
        //        NSLog(@"%@",resposeObject);
        
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if ([resposeObject[@"data"] isKindOfClass:[NSDictionary class]]) {
                
                if ([resposeObject[@"data"][@"data"] isKindOfClass:[NSArray class]]) {
                    
                    if ([resposeObject[@"data"][@"data"] count]) {
                        
                        [self SetData:resposeObject[@"data"][@"data"]];
                        if (_page == [resposeObject[@"data"][@"last_page"] integerValue]) {
                            
                            _customerTable.mj_footer.state = MJRefreshStateNoMoreData;
                        }else{
                            
                            [_customerTable.mj_footer endRefreshing];
                        }
                    }else{
                        
                        _customerTable.mj_footer.state = MJRefreshStateNoMoreData;
                    }
                }else{
                    
                    _customerTable.mj_footer.state = MJRefreshStateNoMoreData;
                }
            }else{
                
                [_customerTable.mj_footer endRefreshing];
            }
        }else{
            [self showContent:resposeObject[@"msg"]];
            
            _page -= 1;
            [_customerTable.mj_footer endRefreshing];
        }
    } failure:^(NSError *error) {
        
        _page -= 1;
        [_customerTable.mj_footer endRefreshing];
        //        NSLog(@"%@",error.localizedDescription);
        [self showContent:@"网络错误"];
    }];
}

- (void)SetData:(NSArray *)data{
    
    if (_page == 1) {
        
        [_dataArr removeAllObjects];
    }
    for (int i = 0; i < data.count; i++) {
        
        NSMutableDictionary *tempDic;
        tempDic = [[NSMutableDictionary alloc] initWithDictionary:data[(NSUInteger) i]];
        [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            
            if ([key isEqualToString:@"region"]) {
                
                if (![obj isKindOfClass:[NSArray class]]) {
                    
                    tempDic[@"region"] = @[];
                }
            }
            
            if ([obj isKindOfClass:[NSNull class]]) {
                
                if ([key isEqualToString:@"region"]) {
                    
                    tempDic[@"region"] = @[];
                }else{
                    
                    tempDic[key] = @"";
                }
            }
        }];
        
        CustomerTableModel *model = [[CustomerTableModel alloc] initWithDictionary:tempDic];
        
        [_dataArr addObject:model];
    }
    [_customerTable reloadData];
}

#pragma mark -- Method

- (void)ActionTagBtn:(UIButton *)btn{
    
    btn.selected = !btn.selected;
    if (btn.tag < 3) {
        
        if (btn.tag == 1) {
            
            _is2 = NO;
            _areaBtn.selected = NO;
            [self.adressView removeFromSuperview];
            if (_is1) {
                
                _is1 = !_is1;
                [self.boxView removeFromSuperview];
            }else{
                
                _is1 = YES;
                _type = @"0";
                
                NSMutableArray * tempArr = [NSMutableArray arrayWithArray:_propertyArr];
                [tempArr insertObject:@{@"id":@"0",@"param":@"不限"} atIndex:0];
                self.boxView.dataArr = [NSMutableArray arrayWithArray:tempArr];
                [tempArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    if (idx == 0) {
                        
                        tempArr[idx] = @(1);
                    }else{
                        
                        tempArr[idx] = @(0);
                    }
                }];
                self.boxView.selectArr = [NSMutableArray arrayWithArray:tempArr];
                [self.boxView.mainTable reloadData];
                [self.view addSubview:self.boxView];
            }
        }else{
            
            _is1 = NO;
            _propertyBtn.selected = NO;
            [self.boxView removeFromSuperview];
            if (_is2) {
                
                _is2 = !_is2;
                [self.adressView removeFromSuperview];
            }else{
                
                _is2 = YES;
                [self.view addSubview:self.adressView];
            }
        }
    }else{
        
        _page = 1;
        _is1 = NO;
        _is2 = NO;
        _propertyBtn.selected = NO;
        _areaBtn.selected = NO;
        if (btn.tag == 3) {
            
            _urgencyBtn.selected = NO;
            if ([_sortType isEqualToString:@"intent"]) {
                
                if ([_asc isEqualToString:@"desc"]) {
                    
                    _asc = @"asc";
                }else{
                    
                    _asc = @"desc";
                }
            }else{
                
                _asc = @"asc";
            }
            _sortType = @"intent";
        }else{
            
            _intentBtn.selected = NO;
            if ([_sortType isEqualToString:@"urgency"]) {
                
                
                if ([_asc isEqualToString:@"desc"]) {
                    
                    _asc = @"asc";
                }else{
                    
                    _asc = @"desc";
                }
            }else{
                
                _asc = @"asc";
            }
            _sortType = @"urgency";
        }
        [self.boxView removeFromSuperview];
        [self RequestMethod];
        if (_dataArr.count) {
            
            [_customerTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
        }
    }
}

#pragma mark -- SearchMethod

- (void)ActionSearchBtn:(UIButton *)btn{
    
    // 1.创建热门搜索
    NSArray *hotSeaches = @[];
    // 2. 创建控制器
    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:hotSeaches searchBarPlaceholder:@"请输入姓名/手机号" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        // 开始搜索执行以下代码
        // 如：跳转到指定控制器
        [searchViewController.navigationController pushViewController:[[CustomSearchVC alloc] initWithTitle:searchText status:self.status] animated:YES];
    }];
    // 3. 设置风格
    searchViewController.searchBar.returnKeyType = UIReturnKeySearch;
    searchViewController.hotSearchStyle = PYHotSearchStyleBorderTag; // 热门搜索风格根据选择
    searchViewController.searchHistoryStyle = PYHotSearchStyleDefault; // 搜索历史风格为
//    if (@available(iOS 13.0, *)) {
//
//        [searchViewController setOverrideUserInterfaceStyle:UIUserInterfaceStyleLight];
//    } else {
//        // Fallback on earlier versions
//    }
    // 4. 设置代理
    searchViewController.delegate = self;
    // 5. 跳转到搜索控制器
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:searchViewController];
    if (@available(iOS 13.0, *)) {
        
        [nav setOverrideUserInterfaceStyle:UIUserInterfaceStyleLight];
    } else {
        // Fallback on earlier versions
    }
    [self presentViewController:nav  animated:NO completion:nil];
    
}

#pragma mark -- TableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    return 110 *SIZE;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *Identifier = @"CustomerTableCell";
    CustomerTableCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (!cell) {
        
        cell = [[CustomerTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    CustomerTableModel *model = _dataArr[(NSUInteger) indexPath.row];
    cell.customerTableCellPhoneTapBlock = ^(NSString *phone) {
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phone]];
        //调用系统方法拨号
        [[UIApplication sharedApplication] openURL:url];
    };
    cell.model = model;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.isSelect) {
        
        if (self.customerListVCCustomBlock) {
            
            CustomerTableModel *model = _dataArr[(NSUInteger) indexPath.row];
            self.customerListVCCustomBlock(model);
            [self.navigationController popViewControllerAnimated:YES];
        }
    }else{
        
        CustomerTableModel *model = _dataArr[(NSUInteger) indexPath.row];
        
//        if ([model.client_type isEqualToString:@"新房"]) {
//
//            NewCustomDetailVC *nextVC = [[NewCustomDetailVC alloc] initWithClientId:model.client_id];
//            nextVC.model = model;
//            [self.navigationController pushViewController:nextVC animated:YES];
//        }else{
            
            CustomDetailVC *nextVC = [[CustomDetailVC alloc] initWithClientId:model.client_id];
            nextVC.customType = model.client_type;
            nextVC.hidesBottomBarWhenPushed = YES;
            nextVC.model = model;
            [self.navigationController pushViewController:nextVC animated:YES];
//        }
    }
}


- (void)initUI{
    
    self.titleLabel.text = @"客源";
    self.navBackgroundView.hidden = NO;
//    self.leftButton.hidden = YES;
    self.view.backgroundColor = YJBackColor;
    if (self.isSelect) {
        
        self.rightBtn.hidden = YES;
    }else{
        
        self.rightBtn.hidden = NO;
    }
    
    [self.rightBtn setImage:[UIImage imageNamed:@"add_3"] forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(action_add) forControlEvents:UIControlEventTouchUpInside];
    
    self.line.hidden = YES;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0,  NAVIGATION_BAR_HEIGHT, SCREEN_Width, 56 *SIZE)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    _searchBar = [[UIView alloc] initWithFrame:CGRectMake(10 *SIZE, 20 *SIZE, 340 *SIZE, 33 *SIZE)];
    _searchBar.backgroundColor = YJBackColor;
    [view addSubview:_searchBar];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(11 *SIZE, 11 *SIZE, 100 *SIZE, 12 *SIZE)];
    label.textColor = COLOR(147, 147, 147, 1);
    label.text = @"请输入姓名/手机号";
    label.font = [UIFont systemFontOfSize:11 *SIZE];
    [_searchBar addSubview:label];
    
    UIImageView *rightImg = [[UIImageView alloc] initWithFrame:CGRectMake(308 *SIZE, 8 *SIZE, 17 *SIZE, 17 *SIZE)];
    rightImg.image = [UIImage imageNamed:@"search_2"];
    [_searchBar addSubview:rightImg];
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame = _searchBar.bounds;
    [searchBtn addTarget:self action:@selector(ActionSearchBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_searchBar addSubview:searchBtn];
    
    for (int i = 0; i < 4; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(SCREEN_Width / 4 * i, NAVIGATION_BAR_HEIGHT + 56 *SIZE, SCREEN_Width / 4, 40 *SIZE);
        btn.tag = i + 1;
        [btn setBackgroundColor:[UIColor whiteColor]];
        [btn addTarget:self action:@selector(ActionTagBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        switch (i) {
//            case 0:
//            {
//                [btn setTitle:@"需求类型" forState:UIControlStateNormal];
//                [btn setTitleColor:YJ86Color forState:UIControlStateNormal];
//                btn.titleLabel.font = [UIFont systemFontOfSize:12 *SIZE];
//                [btn setImage:[UIImage imageNamed:@"downarrow1"] forState:UIControlStateNormal];
//                [btn setImage:[UIImage imageNamed:@"uparrow2"] forState:UIControlStateSelected];
//                _typeBtn = btn;
//                [self.view addSubview:_typeBtn];
//                break;
//            }
            case 0:
            {
                [btn setTitle:@"意向物业" forState:UIControlStateNormal];
                [btn setTitleColor:YJ86Color forState:UIControlStateNormal];
                btn.titleLabel.font = [UIFont systemFontOfSize:12 *SIZE];
                [btn setImage:[UIImage imageNamed:@"downarrow1"] forState:UIControlStateNormal];
                [btn setImage:[UIImage imageNamed:@"uparrow2"] forState:UIControlStateSelected];
                _propertyBtn = btn;
                [self.view addSubview:_propertyBtn];
                break;
            }
            case 1:
            {
                [btn setTitle:@"意向区域" forState:UIControlStateNormal];
                [btn setTitleColor:YJ86Color forState:UIControlStateNormal];
                btn.titleLabel.font = [UIFont systemFontOfSize:12 *SIZE];
                [btn setImage:[UIImage imageNamed:@"downarrow1"] forState:UIControlStateNormal];
                [btn setImage:[UIImage imageNamed:@"uparrow2"] forState:UIControlStateSelected];
                _areaBtn = btn;
                [self.view addSubview:_areaBtn];
                break;
            }
            case 2:
            {
                [btn setTitle:@"意向度" forState:UIControlStateNormal];
                [btn setTitleColor:YJ86Color forState:UIControlStateNormal];
                btn.titleLabel.font = [UIFont systemFontOfSize:12 *SIZE];
                [btn setImage:[UIImage imageNamed:@"downarrow1"] forState:UIControlStateNormal];
                [btn setImage:[UIImage imageNamed:@"uparrow2"] forState:UIControlStateSelected];
                _intentBtn = btn;
                [self.view addSubview:_intentBtn];
                break;
            }
            case 3:
            {
                [btn setTitle:@"紧迫度" forState:UIControlStateNormal];
                [btn setTitleColor:YJ86Color forState:UIControlStateNormal];
                btn.titleLabel.font = [UIFont systemFontOfSize:12 *SIZE];
                [btn setImage:[UIImage imageNamed:@"downarrow1"] forState:UIControlStateNormal];
                [btn setImage:[UIImage imageNamed:@"uparrow2"] forState:UIControlStateSelected];
                _urgencyBtn = btn;
                [self.view addSubview:_urgencyBtn];
                break;
            }
            default:
                break;
        }
    }

    _customerTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 41 *SIZE + NAVIGATION_BAR_HEIGHT + 56 *SIZE, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - 41 *SIZE - 56 *SIZE) style:UITableViewStylePlain];
    
    _customerTable.rowHeight = UITableViewAutomaticDimension;
    _customerTable.estimatedRowHeight = 110 *SIZE;
    
    _customerTable.backgroundColor = YJBackColor;
    _customerTable.delegate = self;
    _customerTable.dataSource = self;
    _customerTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_customerTable];
    _customerTable.mj_header = [GZQGifHeader headerWithRefreshingBlock:^{
        
        _page = 1;
        [self RequestMethod];
    }];
    
    _customerTable.mj_footer = [GZQGifFooter footerWithRefreshingBlock:^{
        
        [self RequestAddMethod];
    }];
}


-(void)action_add
{
    AddCustomerVC *next_vc = [[AddCustomerVC alloc]init];
    next_vc.isSelect = self.isSelect;
    next_vc.status = self.status + 1;
    [self.navigationController pushViewController:next_vc animated:YES];
}

- (AddressChooseView2 *)adressView{
    
    if (!_adressView) {
        
        _adressView = [[AddressChooseView2 alloc]initWithFrame:CGRectMake(0, 41 *SIZE + NAVIGATION_BAR_HEIGHT + 56 *SIZE, SCREEN_Width, SCREEN_Height - (41 *SIZE + NAVIGATION_BAR_HEIGHT + 56 *SIZE))];
        WS(weakSelf);
        _adressView.confirmAreaBlock = ^(NSString *pro, NSString *city, NSString *area, NSString *proviceid, NSString *cityid, NSString *areaid) {
            
            if (area.length) {
                
                if ([area isEqualToString:@"不限"]) {
                    
                    _district = @"";
                    [weakSelf.areaBtn setTitle:@"意向区域" forState:UIControlStateNormal];
                }else{
                    
                    _district = [NSString stringWithFormat:@"%@-%@-%@",proviceid,cityid,areaid];
                    [weakSelf.areaBtn setTitle:area forState:UIControlStateNormal];
                }
                
            }else if(city.length){
                
                if ([area isEqualToString:@"不限"]) {
                    
                    _district = @"";
                    [weakSelf.areaBtn setTitle:@"意向区域" forState:UIControlStateNormal];
                }else{
                    
                    _district = [NSString stringWithFormat:@"%@-%@",proviceid,cityid];
                    [weakSelf.areaBtn setTitle:city forState:UIControlStateNormal];
                }
            }else if (pro.length){
                
                if ([area isEqualToString:@"不限"]) {
                    
                    _district = @"";
                    [weakSelf.areaBtn setTitle:@"意向区域" forState:UIControlStateNormal];
                }else{
                    
                    _district = [NSString stringWithFormat:@"%@",proviceid];
                    [weakSelf.areaBtn setTitle:pro forState:UIControlStateNormal];
                }
            }else{
                
                [weakSelf.areaBtn setTitle:@"意向区域" forState:UIControlStateNormal];
            }
            
            _is2 = NO;
            weakSelf.areaBtn.selected = NO;
            [weakSelf.adressView removeFromSuperview];
            [weakSelf RequestMethod];
        };
        _adressView.cancelBtnBlock = ^{
            
            _is2 = NO;
            weakSelf.areaBtn.selected = NO;
        };
    }
    return _adressView;
}

- (BoxView *)boxView{
    if (!_boxView) {
        _boxView = [[BoxView alloc] initWithFrame:CGRectMake(0, 41 *SIZE + NAVIGATION_BAR_HEIGHT + 56 *SIZE, SCREEN_Width, SCREEN_Height - (41 *SIZE + NAVIGATION_BAR_HEIGHT + 56 *SIZE))];
        WS(weakSelf);
        _boxView.confirmBtnBlock = ^(NSString *ID,NSString *str) {

            if ([str isEqualToString:@"不限"]) {

                [weakSelf.propertyBtn setTitle:@"需求类型" forState:UIControlStateNormal];
            }else{

                [weakSelf.propertyBtn setTitle:str forState:UIControlStateNormal];
            }
            _is1 = NO;
            _type = [NSString stringWithFormat:@"%@",ID];
            weakSelf.propertyBtn.selected = NO;
            [weakSelf.boxView removeFromSuperview];
            [weakSelf RequestMethod];
        };

        _boxView.cancelBtnBlock = ^{

            _is1 = NO;
            weakSelf.propertyBtn.selected = NO;
        };
    }
    return _boxView;
}

@end
