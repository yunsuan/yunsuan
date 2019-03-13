//
//  ApplyProjectVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/5/15.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "ApplyProjectVC.h"
//#import "PeopleCell.h"
#import "ApplyProjectCell.h"
//#import "RoomListModel.h"
#import "MyAttentionModel.h"

@interface ApplyProjectVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSString *_companyId;
    NSMutableArray *_dataArr;
    NSInteger _page;
    NSMutableArray *_selectArr;
    NSString *_projectId;
    NSString *_projectName;
}

@property (nonatomic , strong) UITableView *MainTableView;

@property (nonatomic, strong) UIButton *confirmBtn;

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
    _selectArr = [@[] mutableCopy];
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
    NSMutableDictionary *dic =[@{@"company_id":_companyId,
                                @"page":[NSString stringWithFormat:@"%ld",_page]
                                } mutableCopy];
    
    
    
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
        
        [_selectArr addObject:@(0)];
        [_dataArr addObject:model];
    }
    
    [_MainTableView reloadData];
}


- (void)ActionConfirmBtn:(UIButton *)btn{
    
    if (self.applyProjectVCBlock) {
        
//        RoomListModel *model = _dataArr[indexPath.row];
//        self.applyProjectVCBlock(model.project_id, model.project_name);
        for (int i = 0; i < _selectArr.count; i++) {
            
            if ([_selectArr[i] integerValue] == 1) {
                
                RoomListModel *model = _dataArr[i];
                if (!_projectId.length) {
                    
                    _projectId = [NSString stringWithFormat:@"%@",model.project_id];
                    _projectName = [NSString stringWithFormat:@"%@",model.project_name];
                }else{
                    
                    _projectId = [NSString stringWithFormat:@"%@,%@",_projectId,model.project_id];
                    _projectName = [NSString stringWithFormat:@"%@,%@",_projectName,model.project_name];
                }
            }
        }
        if (_projectId.length) {
            
            
            self.applyProjectVCBlock(_projectId, _projectName);
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            
            [self alertControllerWithNsstring:@"温馨提示" And:@"请选择项目"];
        }
    }

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
    
    
    static NSString *CellIdentifier = @"ApplyProjectCell";
    
    ApplyProjectCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[ApplyProjectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    MyAttentionModel *model = _dataArr[indexPath.row];
    [cell SetTitle:model.project_name image:model.img_url contentlab:model.absolute_address statu:model.sale_state];
    
    if ([_selectArr[indexPath.row] integerValue] == 1) {
        
        cell.selectImg.image = [UIImage imageNamed:@"selected"];
    }else{
        
        cell.selectImg.image = [UIImage imageNamed:@"default"];
    }
    
    NSArray *tempArr1 = @[model.property_tags,model.project_tags_name];
    [cell settagviewWithdata:tempArr1];
    cell.getLevel.hidden = YES;
    cell.statusImg.hidden = YES;
    cell.surelab.hidden = YES;
    
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
    
    if ([_selectArr[indexPath.row] integerValue] == 1) {
        
        [_selectArr replaceObjectAtIndex:indexPath.row withObject:@(0)];
    }else{
        
        [_selectArr replaceObjectAtIndex:indexPath.row withObject:@(1)];
    }
    
    [tableView reloadData];
}

-(void)initUI
{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"选择项目";
    
    
    [self.view addSubview:self.MainTableView];
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirmBtn.frame = CGRectMake(0, SCREEN_Height - 47 *SIZE - TAB_BAR_MORE, SCREEN_Width, 47 *SIZE + TAB_BAR_MORE);
    _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_confirmBtn addTarget:self action:@selector(ActionConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [_confirmBtn setBackgroundColor:YJBlueBtnColor];
    [self.view addSubview:_confirmBtn];
}

#pragma mark  ---  懒加载   ---
-(UITableView *)MainTableView
{
    if(!_MainTableView)
    {
        _MainTableView =   [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, 360*SIZE, SCREEN_Height - NAVIGATION_BAR_HEIGHT - TAB_BAR_MORE - 47 *SIZE) style:UITableViewStylePlain];
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
