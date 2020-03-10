//
//  CustomSelectCityVC.m
//  云渠道
//
//  Created by 谷治墙 on 2020/3/8.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "CustomSelectCityVC.h"

#import "BMChineseSort.h"

@interface CustomSelectCityVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableArray *_cityArr;
    NSMutableArray *_dataArr;
    NSMutableArray *_nameArr;
    NSString *_city;
    NSString *_code;
}
@property (nonatomic, strong) UITableView *cityTable;

@end

@implementation CustomSelectCityVC

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
    
    if (self.customSelectCityVCSaveBlock) {
        
        if (_code) {
            
            self.customSelectCityVCSaveBlock(_code,_city);
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
    
    _cityTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height -  NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    _cityTable.backgroundColor = YJBackColor;;
    _cityTable.delegate = self;
    _cityTable.dataSource = self;
    _cityTable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _cityTable.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_cityTable];
}

@end
