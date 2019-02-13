//
//  SecondryRecommnedStatusVC.m
//  云渠道
//
//  Created by 谷治墙 on 2019/2/13.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "SecondryRecommnedStatusVC.h"

#import "SecondryStatusTableCell.h"

@interface SecondryRecommnedStatusVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableArray *_dataArr;
    NSString *_clientId;
}
@property (nonatomic, strong) UITableView *reStatusTable;

@end

@implementation SecondryRecommnedStatusVC

- (instancetype)initWithClientId:(NSString *)clientId
{
    self = [super init];
    if (self) {
        
        _clientId = clientId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
    [self RequestMethod];
}
- (void)RequestMethod{
    
    [BaseRequest GET:TakeRecommendHis_URL parameters:@{@"client_id":_clientId} success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            _dataArr = [NSMutableArray arrayWithArray:resposeObject[@"data"]];
            [_reStatusTable reloadData];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [self showContent:@"网络错误"];
    }];
}

- (void)initDataSource{
    
    _dataArr = [@[] mutableCopy];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SecondryStatusTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SecondryStatusTableCell"];
    if (!cell) {
        
        cell = [[SecondryStatusTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SecondryStatusTableCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.dataDic = _dataArr[indexPath.section];
    //    cell.titleL.text = _dataArr[indexPath.row][@"project_name"];
    
    
    return cell;
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"已推门店";
    
    
    _reStatusTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStyleGrouped];
    _reStatusTable.rowHeight = UITableViewAutomaticDimension;
    _reStatusTable.estimatedRowHeight = 113 *SIZE;
    _reStatusTable.backgroundColor = self.view.backgroundColor;
    _reStatusTable.delegate = self;
    _reStatusTable.dataSource = self;
    _reStatusTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_reStatusTable];
}

@end
