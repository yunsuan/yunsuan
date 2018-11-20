//
//  ExperienceVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/3/30.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "ExperienceVC.h"
#import "ExperienceTableCell.h"

@interface ExperienceVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableArray *_dataArr;
}
@property (nonatomic, strong) UITableView *experienceTable;

@end

@implementation ExperienceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    [self initDataSource];
}

- (void)initDataSource{
    
    _dataArr = [@[] mutableCopy];
    [self RequestMethod];
}

- (void)RequestMethod{
    
    [BaseRequest GET:WorkHis_URL parameters:nil success:^(id resposeObject) {
        
   
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if ([resposeObject[@"data"] isKindOfClass:[NSArray class]]) {
                
                [self SetData:resposeObject[@"data"]];
            }else{
                
                
            }
        }else{
         
            [self showContent:resposeObject[@"msg"]];
        }
        [_experienceTable reloadData];
    } failure:^(NSError *error) {
        
        [self showContent:@"网络错误"];
    }];
}

- (void)SetData:(NSArray *)data{
    
    [_dataArr removeAllObjects];
    for (int i = 0; i < data.count; i++) {
        
        NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:data[i]];
        [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
           
            if ([obj isKindOfClass:[NSNull class]]) {
                
                [tempDic setObject:@"" forKey:key];
            }
        }];
        
        
        [_dataArr addObject:tempDic];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 144 *SIZE;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ExperienceTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ExperienceTableCell"];
    if (!cell) {
        
        cell = [[ExperienceTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ExperienceTableCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if ([_dataArr[indexPath.row][@"quit_time"] length]) {
        
        cell.timeL.text = [NSString stringWithFormat:@"%@至%@",_dataArr[indexPath.row][@"entry_time"],_dataArr[indexPath.row][@"quit_time"]];
    }else{
        
        cell.timeL.text = [NSString stringWithFormat:@"%@至今",_dataArr[indexPath.row][@"entry_time"]];
    }
    
    cell.companyL.text = _dataArr[indexPath.row][@"company_name"];
    cell.recommendL.text = [NSString stringWithFormat:@"推荐客户数量：%@",_dataArr[indexPath.row][@"his"][@"recommend"]];
    cell.visitL.text = [NSString stringWithFormat:@"到访客户数量：%@",_dataArr[indexPath.row][@"his"][@"value"]];
    cell.dealL.text = [NSString stringWithFormat:@"成交客户数量：%@",_dataArr[indexPath.row][@"his"][@"deal"]];
    cell.roleL.text = _dataArr[indexPath.row][@"role"];
    
    if (indexPath.row == 0) {
        
        cell.upLine.hidden = YES;
    }else{
        
        cell.upLine.hidden = NO;
    }
    
    if (indexPath.row == _dataArr.count - 1) {
        
        cell.downLine.hidden = YES;
    }else{
        
        cell.downLine.hidden = NO;
    }
    return cell;
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"工作经历";
    
    _experienceTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    _experienceTable.backgroundColor = self.view.backgroundColor;
    _experienceTable.delegate = self;
    _experienceTable.dataSource = self;
    _experienceTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_experienceTable];
}

@end
