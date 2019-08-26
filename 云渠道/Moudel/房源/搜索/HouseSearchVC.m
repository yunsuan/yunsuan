//
//  HouseSearchVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/10.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "HouseSearchVC.h"
#import "RoomDetailVC1.h"

#import "CompanyCell.h"
#import "PeopleCell.h"

//#import "RoomListModel.h"

#import "BoxView.h"
#import "BoxAddressView.h"
#import "MoreView.h"

@interface HouseSearchVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    
    NSInteger _page;
//    NSArray *_arr;
    NSMutableArray *_dataArr;
    NSString *_city;
//    NSArray *_tagsArr;
    NSArray *_propertyArr;
    
    BOOL _is1;
    BOOL _is2;
    BOOL _is3;
    BOOL _is4;
    BOOL _upAndDown;
    
    NSString *_status;
    NSString *_district;
    NSString *_price;
    NSString *_type;
//    NSString *_more;
    NSString *_asc;
    NSString *_tag;
    NSString *_houseType;
}
@property (nonatomic , strong) UITableView *searchTable;

@property (nonatomic, strong) UIView *headerView;

@property (nonatomic, strong) UIButton *areaBtn;

@property (nonatomic, strong) UIButton *priceBtn;

@property (nonatomic, strong) UIButton *typeBtn;

@property (nonatomic, strong) UIButton *moreBtn;

@property (nonatomic, strong) UIButton *sortBtn;

@property (nonatomic, strong) UIImageView *upImg;

@property (nonatomic, strong) BoxAddressView *areaView;

@property (nonatomic, strong) BoxView *priceView;

@property (nonatomic, strong) BoxView *typeView;

@property (nonatomic, strong) MoreView *moreView;

@end

@implementation HouseSearchVC

- (instancetype)initWithTitle:(NSString *)str city:(NSString *)city
{
    self = [super init];
    if (self) {
        
        self.title = str;
        _city = city;
    }
    return self;
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [self ActionUpAndDownBtn];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    _tagsArr = [self getDetailConfigArrByConfigState:PROJECT_TAGS_DEFAULT];
    _propertyArr = [self getDetailConfigArrByConfigState:PROPERTY_TYPE];
    _page = 1;
    _dataArr = [@[] mutableCopy];
    
    _asc = @"asc";
    
    [self initUI];
    [self RequestMethod];
}

- (void)RequestMethod{
    
    if (_page == 1) {
        
        [_dataArr removeAllObjects];
        self.searchTable.mj_footer.state = MJRefreshStateIdle;
    }
    
   
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"page":@(_page),@"city":_city}];
    [dic setObject:[UserModel defaultModel].agent_id forKey:@"agent_id"];
    if (self.title.length) {
        
        [dic setObject:self.title forKey:@"project_name"];
    }
    
    if (![_district isEqualToString:@"0"] && _district.length) {
        
        [dic setObject:_district forKey:@"district"];
    }
    if (![_price isEqualToString:@"0"] && _price) {
        
        [dic setObject:[NSString stringWithFormat:@"%@",_price] forKey:@"average_price"];
    }
    if (![_type isEqualToString:@"0"] && _type) {
        
        [dic setObject:[NSString stringWithFormat:@"%@",_type] forKey:@"property_id"];
    }
    if (_tag.length) {
        
        [dic setObject:[NSString stringWithFormat:@"%@",_tag] forKey:@"project_tags"];
    }
    if (_houseType.length) {
        
        [dic setObject:[NSString stringWithFormat:@"%@",_houseType] forKey:@"house_type"];
    }
    if (_status.length) {
        
        [dic setObject:[NSString stringWithFormat:@"%@",_status] forKey:@"sale_state"];
    }
    [dic setObject:_asc forKey:@"sort_type"];
    
    [BaseRequest GET:ProjectList_URL parameters:dic success:^(id resposeObject) {
        
        [self.searchTable.mj_header endRefreshing];
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [_dataArr removeAllObjects];
            [self SetData:resposeObject[@"data"]];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [self showContent:@"网络错误"];
        [self.searchTable.mj_header endRefreshing];
        [self.searchTable.mj_footer endRefreshing];
    }];
    
}

//- (void)RequestAddMethod{
//
//
//    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"page":@(_page),@"city":_city}];
//    [dic setObject:[UserModel defaultModel].agent_id forKey:@"agent_id"];
//    if (self.title.length) {
//
//        [dic setObject:self.title forKey:@"project_name"];
//    }
//
//    if (![_district isEqualToString:@"0"] && _district.length) {
//
//        [dic setObject:_district forKey:@"district"];
//    }
//    if (![_price isEqualToString:@"0"] && _price) {
//
//        [dic setObject:[NSString stringWithFormat:@"%@",_price] forKey:@"average_price"];
//    }
//    if (![_type isEqualToString:@"0"] && _type) {
//
//        [dic setObject:[NSString stringWithFormat:@"%@",_type] forKey:@"property_id"];
//    }
//    if (_tag.length) {
//
//        [dic setObject:[NSString stringWithFormat:@"%@",_tag] forKey:@"project_tags"];
//    }
//    if (_houseType.length) {
//
//        [dic setObject:[NSString stringWithFormat:@"%@",_houseType] forKey:@"house_type"];
//    }
//    if (_status.length) {
//
//        [dic setObject:[NSString stringWithFormat:@"%@",_status] forKey:@"sale_state"];
//    }
//    [dic setObject:_asc forKey:@"sort_type"];
//
//    [BaseRequest GET:ProjectList_URL parameters:dic success:^(id resposeObject) {
//
////        NSLog(@"%@",resposeObject);
//        if ([resposeObject[@"code"] integerValue] == 200) {
//
//            if ([resposeObject[@"data"] count]) {
//
//                [self SetData:resposeObject[@"data"]];
//                [self.searchTable.mj_footer endRefreshing];
//            }else{
//
//                self.searchTable.mj_footer.state = MJRefreshStateNoMoreData;
//            }
//        }else{
//
//            _page -= 1;
//            [self showContent:resposeObject[@"msg"]];
//            [self.searchTable.mj_footer endRefreshing];
//        }
//    } failure:^(NSError *error) {
//
//        _page -= 1;
////        NSLog(@"%@",error);
//        [self.searchTable.mj_footer endRefreshing];
//    }];
//}

- (void)SetData:(NSArray *)data{
    
    for (int i = 0; i < data.count; i++) {
        
        NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:data[i]];
        [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            
            if ([obj isKindOfClass:[NSNull class]]) {
                
                [tempDic setObject:@"" forKey:key];
            }
        }];
        
        RoomListModel *model = [[RoomListModel alloc] initWithDictionary:tempDic];
        
        [_dataArr addObject:model];
    }
    
    [_searchTable reloadData];
}


#pragma mark -- Method --

- (void)ActionUpAndDownBtn {
    
    _is1 = NO;
    _is2 = NO;
    _is3 = NO;
    _is4 = NO;
    _areaBtn.selected = NO;
    _priceBtn.selected = NO;
    _typeBtn.selected = NO;
    _moreBtn.selected = NO;
    [self.areaView removeFromSuperview];
    [self.priceView removeFromSuperview];
    [self.typeView removeFromSuperview];
    [self.moreView removeFromSuperview];
    _upAndDown = !_upAndDown;
    if (_upAndDown) {
        
        
    }else{
        
        
    }
}

- (void)ActionTagBtn:(UIButton *)btn{
    
    btn.selected = !btn.selected;
    
    switch (btn.tag) {
        case 1:
        {
            _is2 = NO;
            _is3 = NO;
            _is4 = NO;
            _priceBtn.selected = NO;
            _typeBtn.selected = NO;
            _moreBtn.selected = NO;
            [self.priceView removeFromSuperview];
            [self.typeView removeFromSuperview];
            [self.moreView removeFromSuperview];
            if (_is1) {
                
                _is1 = !_is1;
                [_areaView removeFromSuperview];
            }else{
                
                _is1 = YES;
                _district = @"0";
                [[UIApplication sharedApplication].keyWindow addSubview:self.areaView];
            }
            break;
        }
        case 2:
        {
            _is1 = NO;
            _is3 = NO;
            _is4 = NO;
            _areaBtn.selected = NO;
            _typeBtn.selected = NO;
            _moreBtn.selected = NO;
            [self.areaView removeFromSuperview];
            [self.typeView removeFromSuperview];
            [self.moreView removeFromSuperview];
            if (_is2) {
                
                _is2 = !_is2;
                [self.priceView removeFromSuperview];
            }else{
                
                _is2 = YES;
                _price = @"0";
                [[UIApplication sharedApplication].keyWindow addSubview:self.priceView];
            }
            break;
        }
        case 3:
        {
            _is1 = NO;
            _is2 = NO;
            _is4 = NO;
            _areaBtn.selected = NO;
            _priceBtn.selected = NO;
            _moreBtn.selected = NO;
            [self.areaView removeFromSuperview];
            [self.priceView removeFromSuperview];
            [self.moreView removeFromSuperview];
            if (_is3) {
                
                _is3 = !_is3;
                [self.typeView removeFromSuperview];
            }else{
                
                _is3 = YES;
                _type = @"0";
                [[UIApplication sharedApplication].keyWindow addSubview:self.typeView];
            }
            break;
        }
        case 4:
        {
            _is1 = NO;
            _is2 = NO;
            _is3 = NO;
            _areaBtn.selected = NO;
            _priceBtn.selected = NO;
            _typeBtn.selected = NO;
            [self.areaView removeFromSuperview];
            [self.priceView removeFromSuperview];
            [self.typeView removeFromSuperview];
            if (_is4) {
                
                _is4 = !_is4;
                [self.moreView removeFromSuperview];
            }else{
                
                _is4 = YES;
//                _more = @"0";
                
                [self.moreView.moreColl reloadData];
                [[UIApplication sharedApplication].keyWindow addSubview:self.moreView];
            }
            break;
        }
        case 5:
        {
            [self.areaView removeFromSuperview];
            [self.priceView removeFromSuperview];
            [self.typeView removeFromSuperview];
            [self.moreView removeFromSuperview];
            if ([_asc isEqualToString:@"asc"]) {
                
                _asc = @"desc";
            }else{
                
                _asc = @"asc";
            }
            _page = 1;
            [self RequestMethod];
            break;
        }
        default:
            break;
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
    
    RoomListModel *model = _dataArr[indexPath.row];
    if ([model.guarantee_brokerage integerValue] == 2) {
        
        static NSString *CellIdentifier = @"CompanyCell";
        
        CompanyCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[CompanyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        [cell SetTitle:model.project_name image:model.img_url contentlab:model.absolute_address statu:model.sale_state];
        
        //                cell.statusImg.hidden = YES;
        //                [cell settagviewWithdata:@[model.property_tags,model.project_tags]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else{
        
        static NSString *CellIdentifier = @"PeopleCell";
        
        PeopleCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[PeopleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        [cell SetTitle:model.project_name image:model.img_url contentlab:model.absolute_address statu:model.sale_state];
        if ([model.sort integerValue] == 0 && [model.cycle integerValue] == 0) {
            
            cell.statusImg.hidden = YES;
            cell.surelab.hidden = YES;
        }else{
            
            if ([[UserModelArchiver unarchive].agent_identity integerValue] == 1) {
                
                cell.statusImg.hidden = NO;
            }else{
                
                cell.statusImg.hidden = YES;
            }
            if ([model.guarantee_brokerage integerValue] == 1) {
                
                cell.surelab.hidden = NO;
            }else{
                
                cell.surelab.hidden = YES;
            }
        }
        NSArray *project_tags =model.project_tags?model.project_tags:@[];
        NSArray *property_tags = model.property_tags?model.property_tags:@[];
        [cell settagviewWithdata:@[property_tags,project_tags]];
        if (model.sort) {
            
            cell.rankView.rankL.text = [NSString stringWithFormat:@"佣金:第%@名",model.sort];
        }else{
            
            cell.rankView.rankL.text = [NSString stringWithFormat:@"佣金:无排名"];
        }
        [cell.rankView.rankL mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(cell.rankView).offset(0);
            make.top.equalTo(cell.rankView).offset(0);
            make.height.equalTo(@(10 *SIZE));
            make.width.equalTo(@(cell.rankView.rankL.mj_textWith + 5 *SIZE));
        }];
        if ([model.brokerSortCompare integerValue] == 0) {
            
            cell.rankView.statusImg.image = nil;
        }else if ([model.brokerSortCompare integerValue] == 1){
            
            cell.rankView.statusImg.image = [UIImage imageNamed:@"rising"];
        }else if ([model.brokerSortCompare integerValue] == 2){
            
            cell.rankView.statusImg.image = [UIImage imageNamed:@"falling"];
        }
        [cell.getLevel SetImage:[UIImage imageNamed:@"lightning_1"] selectImg:[UIImage imageNamed:@"lightning"] num:[model.cycle integerValue]];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    RoomListModel *model = _dataArr[indexPath.row];
    RoomDetailVC1 *nextVC = [[RoomDetailVC1 alloc] initWithModel:model];
    if ([model.guarantee_brokerage integerValue] == 2) {
        
        nextVC.brokerage = @"no";
    }else{
        
        nextVC.brokerage = @"yes";
    }
    nextVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (void)initUI{
    
//    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, 39 *SIZE)];
//    _headerView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:_headerView];
//
//    for (int i = 0; i < 5; i++) {
//
//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        btn.frame = CGRectMake(80 *SIZE * i, 0 *SIZE, 80 *SIZE, 39 *SIZE);
//        btn.tag = i + 1;
//        [btn setBackgroundColor:[UIColor whiteColor]];
//        [btn addTarget:self action:@selector(ActionTagBtn:) forControlEvents:UIControlEventTouchUpInside];
//
//        switch (i) {
//            case 0:
//            {
//                [btn setTitle:@"区域" forState:UIControlStateNormal];
//                [btn setTitleColor:YJ86Color forState:UIControlStateNormal];
//                btn.titleLabel.font = [UIFont systemFontOfSize:12 *SIZE];
//                [btn setImage:[UIImage imageNamed:@"downarrow1"] forState:UIControlStateNormal];
//                [btn setImage:[UIImage imageNamed:@"uparrow2"] forState:UIControlStateSelected];
//                _areaBtn = btn;
//                [self.headerView addSubview:_areaBtn];
//                break;
//            }
//            case 1:
//            {
//                [btn setTitle:@"均价" forState:UIControlStateNormal];
//                [btn setTitleColor:YJ86Color forState:UIControlStateNormal];
//                btn.titleLabel.font = [UIFont systemFontOfSize:12 *SIZE];
//                [btn setImage:[UIImage imageNamed:@"downarrow1"] forState:UIControlStateNormal];
//                [btn setImage:[UIImage imageNamed:@"uparrow2"] forState:UIControlStateSelected];
//                _priceBtn = btn;
//                [self.headerView addSubview:_priceBtn];
//                break;
//            }
//            case 2:
//            {
//                [btn setTitle:@"类型" forState:UIControlStateNormal];
//                [btn setTitleColor:YJ86Color forState:UIControlStateNormal];
//                btn.titleLabel.font = [UIFont systemFontOfSize:12 *SIZE];
//                [btn setImage:[UIImage imageNamed:@"downarrow1"] forState:UIControlStateNormal];
//                [btn setImage:[UIImage imageNamed:@"uparrow2"] forState:UIControlStateSelected];
//                _typeBtn = btn;
//                [self.headerView addSubview:_typeBtn];
//                break;
//            }
//            case 3:
//            {
//                [btn setTitle:@"更多" forState:UIControlStateNormal];
//                [btn setTitleColor:YJ86Color forState:UIControlStateNormal];
//                btn.titleLabel.font = [UIFont systemFontOfSize:12 *SIZE];
//                [btn setImage:[UIImage imageNamed:@"downarrow1"] forState:UIControlStateNormal];
//                [btn setImage:[UIImage imageNamed:@"uparrow2"] forState:UIControlStateSelected];
//                _moreBtn = btn;
//                [self.headerView addSubview:_moreBtn];
//                break;
//            }
//            case 4:
//            {
//                btn.frame = CGRectMake(80 *SIZE * i, 0 *SIZE, 40 *SIZE, 39 *SIZE);
//                [btn setImage:[UIImage imageNamed:@"reverseorder"] forState:UIControlStateNormal];
//                [btn setImage:[UIImage imageNamed:@"reverseorder"] forState:UIControlStateSelected];
//                _sortBtn = btn;
//                [self.headerView addSubview:_sortBtn];
//                break;
//            }
//            default:
//                break;
//        }
//    }
//
//    _upImg = [[UIImageView alloc] initWithFrame:CGRectMake(334 *SIZE, 74 *SIZE, 13 *SIZE, 16 *SIZE)];
//    [self.headerView addSubview:_upImg];
//
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame = CGRectMake(329 *SIZE, 69 *SIZE, 23 *SIZE, 26 *SIZE);
//    [btn addTarget:self action:@selector(ActionUpAndDownBtn:) forControlEvents:UIControlEventTouchUpInside];
//    [self.headerView addSubview:btn];
    
//    _searchTable = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT + 40 *SIZE, 360*SIZE, SCREEN_Height - NAVIGATION_BAR_HEIGHT - 40 *SIZE) style:UITableViewStylePlain];
    _searchTable = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, 360*SIZE, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    _searchTable.backgroundColor = YJBackColor;
    _searchTable.delegate = self;
    _searchTable.dataSource = self;
    [_searchTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:_searchTable];
}

- (BoxAddressView *)areaView{
    
    if (!_areaView) {
        
        _areaView = [[BoxAddressView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT + 40 *SIZE, SCREEN_Width, SCREEN_Height - 40 *SIZE - NAVIGATION_BAR_HEIGHT)];
        
        NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"region" ofType:@"json"]];
        
        NSError *err;
        NSArray *pro = [NSJSONSerialization JSONObjectWithData:JSONData
                                                       options:NSJSONReadingMutableContainers
                                                         error:&err];
        NSMutableArray * tempArr;
        for (NSDictionary *proDic in pro) {
            
            for (NSDictionary *cityDic in proDic[@"city"]) {
                
                if ([cityDic[@"code"] integerValue] == [_city integerValue]) {
                    
                    tempArr = [NSMutableArray arrayWithArray:cityDic[@"district"]];
                    break;
                }
            }
        }
        [tempArr insertObject:@{@"code":@"0",@"name":@"不限"} atIndex:0];
        _areaView.dataArr = [NSMutableArray arrayWithArray:tempArr];
        [tempArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if (idx == 0) {
                
                [tempArr replaceObjectAtIndex:idx withObject:@(1)];
            }else{
                
                [tempArr replaceObjectAtIndex:idx withObject:@(0)];
            }
            
        }];
        _areaView.selectArr = [NSMutableArray arrayWithArray:tempArr];
        [_areaView.mainTable reloadData];
        
        WS(weakSelf);
        _areaView.boxAddressComfirmBlock = ^(NSString *ID, NSString *str, NSInteger index) {
            
            if ([str isEqualToString:@"不限"]) {
                
                [weakSelf.areaBtn setTitle:@"区域" forState:UIControlStateNormal];
                _district = @"";
            }else{
                
                if (str.length) {
                    
                    [weakSelf.areaBtn setTitle:str forState:UIControlStateNormal];
                }else{
                    
                    [weakSelf.areaBtn setTitle:@"区域" forState:UIControlStateNormal];
                }
                if ([ID integerValue]) {
                    
                    _district = [NSString stringWithFormat:@"%@",ID];
                }
            }
            _is1 = NO;
            weakSelf.areaBtn.selected = NO;
            [weakSelf.areaView removeFromSuperview];
            [weakSelf RequestMethod];
        };
        
        _areaView.boxAddressCancelBlock = ^{
            
            _is1 = NO;
            weakSelf.areaBtn.selected = NO;
        };
    }
    return _areaView;
}

- (BoxView *)priceView{
    
    if (!_priceView) {
        
        _priceView = [[BoxView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT + 40 *SIZE, SCREEN_Width, SCREEN_Height - 40 *SIZE - NAVIGATION_BAR_HEIGHT)];
        
        NSArray *array = [self getDetailConfigArrByConfigState:AVERAGE];
        NSMutableArray * tempArr = [NSMutableArray arrayWithArray:array];
        [tempArr insertObject:@{@"id":@"0",@"param":@"不限"} atIndex:0];
        _priceView.dataArr = [NSMutableArray arrayWithArray:tempArr];
        [tempArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if (idx == 0) {
                
                [tempArr replaceObjectAtIndex:idx withObject:@(1)];
            }else{
                
                [tempArr replaceObjectAtIndex:idx withObject:@(0)];
            }
        }];
        _priceView.selectArr = [NSMutableArray arrayWithArray:tempArr];
        [_priceView.mainTable reloadData];
        
        
        WS(weakSelf);
        _priceView.confirmBtnBlock = ^(NSString *ID, NSString *str) {
            
            if ([str isEqualToString:@"不限"]) {
                
                [weakSelf.priceBtn setTitle:@"均价" forState:UIControlStateNormal];
            }else{
                
                [weakSelf.priceBtn setTitle:str forState:UIControlStateNormal];
            }
            _is2 = NO;
            _price = [NSString stringWithFormat:@"%@",ID];
            weakSelf.priceBtn.selected = NO;
            [weakSelf.priceView removeFromSuperview];
            [weakSelf RequestMethod];
        };
        
        _priceView.cancelBtnBlock = ^{
            
            _is2 = NO;
            weakSelf.priceBtn.selected = NO;
        };
    }
    return _priceView;
}

- (BoxView *)typeView{
    
    if (!_typeView) {
        
        _typeView = [[BoxView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT + 40 *SIZE, SCREEN_Width, SCREEN_Height - 40 *SIZE - NAVIGATION_BAR_HEIGHT)];
        
        NSMutableArray * tempArr = [NSMutableArray arrayWithArray:_propertyArr];
        [tempArr insertObject:@{@"id":@"0",@"param":@"不限"} atIndex:0];
        _typeView.dataArr = [NSMutableArray arrayWithArray:tempArr];
        [tempArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if (idx == 0) {
                
                [tempArr replaceObjectAtIndex:idx withObject:@(1)];
            }else{
                [tempArr replaceObjectAtIndex:idx withObject:@(0)];
            }
        }];
        _typeView.selectArr = [NSMutableArray arrayWithArray:tempArr];
        [_typeView.mainTable reloadData];
        
        WS(weakSelf);
        _typeView.confirmBtnBlock = ^(NSString *ID, NSString *str) {
            
            if ([str isEqualToString:@"不限"]) {
                
                [weakSelf.typeBtn setTitle:@"类型" forState:UIControlStateNormal];
            }else{
                
                [weakSelf.typeBtn setTitle:str forState:UIControlStateNormal];
            }
            _is3 = NO;
            _type = [NSString stringWithFormat:@"%@",ID];
            weakSelf.typeBtn.selected = NO;
            [weakSelf.typeView removeFromSuperview];
            [weakSelf RequestMethod];
        };
        
        _typeView.cancelBtnBlock = ^{
            
            _is3 = NO;
            weakSelf.typeBtn.selected = NO;
        };
    }
    return _typeView;
}

- (MoreView *)moreView{
    
    if (!_moreView) {
        
        _moreView = [[MoreView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT + 40 *SIZE, SCREEN_Width, SCREEN_Height - 40 *SIZE - NAVIGATION_BAR_HEIGHT)];
        
        WS(weakSelf);
        _moreView.moreBtnBlock = ^(NSString *tag, NSString *houseType, NSString *status) {
            
            _is4 = NO;
            weakSelf.moreBtn.selected = NO;
            if (tag.length) {
                
                _tag = [NSString stringWithFormat:@"%@",tag];
            }else{
                
                _tag = @"";
            }
            
            if (houseType.length) {
                
                _houseType = [NSString stringWithFormat:@"%@",houseType];
            }else{
                
                _houseType = @"";
            }
            
            if (status.length) {
                
                _status = [NSString stringWithFormat:@"%@",status];
            }else{
                
                _status = @"";
            }
            
            [weakSelf RequestMethod];
        };
        
        _moreView.moreViewClearBlock = ^{
            
            _tag = @"";
            _status = @"";
            _houseType = @"";
            _is4 = NO;
            weakSelf.moreBtn.selected = NO;
            [weakSelf RequestMethod];
        };
    }
    return _moreView;
}

@end
