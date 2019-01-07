//
//  OverviewVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/6/12.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "OverviewVC.h"

#import "BaseHeader.h"
#import "TitleContentBaseCell.h"

@interface OverviewVC ()<UITableViewDataSource,UITableViewDelegate>
{
    
    NSArray *_titleArr;
    NSMutableArray *_contentArr;
    NSString * _info_id;
}
@property (nonatomic, strong) UITableView *overTable;

@end

@implementation OverviewVC

- (instancetype)initWithinfoid:(NSString *)infoid
{
    self = [super init];
    if (self) {
        _info_id = infoid;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
    [self RequestMethod];
}

- (void)initDataSource{
    
    _titleArr = @[@[@"项目名称",@"楼盘状态",@"开发商",@"区域位置",@"设计公司",@"楼盘地址"],@[@"建筑类型",@"均价",@"价格区间",@"占地面积",@"装修标准",@"建筑面积",@"容积率",@"绿化率",@"规划户数",@"规划车位"],@[@"物业类型",@"物业公司",@"物业费",@"供暖方式",@"供水类型",@"供电类型"]];
    _contentArr = [@[] mutableCopy];
//    _contentArr = @[@[@"楼栋数",@"房屋总数",@"总户数",@"开发商",@"建成时间",@"建筑类型",@"绿化面积",@"建筑率",@"总建筑面积",@"建筑占地面积",@"绿化率",@"容积率",@"地上面积",@"总占地面积",@"地上车位",@"地下面积",@"地下车位",@"停车费"],@[@"物业公司",@"物业费",@"供暖方式",@"供水类型",@"供电类型"]];
}

- (void)RequestMethod{
    
    [BaseRequest GET:ProjectBuildInfo_URL parameters:@{@"info_id":_info_id} success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [self SetData:resposeObject[@"data"]];
        }else{
            
            
        }
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
    }];
}

- (void)SetData:(NSDictionary *)data{
    
    NSMutableDictionary *tempData = [NSMutableDictionary dictionaryWithDictionary:data];
    [tempData enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
       
        if ([key isEqualToString:@"sale_permit"] || [key isEqualToString:@"property"]) {
            
        }else{
            
            if ([obj isKindOfClass:[NSNull class]]) {
             
                [tempData setObject:@"" forKey:key];
            }else{
                
                [tempData setObject:[NSString stringWithFormat:@"%@",obj] forKey:key];
            }
        }
    }];
    
    [tempData enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        if ([obj isKindOfClass:[NSString class]]) {
            
            if ([obj isEqualToString:@""] || [obj isEqualToString:@"0"]) {
                
                [tempData setObject:@"暂无数据" forKey:key];
            }
        }
    }];
    
    NSArray *arr1 = @[tempData[@"project_name"],tempData[@"sale_state"],tempData[@"developer_name"],[NSString stringWithFormat:@"%@-%@-%@",tempData[@"province_name"],tempData[@"city_name"],tempData[@"district_name"]],tempData[@"decoration_company"],tempData[@"absolute_address"]];
    NSArray *arr2 = @[tempData[@"build_type"],[NSString stringWithFormat:@"%@元/㎡",tempData[@"average_price"]],[NSString stringWithFormat:@"%@万-%@万",tempData[@"min_price"],tempData[@"max_price"]],[NSString stringWithFormat:@"%@㎡ ",tempData[@"covered_area"]],tempData[@"decoration_standard"],[NSString stringWithFormat:@"%@㎡",tempData[@"floor_space"]],[NSString stringWithFormat:@"%@",tempData[@"plot_retio"]],[NSString stringWithFormat:@"%@",tempData[@"greening_rate"]],[NSString stringWithFormat:@"%@",tempData[@"households_num"]],[NSString stringWithFormat:@"%@",tempData[@"parking_num"]]];
    NSArray *arr3 = @[[tempData[@"property"] componentsJoinedByString:@","],tempData[@"property_company_name"],[NSString stringWithFormat:@"%@元/㎡",tempData[@"property_cost"]],tempData[@"heat_supply"],tempData[@"water_supply"],tempData[@"power_supply"]];

    [_contentArr addObject:arr1];
    [_contentArr addObject:arr2];
    [_contentArr addObject:arr3];
    [_overTable reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _contentArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [_titleArr[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 10 *SIZE;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40 *SIZE;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    BaseHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BaseHeader"];
    if (!header) {
        
        header = [[BaseHeader alloc] initWithReuseIdentifier:@"BaseHeader"];
    }
    if (section == 0) {
        
        header.titleL.text = @"基本信息";
    }else{
        
        header.titleL.text = @"物业信息";
    }
    
    return header;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [[UIView alloc] init];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"TitleContentBaseCell";
    
    TitleContentBaseCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        
        cell = [[TitleContentBaseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [cell setTitle:_titleArr[indexPath.section][indexPath.row] content:_contentArr[indexPath.section][indexPath.row]];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"小区概述";
    
    _overTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStyleGrouped];
    
    _overTable.rowHeight = UITableViewAutomaticDimension;
    _overTable.estimatedRowHeight = 43 *SIZE;
    _overTable.backgroundColor = self.view.backgroundColor;
    _overTable.delegate = self;
    _overTable.dataSource = self;
    _overTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_overTable];
}

@end
