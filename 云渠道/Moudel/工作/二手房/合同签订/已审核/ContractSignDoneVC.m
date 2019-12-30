//
//  ContractSignDoneVC.m
//  云渠道
//
//  Created by 谷治墙 on 2019/1/10.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "ContractSignDoneVC.h"

#import "ContractSignListCell.h"

#import "ContractDetailVC.h"

@interface ContractSignDoneVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_dataArr;
    NSString *_page;
}

@property (nonatomic, strong) UITableView *table;

@end

@implementation ContractSignDoneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDataSouce];
    [self initUI];
}

-(void)initDataSouce
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SearchMethod:) name:@"protocolSearch" object:nil];
    _dataArr = @[];
    _page =@"1";
    [self postWithpage:_page];
}

- (void)SearchMethod:(NSNotification *)noti{
    
    //    _content = noti.userInfo[@"content"];
    [self postWithpage:_page];
}

-(void)postWithpage:(NSString *)page{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"page":page,@"type":@"1"}];
    if (![self isEmpty:self.search]) {
        
        [dic setObject:self.search forKey:@"search"];
    }
    [BaseRequest GET:TakeDealValueList_URL parameters:dic success:^(id resposeObject) {
        [_table.mj_footer endRefreshing];
        [_table.mj_header endRefreshing];
        if ([resposeObject[@"code"] integerValue] ==200) {
            if ([page integerValue]==1) {
                _dataArr = resposeObject[@"data"][@"data"];
                if ([resposeObject[@"data"][@"total"] integerValue]==0||[resposeObject[@"data"][@"total"] integerValue]) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        _table.mj_footer.state = MJRefreshStateNoMoreData;
                    });
                    
                }
            }else
            {
                _dataArr = [_dataArr arrayByAddingObjectsFromArray:resposeObject[@"data"][@"data"]];
                if ([_page integerValue]>=[resposeObject[@"data"][@"total"] integerValue]) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        _table.mj_footer.state = MJRefreshStateNoMoreData;
                    });
                }
            }
            [_table reloadData];
        }
    } failure:^(NSError *error) {
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ContractSignListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ContractSignListCell"];
    if (!cell) {
        
        cell = [[ContractSignListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ContractSignListCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.dataDic = _dataArr[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ContractDetailVC *next_vc = [[ContractDetailVC alloc]init];
    next_vc.deal_id = _dataArr[indexPath.row][@"deal_id"];
    next_vc.state = [_dataArr[indexPath.row][@"state"] integerValue];
    [self.navigationController pushViewController:next_vc animated:YES];
}

- (void)initUI{
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - 81 *SIZE) style:UITableViewStylePlain];
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 120 *SIZE;
    _table.backgroundColor = self.view.backgroundColor;
    _table.delegate = self;
    _table.dataSource = self;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.mj_header= [GZQGifHeader headerWithRefreshingBlock:^{
        _page =@"1";
        [self postWithpage:_page];
    }];
    _table.mj_footer = [GZQGifFooter footerWithRefreshingBlock:^{
        NSInteger i = [_page integerValue];
        i++;
        [self postWithpage:[NSString stringWithFormat:@"%ld",(long)i]];
    }];
    
    [self.view addSubview:_table];
}

@end
