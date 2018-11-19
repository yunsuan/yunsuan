//
//  QuickSearchVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/5/5.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "QuickSearchVC.h"
#import "CompanyCell.h"
#import "PeopleCell.h"
#import "RoomListModel.h"
#import "CustomDetailVC.h"

@interface QuickSearchVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    
    NSInteger _page;
//    NSArray *_arr;
    NSMutableArray *_dataArr;
    NSString *_city;
    NSArray *_tagsArr;
    NSArray *_propertyArr;
    CustomRequireModel *_model;
}
@property (nonatomic , strong) UITableView *searchTable;

@end

@implementation QuickSearchVC

- (instancetype)initWithTitle:(NSString *)str city:(NSString *)city model:(CustomRequireModel *)model
{
    self = [super init];
    if (self) {
        
        self.title = str;
        _city = city;
        _model = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _page = 1;
    _dataArr = [@[] mutableCopy];
    _tagsArr = [self getDetailConfigArrByConfigState:PROJECT_TAGS_DEFAULT];
    _propertyArr = [self getDetailConfigArrByConfigState:PROPERTY_TYPE];
    [self initUI];
    [self RequestMethod];
}

- (void)RequestMethod{
    
    if (_page == 1) {
        
        [_dataArr removeAllObjects];
        self.searchTable.mj_footer.state = MJRefreshStateIdle;
    }
    
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"page":@(_page),@"city":_city}];
    
    if (self.title.length) {
        
        dic[@"project_name"] = self.title;
    }
    
    [BaseRequest GET:ProjectList_URL parameters:dic success:^(id resposeObject) {
        
        [self.searchTable.mj_header endRefreshing];
//        NSLog(@"%@",resposeObject);
     
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            
            if ([resposeObject[@"data"] count]) {
                
                [self SetData:resposeObject[@"data"]];
            }else{
                
                _searchTable.mj_footer.state = MJRefreshStateNoMoreData;
            }
        }else{
      
                [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [self.searchTable.mj_header endRefreshing];
        [self.searchTable.mj_footer endRefreshing];
//        NSLog(@"%@",error.localizedDescription);
    }];
    
}

- (void)SetData:(NSArray *)data{
    
    for (NSUInteger i = 0; i < data.count; i++) {
        
        NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:data[i]];
        [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            
            if ([obj isKindOfClass:[NSNull class]]) {
                
                tempDic[key] = @"";
            }
        }];
        
        RoomListModel *model = [[RoomListModel alloc] initWithDictionary:tempDic];
        
        [_dataArr addObject:model];
    }
    
    [_searchTable reloadData];
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

    RoomListModel *model;
    model = _dataArr[(NSUInteger) indexPath.row];
    if ([model.guarantee_brokerage integerValue] == 2) {
        
        static NSString *CellIdentifier = @"CompanyCell";
        
        CompanyCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[CompanyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        [cell SetTitle:model.project_name image:model.img_url contentlab:model.absolute_address statu:model.sale_state];
        NSMutableArray *tempArr = [@[] mutableCopy];
        for (NSUInteger i = 0; i < model.property_tags.count; i++) {
            
            [_propertyArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if ([obj[@"id"] integerValue] == [model.property_tags[i] integerValue]) {
                    
                    [tempArr addObject:obj[@"param"]];
                    *stop = YES;
                }
            }];
        }

        [cell settagviewWithdata:@[model.property_tags,model.project_tags]];
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
            
            cell.statusImg.hidden = NO;
            cell.surelab.hidden = [model.guarantee_brokerage integerValue] != 1;
        }
        
        NSMutableArray *tempArr = [@[] mutableCopy];
        for (NSUInteger i = 0; i < model.property_tags.count; i++) {
            
            [_propertyArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if ([obj[@"id"] integerValue] == [model.property_tags[i] integerValue]) {
                    
                    [tempArr addObject:obj[@"param"]];
                    *stop = YES;
                }
            }];
        }
        
        [cell settagviewWithdata:@[model.property_tags,model.project_tags]];
        
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
    
    if ([[UserModel defaultModel].agent_identity integerValue] == 1) {

        RoomListModel *model;
        model = _dataArr[(NSUInteger) indexPath.row];
        [BaseRequest POST:RecommendClient_URL parameters:@{@"project_id":model.project_id,@"client_need_id":_model.need_id,@"client_id":_model.client_id} success:^(id resposeObject) {
            
//            NSLog(@"%@",resposeObject);
        
            if ([resposeObject[@"code"] integerValue] == 200) {
                
                for (UIViewController *vc in self.navigationController.viewControllers) {
                    
                    if ([vc isKindOfClass:[CustomDetailVC class]]) {
                        
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            
                            [self.navigationController popToViewController:vc animated:YES];
                        });
                    }
                }
            }
            else{
                [self showContent:resposeObject[@"msg"]];
            }
        } failure:^(NSError *error) {
            
//            NSLog(@"%@",error);
            [self showContent:@"网络错误"];
        }];
    }else{
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"到访确认人不可推荐客户"];
    }
}

- (void)initUI{
    
    _searchTable = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, 360*SIZE, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    _searchTable.backgroundColor = YJBackColor;
    _searchTable.delegate = self;
    _searchTable.dataSource = self;
    [_searchTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:_searchTable];
}

@end
