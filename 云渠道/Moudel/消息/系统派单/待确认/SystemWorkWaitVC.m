//
//  SystemWorkWaitVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/10/24.
//  Copyright © 2018 xiaoq. All rights reserved.
//

#import "SystemWorkWaitVC.h"
#import "SystemWorkConfirmDetailVC.h"
#import "SystemWorkWaitDetailVC.h"

#import "SystemWorkWaitTableCell.h"

@interface SystemWorkWaitVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSInteger _page;
    NSMutableArray *_dataArr;
}
@property (nonatomic, strong) UITableView *waitTable;

@end

@implementation SystemWorkWaitVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
    [self RequestMethod];
}

- (void)initDataSource{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(RequestMethod) name:@"SystemWork" object:nil];
    _page = 1;
    _dataArr = [@[] mutableCopy];
}

- (void)RequestMethod{
    
    _page = 1;
    _waitTable.mj_footer.state = MJRefreshStateIdle;
    [BaseRequest GET:HousePushWaitList_URL parameters:@{@"page":@(_page)} success:^(id resposeObject) {
        
        [_waitTable.mj_header endRefreshing];
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [_dataArr removeAllObjects];
            [_waitTable reloadData];
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
    [BaseRequest GET:HousePushConfirmList_URL parameters:@{@"page":@(_page)} success:^(id resposeObject) {
        
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
    
//    return 1;
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SystemWorkWaitTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SystemWorkWaitTableCell"];
    if (!cell) {
        
        cell = [[SystemWorkWaitTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SystemWorkWaitTableCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.tag = indexPath.row;
    
    cell.dataDic = _dataArr[indexPath.row];
    
    
    cell.systemWorkWaitConfirmBlock = ^(NSInteger index) {

        [self alertControllerWithNsstring:@"温馨提示" And:@"确认抢单" WithCancelBlack:^{
           
            
        } WithDefaultBlack:^{
            
            [BaseRequest POST:HouseRecordPushAccept_URL parameters:@{@"push_id":_dataArr[index][@"push_id"],@"type":_dataArr[index][@"type"]} success:^(id resposeObject) {
                
                if ([resposeObject[@"code"] integerValue] == 200) {
                    
                    [self alertControllerWithNsstring:@"接单成功" And:@"" WithDefaultBlack:^{
                        
                        [self RequestMethod];
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"SystemWork" object:nil];
                        SystemWorkConfirmDetailVC *nextVC = [[SystemWorkConfirmDetailVC alloc] initWithSurveyId:[NSString stringWithFormat:@"%@",resposeObject[@"data"][@"survey_id"]] type:resposeObject[@"data"][@"type"]];
                        NSString *str = _dataArr[index][@"type_name"];
                        if ([str containsString:@"参数"]) {
                            
                            str = [str substringWithRange:NSMakeRange(0, str.length - 2)];
                        }
                        nextVC.typeName = str;
                        [self.navigationController pushViewController:nextVC animated:YES];
                    }];
                }else{
                    
                    [self showContent:resposeObject[@"msg"]];
                }
            } failure:^(NSError *error) {
                
                [self showContent:@"网络错误"];
            }];
        }];
    };

    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self alertControllerWithNsstring:@"温馨提示" And:@"你确定要拒绝派单吗？" WithCancelBlack:^{
       
        
    } WithDefaultBlack:^{
        
        [BaseRequest POST:HouseRecordPushRefuse_URL parameters:@{@"push_id":_dataArr[indexPath.row][@"push_id"],@"type":_dataArr[indexPath.row][@"type"]} success:^(id resposeObject) {
            
            if ([resposeObject[@"code"] integerValue] == 200) {
                
//                [_dataArr removeObjectAtIndex:indexPath.row];
                [self RequestMethod];
//                [tableView reloadData];
            }else{
                
                [self showContent:resposeObject[@"msg"]];
            }
        } failure:^(NSError *error) {
            
            [self showContent:@"网络错误"];
        }];
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    ReportWaitDetailVC *nextVC = [[ReportWaitDetailVC alloc] initWithRecordId:_dataArr[indexPath.row][@"record_id"]];
//    [self.navigationController pushViewController:nextVC animated:YES];
    SystemWorkWaitDetailVC *nextVC = [[SystemWorkWaitDetailVC alloc] initWithPushId:_dataArr[indexPath.row][@"push_id"] type:_dataArr[indexPath.row][@"type"]];
    NSString *str = _dataArr[indexPath.row][@"type_name"];
    if ([str containsString:@"参数"]) {
        
        str = [str substringWithRange:NSMakeRange(0, str.length - 2)];
    }
    nextVC.typeName = str;
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
