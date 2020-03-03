//
//  CustomSearchVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/20.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "CustomSearchVC.h"
#import "CustomerTableCell.h"
//#import "CustomerTableModel.h"
#import "CustomDetailVC.h"

@interface CustomSearchVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    
    NSMutableArray *_dataArr;
    NSInteger _page;
    NSString *_str;
    NSInteger _status;
}
@property (nonatomic , strong) UITableView *searchTable;

@end

@implementation CustomSearchVC

- (instancetype)initWithTitle:(NSString *)str status:(NSInteger )status
{
    self = [super init];
    if (self) {
        
        _str = str;
        _status = status;
        self.title = @"搜索结果";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _page = 1;
    _dataArr = [@[] mutableCopy];
    [self initUI];
    [self RequestMethod];
}

- (void)RequestMethod{
    
    _searchTable.mj_footer.state = MJRefreshStateIdle;
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"search":_str}];
    if (_status == 0) {
        
        [dic setObject:@"184" forKey:@"client_type"];
    }else if (_status == 1){
        
        [dic setObject:@"185" forKey:@"client_type"];
    }else{
        
        [dic setObject:@"186" forKey:@"client_type"];
    }
    [BaseRequest GET:ListClient_URL parameters:dic success:^(id resposeObject) {
        
        [_searchTable.mj_header endRefreshing];
     
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if ([resposeObject[@"data"] isKindOfClass:[NSDictionary class]]) {
                
                if ([resposeObject[@"data"][@"current_page"] integerValue] == [resposeObject[@"data"][@"total"] integerValue]) {
                    
                    _searchTable.mj_footer.state = MJRefreshStateNoMoreData;
                }
                
                if ([resposeObject[@"data"][@"data"] isKindOfClass:[NSArray class]]) {
                    
                    if ([resposeObject[@"data"][@"data"] count]) {
                        
                        [self SetData:resposeObject[@"data"][@"data"]];
                        
                    }else{
                        
                        _searchTable.mj_footer.state = MJRefreshStateNoMoreData;
//                        [self showContent:@"暂无数据"];
                    }
                }else{
//                    [self showContent:@"暂无数据"];
                }
            }else{
//                [self showContent:@"暂无数据"];
            }
        }else{
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [_searchTable.mj_header endRefreshing];
        [self showContent:@"网络错误"];
    }];
}

- (void)RequestAddMethod{
    
    _page += 1;
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"search":_str,@"page":@(_page)}];
    if (_status == 0) {
        
        [dic setObject:@"184" forKey:@"client_type"];
    }else if (_status == 1){
        
        [dic setObject:@"185" forKey:@"client_type"];
    }else{
        
        [dic setObject:@"186" forKey:@"client_type"];
    }
    
    [BaseRequest GET:ListClient_URL parameters:dic success:^(id resposeObject) {
        
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if ([resposeObject[@"data"] isKindOfClass:[NSDictionary class]]) {
                
                if ([resposeObject[@"data"][@"current_page"] integerValue] == [resposeObject[@"data"][@"total"] integerValue]) {
                    
                    _searchTable.mj_footer.state = MJRefreshStateNoMoreData;
                }
                if ([resposeObject[@"data"][@"data"] isKindOfClass:[NSArray class]]) {
                    
                    if ([resposeObject[@"data"][@"data"] count]) {
                    
                        [_searchTable.mj_footer endRefreshing];
                        [self SetData:resposeObject[@"data"][@"data"]];
                        
                    }else{
                        
                        _searchTable.mj_footer.state = MJRefreshStateNoMoreData;
                    }
                }else{

                    [_searchTable.mj_footer endRefreshing];
                }
            }else{
                
                [_searchTable.mj_footer endRefreshing];
            }
        }else{
            
            [_searchTable.mj_footer endRefreshing];
            _page -= 1;
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        _page -= 1;
        [_searchTable.mj_footer endRefreshing];
//        NSLog(@"%@",error.localizedDescription);
        [self showContent:@"网络错误"];
    }];
}

- (void)SetData:(NSArray *)data{
    
    if (_page == 1) {
        
        [_dataArr removeAllObjects];
    }
    for (NSUInteger i = 0; i < data.count; i++) {
        
        NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:data[i]];
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
    [_searchTable reloadData];
}

#pragma mark -- TableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 110 *SIZE;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *Identifier = @"CustomerTableCell";
    CustomerTableCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (!cell) {
        
        cell = [[CustomerTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    CustomerTableModel *model = _dataArr[(NSUInteger) indexPath.row];
    cell.model = model;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CustomerTableModel *model = _dataArr[(NSUInteger) indexPath.row];
    CustomDetailVC *nextVC = [[CustomDetailVC alloc] initWithClientId:model.client_id];
    [self.navigationController pushViewController:nextVC animated:YES];
}


- (void)initUI{

    
    _searchTable = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, 360*SIZE, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    _searchTable.backgroundColor = YJBackColor;
    _searchTable.delegate = self;
    _searchTable.dataSource = self;
    _searchTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_searchTable];
    _searchTable.mj_header = [GZQGifHeader headerWithRefreshingBlock:^{
        
        _page = 1;
        [self RequestMethod];
    }];
    
    _searchTable.mj_footer = [GZQGifFooter footerWithRefreshingBlock:^{
        
        [self RequestAddMethod];
    }];
}

@end
