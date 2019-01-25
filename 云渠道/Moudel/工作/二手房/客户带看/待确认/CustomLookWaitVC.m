//
//  CustomLookWaitVC.m
//  云渠道
//
//  Created by 谷治墙 on 2019/1/8.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "CustomLookWaitVC.h"

#import "CustomLookWaitDetailVC.h"

#import "CustomLookWaitCell.h"

@interface CustomLookWaitVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSInteger _page;
    NSMutableArray *_dataArr;
}
@property (nonatomic, strong) UITableView *waitTable;

@end

@implementation CustomLookWaitVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
    [self RequestMethod];
}

- (void)initDataSource{
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(RequestMethod) name:@"SystemWork" object:nil];
    _page = 1;
    _dataArr = [@[] mutableCopy];
}

- (void)RequestMethod{
    
    _page = 1;
    _waitTable.mj_footer.state = MJRefreshStateIdle;
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"page":@(_page),@"type":@"1"}];
    if (![self isEmpty:self.search]) {
        
        [dic setObject:self.search forKey:@"search"];
    }
    [BaseRequest GET:RecommendButterWaitList_URL parameters:dic success:^(id resposeObject) {

        [_waitTable.mj_header endRefreshing];
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {

            [_dataArr removeAllObjects];
            if ([resposeObject[@"data"] count]) {

                [self SetData:resposeObject[@"data"]];
            }else{

                _waitTable.mj_footer.state = MJRefreshStateNoMoreData;
            }
            [_waitTable reloadData];
        }else{

            _page -= 1;
            [self showContent:resposeObject[@"msg"]];
        }
        [_waitTable reloadData];
    } failure:^(NSError *error) {

        [_waitTable.mj_header endRefreshing];
        NSLog(@"%@",error);
        [self showContent:@"网络错误"];
    }];
}

- (void)RequestAddMethod{
    
    _page += 1;
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"page":@(_page),@"type":@"1"}];
    if (![self isEmpty:self.search]) {
        
        [dic setObject:self.search forKey:@"search"];
    }
    [BaseRequest GET:RecommendButterWaitList_URL parameters:dic success:^(id resposeObject) {

        NSLog(@"%@",resposeObject);

        if ([resposeObject[@"code"] integerValue] == 200) {

            if ([resposeObject[@"data"] count]) {

                [_waitTable.mj_footer endRefreshing];
                [self SetData:resposeObject[@"data"]];
            }else{

                _waitTable.mj_footer.state = MJRefreshStateNoMoreData;
            }
            [_waitTable reloadData];
        }else{

            [_waitTable.mj_footer endRefreshing];
            _page -= 1;
            [self showContent:resposeObject[@"msg"]];
        }
        [_waitTable reloadData];
    } failure:^(NSError *error) {

        [_waitTable.mj_footer endRefreshing];
        _page -= 1;
        NSLog(@"%@",error);
        [self showContent:@"网络错误"];
    }];
}

- (void)SetData:(NSArray *)data{
    
    _dataArr = [NSMutableArray arrayWithArray:data];
    for (int i = 0; i < _dataArr.count; i++) {
        
        NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:_dataArr[i]];
        [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            
            if ([obj isKindOfClass:[NSNull class]]) {
                
                [tempDic setObject:@"" forKey:key];
            }
        }];
        
        [_dataArr replaceObjectAtIndex:i withObject:tempDic];
    }
    
    [_waitTable reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CustomLookWaitCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomLookWaitCell"];
    if (!cell) {
        
        cell = [[CustomLookWaitCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CustomLookWaitCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.comfirmBtn.tag = indexPath.row;
    
    cell.dataDic = _dataArr[indexPath.row];
    cell.customLookWaitCellBlock = ^(NSInteger index) {
      
        
    };
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CustomLookWaitDetailVC *nextVC = [[CustomLookWaitDetailVC alloc] initWithSurveyId:@""];
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (void)initUI{
    
    _waitTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, self.view.bounds.size.height - NAVIGATION_BAR_HEIGHT - 40 *SIZE) style:UITableViewStylePlain];
    
    _waitTable.rowHeight = UITableViewAutomaticDimension;
    _waitTable.estimatedRowHeight = 87 *SIZE;
    _waitTable.backgroundColor = self.view.backgroundColor;
    _waitTable.delegate = self;
    _waitTable.dataSource = self;
    _waitTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_waitTable];
    
    WS(weakSelf);
    _waitTable.mj_header = [GZQGifHeader headerWithRefreshingBlock:^{
        
        [weakSelf RequestMethod];
    }];
    
    _waitTable.mj_footer = [GZQGifFooter footerWithRefreshingBlock:^{
        
        [weakSelf RequestAddMethod];
    }];
}

@end
