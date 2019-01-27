//
//  StoreDetailVC.m
//  云渠道
//
//  Created by xiaoq on 2019/1/24.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "StoreDetailVC.h"
#import "BaseHeader.h"
#import "StoreDetailCell.h"
#import "SecdaryAllTableCell.h"
#import "SecdaryAllTableModel.h"
#import <MapKit/MapKit.h>

@interface StoreDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSString *_recommendId;
    NSMutableArray *_dataArr;
    NSDictionary *_store_info;
    NSInteger _page;
    NSString *_numofhouse;
}

@property (nonatomic, strong) UITableView *table;
@property (nonatomic , strong) UIButton *surebtn;
@end

@implementation StoreDetailVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
    [self requestMethodWithpage:_page];
}

- (void)initDataSource{
    
    _dataArr = [@[] mutableCopy];
    _store_info = [@{} mutableCopy];
    _numofhouse = 0;
}

-(void)action_sure
{
    
}

-(void)action_phone
{
    NSString *phone = _store_info[@"contact_tel"];
    if (phone.length) {
        
        //获取目标号码字符串,转换成URL
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phone]];
        //调用系统方法拨号
        [[UIApplication sharedApplication] openURL:url];
    }else{
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"暂时未获取到联系电话"];
    }
}

-(void)action_map
{
    double lat = [_store_info[@"latitude"] doubleValue];
    double lon = [_store_info[@"longitude"] doubleValue];
    CLLocationCoordinate2D endCoor = CLLocationCoordinate2DMake(lat, lon);
    MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
    MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:endCoor addressDictionary:nil]];
    toLocation.name = _store_info[@"address"];
    [MKMapItem openMapsWithItems:@[currentLocation, toLocation] launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES]}];
}

- (void)requestMethodWithpage:(NSInteger )page{
    NSString *pagestr = [NSString stringWithFormat:@"%ld",page];
    
    [BaseRequest GET:DetailStore_URl parameters:@{@"store_id":_store_id,
                                                  @"type":_type,
                                                  @"page":pagestr
                                                  }
             success:^(id resposeObject) {
                 NSLog(@"%@",resposeObject);
                 if ([resposeObject[@"code"] integerValue]==200) {

                         _store_info = resposeObject[@"data"][@"store_info"];
                    
                     
                     if (page ==1) {
                         [_dataArr removeAllObjects];
                     }
                     _numofhouse = resposeObject[@"data"][@"houseList"][@"total"] ;
                       [self SetData:resposeObject[@"data"][@"houseList"][@"data"]];
                 }
                 
        

    } failure:^(NSError *error) {

        [self showContent:@"网络错误"];
    }];
}

- (void)SetData:(NSMutableArray *)data{
    
    for (int i = 0; i < data.count; i++) {
        
        NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:data[i]];
        [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            
            if ([obj isKindOfClass:[NSNull class]]) {
                
                if ([key isEqualToString:@"house_tags"] || [key isEqualToString:@"project_tags"]) {
                    
                    [tempDic setObject:@[] forKey:key];
                }else{
                    
                    [tempDic setObject:@"" forKey:key];
                }
            }else{
                
                if ([key isEqualToString:@"house_tags"] || [key isEqualToString:@"project_tags"]) {
                    
                    
                }else{
                    
                    [tempDic setObject:[NSString stringWithFormat:@"%@",obj] forKey:key];
                }
            }
        }];
        
        SecdaryAllTableModel *model = [[SecdaryAllTableModel alloc] init];//WithDictionary:tempDic];
        model.price_change = tempDic[@"price_change"];
        model.img_url = tempDic[@"img_url"];
        model.house_id = tempDic[@"house_id"];
        model.title = tempDic[@"title"];
        model.describe = tempDic[@"describe"];
        model.price = tempDic[@"price"];
        model.unit_price = tempDic[@"unit_price"];
        model.property_type = tempDic[@"property_type"];
        model.store_name = tempDic[@"store_name"];
        model.project_tags = [NSMutableArray arrayWithArray:tempDic[@"project_tags"]];
        model.house_tags = [NSMutableArray arrayWithArray:tempDic[@"house_tags"]];
        model.type = tempDic[@"type"];
        [_dataArr addObject:model];
    }
    
    [self.table reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
    }else
    {
        return _dataArr.count;
    }

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    return 40*SIZE;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        BaseHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BaseHeader"];
        if (!header) {
            
            header = [[BaseHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
        }
        
        header.titleL.text = @"门店信息";
        
        return header;
    }
    else{
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 360*SIZE, 40*SIZE)];
        view.backgroundColor = COLOR(240, 240, 240, 1);
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(10*SIZE, 12*SIZE, 200*SIZE, 16*SIZE)];
        lab.textColor = YJTitleLabColor;
        lab.font = [UIFont systemFontOfSize:15 *SIZE];
        if ([_type isEqualToString:@"1"]) {
            if (_numofhouse) {
                 lab.text = [NSString stringWithFormat:@"可售房源（%@）",_numofhouse];
            }
           
        }else
        {
            
            if (_numofhouse) {
                  lab.text = [NSString stringWithFormat:@"可租房源（%@）",_numofhouse];
            }
        }
        [view addSubview:lab];
            return view;
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section ==0) {
        StoreDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SingleContentCell"];
        if (!cell) {
            
            cell = [[StoreDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"StoreDetailCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setDataBydata:_store_info];
        [cell.mapbtn addTarget:self action:@selector(action_map) forControlEvents:UIControlEventTouchUpInside];
        [cell.phonebtn addTarget:self action:@selector(action_phone) forControlEvents:UIControlEventTouchUpInside];
//        cell.contentL.text = _dataArr[indexPath.row];
        
        return cell;
    }
    else{
        SecdaryAllTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SecdaryAllTableCell"];
        if (!cell) {
            
            cell = [[SecdaryAllTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SecdaryAllTableCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        SecdaryAllTableModel *model = _dataArr[indexPath.row];
        cell.model = model;
        return cell;
    }
}

- (void)initUI{
     self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"门店详情";
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT-TAB_BAR_HEIGHT) style:UITableViewStylePlain];
    _table.backgroundColor = self.view.backgroundColor;
    _table.delegate = self;
    _table.dataSource = self;
    [self.view addSubview:_table];
    [self.view addSubview:self.surebtn];
}


-(UIButton *)surebtn
{
    if (!_surebtn) {
        _surebtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _surebtn.frame =  CGRectMake(0, SCREEN_Height-TAB_BAR_HEIGHT, 360*SIZE, TAB_BAR_HEIGHT*SIZE);
        _surebtn.backgroundColor = YJBlueBtnColor;
        [_surebtn setTitle:@"推荐" forState:UIControlStateNormal];
        
        [_surebtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _surebtn.titleLabel.font = [UIFont systemFontOfSize:15.3*SIZE];
        [_surebtn addTarget:self action:@selector(action_sure) forControlEvents:UIControlEventTouchUpInside];
    }
    return _surebtn;
}

@end



