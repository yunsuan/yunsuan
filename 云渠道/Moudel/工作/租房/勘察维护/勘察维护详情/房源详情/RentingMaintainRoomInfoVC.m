//
//  RentingMaintainRoomInfoVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/7/30.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RentingMaintainRoomInfoVC.h"

#import "BaseHeader.h"
#import "TitleContentBaseCell.h"
#import "BrokerageDetailTableCell3.h"

@interface RentingMaintainRoomInfoVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSArray *_contentArr;
    NSArray *_dataArr;
    NSArray *_titleArr;
    NSMutableDictionary *_dataDic;
}
@property (nonatomic, strong) UITableView *table;

@end

@implementation RentingMaintainRoomInfoVC

- (instancetype)initWithDataDic:(NSDictionary *)data
{
    self = [super init];
    if (self) {
        
        _dataDic = [NSMutableDictionary dictionaryWithDictionary:data];
        [_dataDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            
            if ([obj isKindOfClass:[NSNull class]]) {
                
                [_dataDic setObject:@"" forKey:key];
            }else{
                
                if ([obj isKindOfClass:[NSNumber class]]) {
                    
                    [_dataDic setObject:[NSString stringWithFormat:@"%@",obj] forKey:key];
                }else{
                    
                    [_dataDic setObject:obj forKey:key];
                }
            }
        }];
        
        [_dataDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            
            if ([obj isKindOfClass:[NSArray class]]) {
                
                if (![obj count]) {
                    
                    [_dataDic setObject:@"暂无数据" forKey:key];
                }
                
            }else if (![obj length]) {
                
                [_dataDic setObject:@"暂无数据" forKey:key];
            }
        }];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
    _titleArr = @[@"挂牌信息",@"房源信息",@"物业信息"];
    
    if (_type == 1) {
        
        _dataArr = @[@[@"挂牌价格",@"单价",@"收款方式",@"看房方式"],@[@"房源编号",@"小区地址",@"物业类型",@"面积",@"朝向",@"楼层",@"建成年代"]];
        
        _contentArr = @[@[[NSString stringWithFormat:@"%@万",_dataDic[@"price"]],[NSString stringWithFormat:@"%@元/㎡",_dataDic[@"unit_price"]],_dataDic[@"pay_way"],_dataDic[@"check_way"]],@[_dataDic[@"house_code"],_dataDic[@"absolute_address"],@"住宅",[NSString stringWithFormat:@"%@㎡",_dataDic[@"build_area"]],_dataDic[@"orientation"],_dataDic[@"floor_type"],[NSString stringWithFormat:@"%@",_dataDic[@"build_year"]]]];
    }else if (_type == 2) {
        
        _dataArr = @[@[@"挂牌价格",@"单价",@"收款方式",@"看房方式",@"上架时间"],@[@"房源编号",@"地址",@"物业类型",@"面积",@"门宽",@"层高",@"层数",@"适合业态",@"限制业态",@"建成年代"],@[@"物业信息",@"物业费",@"供暖方式",@"供水类型",@"供电类型"]];
        _contentArr = @[@[[NSString stringWithFormat:@"%@万",_dataDic[@"price"]],[NSString stringWithFormat:@"%@元/㎡",_dataDic[@"unit_price"]],_dataDic[@"pay_way"],_dataDic[@"check_way"],_dataDic[@"create_time"]],@[_dataDic[@"house_code"],_dataDic[@"absolute_address"],@"商铺",[NSString stringWithFormat:@"%@㎡",_dataDic[@"build_area"]],[NSString stringWithFormat:@"%@m",_dataDic[@"shop_width"]],[NSString stringWithFormat:@"%@m",_dataDic[@"shop_height"]],[NSString stringWithFormat:@"%@",_dataDic[@"floor"]],_dataDic[@"shop_type"],_dataDic[@"limit_shop_type"],[NSString stringWithFormat:@"%@",_dataDic[@"build_year"]]],@[_dataDic[@"property_company_name"],[NSString stringWithFormat:@"%@元/月",_dataDic[@"property_cost"]],_dataDic[@"heat_supply"],_dataDic[@"water_supply"],_dataDic[@"power_supply"]]];
    }else{
        
        _dataArr = @[@[@"挂牌价格",@"单价",@"收款方式",@"看房方式",@"上架时间"],@[@"房源编号",@"地址",@"物业类型",@"面积",@"门宽",@"层高",@"楼层",@"建成年代"],@[@"物业信息",@"物业费",@"供暖方式",@"供水类型",@"供电类型"]];
        _contentArr = @[@[[NSString stringWithFormat:@"%@万",_dataDic[@"price"]],[NSString stringWithFormat:@"%@元/㎡",_dataDic[@"unit_price"]],_dataDic[@"pay_way"],_dataDic[@"check_way"],_dataDic[@"create_time"]],@[_dataDic[@"house_code"],_dataDic[@"absolute_address"],@"写字楼",[NSString stringWithFormat:@"%@㎡",_dataDic[@"build_area"]],[NSString stringWithFormat:@"%@m",_dataDic[@"office_width"]],[NSString stringWithFormat:@"%@m",_dataDic[@"office_height"]],[NSString stringWithFormat:@"%@",_dataDic[@"floor_type"]],[NSString stringWithFormat:@"%@",_dataDic[@"build_year"]]],@[_dataDic[@"property_company_name"],[NSString stringWithFormat:@"%@元/月",_dataDic[@"property_cost"]],_dataDic[@"heat_supply"],_dataDic[@"water_supply"],_dataDic[@"power_supply"]]];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _dataArr.count + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == _dataArr.count) {
        
        return self.progressArr.count;
    }else{
        
        return [_dataArr[section] count];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == _dataArr.count) {
        
        return 0;
    }
    return 40 *SIZE;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 3 *SIZE;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [[UIView alloc] init];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    BaseHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BaseHeader"];
    if (!header) {
        
        header = [[BaseHeader alloc] initWithReuseIdentifier:@"BaseHeader"];
    }
    if (section < _dataArr.count) {
        
        header.titleL.text = _titleArr[section];
    }
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == _dataArr.count) {
        
        BrokerageDetailTableCell3 *cell = [tableView dequeueReusableCellWithIdentifier:@"BrokerageDetailTableCell3"];
        if (!cell) {
            cell = [[BrokerageDetailTableCell3 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BrokerageDetailTableCell3"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.titleL.text = [NSString stringWithFormat:@"%@时间：%@",self.progressArr[indexPath.row][@"name"],self.progressArr[indexPath.row][@"time"]];
        if (indexPath.row == 0) {
            
            cell.upLine.hidden = YES;
        }else{
            
            cell.upLine.hidden = NO;
        }
        if (indexPath.row == self.progressArr.count - 1) {
            
            cell.downLine.hidden = YES;
        }else{
            
            cell.downLine.hidden = NO;
        }
        return cell;
    }else{
        
        TitleContentBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TitleContentBaseCell"];
        if (!cell) {
            
            cell = [[TitleContentBaseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TitleContentBaseCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.titleL.text = _dataArr[indexPath.section][indexPath.row];
        cell.contentL.text = _contentArr[indexPath.section][indexPath.row];
        
        return cell;
    }
}

- (void)initUI{
    
    self.titleLabel.text = @"房源信息";
    self.navBackgroundView.hidden = NO;
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 40 *SIZE;
    _table.sectionHeaderHeight = UITableViewAutomaticDimension;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.backgroundColor = self.view.backgroundColor;
    _table.delegate = self;
    _table.dataSource = self;
    [self.view addSubview:_table];
}

@end
