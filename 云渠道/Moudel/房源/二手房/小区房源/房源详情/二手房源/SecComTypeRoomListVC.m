//
//  SecComTypeRoomListVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/10/10.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "SecComTypeRoomListVC.h"
#import "SecAllRoomDetailVC.h"

#import "SecdaryAllTableCell.h"

#import "SecdaryAllTableModel.h"

@interface SecComTypeRoomListVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSInteger _page;
    NSMutableArray *_dataArr;
    NSString *_city;
    NSString *_projectId;
    NSString *_name;
}
@property (nonatomic , strong) UITableView *MainTableView;

@end

@implementation SecComTypeRoomListVC

- (instancetype)initWithProjectId:(NSString *)projectId city:(NSString *)city name:(nonnull NSString *)name
{
    self = [super init];
    if (self) {
        
        _projectId = projectId;
        _city = city;
        _name = name;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDateSouce];
    [self initUI];
    self.MainTableView.mj_footer.state = MJRefreshStateNoMoreData;
    [self RequestMethod];
}

-(void)initDateSouce
{
    
    _dataArr = [@[] mutableCopy];
    _page = 1;
    
}

- (void)SetData:(NSArray *)data{
    
    if (data.count < 15) {
        
        self.MainTableView.mj_footer.state = MJRefreshStateNoMoreData;
    }else{
        
        [self.MainTableView.mj_footer endRefreshing];
    }
    
    for (int i = 0; i < data.count; i++) {
        
        NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:data[i]];
        [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            
            if ([obj isKindOfClass:[NSNull class]]) {
                
                if ([key isEqualToString:@"house_tags"] || [key isEqualToString:@"project_tags"]) {
                    
                    [tempDic setObject:@[] forKey:key];
                }else{
                    
                    [tempDic setObject:@"" forKey:key];
                }
            }else{
                
                if ([key isEqualToString:@"house_tags"] || [key isEqualToString:@"project_tags"]) {
                    
                    
                }else{
                    
                    [tempDic setObject:[NSString stringWithFormat:@"%@",obj] forKey:key];
                }
            }
        }];
        SecdaryAllTableModel *model = [[SecdaryAllTableModel alloc] init];//WithDictionary:tempDic];
        model.price_change = tempDic[@"price_change"];
        model.img_url = tempDic[@"img_url"];
        model.house_id = tempDic[@"house_id"];
        model.title = tempDic[@"title"];
        model.describe = tempDic[@"describe"];
        model.price = tempDic[@"price"];
        model.unit_price = tempDic[@"unit_price"];
        model.property_type = tempDic[@"property_type"];
        model.store_name = tempDic[@"store_name"];
        model.project_tags = [NSMutableArray arrayWithArray:tempDic[@"project_tags"]];
        model.house_tags = [NSMutableArray arrayWithArray:tempDic[@"house_tags"]];
        model.type = tempDic[@"type"];
        [_dataArr addObject:model];
    }
    
    [self.MainTableView reloadData];
}

- (void)RequestMethod{
    
    if (_page == 1) {
        
        self.MainTableView.mj_footer.state = MJRefreshStateIdle;
    }
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"page":@(_page),@"house_type_name":_name}];
    [dic setObject:_city forKey:@"city"];
    [dic setObject:_projectId forKey:@"project_id"];
    [BaseRequest GET:HouseHouseList_URL parameters:dic success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [self.MainTableView.mj_header endRefreshing];
            [_dataArr removeAllObjects];
            [self SetData:resposeObject[@"data"][@"data"]];
            
        }else{
            
            [self.MainTableView.mj_header endRefreshing];
            [self showContent:resposeObject[@"msg"]];
            
        }
        [_MainTableView reloadData];
    } failure:^(NSError *error) {
        
        [self.MainTableView.mj_header endRefreshing];
        [self showContent:@"网络错误"];
        NSLog(@"%@",error);
    }];
    
}

- (void)RequestAddMethod{
    
    _page += 1;
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"page":@(_page),@"house_type_name":_name}];
    [dic setObject:_city forKey:@"city"];
    [dic setObject:_projectId forKey:@"project_id"];
    [BaseRequest GET:HouseHouseList_URL parameters:dic success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if ([resposeObject[@"data"] count]) {
                
                [self SetData:resposeObject[@"data"][@"data"]];
            }else{
                
                self.MainTableView.mj_footer.state = MJRefreshStateNoMoreData;
            }
        }else{
            
            _page -= 1;
            [self showContent:resposeObject[@"msg"]];
            [self.MainTableView.mj_footer endRefreshing];
        }
    } failure:^(NSError *error) {
        
        _page -= 1;
        [self showContent:@"网络错误"];
        [self.MainTableView.mj_footer endRefreshing];
    }];
    
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
    
    SecdaryAllTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SecdaryAllTableCell"];
    if (!cell) {
        
        cell = [[SecdaryAllTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SecdaryAllTableCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    SecdaryAllTableModel *model = _dataArr[indexPath.row];
    cell.model = model;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SecdaryAllTableModel *model = _dataArr[indexPath.row];
    SecAllRoomDetailVC *nextVC = [[SecAllRoomDetailVC alloc] initWithHouseId:model.house_id city:_city];
    nextVC.type = [model.type integerValue];
    nextVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (void)initUI{
    
    self.view.backgroundColor = YJBackColor;
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"二手房源";
    
    
    [self.view addSubview:self.MainTableView];
//    self.MainTableView.mj_footer.state = MJRefreshStateNoMoreData;
}

#pragma mark  ---  懒加载   ---
-(UITableView *)MainTableView
{
    if(!_MainTableView)
    {
        
        _MainTableView =   [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, 360*SIZE, SCREEN_Height-NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
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

@end
