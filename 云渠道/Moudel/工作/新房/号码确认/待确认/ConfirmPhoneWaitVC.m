//
//  ConfirmPhoneWaitVC.m
//  云渠道
//
//  Created by 谷治墙 on 2019/2/22.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "ConfirmPhoneWaitVC.h"

#import "ConfirmPhoneWaitDetailVC.h"

#import "ConfrimPhoneWaitCell.h"

@interface ConfirmPhoneWaitVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *_dataArr;
    NSInteger _page;
}

@property (nonatomic, strong) UITableView *table;

@end

@implementation ConfirmPhoneWaitVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSouce];
    [self initUI];
    [self RequestMethod];
}

-(void)initDataSouce
{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SearchMethod:) name:@"protocolSearch" object:nil];
    _dataArr = [@[] mutableCopy];
    _page = 1;
}

- (void)SearchMethod:(NSNotification *)noti{
    

}

- (void)RequestMethod{
    
    _page = 1;
    _table.mj_footer.state = MJRefreshStateIdle;
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"page":@(_page)}];
    if (![self isEmpty:self.search]) {
        
        [dic setObject:self.search forKey:@"search"];
    }
    [BaseRequest GET:ButterTelConfirmList_URL parameters:dic success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [_dataArr removeAllObjects];
            if ([resposeObject[@"data"] count]) {
                
                [_table.mj_header endRefreshing];
                [self SetData:resposeObject[@"data"]];
                
            }else{
                
                [_table.mj_header endRefreshing];
                _table.mj_footer.state = MJRefreshStateNoMoreData;
            }
        }else{
            
            [_table.mj_header endRefreshing];
            [self showContent:resposeObject[@"msg"]];
        }
        [_table reloadData];
    } failure:^(NSError *error) {
        
        [_table.mj_header endRefreshing];
        NSLog(@"%@",error);
        [self showContent:@"网络错误"];
    }];
}

- (void)RequestAddMethod{
    
    _page += 1;
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"page":@(_page)}];
    if (![self isEmpty:self.search]) {
        
        [dic setObject:self.search forKey:@"search"];
    }
    [BaseRequest GET:ButterTelConfirmList_URL parameters:dic success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [_dataArr removeAllObjects];
            if ([resposeObject[@"data"] count]) {
                
                [_table.mj_footer endRefreshing];
                [self SetData:resposeObject[@"data"]];
                
            }else{
                
                _table.mj_footer.state = MJRefreshStateNoMoreData;
            }
        }else{
            
            _page -= 1;
            [_table.mj_footer endRefreshing];
            [self showContent:resposeObject[@"msg"]];
        }
        [_table reloadData];
    } failure:^(NSError *error) {
        
        _page -= 1;
        [_table.mj_footer endRefreshing];
        NSLog(@"%@",error);
        [self showContent:@"网络错误"];
    }];
}

- (void)SetData:(NSArray *)data{
    
    if (data.count < 15) {
        
        _table.mj_footer.state = MJRefreshStateNoMoreData;
    }
    for (int i = 0; i < data.count; i++) {
        
        NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:data[i]];
        [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            
            if ([obj isKindOfClass:[NSNull class]]) {
                
                [tempDic setObject:@"" forKey:key];
            }else{
                
                [tempDic setObject:[NSString stringWithFormat:@"%@",obj] forKey:key];
            }
        }];
        
        [_dataArr addObject:tempDic];
    }
    
    [_table reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ConfrimPhoneWaitCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ConfrimPhoneWaitCell"];
    if (!cell) {

        cell = [[ConfrimPhoneWaitCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ConfrimPhoneWaitCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.confrimPhoneWaitCellBlock = ^{
      
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认号码" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *unuse = [UIAlertAction actionWithTitle:@"号码可用" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
           
            [BaseRequest GET:ClientTelCheckValue_URL parameters:@{@"client_id":_dataArr[indexPath.row][@"client_id"]} success:^(id resposeObject) {
                
                if ([resposeObject[@"code"] integerValue] == 200) {
                    
                    [_dataArr removeObjectAtIndex:indexPath.row];
                    [tableView reloadData];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"PhoneConfirm" object:nil];
                }else{
                    
                    [self showContent:resposeObject[@"msg"]];
                }
            } failure:^(NSError *error) {
               
                [self showContent:@"网络错误"];
            }];
        }];
        
        UIAlertAction *used = [UIAlertAction actionWithTitle:@"号码重复" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [BaseRequest GET:ClientTelCheckDisabled_URL parameters:@{@"client_id":_dataArr[indexPath.row][@"client_id"]} success:^(id resposeObject) {
                
                if ([resposeObject[@"code"] integerValue] == 200) {
                    
                    [_dataArr removeObjectAtIndex:indexPath.row];
                    [tableView reloadData];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"PhoneConfirm" object:nil];
                }else{
                    
                    [self showContent:resposeObject[@"msg"]];
                }
            } failure:^(NSError *error) {
                
                [self showContent:@"网络错误"];
            }];
        }];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alert addAction:unuse];
        [alert addAction:used];
        [alert addAction:cancel];
        
        [self.navigationController presentViewController:alert animated:YES completion:^{
            
        }];
    };
    
    cell.copyPhoneWaitCellBlock = ^{
     
        [self showContent:@"复制成功!"];
            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
            pasteboard.string = _dataArr[indexPath.row][@"tel"];
    
    };

    cell.dataDic = _dataArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ConfirmPhoneWaitDetailVC *nextVC = [[ConfirmPhoneWaitDetailVC alloc] initWithClientId:_dataArr[indexPath.row][@"client_id"]];
    nextVC.confirmPhoneWaitDetailVCBlock = ^{
      
        [_dataArr removeObjectAtIndex:indexPath.row];
        [tableView reloadData];
    };
    [self.navigationController pushViewController:nextVC animated:YES];
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
        
        _page = 1;
        [self RequestMethod];
    }];
    _table.mj_footer = [GZQGifFooter footerWithRefreshingBlock:^{
        
        _page ++;
        [self RequestAddMethod];
    }];
    [self.view addSubview:_table];
}

@end
