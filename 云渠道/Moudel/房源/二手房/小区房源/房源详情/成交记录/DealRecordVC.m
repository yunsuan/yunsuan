//
//  DealRecordVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/6/12.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "DealRecordVC.h"
#import "DealRecordDetailVC.h"
//#import "DealRecordCell.h"

#import "DealRecordCell.h"

@interface DealRecordVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSString *_project_id;
    NSMutableArray *_dataArr;
}
@property (nonatomic, strong) UITableView *dealTable;

@end

@implementation DealRecordVC

- (instancetype)initWithProjectId:(NSString *)projectId
{
    self = [super init];
    if (self) {
        
        _project_id = projectId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _dataArr = [@[] mutableCopy];
    [self initUI];
    [self RequestMethod];
}

- (void)RequestMethod{
    
    [BaseRequest GET:HouseHouseSubHis_URL parameters:@{@"project_id":_project_id} success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            
            [self SetData:resposeObject[@"data"][@"data"]];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        [self showContent:@"网络错误"];
    }];
}

- (void)SetData:(NSArray *)data{
    
    for (int i = 0; i < data.count; i++) {
        
        NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:data[i]];
        [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            
            if ([obj isKindOfClass:[NSNull class]]) {
                
                if ([key isEqualToString:@"project_tags"] || [key isEqualToString:@"house_tags"]) {
                    
                    [tempDic setObject:@[] forKey:key];
                }else{
                    
                    [tempDic setObject:@"" forKey:key];
                }
            }else{
                
                if ([key isEqualToString:@"project_tags"] || [key isEqualToString:@"house_tags"]) {
                    
                    [tempDic setObject:obj forKey:key];
                }else{
                    
                    [tempDic setObject:[NSString stringWithFormat:@"%@",obj] forKey:key];
                }
            }
        }];
        
        [_dataArr addObject:tempDic];
    }
    
    [_dealTable reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DealRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DealRecordCell"];
    if (!cell) {
        
        cell = [[DealRecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DealRecordCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (_dataArr.count) {
        
        [cell setData:_dataArr[indexPath.row]];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DealRecordDetailVC *nextVC = [[DealRecordDetailVC alloc] init];
    [self.navigationController pushViewController:nextVC animated:YES];
    
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"成交记录";
    
    _dealTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    
    _dealTable.rowHeight = UITableViewAutomaticDimension;
    _dealTable.estimatedRowHeight = 107 *SIZE;
    _dealTable.backgroundColor = self.view.backgroundColor;
    _dealTable.delegate = self;
    _dealTable.dataSource = self;
    _dealTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_dealTable];
}

@end
