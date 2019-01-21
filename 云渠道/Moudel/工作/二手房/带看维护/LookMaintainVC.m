//
//  LookMaintainVC.m
//  云渠道
//
//  Created by 谷治墙 on 2019/1/10.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "LookMaintainVC.h"

#import "CustomLookConfirmCell.h"

@interface LookMaintainVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    
    NSInteger _page;
    NSMutableArray *_dataArr;
}
@property (nonatomic, strong) UITextField *searchBar;

@property (nonatomic, strong) UITableView *waitTable;

@end

@implementation LookMaintainVC

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
    //    [BaseRequest GET:HousePushWaitList_URL parameters:@{@"page":@(_page)} success:^(id resposeObject) {
    //
    //        [_waitTable.mj_header endRefreshing];
    //        NSLog(@"%@",resposeObject);
    //        if ([resposeObject[@"code"] integerValue] == 200) {
    //
    //            [_dataArr removeAllObjects];
    //            if ([resposeObject[@"data"] count]) {
    //
    //                [self SetData:resposeObject[@"data"]];
    //            }else{
    //
    //                _waitTable.mj_footer.state = MJRefreshStateNoMoreData;
    //            }
    //            [_waitTable reloadData];
    //        }else{
    //
    //            _page -= 1;
    //            [self showContent:resposeObject[@"msg"]];
    //        }
    //        [_waitTable reloadData];
    //    } failure:^(NSError *error) {
    //
    //        [_waitTable.mj_header endRefreshing];
    //        NSLog(@"%@",error);
    //        [self showContent:@"网络错误"];
    //    }];
}

- (void)RequestAddMethod{
    
    _page += 1;
    //    [BaseRequest GET:HousePushConfirmList_URL parameters:@{@"page":@(_page)} success:^(id resposeObject) {
    //
    //        NSLog(@"%@",resposeObject);
    //
    //        if ([resposeObject[@"code"] integerValue] == 200) {
    //
    //            if ([resposeObject[@"data"] count]) {
    //
    //                [_waitTable.mj_footer endRefreshing];
    //                [self SetData:resposeObject[@"data"]];
    //            }else{
    //
    //                _waitTable.mj_footer.state = MJRefreshStateNoMoreData;
    //            }
    //            [_waitTable reloadData];
    //        }else{
    //
    //            [_waitTable.mj_footer endRefreshing];
    //            _page -= 1;
    //            [self showContent:resposeObject[@"msg"]];
    //        }
    //        [_waitTable reloadData];
    //    } failure:^(NSError *error) {
    //
    //        [_waitTable.mj_footer endRefreshing];
    //        _page -= 1;
    //        NSLog(@"%@",error);
    //        [self showContent:@"网络错误"];
    //    }];
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
    
    CustomLookConfirmCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomLookConfirmCell"];
    if (!cell) {
        
        cell = [[CustomLookConfirmCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CustomLookConfirmCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.tag = indexPath.row;
    
    cell.dataDic = _dataArr[indexPath.row];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //    ReportWaitDetailVC *nextVC = [[ReportWaitDetailVC alloc] initWithRecordId:_dataArr[indexPath.row][@"record_id"]];
    //    [self.navigationController pushViewController:nextVC animated:YES];
    //    SystemWorkWaitDetailVC *nextVC = [[SystemWorkWaitDetailVC alloc] initWithPushId:_dataArr[indexPath.row][@"push_id"] type:_dataArr[indexPath.row][@"type"]];
    //    [self.navigationController pushViewController:nextVC animated:YES];
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"带看维护";
    
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, 40 *SIZE)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiteView];
    
    _searchBar = [[UITextField alloc] initWithFrame:CGRectMake(10 *SIZE, 3 *SIZE, 340 *SIZE, 33 *SIZE)];
    _searchBar.backgroundColor = YJBackColor;
    _searchBar.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 11 *SIZE, 0)];
    //设置显示模式为永远显示(默认不显示)
    _searchBar.leftViewMode = UITextFieldViewModeAlways;
    _searchBar.placeholder = @"输入电话/姓名";
    _searchBar.font = [UIFont systemFontOfSize:12 *SIZE];
    _searchBar.layer.cornerRadius = 2 *SIZE;
    _searchBar.delegate = self;
    _searchBar.returnKeyType = UIReturnKeySearch;
    
    UIImageView *rightImg = [[UIImageView alloc] initWithFrame:CGRectMake(0 *SIZE, 8 *SIZE, 17 *SIZE, 17 *SIZE)];
    //    rightImg.backgroundColor = [UIColor whiteColor];
    rightImg.image = [UIImage imageNamed:@"search"];
    _searchBar.rightView = rightImg;
    _searchBar.rightViewMode = UITextFieldViewModeUnlessEditing;
    _searchBar.clearButtonMode = UITextFieldViewModeWhileEditing;
    _searchBar.delegate = self;
    [whiteView addSubview:_searchBar];
    
//    self.rightBtn.hidden = NO;
//    [self.rightBtn setImage:[UIImage imageNamed:@"add_3"] forState:UIControlStateNormal];
//    [self.rightBtn addTarget:self action:@selector(ActionAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    _waitTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT + 40 *SIZE, SCREEN_Width, self.view.bounds.size.height - NAVIGATION_BAR_HEIGHT - 40 *SIZE) style:UITableViewStylePlain];
    
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
