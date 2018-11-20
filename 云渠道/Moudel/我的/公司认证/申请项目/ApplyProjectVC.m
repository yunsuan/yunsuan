//
//  ApplyProjectVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/5/15.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "ApplyProjectVC.h"
#import "PeopleCell.h"
//#import "RoomListModel.h"
#import "MyAttentionModel.h"

@interface ApplyProjectVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSString *_companyId;
    NSMutableArray *_dataArr;
    NSInteger _page;
}

@property (nonatomic , strong) UITableView *MainTableView;

@end

@implementation ApplyProjectVC

- (instancetype)initWithCompanyId:(NSString *)companyId
{
    self = [super init];
    if (self) {
        
        _companyId = companyId;
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = YJBackColor;
    self.navBackgroundView.hidden = NO;
    [self initDateSouce];
    [self initUI];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)initDateSouce
{
    
    _page = 1;
    _dataArr = [@[] mutableCopy];
    [self RequestMethod];
}



- (void)RequestMethod{

    self.MainTableView.mj_footer.state = MJRefreshStateIdle;
    NSDictionary *dic = @{@"company_id":_companyId};

    [BaseRequest GET:GetCompanyProject_URL parameters:dic success:^(id resposeObject) {

        [self.MainTableView.mj_header endRefreshing];
//        NSLog(@"%@",resposeObject);
       
        if ([resposeObject[@"code"] integerValue] == 200) {

            [_dataArr removeAllObjects];
            [self SetData:resposeObject[@"data"][@"data"]];
            if (_page >= [resposeObject[@"data"][@"last_page"] integerValue]) {
                
                self.MainTableView.mj_footer.state = MJRefreshStateNoMoreData;
            }
        }else{
            
            [self showContent:resposeObject[@"msg"]];
            self.MainTableView.mj_footer.state = MJRefreshStateNoMoreData;
        }
    } failure:^(NSError *error) {

        [self.MainTableView.mj_header endRefreshing];
        [self showContent:@"网络错误"];
//        NSLog(@"%@",error.localizedDescription);
    }];

}

- (void)RequestAddMethod{

    _page += 1;
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"page":@(_page)}];

    [BaseRequest GET:GetCompanyProject_URL parameters:dic success:^(id resposeObject) {
        
        
//        NSLog(@"%@",resposeObject);
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [self SetData:resposeObject[@"data"][@"data"]];
            if (_page >= [resposeObject[@"data"][@"last_page"] integerValue]) {
                
                self.MainTableView.mj_footer.state = MJRefreshStateNoMoreData;
            }
        }else{
            
            [self.MainTableView.mj_footer endRefreshing];
            _page -= 1;
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        _page -= 1;
        [self.MainTableView.mj_footer endRefreshing];
        [self showContent:@"网络错误"];
//        NSLog(@"%@",error.localizedDescription);
    }];

}


- (void)SetData:(NSArray *)data{

    for (int i = 0; i < data.count; i++) {

        NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:data[i]];
        [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {

            if ([obj isKindOfClass:[NSNull class]]) {

                [tempDic setObject:@"" forKey:key];
            }
            
        }];

       MyAttentionModel *model = [[MyAttentionModel alloc] initWithDictionary:tempDic];

        [_dataArr addObject:model];
    }

    [_MainTableView reloadData];
}


#pragma mark  ---  delegate   ---

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120*SIZE;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *CellIdentifier = @"PeopleCell";
    
    PeopleCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[PeopleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    MyAttentionModel *model = _dataArr[indexPath.row];
    [cell SetTitle:model.project_name image:model.img_url contentlab:model.absolute_address statu:model.sale_state];
    
    NSArray *tempArr1 = @[model.property_tags,model.project_tags_name];
    [cell settagviewWithdata:tempArr1];
    cell.getLevel.hidden = YES;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
    //    if (indexPath.row == 1) {
    //        static NSString *CellIdentifier = @"CompanyCell";
    //
    //        CompanyCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //        if (!cell) {
    //            cell = [[CompanyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    //        }
    //        //    [cell setTitle:_namelist[indexPath.row] content:@"123" img:@""];
    //        [cell SetTitle:@"新希望国际" image:@"" contentlab:@"高新区——天府三街" statu:@"在售"];
    //        [cell settagviewWithdata:_arr[indexPath.row]];
    //        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //        return cell;
    //    }else
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.applyProjectVCBlock) {
        
        RoomListModel *model = _dataArr[indexPath.row];
        self.applyProjectVCBlock(model.project_id, model.project_name);
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)initUI
{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"选择项目";
    
    [self.view addSubview:self.MainTableView];
}

#pragma mark  ---  懒加载   ---
-(UITableView *)MainTableView
{
    if(!_MainTableView)
    {
        _MainTableView =   [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, 360*SIZE, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
        _MainTableView.backgroundColor = YJBackColor;
        _MainTableView.delegate = self;
        _MainTableView.dataSource = self;
        [_MainTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        _MainTableView.mj_header = [GZQGifHeader headerWithRefreshingBlock:^{
            
            _page = 1;
            [self RequestMethod];
        }];
        
        _MainTableView.mj_footer = [GZQGifFooter footerWithRefreshingBlock:^{
            
            [self RequestAddMethod];
        }];
    }
    return _MainTableView;
}


@end
