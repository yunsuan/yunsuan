//
//  AreaCustomListVC.m
//  云渠道
//
//  Created by 谷治墙 on 2019/12/2.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "AreaCustomListVC.h"

#import "AddAreaCustomVC.h"
#import "AreaCustomDetailVC.h"

#import "AreaCustomListCell.h"

@interface AreaCustomListVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableArray *_dataArr;
    NSInteger _page;
//    NSString *_type;
//    NSString *_district;
//    NSString *_sortType;
//    NSString *_asc;
//    NSArray *_propertyArr;
}

@property (nonatomic, strong) UITableView *table;
@end

@implementation AreaCustomListVC

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
    
    _table.mj_footer.state = MJRefreshStateIdle;
    NSMutableDictionary *dic = [@{} mutableCopy];
    
    [BaseRequest GET:ClientOtherButList_URL parameters:dic success:^(id resposeObject) {
        
        //        NSLog(@"%@",resposeObject);
        [_table.mj_header endRefreshing];
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [_dataArr removeAllObjects];
            if ([resposeObject[@"data"][@"data"] count]) {
                
                [self SetData:resposeObject[@"data"][@"data"]];
                if (_page == [resposeObject[@"data"][@"last_page"] integerValue]) {
                    
                    _table.mj_footer.state = MJRefreshStateNoMoreData;
                }else{
                    
                    [_table.mj_footer endRefreshing];
                }
            }else{
                
                _table.mj_footer.state = MJRefreshStateNoMoreData;
            }
        }else{
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [_table.mj_header endRefreshing];
        [self showContent:@"网络错误"];
    }];
}

- (void)RequestAddMethod{
    
    _page += 1;
    NSDictionary *tempDic = @{@"page":@(_page)};
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:tempDic];
    
    [BaseRequest GET:ListClient_URL parameters:dic success:^(id resposeObject) {

        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [self SetData:resposeObject[@"data"][@"data"]];
            if (_page == [resposeObject[@"data"][@"last_page"] integerValue]) {
                
                _table.mj_footer.state = MJRefreshStateNoMoreData;
            }else{
                
                [_table.mj_footer endRefreshing];
            }
        }else{
            [self showContent:resposeObject[@"msg"]];
            
            [_table.mj_footer endRefreshing];
        }
    } failure:^(NSError *error) {
        
        [_table.mj_footer endRefreshing];
        [self showContent:@"网络错误"];
    }];
}

- (void)SetData:(NSArray *)data{
    
    if (_page == 1) {
        
        [_dataArr removeAllObjects];
    }
    for (int i = 0; i < data.count; i++) {
        
        NSMutableDictionary *tempDic;
        tempDic = [[NSMutableDictionary alloc] initWithDictionary:data[(NSUInteger) i]];
//        [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
//
//            if ([key isEqualToString:@"region"]) {
//
//                if (![obj isKindOfClass:[NSArray class]]) {
//
//                    tempDic[@"region"] = @[];
//                }
//            }
//
//            if ([obj isKindOfClass:[NSNull class]]) {
//
//                if ([key isEqualToString:@"region"]) {
//
//                    tempDic[@"region"] = @[];
//                }else{
//
//                    tempDic[key] = @"";
//                }
//            }
//        }];
        
        [_dataArr addObject:tempDic];
//        CustomerTableModel *model = [[CustomerTableModel alloc] initWithDictionary:tempDic];
//
//        [_dataArr addObject:model];
    }
    [_table reloadData];
}



-(void)action_add
{
    AddAreaCustomVC *next_vc = [[AddAreaCustomVC alloc]init];
//    next_vc.isSelect = self.isSelect;
//    next_vc.status = self.status + 1;
    [self.navigationController pushViewController:next_vc animated:YES];
}

#pragma mark -- TableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    return 110 *SIZE;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *Identifier = @"AreaCustomListCell";
    AreaCustomListCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (!cell) {
        
        cell = [[AreaCustomListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.dataDic = _dataArr[indexPath.row];
//    CustomerTableModel *model = _dataArr[(NSUInteger) indexPath.row];
//    cell.customerTableCellPhoneTapBlock = ^(NSString *phone) {
//
//        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phone]];
//        //调用系统方法拨号
//        [[UIApplication sharedApplication] openURL:url];
//    };
//    cell.model = model;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AreaCustomDetailVC *nextVC = [[AreaCustomDetailVC alloc] initWithRecommendId:_dataArr[indexPath.row][@"recommend_id"]];
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (void)initUI{
    
    self.titleLabel.text = @"异地客源";
    self.navBackgroundView.hidden = NO;
//    self.leftButton.hidden = YES;
    self.view.backgroundColor = YJBackColor;
//    if (self.isSelect) {
//
//        self.rightBtn.hidden = YES;
//    }else{
//
        self.rightBtn.hidden = NO;
//    }
    
    [self.rightBtn setImage:[UIImage imageNamed:@"add_3"] forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(action_add) forControlEvents:UIControlEventTouchUpInside];
    
    self.line.hidden = YES;
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 110 *SIZE;
    
    _table.backgroundColor = YJBackColor;
    _table.delegate = self;
    _table.dataSource = self;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_table];
    _table.mj_header = [GZQGifHeader headerWithRefreshingBlock:^{
        
        _page = 1;
        [self RequestMethod];
    }];
    
    _table.mj_footer = [GZQGifFooter footerWithRefreshingBlock:^{
        
        [self RequestAddMethod];
    }];
}

@end
