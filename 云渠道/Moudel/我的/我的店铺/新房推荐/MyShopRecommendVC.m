//
//  MyShopRecommendVC.m
//  云渠道
//
//  Created by 谷治墙 on 2020/2/27.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "MyShopRecommendVC.h"

#import "MyShopRecommendHistoryVC.h"
#import "MyShopRecommendDetailVC.h"

#import "MyShopRoomCell.h"
#import "MyShopRecommendCell.h"

@interface MyShopRecommendVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSInteger _page;
    
    NSMutableArray *_dataArr;
}

@property (nonatomic , strong) UITableView *MainTableView;

@end

@implementation MyShopRecommendVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
    [self RequestMethod];
}

- (void)initDataSource{
    
    _page = 1;
    _dataArr = [@[] mutableCopy];
}

- (void)RequestMethod{
    
    if (_page == 1) {
        
        self.MainTableView.mj_footer.state = MJRefreshStateIdle;
    }
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"page":@(_page)}];
    
    [BaseRequest GET:GetRecommendHouseList_URL parameters:dic success:^(id resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [_dataArr removeAllObjects];
            [self->_MainTableView reloadData];
            [_MainTableView.mj_header endRefreshing];
            if ([resposeObject[@"data"][@"data"] count]) {
                
                
                [self SetData:resposeObject[@"data"][@"data"]];
                
            }else{
                
                [_dataArr removeAllObjects];
                _MainTableView.mj_footer.state = MJRefreshStateNoMoreData;
            }
        }else{
            
            [_MainTableView.mj_header endRefreshing];
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [_MainTableView.mj_header endRefreshing];
        [self showContent:@"网络错误"];
    }];
}

- (void)RequestAddMethod{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"page":@(_page)}];
    
    [BaseRequest GET:GetRecommendHouseList_URL parameters:dic success:^(id resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if ([resposeObject[@"data"][@"data"] count]) {
                
                [_MainTableView.mj_footer endRefreshing];
                [self SetData:resposeObject[@"data"][@"data"]];
                
            }else{
                
                _MainTableView.mj_footer.state = MJRefreshStateNoMoreData;
            }
        }else{
            
            _page -= 1;
            [_MainTableView.mj_footer endRefreshing];
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        _page -= 1;
        [_MainTableView.mj_footer endRefreshing];
        [self showContent:@"网络错误"];
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
        
        [_dataArr addObject:tempDic];
    }
    
    [self.MainTableView reloadData];
}

- (void)ActionSaveBtn:(UIButton *)btn{
 
    MyShopRecommendHistoryVC *nextVC = [[MyShopRecommendHistoryVC alloc] init];
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    MyShopRoomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyShopRoomCell"];
    if (!cell) {
        
        cell = [[MyShopRoomCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"MyShopRoomCell"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.tag = indexPath.row;
    
    cell.dataDic = _dataArr[indexPath.row];
    if (indexPath.row == 0) {
        
        cell.upBtn.hidden = YES;
    }else{
        
        cell.upBtn.hidden = NO;
    }
    cell.myShopRoomCellBlock = ^(NSInteger index, NSInteger btn) {
        
        [BaseRequest POST:ProjectUpdateRecommendHouse_URL parameters:@{@"recommend_id":[NSString stringWithFormat:@"%@",_dataArr[index][@"recommend_id"]],@"house_id":[NSString stringWithFormat:@"%@",_dataArr[index][@"house_id"]],@"top_sort":@"1"} success:^(id resposeObject) {

            if ([resposeObject[@"code"] integerValue] == 200) {

                _page = 1;
                [self RequestMethod];
                if (self.myShopRecommendVCBlock) {
                    
                    self.myShopRecommendVCBlock();
                }
            }else{

                [self showContent:resposeObject[@"msg"]];
            }
        } failure:^(NSError *error) {

            [self showContent:@"网络错误"];
        }];
    };
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyShopRecommendDetailVC *nextVC = [[MyShopRecommendDetailVC alloc] initWithHouseId:[NSString stringWithFormat:@"%@",_dataArr[indexPath.row][@"house_id"]] info_id:@""];
    nextVC.project_id = @"";
    nextVC.projectName = [NSString stringWithFormat:@"%@",_dataArr[indexPath.row][@"project_name"]];
    nextVC.config_id = [NSString stringWithFormat:@"%@",_dataArr[indexPath.row][@"config_id"]];
    nextVC.myShopRecommendDetailVCBlock = ^{
      
        [self RequestMethod];
        if (self.myShopRecommendVCBlock) {
            
            self.myShopRecommendVCBlock();
        }
    };
    [self.navigationController pushViewController:nextVC animated:YES];
}
    
- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"新房推荐";
    
    self.rightBtn.hidden = NO;
    [self.rightBtn addTarget:self action:@selector(ActionSaveBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightBtn setTitle:@"查看历史" forState:UIControlStateNormal];
    self.rightBtn.titleLabel.font = [UIFont systemFontOfSize:13 *SIZE];
    self.rightBtn.frame = CGRectMake(SCREEN_Width - 65 *SIZE, 7 *SIZE + STATUS_BAR_HEIGHT, 60 *SIZE, 30 *SIZE);
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
