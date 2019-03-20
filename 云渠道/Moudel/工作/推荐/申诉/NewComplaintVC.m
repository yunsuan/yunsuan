//
//  RecommendComplaintVC.m
//  云渠道
//
//  Created by 谷治墙 on 2019/1/18.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "NewComplaintVC.h"

#import "ComplaintCompleteVC.h"
#import "ComplaintUnCompleteVC.h"

#import "RecommendCell5.h"

@interface NewComplaintVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableArray *_dataArr;
    NSInteger _page;
}

@property (nonatomic , strong) UITableView *MainTableView;

@end

@implementation NewComplaintVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDateSouce];
    [self initUI];
    [self RequestMethod];
}

- (void)initDateSouce
{
    _page = 1;
    _dataArr = [@[] mutableCopy];
}

- (void)RequestMethod{
    
    _page = 1;
    _MainTableView.mj_footer.state = MJRefreshStateIdle;
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"page":@(_page)}];
    if (![self isEmpty:self.search]) {
        
        [dic setObject:self.search forKey:@"search"];
    }
    if ([[UserModel defaultModel].agent_identity integerValue] == 1) {
        
        [BaseRequest GET:BrokerAppeal_URL parameters:dic success:^(id resposeObject) {
            
            [_MainTableView.mj_header endRefreshing];
            if ([resposeObject[@"code"] integerValue] == 200) {
                
                [_dataArr removeAllObjects];
                if ([resposeObject[@"data"][@"data"] count]) {
                    
                    [_MainTableView.mj_footer endRefreshing];
                    [self SetUnComfirmArr:resposeObject[@"data"][@"data"]];
                }else{
                    
                    _MainTableView.mj_footer.state = MJRefreshStateNoMoreData;
                }
            }
            else{
                
                [self showContent:resposeObject[@"msg"]];
            }
        } failure:^(NSError *error) {
            
            [_MainTableView.mj_header endRefreshing];
            [self showContent:@"网络错误"];
        }];
    }else{
        
        [_dataArr removeAllObjects];
        [_MainTableView.mj_header endRefreshing];
        _MainTableView.mj_footer.state = MJRefreshStateNoMoreData;
        [_MainTableView reloadData];
    }
}

- (void)RequestAddMethod{
    
    _page += 1;
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"page":@(_page)}];
    if (![self isEmpty:self.search]) {
        
        [dic setObject:self.search forKey:@"search"];
    }
    if ([[UserModel defaultModel].agent_identity integerValue] == 1) {
        
        [BaseRequest GET:BrokerAppeal_URL parameters:dic success:^(id resposeObject) {
            
            if ([resposeObject[@"code"] integerValue] == 200) {
                
                [self SetUnComfirmArr:resposeObject[@"data"][@"data"]];
                if ([resposeObject[@"data"][@"data"] count]) {
                    
                    [_MainTableView.mj_footer endRefreshing];
                    [self SetUnComfirmArr:resposeObject[@"data"][@"data"]];
                }else{
                    
                    _MainTableView.mj_footer.state = MJRefreshStateNoMoreData;
                }
            }
            else{
                
                _page -= 1;
                [_MainTableView.mj_footer endRefreshing];
                [self showContent:resposeObject[@"msg"]];
            }
        } failure:^(NSError *error) {
            
            _page -= 1;
            [_MainTableView.mj_footer endRefreshing];
            [self showContent:@"网络错误"];
        }];
    }else{
        
        [_dataArr removeAllObjects];
        
        _MainTableView.mj_footer.state = MJRefreshStateNoMoreData;
        [_MainTableView reloadData];
    }
}

- (void)SetUnComfirmArr:(NSArray *)data{
    
    for (int i = 0; i < data.count; i++) {
        
        NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:data[i]];
        [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            
            if ([obj isKindOfClass:[NSNull class]]) {
                
                [tempDic setObject:@"" forKey:key];
            }
        }];
        
        [_dataArr addObject:tempDic];
    }
    
    [_MainTableView reloadData];
}

#pragma mark  ---  delegate   ---

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _dataArr.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *CellIdentifier = @"RecommendCell5";
    
    RecommendCell5 *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[RecommendCell5 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.dataDic = _dataArr[indexPath.row];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([_dataArr[indexPath.row][@"state"] isEqualToString:@"处理完成"]) {
        
        ComplaintCompleteVC *nextVC = [[ComplaintCompleteVC alloc] initWithAppealId:_dataArr[indexPath.row][@"appeal_id"]];
        [self.navigationController pushViewController:nextVC animated:YES];
    }else{
        
        ComplaintUnCompleteVC *nextVC = [[ComplaintUnCompleteVC alloc] initWithAppealId:_dataArr[indexPath.row][@"appeal_id"]];
        [self.navigationController pushViewController:nextVC animated:YES];
    }
}

-(void)initUI
{
    
    if ([[UserModel defaultModel].agent_identity integerValue] ==1) {
        self.rightBtn.hidden = NO;
    }else{
        self.rightBtn.hidden = YES;
    }
    
    [self.view addSubview:self.MainTableView];
}


-(UITableView *)MainTableView
{
    if(!_MainTableView)
    {
        _MainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 360*SIZE, SCREEN_Height - NAVIGATION_BAR_HEIGHT - 81 *SIZE) style:UITableViewStylePlain];
        _MainTableView.backgroundColor = YJBackColor;
        _MainTableView.rowHeight = UITableViewAutomaticDimension;
        _MainTableView.estimatedRowHeight = 130 *SIZE;
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
