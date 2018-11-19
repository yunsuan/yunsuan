//
//  CustomListVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/5/5.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "CustomListVC.h"
#import "CustomerTableModel.h"
#import "CustomDetailVC.h"
#import "RoomDetailTableCell5.h"
#import "QuickAddCustomVC.h"

@interface CustomListVC() <UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>{
    
    NSMutableArray *_dataArr;
    NSMutableArray *_tempArr;
    NSString *_projectId;
    NSInteger _page;
    BOOL _isSearch;
}

@property (nonatomic , strong) UITableView *customerTable;

@property (nonatomic, strong) UITextField *searchBar;

@end

@implementation CustomListVC

- (instancetype)initWithProjectId:(NSString *)projectId
{
    self = [super init];
    if (self) {
        
        _page = 1;
        _projectId = projectId;
        _dataArr = [@[] mutableCopy];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    [self RequestMethod];
}

- (void)RequestMethod{
    
    _customerTable.mj_footer.state = MJRefreshStateIdle;
    [BaseRequest GET:FastRecommendList_URL parameters:nil success:^(id resposeObject) {
        
        [_customerTable.mj_header endRefreshing];
     
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if ([resposeObject[@"data"] isKindOfClass:[NSDictionary class]]) {
                
                if (_page >= [resposeObject[@"data"][@"last_page"] integerValue]) {
                    
                    [_dataArr removeAllObjects];
                    _customerTable.mj_footer.state = MJRefreshStateNoMoreData;
                }
                
                if ([resposeObject[@"data"][@"data"] isKindOfClass:[NSArray class]]) {
                    
                    if ([resposeObject[@"data"][@"data"] count]) {
                        
                        [self SetData:resposeObject[@"data"][@"data"]];
                        
                    }else{
                        
                        [_dataArr removeAllObjects];
                        _customerTable.mj_footer.state = MJRefreshStateNoMoreData;
                    }
                }else{
                    
                    [_dataArr removeAllObjects];
                }
            }else{
                
                [_dataArr removeAllObjects];
            }
        }else{
       
                [self showContent:resposeObject[@"msg"]];
           
        }
    } failure:^(NSError *error) {
        
        [_customerTable.mj_header endRefreshing];
        [self showContent:@"网络错误"];
    }];
}

- (void)RequestAddMethod{
    
    _page += 1;
    NSDictionary *tempDic = @{@"page":@(_page)};
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:tempDic];
    if (_isSearch) {
        
        
    }
    [BaseRequest GET:FastRecommendList_URL parameters:dic success:^(id resposeObject) {

        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if ([resposeObject[@"data"] isKindOfClass:[NSDictionary class]]) {
                
                
                if ([resposeObject[@"data"][@"data"] isKindOfClass:[NSArray class]]) {
                    
                    if ([resposeObject[@"data"][@"data"] count]) {
                        
                        
                        [self SetData:resposeObject[@"data"][@"data"]];
                        if (_page >= [resposeObject[@"data"][@"last_page"] integerValue]) {
                            
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
            
            [_customerTable.mj_footer endRefreshing];
        }
    } failure:^(NSError *error) {
        
        [_customerTable.mj_footer endRefreshing];
        [self showContent:@"网络错误"];
    }];
}

- (void)SearchMethod{
    
    _customerTable.mj_footer.state = MJRefreshStateIdle;
    NSDictionary *dic = @{@"search":_searchBar.text};
    [BaseRequest GET:ListClient_URL parameters:dic success:^(id resposeObject) {
        
//        NSLog(@"%@",resposeObject);
        [_customerTable.mj_header endRefreshing];
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if ([resposeObject[@"data"] isKindOfClass:[NSDictionary class]]) {
                
                if ([resposeObject[@"data"][@"current_page"] integerValue] == [resposeObject[@"data"][@"total"] integerValue]) {
                    
                    _customerTable.mj_footer.state = MJRefreshStateNoMoreData;
                }
                
                if ([resposeObject[@"data"][@"data"] isKindOfClass:[NSArray class]]) {
                    
                    if ([resposeObject[@"data"][@"data"] count]) {
                        
                        [self SetData:resposeObject[@"data"][@"data"]];
                        
                    }else{
                        
                        _customerTable.mj_footer.state = MJRefreshStateNoMoreData;
                        //                        [self showContent:@"暂无数据"];
                    }
                }else{
                    //                    [self showContent:@"暂无数据"];
                }
            }else{
                //                [self showContent:@"暂无数据"];
            }
        }else if([resposeObject[@"code"] integerValue] == 400){
            
            //            [self showContent:resposeObject[@"msg"]];
        }
        else{
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [_customerTable.mj_header endRefreshing];
//        NSLog(@"%@",error.localizedDescription);
        [self showContent:@"网络错误"];
    }];
}

- (void)SearchRequestAdd{
    
    _page += 1;
    NSDictionary *dic = @{@"search":_searchBar.text,
                          @"page":@(_page)
                          };
    [BaseRequest GET:ListClient_URL parameters:dic success:^(id resposeObject) {
        
//        NSLog(@"%@",resposeObject);
        [_customerTable.mj_footer endRefreshing];
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if ([resposeObject[@"data"] isKindOfClass:[NSDictionary class]]) {
                
                if ([resposeObject[@"data"][@"current_page"] integerValue] == [resposeObject[@"data"][@"total"] integerValue]) {
                    
                    _customerTable.mj_footer.state = MJRefreshStateNoMoreData;
                }
                if ([resposeObject[@"data"][@"data"] isKindOfClass:[NSArray class]]) {
                    
                    if ([resposeObject[@"data"][@"data"] count]) {
                        
                        [self SetData:resposeObject[@"data"][@"data"]];
                        
                    }else{
                        
                        _customerTable.mj_footer.state = MJRefreshStateNoMoreData;
                        //                        [self showContent:@"暂无数据"];
                    }
                }else{
                    //                    [self showContent:@"暂无数据"];
                }
            }else{
                //                [self showContent:@"暂无数据"];
            }
        }else if([resposeObject[@"code"] integerValue] == 400){
            
            //            [self showContent:resposeObject[@"msg"]];
        }
        else{
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
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
        
        NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:data[i]];
        [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            
            if ([key isEqualToString:@"region"]) {
                
                if (![obj isKindOfClass:[NSArray class]]) {
                    
                    [tempDic setObject:@[] forKey:@"region"];
                }
            }
            
            if ([obj isKindOfClass:[NSNull class]]) {
                
                if ([key isEqualToString:@"region"]) {
                    
                    [tempDic setObject:@[] forKey:@"region"];
                }else{
                    
                    [tempDic setObject:@"" forKey:key];
                }
            }
        }];
        
        CustomMatchModel *model = [[CustomMatchModel alloc] init];
        model.client_id = tempDic[@"client_id"];
        model.name = tempDic[@"name"];
        model.price = tempDic[@"price"];
        model.sex = tempDic[@"sex"];
        model.tel = tempDic[@"tel"];
        model.house_type = tempDic[@"house_type"];
        model.intent = tempDic[@"intent"];
        model.urgency = tempDic[@"urgency"];
        model.need_id = tempDic[@"need_id"];
        model.region = [NSMutableArray arrayWithArray:tempDic[@"region"]];
        
        [_dataArr addObject:model];
    }
    [_customerTable reloadData];
}


//action
-(void)action_add
{
    QuickAddCustomVC *next_vc = [[QuickAddCustomVC alloc]initWithProjectId:_projectId];
    [self.navigationController pushViewController:next_vc animated:YES];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    _page = 1;
    if (![self isEmpty:textField.text]) {
        
        _isSearch = YES;
        [self SearchMethod];
    }else{
        
        _isSearch = NO;
        [self RequestMethod];
    }
    return YES;
}

#pragma mark -- TableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RoomDetailTableCell5 *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomDetailTableCell5"];
    if (!cell) {
        
        cell = [[RoomDetailTableCell5 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomDetailTableCell5"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = _dataArr[indexPath.row];
    
    cell.recommendBtn.tag = indexPath.row;
    cell.recommendBtnBlock5 = ^(NSInteger index) {
        
        CustomMatchModel *model = _dataArr[index];
        [BaseRequest POST:RecommendClient_URL parameters:@{@"project_id":_projectId,@"client_need_id":model.need_id,@"client_id":model.client_id} success:^(id resposeObject) {

            if ([resposeObject[@"code"] integerValue] == 200) {
                
                [self alertControllerWithNsstring:@"推荐成功" And:nil WithDefaultBlack:^{
                   
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"matchReload" object:nil];
                    [self.navigationController popViewControllerAnimated:YES];
                }];
            }
            else{
                
                [self alertControllerWithNsstring:@"温馨提示" And:resposeObject[@"msg"]];
            }
        } failure:^(NSError *error) {
            
            [self showContent:@"网络错误"];
        }];
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    CustomerTableModel *model = _dataArr[indexPath.row];
//    CustomDetailVC *nextVC = [[CustomDetailVC alloc] initWithClientId:model.client_id];
//    nextVC.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:nextVC animated:YES];
}

- (void)initUI{
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:_searchBar];
    
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 62 *SIZE + STATUS_BAR_HEIGHT)];
    whiteView.backgroundColor = CH_COLOR_white;
    [self.view addSubview:whiteView];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT + 61 *SIZE, SCREEN_Width, SIZE)];
    line.backgroundColor = YJBackColor;
    [whiteView addSubview:line];
    
    self.leftButton.center = CGPointMake(25 * sIZE, STATUS_BAR_HEIGHT + 30 *SIZE);
    self.leftButton.bounds = CGRectMake(0, 0, 80 * sIZE, 33 * sIZE);
    self.maskButton.frame = CGRectMake(0, STATUS_BAR_HEIGHT, 60 * sIZE, 44 *SIZE);
    
    self.rightBtn.hidden = NO;
    [self.rightBtn setImage:[UIImage imageNamed:@"add_3"] forState:UIControlStateNormal];
    self.rightBtn.center = CGPointMake(SCREEN_Width - 25 * SIZE, STATUS_BAR_HEIGHT + 30 *SIZE);
    self.rightBtn.bounds = CGRectMake(0, 0, 80 * SIZE, 33 * SIZE);
    [self.rightBtn addTarget:self action:@selector(action_add) forControlEvents:UIControlEventTouchUpInside];
    
    [whiteView addSubview:self.rightBtn];
    [whiteView addSubview:self.leftButton];
    [whiteView addSubview:self.maskButton];
    
    _searchBar = [[UITextField alloc] initWithFrame:CGRectMake(38 *SIZE, STATUS_BAR_HEIGHT + 14  *SIZE, 263 *SIZE, 33 *SIZE)];
    _searchBar.backgroundColor = YJBackColor;
    _searchBar.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 11 *SIZE, 0)];
    //设置显示模式为永远显示(默认不显示)
    _searchBar.leftViewMode = UITextFieldViewModeAlways;
    _searchBar.placeholder = @"客户姓名/电话";
    _searchBar.font = [UIFont systemFontOfSize:11 *SIZE];
    _searchBar.returnKeyType = UIReturnKeySearch;
    UIImageView *rightImg = [[UIImageView alloc] initWithFrame:CGRectMake(0 *SIZE, 8 *SIZE, 17 *SIZE, 17 *SIZE)];
    //    rightImg.backgroundColor = YJGreenColor;
    rightImg.image = [UIImage imageNamed:@"search_2"];
    _searchBar.rightView = rightImg;
    _searchBar.rightViewMode = UITextFieldViewModeUnlessEditing;
    _searchBar.clearButtonMode = UITextFieldViewModeWhileEditing;
    _searchBar.delegate = self;
    [whiteView addSubview:_searchBar];
    
    _customerTable = [[UITableView alloc] initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT + 62 *SIZE , SCREEN_Width, SCREEN_Height - STATUS_BAR_HEIGHT - 62 *SIZE  - TAB_BAR_MORE) style:UITableViewStylePlain];;
    _customerTable.estimatedRowHeight = 150 *SIZE;
    _customerTable.rowHeight = UITableViewAutomaticDimension;
    _customerTable.backgroundColor = self.view.backgroundColor;
    _customerTable.delegate = self;
    _customerTable.dataSource = self;
    _customerTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_customerTable];
    _customerTable.mj_header = [GZQGifHeader headerWithRefreshingBlock:^{
        
        _page = 1;
        if (!_isSearch) {
            
            [self RequestMethod];
        }else{
            
            [self SearchRequestAdd];
        }
    }];
    
    _customerTable.mj_footer = [GZQGifFooter footerWithRefreshingBlock:^{
        
        if (_isSearch) {
            
            [self SearchRequestAdd];
        }else{
            
            [self RequestAddMethod];
        }
    }];
}

@end
