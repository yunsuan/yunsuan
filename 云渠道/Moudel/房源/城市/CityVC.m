//
//  CityVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/5/14.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "CityVC.h"
#import "BMChineseSort.h"

@interface CityVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableArray *_cityArr;
    NSMutableArray *_dataArr;
    NSMutableArray *_nameArr;
    NSString *_city;
    NSString *_code;
}
@property (nonatomic, strong) UITableView *cityTable;

@property (nonatomic, strong) UILabel *cityLabel;

@end

@implementation CityVC

- (instancetype)initWithLabel:(NSString *)label
{
    self = [super init];
    if (self) {
        
        _city = label;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
    
    if (!_cityArr.count) {
        
        [self CityListRequest];
    }else{
        
        [self SetData:_cityArr];
    }
    
}

- (void)initDataSource{
    
    _cityArr = [@[] mutableCopy];
    _cityArr = [UserModel defaultModel].cityArr;
}

- (void)CityListRequest{
    
    [BaseRequest GET:OpenCity_URL parameters:nil success:^(id resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            _cityArr = [NSMutableArray arrayWithArray:resposeObject[@"data"]];
            [self SetData:_cityArr];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [self showContent:@"网络错误"];
    }];
}

- (void)SetData:(NSArray *)data{
    
    _nameArr = [BMChineseSort IndexWithArray:_cityArr Key:@"city_name"];
    _dataArr = [BMChineseSort sortObjectArray:_cityArr Key:@"city_name"];
    [UserModel defaultModel].cityArr = [NSMutableArray arrayWithArray:data];
    [UserModelArchiver archive];
    [_cityTable reloadData];
}


#pragma mark -- tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _nameArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [_dataArr[section] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return [_nameArr objectAtIndex:section];
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    
    return _nameArr;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    
    return index;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.textLabel.text = _dataArr[indexPath.section][indexPath.row][@"city_name"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    _code = _dataArr[indexPath.section][indexPath.row][@"city_code"];
    _city = _dataArr[indexPath.section][indexPath.row][@"city_name"];
    _cityLabel.text = [NSString stringWithFormat:@"当前选择：%@",_city];
    if (self.cityVCSaveBlock) {
        
        if (_code) {
            
            self.cityVCSaveBlock(_code,_city);
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            
            [self showContent:@"请选择城市"];
        }
    }
}



- (void)initUI{
    
    self.titleLabel.text = @"选择城市";
    self.navBackgroundView.hidden = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    _cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(11 *SIZE, NAVIGATION_BAR_HEIGHT + 15 *SIZE, 200 *SIZE, 13 *SIZE)];
    _cityLabel.textColor = COLOR(51, 51, 51, 1);
    _cityLabel.font = [UIFont boldSystemFontOfSize:13 *SIZE];
    _cityLabel.text = [NSString stringWithFormat:@"当前定位：%@",_city];
    [self.view addSubview:_cityLabel];
    
    
    _cityTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 40 *SIZE + NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - 40 *SIZE - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    _cityTable.backgroundColor = YJBackColor;;
    _cityTable.delegate = self;
    _cityTable.dataSource = self;
    _cityTable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _cityTable.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_cityTable];
}

@end
