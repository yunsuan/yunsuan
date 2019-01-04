//
//  CustomDetailVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/3/22.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "CustomDetailVC.h"

#import "AddRequireMentVC.h"
#import "AddStoreRequireMentVC.h"
#import "AddOfficeRequireMentVC.h"
#import "FollowRecordVC.h"
#import "AddCustomerVC.h"
//#import "RoomMatchListVC.h"
#import "QuickRoomVC.h"
//#import "AddTagVC.h"
#import "RecommendedStatusVC.h"
#import "CustomSearchVC.h"
#import "CustomerListVC.h"

#import "CustomDetailTableCell.h"
#import "CustomDetailTableCell2.h"
#import "CustomDetailTableCell3.h"
#import "CustomDetailTableCell4.h"
#import "CustomDetailTableCell5.h"
#import "CustomTableHeader.h"
#import "CustomTableAddHeader.h"
#import "CustomTableListHeader.h"



@interface CustomDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger _item;
    NSString *_clientId;
    
    CustomerModel *_customModel;//客户信息
    NSMutableArray *_dataArr;//需求信息
    NSMutableArray *_FollowArr;
    NSMutableArray *_projectArr;
    NSMutableArray *_statusArr;
    NSArray *_tagsArr;
    NSArray *_propertyArr;
}
@property (nonatomic, strong) UITableView *customDetailTable;

@end

@implementation CustomDetailVC

- (instancetype)initWithClientId:(NSString *)clientId
{
    self = [super init];
    if (self) {
        
        _clientId = clientId;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    dispatch_queue_t queue1 = dispatch_queue_create("com.test.gcg.group", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_async(group, queue1, ^{
        
        [self RequestMethod];
        
    });
    dispatch_group_async(group, queue1, ^{
        
        [self GetFollowRequestMethod];
        
    });
    dispatch_group_async(group, queue1, ^{
        
        [self MatchRequest];
        
    });
    [self.navigationController setNavigationBarHidden:YES animated:YES]; //设置隐藏
}

- (void)ActionMaskBtn:(UIButton *)btn{
    
    for (UIViewController *vc in self.navigationController.viewControllers) {
        
        if ([vc isKindOfClass:[CustomSearchVC class]]) {
            
            [self.navigationController setNavigationBarHidden:NO animated:YES];
            [self.navigationController popToViewController:vc animated:YES];
        }else{
            
            if ([vc isKindOfClass:[CustomerListVC class]]) {
                
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];

}

- (void)initDataSource{
    
    _customModel = [[CustomerModel alloc] init];
    _dataArr = [@[] mutableCopy];
    _FollowArr = [@[] mutableCopy];
    _projectArr = [@[] mutableCopy];
    _statusArr = [@[] mutableCopy];
    _tagsArr = [self getDetailConfigArrByConfigState:PROJECT_TAGS_DEFAULT];
    _propertyArr = [self getDetailConfigArrByConfigState:PROPERTY_TYPE];
}

- (void)MatchRequest{
    
    [BaseRequest GET:ClientMatching_URL parameters:@{@"client_id":_clientId} success:^(id resposeObject) {
        
       
//        NSLog(@"%@",resposeObject);
    
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if ([resposeObject[@"data"] isKindOfClass:[NSDictionary class]]) {
                
                [self SetProjectList:resposeObject[@"data"][@"list"]];
                _statusArr = [NSMutableArray arrayWithArray:resposeObject[@"data"][@"recommend_project"]];
            }
        }
        else{
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
//        NSLog(@"%@",error);
    }];
}

- (void)SetProjectList:(NSArray *)data{
    
    [_projectArr removeAllObjects];
    for (NSUInteger i = 0; i < data.count; i++) {
        
        NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:data[i]];
        [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
           
            if ([key isEqualToString:@"property_tags"]) {
                
                if (![obj isKindOfClass:[NSArray class]]) {
                    
                    tempDic[key] = @[];
                }
            }else{
                
                if ([obj isKindOfClass:[NSNull class]]) {
                    
                    tempDic[key] = @"";
                }
            }
        }];
        
        [_projectArr addObject:tempDic];
    }
    [_customDetailTable reloadData];
}

//-(void)GetCustomRequestMethod
//{
//
//    [BaseRequest GET:GetStateList_URL parameters:@{@"client_id":[UserModelArchiver unarchive].agent_id} success:^(id resposeObject) {
//
//        NSLog(@"%@",resposeObject);
//    } failure:^(NSError *error) {
//
//        NSLog(@"%@",error);
//    }];
//
//}

- (void)GetFollowRequestMethod{
    
    [BaseRequest GET:GetRecord_URL parameters:@{@"client_id":_clientId} success:^(id resposeObject) {
        
//        NSLog(@"%@",resposeObject);
      
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            _FollowArr = [NSMutableArray arrayWithArray:resposeObject[@"data"][@"data"]];
            [_customDetailTable reloadData];
        }else{
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
       
//        NSLog(@"%@",error);
        [self showContent:@"网络错误"];
    }];
}

- (void)RequestMethod{
    
    [BaseRequest GET:GetCliendInfo_URL parameters:@{@"client_id":_clientId} success:^(id resposeObject) {
        
//        NSLog(@"%@",resposeObject);
      
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if ([resposeObject[@"data"] isKindOfClass:[NSDictionary class]]) {
                
                if ([resposeObject[@"data"][@"basic"] isKindOfClass:[NSDictionary class]]) {
                    
                    [self setCustomModel:resposeObject[@"data"][@"basic"]];
                }
                if ([resposeObject[@"data"][@"need_info"] isKindOfClass:[NSArray class]]) {
                    
                    [self setData:resposeObject[@"data"][@"need_info"]];
                }
                [_customDetailTable reloadData];
            }else{
                
//                [self showContent:@"暂无客户信息"];
            }
        }        else{
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
       
//        NSLog(@"%@",error);
        [self showContent:@"网络错误"];
    }];
}

- (void)setCustomModel:(NSDictionary *)dic{
    
    NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
       
        if ([obj isKindOfClass:[NSNull class]]) {
            
            tempDic[key] = @"";
            
        }
        
    }];
    _customModel = [[CustomerModel alloc] initWithDictionary:tempDic];
}

- (void)setData:(NSArray *)data{
    
    [_dataArr removeAllObjects];
    for (NSUInteger i = 0; i < data.count; i++) {
        if ([data[i] isKindOfClass:[NSDictionary class]]) {
            
            NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:data[i]];
            [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                
                if ([key isEqualToString:@"region"] || [key isEqualToString:@"shop_type"]) {
                    
                    if ([obj isKindOfClass:[NSArray class]]) {
                        
                        
                    }else{
                        
                        tempDic[key] = @[];
                    }
                }else{
                    
                    if ([obj isKindOfClass:[NSNull class]]) {
                        
                        tempDic[key] = @"";
                    }else{
                        
                        [tempDic setObject:[NSString stringWithFormat:@"%@",obj] forKey:key];
                    }
                }
            }];
            
            CustomRequireModel *model = [[CustomRequireModel alloc] initWithDictionary:tempDic];
            [_dataArr addObject:model];
        }
    }
}

- (void)ActionRightBtn:(UIButton *)btn{
    
    if (_dataArr.count) {
        QuickRoomVC  *nextVC = [[QuickRoomVC alloc] initWithModel:_dataArr[0]];
//        self.model.client_id = _customModel.client_id;
        nextVC.customerTableModel = self.model;
        [self.navigationController pushViewController:nextVC animated:YES];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (_item == 0) {
        
        if ([_customModel.client_property_type isEqualToString:@"商铺"] || [_customModel.client_property_type isEqualToString:@"写字楼"]) {
            
            return 2;
        }
        return 3;
    }else{
        
        return 2;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (_item == 0) {
        
        return _dataArr.count;
    }else if (_item == 1){
        
        if (section == 0) {
            
            return 0;
        }
        return _FollowArr.count;
    }else{
        
        if (section == 0) {
            
            return 0;
        }
        return _projectArr.count < 3? _projectArr.count : 3;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return UITableViewAutomaticDimension;
    }else{
        
        if (_item == 0) {
            
            if (section == 2) {
                
                return 36 *SIZE;;
            }else{
                
                if ([_customModel.client_property_type isEqualToString:@"商铺"] || [_customModel.client_property_type isEqualToString:@"写字楼"]) {
                    return 36 *SIZE;;
                }

            }
            return SIZE;
        }else{
            
            if (_item == 1) {
                
                if (section == 1) {
                    
                    return 40 *SIZE;
                }
                return CGFLOAT_MIN;
            }else{
                
                if (section == 1) {
                    
                    return 67 *SIZE;
                }
                return CGFLOAT_MIN;
            }
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [[UIView alloc] init];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        CustomTableHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"CustomTableHeader"];
        if (!header) {
            
            header = [[CustomTableHeader alloc] initWithReuseIdentifier:@"CustomTableHeader"];
        }
        header.model = _customModel;
        
        [header.infoBtn setBackgroundColor:COLOR(219, 219, 219, 1)];
        [header.infoBtn setTitleColor:YJ86Color forState:UIControlStateNormal];
        [header.matchBtn setBackgroundColor:COLOR(219, 219, 219, 1)];
        [header.matchBtn setTitleColor:YJ86Color forState:UIControlStateNormal];
        [header.followBtn setBackgroundColor:COLOR(219, 219, 219, 1)];
        [header.followBtn setTitleColor:YJ86Color forState:UIControlStateNormal];
        
        if (_item == 0) {
            
            [header.infoBtn setBackgroundColor:YJBlueBtnColor];
            [header.infoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }else if (_item == 1){
            
            [header.followBtn setBackgroundColor:YJBlueBtnColor];
            [header.followBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }else{
            
            [header.matchBtn setBackgroundColor:YJBlueBtnColor];
            [header.matchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }

        header.customTableHeaderEditBlock = ^{
            
            AddCustomerVC *nextVC = [[AddCustomerVC alloc] initWithModel:_customModel];
            [self.navigationController pushViewController:nextVC animated:YES];
        };
        
        header.customTableHeaderTagBlock = ^(NSInteger index) {
            
            _item = index;
            if (index == 1) {
                
                if (_FollowArr.count) {
                    
                    [_customDetailTable reloadData];
                }else{
                    
                    [self GetFollowRequestMethod];
                }
            }else if (index == 2){
                
                if (_projectArr.count) {
                    
                    [_customDetailTable reloadData];
                }else{
                    
                    [self MatchRequest];
                }
            }
            [tableView reloadData];
        };
        return header;
    }else{
        
        if (_item == 0) {

            if (section == 1) {

                if ([_customModel.client_property_type isEqualToString:@"商铺"]) {
                    
                    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 36 *SIZE)];
                    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(28 *SIZE, 12 *SIZE, 100 *SIZE, 12 *SIZE)];
                    label.textColor = YJContentLabColor;
                    label.font = [UIFont systemFontOfSize:13 *SIZE];
                    label.text = @"其他要求";
                    [view addSubview:label];
                    return view;
                }else if ([_customModel.client_property_type isEqualToString:@"写字楼"]){
                    
                    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 36 *SIZE)];
                    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(28 *SIZE, 12 *SIZE, 100 *SIZE, 12 *SIZE)];
                    label.textColor = YJContentLabColor;
                    label.font = [UIFont systemFontOfSize:13 *SIZE];
                    label.text = @"其他要求";
                    [view addSubview:label];
                    return view;
                }else{
                    
                    return nil;
                }
            }else{

                UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 36 *SIZE)];
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(28 *SIZE, 12 *SIZE, 100 *SIZE, 12 *SIZE)];
                label.textColor = YJContentLabColor;
                label.font = [UIFont systemFontOfSize:13 *SIZE];
                label.text = @"其他要求";
                [view addSubview:label];
                return view;
            }
        }else{
            
            if (_item == 1) {
                
                CustomTableAddHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"CustomTableAddHeader"];
                if (!header) {
                    
                    header = [[CustomTableAddHeader alloc] initWithReuseIdentifier:@"CustomTableAddHeader"];
                }
                header.customTableAddHeaderBlock = ^{
                  
                    FollowRecordVC *nextVC = [[FollowRecordVC alloc] init];
                    nextVC.customername = _customModel.name;
                    nextVC.clint_id =_customModel.client_id;
                    CustomRequireModel *model = _dataArr[0];
                    nextVC.intent = model.intent;
                    nextVC.urgency = model.urgency;
                    
                    [self.navigationController pushViewController:nextVC animated:YES];
                };
                
                return header;
            }else{
                
                CustomTableListHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"CustomTableListHeader"];
                if (!header) {
                    
                    header = [[CustomTableListHeader alloc] initWithReuseIdentifier:@"CustomTableListHeader"];
                }
                
                if ([_model.client_type isEqualToString:@"新房"]) {
                    
                    header.numListL.text = [NSString stringWithFormat:@"匹配项目列表(%ld)",_projectArr.count];
                    header.recommendListL.text = [NSString stringWithFormat:@"已推荐项目数(%ld)",_statusArr.count];
                    header.customTableListHeaderStatusBlock = ^{
                        
                        RecommendedStatusVC *nextVC = [[RecommendedStatusVC alloc] initWithData:_statusArr];
                        [self.navigationController pushViewController:nextVC animated:YES];
                    };
                }else{
                    
                    header.numListL.text = [NSString stringWithFormat:@"匹配小区列表(%ld)",_projectArr.count];
                    header.recommendListL.text = [NSString stringWithFormat:@"已推荐小区数(%ld)",_statusArr.count];
                }
                
                if (_projectArr.count == 0) {
                    
                    header.moreBtn.hidden = YES;
                }else{
                    
                    header.moreBtn.hidden = NO;
                }
                
                
                header.customTableListHeaderMoreBlock = ^{
                    
                    
                };
                return header;
            }
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_item == 0) {
        
        if (indexPath.section == 0) {
            
            NSString * Identifier = @"CustomDetailTableCell";
            CustomDetailTableCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
            if (!cell) {
                
                cell = [[CustomDetailTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.editBlock = ^(NSUInteger index) {

                if ([_customModel.client_property_type isEqualToString:@"商铺"]) {

                    AddStoreRequireMentVC *nextVC = [[AddStoreRequireMentVC alloc] initWithCustomRequireModel:_dataArr[index]];
                    [self.navigationController pushViewController:nextVC animated:YES];
                }else if ([_customModel.client_property_type isEqualToString:@"写字楼"]){

                    AddOfficeRequireMentVC *nextVC = [[AddOfficeRequireMentVC alloc] initWithCustomRequireModel:_dataArr[index]];
                    [self.navigationController pushViewController:nextVC animated:YES];
                }else{

                    AddRequireMentVC *nextVC = [[AddRequireMentVC alloc] initWithCustomRequireModel:_dataArr[index]];
                    [self.navigationController pushViewController:nextVC animated:YES];
                }
            };
            cell.type = _customModel.client_type;
            cell.proType = _customModel.client_property_type;
            CustomRequireModel *model = _dataArr[indexPath.row];
            cell.model = model;
            if ([_model.client_type isEqualToString:@"新房"]) {
                
                if (model.property_type.length) {
                    
                    cell.houseTypeL.text = [NSString stringWithFormat:@"物业类型：%@",model.property_type];
                }else{
                    
                    cell.houseTypeL.text = @"物业类型：";
                }
            }else{
                
                [cell.priceL mas_remakeConstraints:^(MASConstraintMaker *make) {
                    
                    make.left.equalTo(cell.contentView).offset(28 *SIZE);
                    make.top.equalTo(cell.addressL.mas_bottom).offset(18 *SIZE);
                    make.right.equalTo(cell.contentView).offset(-28 *SIZE);
                }];
            }
            return cell;
        }else{
            
            if ([_customModel.client_property_type isEqualToString:@"商铺"]) {
                
                CustomDetailTableCell5 *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomDetailTableCell5"];
                if (!cell) {
                    cell = [[CustomDetailTableCell5 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CustomDetailTableCell5"];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                CustomRequireModel *model = _dataArr[0];
                cell.contentL.text = model.comment;
                return cell;
            }else if ([_customModel.client_property_type isEqualToString:@"写字楼"]){
                
                CustomDetailTableCell5 *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomDetailTableCell5"];
                if (!cell) {
                    cell = [[CustomDetailTableCell5 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CustomDetailTableCell5"];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                CustomRequireModel *model = _dataArr[0];
                cell.contentL.text = model.comment;
                return cell;
            }else{
                
                if (indexPath.section == 1) {
                    
                    CustomDetailTableCell4 *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomDetailTableCell4"];
                    if (!cell) {
                        
                        cell = [[CustomDetailTableCell4 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CustomDetailTableCell4"];
                    }
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.addBtn.hidden = YES;
                    [cell.tagView removeFromSuperview];
                    
                    CustomRequireModel *model = _dataArr[indexPath.row];
                    NSArray *arr =  [model.need_tags componentsSeparatedByString:@","];
                    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
                    layout.itemSize = CGSizeMake(77 *SIZE, 30 *SIZE);
                    layout.minimumInteritemSpacing = 11 *SIZE;
                    layout.sectionInset = UIEdgeInsetsMake(0, 28 *SIZE, 0, 0);
                    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
                    
                    
                    NSMutableArray *tagArr1 = [[NSMutableArray alloc] init];
                    for (int i = 0; i < arr.count; i++) {
                        [_tagsArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                            if ([obj[@"id"] integerValue] == [arr[i] integerValue]) {
                                [tagArr1 addObject:obj[@"param"]];
                                *stop = YES;
                            }
                        }];
                    }
                    cell.tagView = [[TagView2 alloc] initWithFrame:CGRectMake(0, 49 *SIZE, SCREEN_Width, 30 *SIZE) DataSouce:tagArr1 type:@"0" flowLayout:layout];
                    [cell.contentView addSubview:cell.tagView];
                    [cell.tagView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(cell.contentView).offset(0);
                        make.top.equalTo(cell.contentView).offset(49 *SIZE);
                        make.height.equalTo(@(30 *SIZE));
                        make.right.equalTo(cell.contentView).offset(0);
                        make.bottom.equalTo(cell.contentView).offset(-39 *SIZE);
                    }];
                    return cell;
                }else{
                    CustomDetailTableCell5 *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomDetailTableCell5"];
                    if (!cell) {
                        cell = [[CustomDetailTableCell5 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CustomDetailTableCell5"];
                    }
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    CustomRequireModel *model = _dataArr[0];
                    cell.contentL.text = model.comment;
                    return cell;
                }
            }
        }
    }else{
        
        if (_item == 1) {
            
            NSString * Identifier = @"CustomDetailTableCell2";
            CustomDetailTableCell2 *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
            if (!cell) {
                
                cell = [[CustomDetailTableCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            NSArray *arr = [self getDetailConfigArrByConfigState:FOLLOW_TYPE];
            [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if ([_FollowArr[indexPath.row][@"follow_type"] integerValue] == [obj[@"id"] integerValue]) {
                    
                    cell.wayL.text = [NSString stringWithFormat:@"跟进方式:%@",obj[@"param"]];
                    *stop = YES;
                }
            }];
            
            cell.intentionL.text = [NSString stringWithFormat:@"购买意向度:%@",_FollowArr[indexPath.row][@"intent"]];
            cell.urgentL.text = [NSString stringWithFormat:@"购买紧迫度:%@",_FollowArr[indexPath.row][@"urgency"]];
            cell.contentL.text = _FollowArr[indexPath.row][@"comment"];
            cell.timeL.text = [NSString stringWithFormat:@"跟进时间:%@",_FollowArr[indexPath.row][@"follow_time"]];
            
            return cell;
        }else{
            
            NSString * Identifier = @"CustomDetailTableCell3";
            CustomDetailTableCell3 *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
            if (!cell) {
                
                cell = [[CustomDetailTableCell3 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.tag = indexPath.row;
            [cell setDataDic:_projectArr[indexPath.row]];
            
            NSMutableArray *tempArr = [@[] mutableCopy];
            for (int i = 0; i < [_projectArr[indexPath.row][@"property_tags"] count]; i++) {
                
                [_propertyArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    if ([obj[@"id"] integerValue] == [_projectArr[indexPath.row][@"property_tags"][i] integerValue]) {
                        
                        [tempArr addObject:obj[@"param"]];
                        *stop = YES;
                    }
                }];
            }
            
            NSArray *tempArr1 = _projectArr[indexPath.row][@"project_tags"];
            
            NSArray *tempArr3 = @[tempArr,tempArr1.count == 0 ? @[]:tempArr1];
            [cell settagviewWithdata:tempArr3];
            
            cell.recommendBtnBlock3 = ^(NSInteger index) {
                
                if (_dataArr.count) {
                    
                    CustomRequireModel *model = _dataArr[0];
//                    self.customDetailTable.userInteractionEnabled = NO;
                    [BaseRequest POST:RecommendClient_URL parameters:@{@"project_id":_projectArr[index][@"project_id"],@"client_need_id":model.need_id,@"client_id":model.client_id} success:^(id resposeObject) {
                        
//                        self.customDetailTable.userInteractionEnabled = YES;
//                        NSLog(@"%@",resposeObject);
                        if ([resposeObject[@"code"] integerValue] == 200) {
                            
                            [self alertControllerWithNsstring:@"推荐成功" And:nil WithDefaultBlack:^{
                                
                                [self MatchRequest];
                            }];
                        }else{
                            
                            [self alertControllerWithNsstring:@"温馨提示" And:resposeObject[@"msg"]];
                        }
                    } failure:^(NSError *error) {
                        
//                        NSLog(@"%@",error);
                        [self showContent:@"网络错误"];
                    }];
                }
            };
            
            return cell;
        }
    }
}


- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"客户详情";

    self.rightBtn.hidden = NO;
    [self.rightBtn setImage:[UIImage imageNamed:@"add_3"] forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(ActionRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    
    _customDetailTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - TAB_BAR_MORE) style:UITableViewStyleGrouped];
    _customDetailTable.estimatedRowHeight = 367 *SIZE;
    _customDetailTable.rowHeight = UITableViewAutomaticDimension;
    _customDetailTable.estimatedSectionHeaderHeight = 320 *SIZE;
//    _customDetailTable.sectionHeaderHeight = UITableViewAutomaticDimension;
    _customDetailTable.backgroundColor = YJBackColor;
    _customDetailTable.delegate = self;
    _customDetailTable.dataSource = self;
    _customDetailTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_customDetailTable];
}


@end
