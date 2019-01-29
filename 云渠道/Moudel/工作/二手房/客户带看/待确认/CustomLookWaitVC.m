//
//  CustomLookWaitVC.m
//  云渠道
//
//  Created by 谷治墙 on 2019/1/8.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "CustomLookWaitVC.h"

#import "CustomLookWaitDetailVC.h"
#import "CustomLookConfirmFailVC.h"

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
    
    if (data.count < 15) {
        
        _waitTable.mj_footer.state = MJRefreshStateNoMoreData;
    }
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
      
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认客源" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        UIAlertAction *valid = [UIAlertAction actionWithTitle:@"客源有效" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            //            RoomValidApplyVC *nextVC = [[RoomValidApplyVC alloc] initWithData:_dataArr[index] SurveyId:_dataArr[index][@"survey_id"]];
            //            nextVC.roomValidApplyVCBlock = ^{
            //
            //                [[NSNotificationCenter defaultCenter] postNotificationName:@"RoomSurveying" object:nil];
            //                [self RequestMethod];
            //            };
            //            [self.navigationController pushViewController:nextVC animated:YES];
        }];
        
        UIAlertAction *invalid = [UIAlertAction actionWithTitle:@"客源无效" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            CustomLookConfirmFailVC *nextVC = [[CustomLookConfirmFailVC alloc] initWithData:_dataArr[index]];
            nextVC.customLookConfirmFailVCBlock = ^{
            
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


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CustomLookWaitDetailVC *nextVC = [[CustomLookWaitDetailVC alloc] initWithTakeId:_dataArr[indexPath.row][@"take_id"]];
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
