//
//  SystemWorkConfrimVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/10/25.
//  Copyright © 2018 xiaoq. All rights reserved.
//

#import "SystemWorkConfrimVC.h"

#import "RoomValidApplyVC.h"
#import "RoomInvalidApplyVC.h"

#import "SystemWorkConfirmDetailVC.h"

#import "SystemWorkConfirmTableCell.h"

@interface SystemWorkConfrimVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSInteger _page;
    NSMutableArray *_dataArr;
}
@property (nonatomic, strong) UITableView *waitTable;

@end

@implementation SystemWorkConfrimVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
    [self RequestMethod];
}

- (void)initDataSource{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(RequestMethod) name:@"SystemWork" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(RequestMethod) name:@"RoomSurveying" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(RequestMethod) name:@"SurveyInvlid" object:nil];
    _page = 1;
    _dataArr = [@[] mutableCopy];
}

- (void)RequestMethod{
    
    _page = 1;
    _waitTable.mj_footer.state = MJRefreshStateIdle;
    [BaseRequest GET:HousePushConfirmList_URL parameters:@{@"page":@(_page)} success:^(id resposeObject) {
        
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
    [BaseRequest GET:HousePushConfirmList_URL parameters:@{@"page":@(_page)} success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if ([resposeObject[@"data"] count]) {
                
                [_waitTable.mj_footer endRefreshing];
                [self SetData:resposeObject[@"data"]];
            }else{
                
                _waitTable.mj_footer.state = MJRefreshStateNoMoreData;
            }
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
    
    SystemWorkConfirmTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SystemWorkConfirmTableCell"];
    if (!cell) {
        
        cell = [[SystemWorkConfirmTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SystemWorkConfirmTableCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.tag = indexPath.row;
    
    cell.dataDic = _dataArr[indexPath.row];
    
    
    cell.systemWorkConfirmConfirmBlock = ^(NSInteger index) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认房源" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        UIAlertAction *valid = [UIAlertAction actionWithTitle:@"房源有效" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            RoomValidApplyVC *nextVC = [[RoomValidApplyVC alloc] initWithData:_dataArr[index] SurveyId:_dataArr[index][@"survey_id"]];
            nextVC.roomValidApplyVCBlock = ^{
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"RoomSurveying" object:nil];
                [self RequestMethod];
            };
            [self.navigationController pushViewController:nextVC animated:YES];
        }];
        
        UIAlertAction *invalid = [UIAlertAction actionWithTitle:@"房源无效" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            RoomInvalidApplyVC *nextVC = [[RoomInvalidApplyVC alloc] initWithData:_dataArr[index] SurveyId:_dataArr[index][@"survey_id"]];
            nextVC.roomInvalidApplyVCBlock = ^{
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"SurveyInvlid" object:nil];
                [self RequestMethod];
            };
            [self.navigationController pushViewController:nextVC animated:YES];
        }];
        
        [alert addAction:valid];
        [alert addAction:invalid];
        [alert addAction:cancel];
        [self.navigationController presentViewController:alert animated:YES completion:^{
            
        }];
    };
    
    return cell;
}

//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    return YES;
//}
//
//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    return UITableViewCellEditingStyleDelete;
//}
//
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    [self alertControllerWithNsstring:@"温馨提示" And:@"你确定要拒绝派单吗？" WithCancelBlack:^{
//
//        [BaseRequest POST:HouseRecordPushRefuse_URL parameters:@{@"push_id":_dataArr[indexPath.row][@"push_id"],@"type":_dataArr[indexPath.row][@"type"]} success:^(id resposeObject) {
//
//            if ([resposeObject[@"code"] integerValue] == 200) {
//
//
//            }else{
//
//                [self showContent:resposeObject[@"msg"]];
//            }
//        } failure:^(NSError *error) {
//
//            [self showContent:@"网络错误"];
//        }];
//    } WithDefaultBlack:^{
//
//    }];
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SystemWorkConfirmDetailVC *nextVC = [[SystemWorkConfirmDetailVC alloc] initWithSurveyId:_dataArr[indexPath.row][@"survey_id"]];
    nextVC.systemWorkConfirmDetailVCBlock = ^{
        
        [self RequestMethod];
    };
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
