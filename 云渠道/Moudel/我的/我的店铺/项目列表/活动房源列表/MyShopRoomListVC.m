//
//  MyShopRoomListVC.m
//  云渠道
//
//  Created by 谷治墙 on 2020/2/26.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "MyShopRoomListVC.h"

#import "MyShopRoomDetailVC.h"

#import "ActiveRoomListCell.h"

#import "BoxView.h"


@interface MyShopRoomListVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSInteger _page;
    NSInteger _tag;
    
    NSString *_info_id;
    NSString *_project_id;
    
    NSString *_buildStr;
    NSString *_unitStr;
    NSString *_houseStr;
    NSString *_priceStr;
    NSString *_areaStr;
    
    NSMutableArray *_dataArr;
    
    NSArray *_buildA;
    NSMutableArray *_buildArr;
    NSMutableArray *_unitArr;
    NSArray *_houseArr;
    NSArray *_priceArr;
    NSArray *_areaArr;
}

@property (nonatomic, strong) UIButton *buildBtn;

@property (nonatomic, strong) UIButton *unitBtn;

@property (nonatomic, strong) UIButton *houseBtn;

@property (nonatomic, strong) UIButton *priceBtn;

@property (nonatomic, strong) UIButton *areaBtn;

@property (nonatomic, strong) BoxView *boxView;

@property (nonatomic, strong) UITableView *table;

@end

@implementation MyShopRoomListVC

- (instancetype)initWithProjectId:(NSString *)project_id info_id:(NSString *)info_id
{
    self = [super init];
    if (self) {
        
        _info_id = info_id;
        _project_id = project_id;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initDataSource];
    [self initUI];
    [self RequestMethod];
    [self BuildRequest];
}

- (void)initDataSource{
    
    _page = 1;
    _dataArr = [@[] mutableCopy];
    
    _buildArr = [@[] mutableCopy];
    _unitArr = [@[] mutableCopy];
    _houseArr = @[@{@"id":@"0",@"param":@"不限"},@{@"id":@"1",@"param":@"一室"},@{@"id":@"2",@"param":@"二室"},@{@"id":@"3",@"param":@"三室"},@{@"id":@"4",@"param":@"四室"},@{@"id":@"5",@"param":@"五室及以上"}];
    _priceArr = @[@{@"id":@"0",@"param":@"不限"},@{@"id":@"1",@"param":@"升序"},@{@"id":@"2",@"param":@"降序"}];
    _areaArr = @[@{@"id":@"0",@"param":@"不限"},@{@"id":@"1",@"param":@"升序"},@{@"id":@"2",@"param":@"降序"}];
}

- (void)BuildRequest{
    
    [BaseRequest GET:ProjectGetProjectBuildUnitTitle_URL parameters:@{@"info_id":_info_id} success:^(id resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            _buildA = resposeObject[@"data"];
            for (int i = 0; i < _buildA.count; i++) {
                
                [_buildArr addObject:@{@"id":_buildA[i][@"build_id"],@"param":_buildA[i][@"build_name"]}];
            }
            [_buildArr insertObject:@{@"id":@"0",@"param":@"不限"} atIndex:0];
        }else{
            
            
        }
    } failure:^(NSError *error) {
        

    }];
}


- (void)RequestMethod{
    
    self->_table.mj_footer.state = MJRefreshStateIdle;
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"project_id":_project_id,@"page":@"1"}];
    if ([_buildStr integerValue]) {
        
        [dic setValue:_buildStr forKey:@"build_id"];
    }
    if ([_unitStr integerValue]) {
        
        [dic setValue:_unitStr forKey:@"unit_id"];
    }
    if ([_houseStr integerValue]) {
        
        [dic setValue:_houseStr forKey:@"house_type"];
    }
    if ([_priceStr integerValue]) {
        
        [dic setValue:_priceStr forKey:@"price_sort"];
    }
    if ([_areaStr integerValue]) {
        
        [dic setValue:_areaStr forKey:@"size_sort"];
    }
    [BaseRequest GET:ProjectGetHouseList_URL parameters:dic success:^(id resposeObject) {
        
        [self->_table.mj_header endRefreshing];
        [_dataArr removeAllObjects];
        [self->_table reloadData];
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [self SetDataArr:resposeObject[@"data"][@"data"]];
            if (![resposeObject[@"data"][@"data"] count]) {
                
                self->_table.mj_footer.state = MJRefreshStateNoMoreData;
            }
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [self->_table.mj_header endRefreshing];
        [self showContent:@"网络错误"];
    }];
}

- (void)RequestAddMethod{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"project_id":_project_id,@"page":@(_page)}];
    
    if ([_buildStr integerValue]) {
        
        [dic setValue:_buildStr forKey:@"build_id"];
    }
    if ([_unitStr integerValue]) {
        
        [dic setValue:_unitStr forKey:@"unit_id"];
    }
    if ([_houseStr integerValue]) {
        
        [dic setValue:_houseStr forKey:@"house_type"];
    }
    if ([_priceStr integerValue]) {
        
        [dic setValue:_priceStr forKey:@"price_sort"];
    }
    if ([_areaStr integerValue]) {
        
        [dic setValue:_areaStr forKey:@"size_sort"];
    }
    
    [BaseRequest GET:ProjectGetHouseList_URL parameters:dic success:^(id resposeObject) {
        
        [self->_table.mj_footer endRefreshing];
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            
            if (![resposeObject[@"data"][@"data"] count]) {
                
                self->_table.mj_footer.state = MJRefreshStateNoMoreData;
            }else{
                
                [self SetDataArr:resposeObject[@"data"][@"data"]];
            }
        }else{
            
            _page -= 1;
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        _page -= 1;
        [self->_table.mj_footer endRefreshing];
        [self showContent:@"网络错误"];
    }];
}

- (void)SetDataArr:(NSArray *)data{
    
    for (int i = 0; i < data.count; i++) {
        
        NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:data[i]];
        [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
           
            if ([obj isKindOfClass:[NSNull class]]) {
                
                [tempDic setValue:@"" forKey:key];
            }
        }];
        
        [_dataArr addObject:tempDic];
    }
    
    [_table reloadData];
}


- (void)ActionTagBtn:(UIButton *)btn{
    
    btn.selected = !btn.selected;
    switch (btn.tag) {
        case 1:
        {
            
            if (_tag == 1) {
                
                _buildBtn.selected = NO;
                _tag = 0;
                [self.boxView removeFromSuperview];
            }else{
                
                _tag = btn.tag;
                _unitBtn.selected = NO;
                _houseBtn.selected = NO;
                _priceBtn.selected = NO;
                _areaBtn.selected = NO;
                if (_buildA.count) {
                    
                    
                    [self.boxView removeFromSuperview];
                    NSMutableArray *tempArr = [NSMutableArray arrayWithArray:_buildArr];
                    self.boxView.dataArr = [NSMutableArray arrayWithArray:tempArr];
                    [tempArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        
                        if (idx == 0) {
                            
                            tempArr[idx] = @(1);
                        }else{
                            
                            tempArr[idx] = @(0);
                        }
                    }];
                    self.boxView.selectArr = [NSMutableArray arrayWithArray:tempArr];
                    [self.boxView.mainTable reloadData];
                    [self.view addSubview:self.boxView];
                }else{
                    
                    [BaseRequest GET:ProjectGetProjectBuildUnitTitle_URL parameters:@{@"info_id":_info_id} success:^(id resposeObject) {
                        
                        if ([resposeObject[@"code"] integerValue] == 200) {
                            
                            [_buildArr removeAllObjects];
                            _buildA = resposeObject[@"data"];
                            for (int i = 0; i < _buildA.count; i++) {
                                
                                [_buildArr addObject:@{@"id":_buildA[i][@"build_id"],@"param":_buildA[i][@"build_name"]}];
                            }
                            [_buildArr insertObject:@{@"id":@"0",@"param":@"不限"} atIndex:0];
                            [self.boxView removeFromSuperview];
                            NSMutableArray *tempArr = [NSMutableArray arrayWithArray:_buildArr];
                            self.boxView.dataArr = [NSMutableArray arrayWithArray:tempArr];
                            [tempArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                                
                                if (idx == 0) {
                                    
                                    tempArr[idx] = @(1);
                                }else{
                                    
                                    tempArr[idx] = @(0);
                                }
                            }];
                            self.boxView.selectArr = [NSMutableArray arrayWithArray:tempArr];
                            [self.boxView.mainTable reloadData];
                            [self.view addSubview:self.boxView];
                        }else{
                            
                            [self showContent:resposeObject[@"msg"]];
                        }
                    } failure:^(NSError *error) {
                        
                        [self showContent:@"网络错误"];
                    }];
                }
            }
            break;
        }
        case 2:{
            
            if (_tag == 2) {
                
                _unitBtn.selected = NO;
                _tag = 0;
                [self.boxView removeFromSuperview];
            }else{
                
                _tag = btn.tag;
                _buildBtn.selected = NO;
                _houseBtn.selected = NO;
                _priceBtn.selected = NO;
                _areaBtn.selected = NO;
                [self.boxView removeFromSuperview];
                NSMutableArray *tempArr = [NSMutableArray arrayWithArray:_unitArr];
                self.boxView.dataArr = [NSMutableArray arrayWithArray:tempArr];
                [tempArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    if (idx == 0) {
                        
                        tempArr[idx] = @(1);
                    }else{
                        
                        tempArr[idx] = @(0);
                    }
                }];
                self.boxView.selectArr = [NSMutableArray arrayWithArray:tempArr];
                [self.boxView.mainTable reloadData];
                [self.view addSubview:self.boxView];
            }
            
            break;
        }
        case 3:{
            
            if (_tag == 3) {
                
                _houseBtn.selected = NO;
                _tag = 0;
                [self.boxView removeFromSuperview];
            }else{
                
                _tag = btn.tag;
                _unitBtn.selected = NO;
                _buildBtn.selected = NO;
                _priceBtn.selected = NO;
                _areaBtn.selected = NO;
                
                [self.boxView removeFromSuperview];
                NSMutableArray *tempArr = [NSMutableArray arrayWithArray:_houseArr];
                self.boxView.dataArr = [NSMutableArray arrayWithArray:tempArr];
                [tempArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    if (idx == 0) {
                        
                        tempArr[idx] = @(1);
                    }else{
                        
                        tempArr[idx] = @(0);
                    }
                }];
                self.boxView.selectArr = [NSMutableArray arrayWithArray:tempArr];
                [self.boxView.mainTable reloadData];
                [self.view addSubview:self.boxView];
            }
            break;
        }
        case 4:{
            
            _areaStr = @"";
            if (_tag == 4) {
                
                _tag = btn.tag;
                _tag = 0;
                _unitBtn.selected = NO;
                _buildBtn.selected = NO;
                _houseBtn.selected = NO;
                _areaBtn.selected = NO;
                
                [self.boxView removeFromSuperview];
                _priceStr = @"2";
                [self RequestMethod];
            }else{
                
                _tag = btn.tag;
                _unitBtn.selected = NO;
                _buildBtn.selected = NO;
                _houseBtn.selected = NO;
                _areaBtn.selected = NO;
                
                [self.boxView removeFromSuperview];
                
                _priceStr = @"1";
                [self RequestMethod];
            }
            break;
        }
        case 5:{
            
            _priceStr = @"";
            if (_tag == 5) {
                
                _tag = btn.tag;
                _tag = 0;
                _unitBtn.selected = NO;
                _buildBtn.selected = NO;
                _houseBtn.selected = NO;
                _priceBtn.selected = NO;
                
                [self.boxView removeFromSuperview];
                
                _areaStr = @"2";
                [self RequestMethod];
            }else{
                
                _tag = btn.tag;
                _unitBtn.selected = NO;
                _buildBtn.selected = NO;
                _houseBtn.selected = NO;
                _priceBtn.selected = NO;
                
                [self.boxView removeFromSuperview];
                
                _areaStr = @"1";
                [self RequestMethod];
            }
            break;
        }
        default:
            break;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ActiveRoomListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ActiveRoomListCell"];
    if (!cell) {
        
        cell = [[ActiveRoomListCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ActiveRoomListCell"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.dataDic = _dataArr[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyShopRoomDetailVC *nextVC = [[MyShopRoomDetailVC alloc] initWithHouseId:[NSString stringWithFormat:@"%@",_dataArr[indexPath.row][@"house_id"]] info_id:_info_id];
    nextVC.project_id = _project_id;
    nextVC.projectName = self.projectName;
    nextVC.config_id = [NSString stringWithFormat:@"%@",_dataArr[indexPath.row][@"config_id"]];
    nextVC.myShopRoomDetailVCBlock = ^{
      
        if (self.myShopRoomListVCBlock) {
            
            self.myShopRoomListVCBlock();
        }
    };
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"房源列表";
    
    for (int i = 0; i < 5; i++) {
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(SCREEN_Width / 5 * i, NAVIGATION_BAR_HEIGHT, SCREEN_Width / 5, 40 *SIZE);
            btn.tag = i + 1;
            [btn setBackgroundColor:[UIColor whiteColor]];
            [btn addTarget:self action:@selector(ActionTagBtn:) forControlEvents:UIControlEventTouchUpInside];
            
            switch (i) {
                case 0:
                {
                    [btn setTitle:@"楼栋" forState:UIControlStateNormal];
                    [btn setTitleColor:YJ86Color forState:UIControlStateNormal];
                    btn.titleLabel.font = [UIFont systemFontOfSize:12 *SIZE];
                    [btn setImage:[UIImage imageNamed:@"downarrow1"] forState:UIControlStateNormal];
                    [btn setImage:[UIImage imageNamed:@"uparrow2"] forState:UIControlStateSelected];
                    _buildBtn = btn;
                    [self.view addSubview:_buildBtn];
                    break;
                }
                case 1:
                {
                    [btn setTitle:@"单元" forState:UIControlStateNormal];
                    [btn setTitleColor:YJ86Color forState:UIControlStateNormal];
                    btn.titleLabel.font = [UIFont systemFontOfSize:12 *SIZE];
                    [btn setImage:[UIImage imageNamed:@"downarrow1"] forState:UIControlStateNormal];
                    [btn setImage:[UIImage imageNamed:@"uparrow2"] forState:UIControlStateSelected];
                    _unitBtn = btn;
                    [self.view addSubview:_unitBtn];
                    break;
                }
                case 2:
                {
                    [btn setTitle:@"户型" forState:UIControlStateNormal];
                    [btn setTitleColor:YJ86Color forState:UIControlStateNormal];
                    btn.titleLabel.font = [UIFont systemFontOfSize:12 *SIZE];
                    [btn setImage:[UIImage imageNamed:@"downarrow1"] forState:UIControlStateNormal];
                    [btn setImage:[UIImage imageNamed:@"uparrow2"] forState:UIControlStateSelected];
                    _houseBtn = btn;
                    [self.view addSubview:_houseBtn];
                    break;
                }
                case 3:
                {
                    [btn setTitle:@"总价" forState:UIControlStateNormal];
                    [btn setTitleColor:YJ86Color forState:UIControlStateNormal];
                    btn.titleLabel.font = [UIFont systemFontOfSize:12 *SIZE];
                    [btn setImage:[UIImage imageNamed:@"downarrow1"] forState:UIControlStateNormal];
                    [btn setImage:[UIImage imageNamed:@"uparrow2"] forState:UIControlStateSelected];
                    _priceBtn = btn;
                    [self.view addSubview:_priceBtn];
                    break;
                }
                case 4:
                {
                    [btn setTitle:@"面积" forState:UIControlStateNormal];
                    [btn setTitleColor:YJ86Color forState:UIControlStateNormal];
                    btn.titleLabel.font = [UIFont systemFontOfSize:12 *SIZE];
                    [btn setImage:[UIImage imageNamed:@"downarrow1"] forState:UIControlStateNormal];
                    [btn setImage:[UIImage imageNamed:@"uparrow2"] forState:UIControlStateSelected];
                    _areaBtn = btn;
                    [self.view addSubview:_areaBtn];
                    break;
                }
                default:
                    break;
            }
        }
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT + 41 *SIZE , SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - 41 *SIZE) style:UITableViewStylePlain];
    _table.backgroundColor = CLBackColor;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.delegate = self;
    _table.dataSource = self;
    _table.estimatedRowHeight = 150 *SIZE;
    _table.rowHeight = UITableViewAutomaticDimension;
    [self.view addSubview:_table];
    _table.mj_header = [GZQGifHeader headerWithRefreshingBlock:^{
       
        _page = 1;
        [self RequestMethod];
    }];
    
    _table.mj_footer = [GZQGifFooter footerWithRefreshingBlock:^{
       
        _page += 1;
        [self RequestAddMethod];
    }];
}

- (BoxView *)boxView{
    
    if (!_boxView) {
        
        _boxView = [[BoxView alloc] initWithFrame:CGRectMake(0, 41 *SIZE + NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - (41 *SIZE + NAVIGATION_BAR_HEIGHT))];
        WS(weakSelf);
        SS(strongSelf);
        _boxView.confirmBtnBlock = ^(NSString *ID,NSString *str) {

            if ([str isEqualToString:@"不限"]) {

                if (_tag == 1) {
                    
                    [weakSelf.buildBtn setTitle:@"楼栋" forState:UIControlStateNormal];
                    _buildStr = [NSString stringWithFormat:@"%@",ID];
                    [strongSelf->_unitArr removeAllObjects];
                    [strongSelf->_unitArr insertObject:@{@"id":@"0",@"param":@"不限"} atIndex:0];
                }else if (_tag == 2){
                    
                    [weakSelf.unitBtn setTitle:@"单元" forState:UIControlStateNormal];
                    _unitStr = [NSString stringWithFormat:@"%@",ID];
                }else if (_tag == 3){
                    
                    [weakSelf.houseBtn setTitle:@"户型" forState:UIControlStateNormal];
                    _houseStr = [NSString stringWithFormat:@"%@",ID];
                }else if (_tag == 4){
                    
                    [weakSelf.priceBtn setTitle:@"单价" forState:UIControlStateNormal];
                    _priceStr = [NSString stringWithFormat:@"%@",ID];
                }else if (_tag == 5){
                    
                    [weakSelf.areaBtn setTitle:@"面积" forState:UIControlStateNormal];
                    _areaStr = [NSString stringWithFormat:@"%@",ID];
                }
            }else{

                if (_tag == 1) {
                    
                    [weakSelf.buildBtn setTitle:str forState:UIControlStateNormal];
                    _buildStr = [NSString stringWithFormat:@"%@",ID];
                    for (int i = 0; i < _buildA.count; i++) {
                        
                        if ([_buildStr integerValue] == [_buildA[i][@"build_id"] integerValue]) {
                            
                            NSArray *arr = strongSelf->_buildA[i][@"uniList"];
                            [strongSelf->_unitArr removeAllObjects];
                            for (int j = 0; j < arr.count; j++) {
                                
                                [strongSelf->_unitArr addObject:@{@"id":arr[j][@"unit_id"],@"param":arr[j][@"unit_name"]}];
                            }
                            [strongSelf->_unitArr insertObject:@{@"id":@"0",@"param":@"不限"} atIndex:0];
                            break;
                        }else{
                            
                            [strongSelf->_unitArr removeAllObjects];
                            [strongSelf->_unitArr insertObject:@{@"id":@"0",@"param":@"不限"} atIndex:0];
                        }
                    }
                }else if (_tag == 2){
                    
                    [weakSelf.unitBtn setTitle:str forState:UIControlStateNormal];
                    _unitStr = [NSString stringWithFormat:@"%@",ID];
                }else if (_tag == 3){
                    
                    [weakSelf.houseBtn setTitle:str forState:UIControlStateNormal];
                    _houseStr = [NSString stringWithFormat:@"%@",ID];
                }else if (_tag == 4){
                    
                    [weakSelf.priceBtn setTitle:str forState:UIControlStateNormal];
                    _priceStr = [NSString stringWithFormat:@"%@",ID];
                }else if (_tag == 5){
                    
                    [weakSelf.areaBtn setTitle:str forState:UIControlStateNormal];
                    _areaStr = [NSString stringWithFormat:@"%@",ID];
                }
            }
            
            [weakSelf.boxView removeFromSuperview];
            [weakSelf RequestMethod];
        };

        _boxView.cancelBtnBlock = ^{

            _tag = 0;
            weakSelf.buildBtn.selected = NO;
            weakSelf.unitBtn.selected = NO;
            weakSelf.houseBtn.selected = NO;
            weakSelf.priceBtn.selected = NO;
            weakSelf.areaBtn.selected = NO;
        };
    }
    return _boxView;
}

@end
