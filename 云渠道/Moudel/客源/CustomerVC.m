//
//  CustomerVC.m
//  云渠道
//
//  Created by xiaoq on 2018/3/13.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "CustomerVC.h"

#import "CustomerListVC.h"
#import "AreaCustomListVC.h"

#import "WorkingCell.h"

@interface CustomerVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSArray *_titleArr;
    NSArray *_imgArr;
    NSArray *_dataArr;
}

@property (nonatomic, strong) UITableView *table;

@end

@implementation CustomerVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
    [self RequestMethod];
}

- (void)initDataSource{
    
    _titleArr = @[@"新房客户",@"二手房客户",@"租房客户",@"异地客户"];
    _imgArr = @[@"新房",@"二手房",@"租房",@"租房"];
    _dataArr = @[@"",@"",@"",@"租房"];
}

- (void)RequestMethod{
    
    [BaseRequest GET:ClientList_URL parameters:nil success:^(id resposeObject) {
        
        [_table.mj_header endRefreshing];
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            _dataArr = @[[NSString stringWithFormat:@"今日新增%@人 累计%@人",resposeObject[@"data"][@"project"][@"today"],resposeObject[@"data"][@"project"][@"total"]],[NSString stringWithFormat:@"今日新增%@人 累计%@人",resposeObject[@"data"][@"house"][@"today"],resposeObject[@"data"][@"house"][@"total"]],[NSString stringWithFormat:@"今日新增%@人 累计%@人",resposeObject[@"data"][@"rent"][@"today"],resposeObject[@"data"][@"rent"][@"total"]],[NSString stringWithFormat:@"今日新增%@人 累计%@人",resposeObject[@"data"][@"rent"][@"today"],resposeObject[@"data"][@"rent"][@"total"]]];
            [_table reloadData];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
       
        [_table.mj_header endRefreshing];
        [self showContent:@"网络错误"];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 84*SIZE;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"WorkingCell";
    
    WorkingCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[WorkingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell setTitle:_titleArr[indexPath.row] content:_dataArr[indexPath.row] img:_imgArr[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row < 3) {
        
        CustomerListVC *nextVC = [[CustomerListVC alloc] init];
        nextVC.hidesBottomBarWhenPushed = YES;
        nextVC.status = indexPath.row;
        [self.navigationController pushViewController:nextVC animated:YES];
    }else{
        
        AreaCustomListVC *nextVC = [[AreaCustomListVC alloc] init];
        [self.navigationController pushViewController:nextVC animated:YES];
    }
    
//    if (indexPath.row == 1) {
//        StoreListVC *nextVC = [[StoreListVC alloc] init];
//        nextVC.type = @"1";
//        [self.navigationController pushViewController:nextVC animated:YES];
//    }
//    else{
//    CustomerListVC *nextVC = [[CustomerListVC alloc] init];
//    nextVC.hidesBottomBarWhenPushed = YES;
//    nextVC.status = indexPath.row;
//    [self.navigationController pushViewController:nextVC animated:YES];
//    }
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"客源";
    self.leftButton.hidden = YES;
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    _table.backgroundColor = self.view.backgroundColor;
    _table.delegate = self;
    _table.dataSource = self;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_table];
    _table.mj_header = [GZQGifHeader headerWithRefreshingBlock:^{
        
        [self RequestMethod];
    }];
    
}


@end
