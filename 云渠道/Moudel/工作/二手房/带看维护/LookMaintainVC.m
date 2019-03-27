//
//  LookMaintainVC.m
//  云渠道
//
//  Created by 谷治墙 on 2019/1/10.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "LookMaintainVC.h"

#import "LookMaintainDetailVC.h"
//#import "CustomerListVC.h"
#import "QuickAddLookMaintainVC.h"

#import "LookMaintainCell.h"

@interface LookMaintainVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    
    NSInteger _page;
    NSMutableArray *_dataArr;
    NSString *_search;
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
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"page":@(_page),@"type":@"1"}];
    
    if (![self isEmpty:_search]) {
        
        [dic setObject:_search forKey:@"search"];
    }
    [BaseRequest GET:TakeMaintainList_URL parameters:dic success:^(id resposeObject) {
    
        [_waitTable.mj_header endRefreshing];
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
    
            [_dataArr removeAllObjects];
            [_waitTable reloadData];
            if ([resposeObject[@"data"][@"data"] count]) {
    
                [self SetData:resposeObject[@"data"][@"data"]];
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
    if (![self isEmpty:_search]) {
        
        [dic setObject:_search forKey:@"search"];
    }
    [BaseRequest GET:TakeMaintainList_URL parameters:dic success:^(id resposeObject) {
    
        NSLog(@"%@",resposeObject);
    
        if ([resposeObject[@"code"] integerValue] == 200) {
    
            if ([resposeObject[@"data"][@"data"] count]) {
    
                [_waitTable.mj_footer endRefreshing];
                [self SetData:resposeObject[@"data"][@"data"]];
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
//    
//    if (data.count < 15) {
//        
//        _waitTable.mj_footer.state = MJRefreshStateNoMoreData;
//    }
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



- (void)ActionAddBtn:(UIButton *)btn{
    
    QuickAddLookMaintainVC *nextVC = [[QuickAddLookMaintainVC alloc] init];
    nextVC.quickAddLookMaintainVCBlock = ^{
      
        [self RequestMethod];
    };
    [self.navigationController pushViewController:nextVC animated:YES];
//    CustomerListVC *nextVC = [[CustomerListVC alloc] init];
//    nextVC.customerListVCBlock = ^{
//
//        [self RequestMethod];
//    };
//    nextVC.hidesBottomBarWhenPushed = YES;
//    nextVC.status = 1;
//    nextVC.isSelect = YES;
//    [self.navigationController pushViewController:nextVC animated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (![self isEmpty:textField.text]) {
        
        _search = textField.text;
        [self RequestMethod];
    }else{
        
        _search = @"";
    }
    return YES;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LookMaintainCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LookMaintainCell"];
    if (!cell) {
        
        cell = [[LookMaintainCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LookMaintainCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.tag = indexPath.row;
    
    cell.dataDic = _dataArr[indexPath.row];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LookMaintainDetailVC *nextVC = [[LookMaintainDetailVC alloc] initWithTakeId:_dataArr[indexPath.row][@"take_id"]];
    nextVC.edit = [NSString stringWithFormat:@"%@",_dataArr[indexPath.row][@"is_edit"]];
    nextVC.lookMaintainDetailVCBlock = ^{
      
        [self RequestMethod];
    };
    [self.navigationController pushViewController:nextVC animated:YES];
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
    
    self.rightBtn.hidden = NO;
    [self.rightBtn setImage:[UIImage imageNamed:@"add_3"] forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(ActionAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    _waitTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT + 41 *SIZE, SCREEN_Width, self.view.bounds.size.height - NAVIGATION_BAR_HEIGHT - 41 *SIZE) style:UITableViewStylePlain];
    
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
