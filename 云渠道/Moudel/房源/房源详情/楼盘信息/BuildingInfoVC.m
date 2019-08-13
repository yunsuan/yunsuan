//
//  BuildingInfoVC.m
//  云渠道
//
//  Created by xiaoq on 2018/4/2.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BuildingInfoVC.h"
#import "BuildinginfoCell.h"
#import "LicenceCell.h"

@interface BuildingInfoVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *_titlelist;
    NSMutableArray *_contentlist;
    NSString *_infoid;
}
@property (nonatomic , strong) UITableView *Mytableview;
-(void)initUI;
-(void)initDataSouce;
@end

@implementation BuildingInfoVC

- (instancetype)initWithinfoid:(NSString *)infoid
{
    self = [super init];
    if (self) {
        
        _infoid = infoid;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDataSouce];
    [self initUI];
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"楼盘详情";
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
}

-(void)initUI
{
    [self.view addSubview:self.Mytableview];
}

-(void)initDataSouce
{
    _titlelist = [NSMutableArray arrayWithArray:@[@[@"项目名称",@"楼盘状态",@"开发商",@"区域位置",@"设计公司",@"楼盘地址",@"售楼处地址"],@[@"建筑类型",@"均价",@"价格区间",@"占地面积",@"装修标准",@"建筑面积",@"容积率",@"绿化率",@"规划户数",@"规划车位"],@[@"物业类型",@"物业公司",@"物业费",@"供暖方式",@"供水类型",@"供电类型"]]];
    _contentlist = [@[] mutableCopy];
    [self RequestMethod];
}

- (void)RequestMethod{
    
    [BaseRequest GET:ProjectBuildInfo_URL parameters:@{@"info_id":_infoid} success:^(id resposeObject) {
        
        //        NSLog(@"%@",resposeObject);
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [self SetData:resposeObject[@"data"]];
        }
        else{
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        //        NSLog(@"%@",error);
        [self showContent:@"网络错误"];
    }];
}

- (void)SetData:(NSDictionary *)data{
    
    NSMutableDictionary *tempData = [[NSMutableDictionary alloc] init];
    
    [data enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        if ([key isEqualToString:@"property"]) {
            
            [tempData setObject:obj forKey:key];
        }else{
            
            if ([key isEqualToString:@"sale_permit"]) {
                
                [tempData setObject:obj forKey:key];
            }else{
                
                [tempData setObject:[NSString stringWithFormat:@"%@",obj] forKey:key];
            }
        }
    }];
    
    [tempData enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        if ([key isEqualToString:@"property"]) {
            
            
        }else{
            
            if ([key isEqualToString:@"sale_permit"]) {
                
                
            }else{
                
                if ([obj isEqualToString:@""]) {
                    
                    [tempData setObject:@"暂无数据" forKey:key];
                }else{
                    
                    if ([key isEqualToString:@"average_price"]) {
                        
                        if ([obj isEqualToString:@"0"]) {
                            
                            [tempData setObject:@"暂无数据" forKey:key];
                        }else{
                            
                            [tempData setObject:[NSString stringWithFormat:@"%@元/㎡",obj] forKey:key];
                        }
                    }
                    
                    if ([key isEqualToString:@"floor_space"]) {
                        
                        if ([obj isEqualToString:@"0"]) {
                            
                            [tempData setObject:@"暂无数据" forKey:key];
                        }else{
                            
                            [tempData setObject:[NSString stringWithFormat:@"%@㎡",obj] forKey:key];
                        }
                    }
                    
                    if ([key isEqualToString:@"covered_area"]) {
                        
                        if ([obj isEqualToString:@"0"]) {
                            
                            [tempData setObject:@"暂无数据" forKey:key];
                        }else{
                            
                            [tempData setObject:[NSString stringWithFormat:@"%@㎡",obj] forKey:key];
                        }
                    }
                    
                    if ([key isEqualToString:@"greening_rate"]) {
                        
                        if ([obj isEqualToString:@"0"]) {
                            
                            [tempData setObject:@"暂无数据" forKey:key];
                        }else{
                            
                            [tempData setObject:[NSString stringWithFormat:@"%@%@",obj,@"%"] forKey:key];
                        }
                    }
                    
                    if ([key isEqualToString:@"parking_num"]) {
                        
                        if ([obj isEqualToString:@"0"]) {
                            
                            [tempData setObject:@"暂无数据" forKey:key];
                        }else{
                            
                            [tempData setObject:[NSString stringWithFormat:@"%@%@",obj,@""] forKey:key];
                        }
                    }
                    
                    if ([key isEqualToString:@"households_num"]) {
                        
                        if ([obj isEqualToString:@"0"]) {
                            
                            [tempData setObject:@"暂无数据" forKey:key];
                        }else{
                            
                            [tempData setObject:[NSString stringWithFormat:@"%@%@",obj,@""] forKey:key];
                        }
                    }
                    
                    
                    if ([key isEqualToString:@"plot_retio"]) {
                        
                        if ([obj isEqualToString:@"0"]) {
                            
                            [tempData setObject:@"暂无数据" forKey:key];
                        }else{
                            
                            [tempData setObject:[NSString stringWithFormat:@"%@",obj] forKey:key];
                        }
                    }
                    
#pragma warning ---- 修改  ---
                    
                    if ([key isEqualToString:@"property_cost"]) {
                        
                        if ([obj isEqualToString:@"0"]) {
                            
                            [tempData setObject:@"暂无数据" forKey:key];
                        }else{
                            
                            [tempData setObject:[NSString stringWithFormat:@"%@元/㎡/月",obj] forKey:key];
                        }
                    }
                }
            }
        }
    }];
    
    NSArray *arr1 = @[tempData[@"project_name"],tempData[@"sale_state"],tempData[@"developer_name"],[NSString stringWithFormat:@"%@-%@-%@",tempData[@"province_name"],tempData[@"city_name"],tempData[@"district_name"]],tempData[@"decoration_company"],tempData[@"absolute_address"],tempData[@"sale_address"]];
    NSArray *arr2 = @[tempData[@"build_type"],[NSString stringWithFormat:@"%@",tempData[@"average_price"]],[tempData[@"max_price"] integerValue]>0?[NSString stringWithFormat:@"%@万-%@万",tempData[@"min_price"],tempData[@"max_price"]]:@"暂无数据",[NSString stringWithFormat:@"%@ ",tempData[@"covered_area"]],tempData[@"decoration_standard"],[NSString stringWithFormat:@"%@",tempData[@"floor_space"]],[NSString stringWithFormat:@"%@",tempData[@"plot_retio"]],[NSString stringWithFormat:@"%@",tempData[@"greening_rate"]],[NSString stringWithFormat:@"%@",tempData[@"households_num"]],[NSString stringWithFormat:@"%@",tempData[@"parking_num"]]];
    NSArray *arr3 = @[[tempData[@"property"] componentsJoinedByString:@","],tempData[@"property_company_name"],[NSString stringWithFormat:@"%@",tempData[@"property_cost"]],tempData[@"heat_supply"],tempData[@"water_supply"],tempData[@"power_supply"]];
    
    NSArray *tempArr = @[@"发证时间"];
    NSMutableArray *arr4 = [NSMutableArray arrayWithArray:tempArr];
    for (NSDictionary *dic in tempData[@"sale_permit"]) {
        
        [arr4 addObject:dic[@"permit_time"]];
    }
    NSArray *tempArr1 = @[@"预售许可证"];
    NSMutableArray *arr5 = [NSMutableArray arrayWithArray:tempArr1];
    for (NSDictionary *dic in tempData[@"sale_permit"]) {
        
        [arr5 addObject:dic[@"sale_permit"]];
    }
    
    [_titlelist addObject:arr5];
    
    
    [_contentlist addObject:arr1];
    [_contentlist addObject:arr2];
    [_contentlist addObject:arr3];
    [_contentlist addObject:arr4];
    
    [_Mytableview reloadData];
}

#pragma mark  ---  delegate  ---
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSArray *arr = _titlelist[section];
    return arr.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    if (_contentlist.count) {
        
        return _titlelist.count;
    }
    return 0;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (!section) {
        
        return 2 *SIZE;
    }
    return 7 *SIZE;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 360*SIZE, 10*SIZE)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section != 3) {
        static NSString *CellIdentifier = @"BuildinginfoCell";
        
        BuildinginfoCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[BuildinginfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            
        }
        [cell settitle:_titlelist[indexPath.section][indexPath.row] content:_contentlist[indexPath.section][indexPath.row]];
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else{
        static NSString *CellIdentifier = @"LicenceCell";
        LicenceCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[LicenceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        if (indexPath.row == 0) {
            
            cell.titlelab.textColor = YJContentLabColor;
            cell.contentlab.textColor = YJContentLabColor;
        }else{
            
            cell.titlelab.textColor = YJTitleLabColor;
            cell.contentlab.textColor = YJTitleLabColor;
        }
        [cell settitle:_titlelist[indexPath.section][indexPath.row] content:_contentlist[indexPath.section][indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
}

#pragma mark  ---  懒加载   ---

-(UITableView *)Mytableview
{
    if(!_Mytableview)
    {
        _Mytableview =   [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, 360*SIZE, SCREEN_Height-NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
        _Mytableview.rowHeight = UITableViewAutomaticDimension;
        _Mytableview.estimatedRowHeight = 34.4 *SIZE;
        _Mytableview.backgroundColor = YJBackColor;
        _Mytableview.delegate = self;
        _Mytableview.dataSource = self;
        
        [_Mytableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }
    return _Mytableview;
}


@end
