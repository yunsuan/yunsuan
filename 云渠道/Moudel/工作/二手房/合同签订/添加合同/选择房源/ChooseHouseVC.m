//
//  ChooseHouseVC.m
//  云渠道
//
//  Created by xiaoq on 2019/1/22.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "ChooseHouseVC.h"
#import "ChooseHouseCell.h"

@interface ChooseHouseVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    
    NSMutableArray *_dataArr;
    NSString *_search;
    NSInteger _page;
}

@property (nonatomic, strong) UITextField *searchBar;

@property (nonatomic, strong) UITableView *table;

@end

@implementation ChooseHouseVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
    [self RequestMethod];
}

- (void)initDataSource{
    
    _dataArr = [@[] mutableCopy];
    _search = @"";
}

- (void)RequestMethod{
    
    _table.mj_footer.state = MJRefreshStateIdle;
    _page = 1;
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"page":@(_page),@"type":@"1"}];
    if (![self isEmpty:_search]) {
        
        [dic setObject:_search forKey:@"search"];
    }
    [BaseRequest GET:TakeHouseList_URL parameters:dic success:^(id resposeObject) {
        
        [_table.mj_header endRefreshing];
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [_dataArr removeAllObjects];
            _dataArr =[NSMutableArray arrayWithArray:resposeObject[@"data"][@"data"]]
            ;
            if ([resposeObject[@"data"][@"last_page"] integerValue]==1) {
                _table.mj_footer.state = MJRefreshStateNoMoreData;
            }
            [_table reloadData];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [_table.mj_header endRefreshing];
        [self showContent:@"网络错误"];
        NSLog(@"%@",error);
    }];
}

- (void)RequestAddMethod{
    
    _page += 1;
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"page":@(_page),@"type":@"1"}];
    if (![self isEmpty:_search]) {
        
        [dic setObject:_search forKey:@"search"];
    }
    [BaseRequest GET:TakeHouseList_URL parameters:dic success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            NSArray *arr=resposeObject[@"data"][@"data"];
            [_dataArr addObjectsFromArray:arr];
            [_table reloadData];
            if ([resposeObject[@"data"][@"data"] count]) {
                
                [_table.mj_footer endRefreshing];
//                [self SetData:resposeObject[@"data"][@"data"]];
            }else{
                
                _table.mj_footer.state = MJRefreshStateNoMoreData;
            }
        }else{
            
            [_table.mj_footer endRefreshing];
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [_table.mj_footer endRefreshing];
        [self showContent:@"网络错误"];
        NSLog(@"%@",error);
    }];
}





- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    _search = textField.text;
    [self RequestMethod];
    return YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ChooseHouseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChooseHouseCell"];
    if (!cell) {
        
        cell = [[ChooseHouseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ChooseHouseCell"];
    }
    [cell setdatabydata:_dataArr[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
    
    [self.navigationController popViewControllerAnimated:YES];
    if (self.ChooseHouseblock != nil) {
        self.ChooseHouseblock(_dataArr[indexPath.row]);
    }
    
  
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90*SIZE;
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"勘察维护";
    
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, 40 *SIZE)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiteView];
    
    _searchBar = [[UITextField alloc] initWithFrame:CGRectMake(10 *SIZE, 3 *SIZE, 340 *SIZE, 33 *SIZE)];
    _searchBar.backgroundColor = YJBackColor;
    _searchBar.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 11 *SIZE, 0)];
    //设置显示模式为永远显示(默认不显示)
    _searchBar.leftViewMode = UITextFieldViewModeAlways;
    _searchBar.placeholder = @"输入房源编号/小区名称";
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
    

    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT + 40 *SIZE, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - 40 *SIZE) style:UITableViewStylePlain];
    _table.estimatedRowHeight = 108 *SIZE;
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.backgroundColor = self.view.backgroundColor;
    _table.delegate = self;
    _table.dataSource = self;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_table];
    _table.mj_header = [GZQGifHeader headerWithRefreshingBlock:^{
        
        [self RequestMethod];
    }];
    _table.mj_footer = [GZQGifFooter footerWithRefreshingBlock:^{
        [self RequestAddMethod];
    }];
}

@end


