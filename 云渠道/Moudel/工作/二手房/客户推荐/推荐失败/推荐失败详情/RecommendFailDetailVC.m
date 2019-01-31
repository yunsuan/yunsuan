//
//  RecommendFailDetailVC.m
//  云渠道
//
//  Created by 谷治墙 on 2019/1/21.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "RecommendFailDetailVC.h"

#import "RecommendFailComplaintVC.h"

#import "SingleContentCell.h"
#import "BaseHeader.h"
//#import "BrokerageDetailTableCell3.h"

@interface RecommendFailDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSString *_recommendId;
    NSArray *_contentArr;
    //    NSString *_sta/te;
    NSMutableArray *_processArr;
}

@property (nonatomic, strong) UITableView *detailTable;

@property (nonatomic, strong) UIButton *complaintBtn;

@end

@implementation RecommendFailDetailVC

- (instancetype)initWithRecommendId:(NSString *)recommendId;
{
    self = [super init];
    if (self) {
        
        _recommendId = recommendId;
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
    
    
    _processArr = [@[] mutableCopy];
}

- (void)ActionComplaintBtn:(UIButton *)btn{
    
    RecommendFailComplaintVC *nextVC = [[RecommendFailComplaintVC alloc] initWithRecommendId:_recommendId];
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (void)RequestMethod{
    
    [BaseRequest GET:RecommendBrokerDisabledDetail_URL parameters:@{@"recommend_id":_recommendId} success:^(id resposeObject) {
    
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
    
            [self SetData:resposeObject[@"data"]];
        }else{
    
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
    
        NSLog(@"%@",error);
        [self showContent:@"网络错误"];
    }];
}


- (void)SetData:(NSDictionary *)data{
    
    _contentArr = @[@[[NSString stringWithFormat:@"客源编号：%@",data[@"recommend_code"]],[NSString stringWithFormat:@"客户姓名：%@",data[@"client_name"]],[NSString stringWithFormat:@"客户性别：%@",[data[@"client_sex"] integerValue] == 1? @"男":@"女"],[NSString stringWithFormat:@"联系方式：%@",data[@"client_tel"]],[NSString stringWithFormat:@"推荐时间：%@",data[@"recommend_time"]],[NSString stringWithFormat:@"备注：%@",data[@"comment"]]],@[[NSString stringWithFormat:@"经纪人：%@",data[@"butter_name"]],[NSString stringWithFormat:@"联系电话：%@",data[@"butter_tel"]],[NSString stringWithFormat:@"门店编号：%@",data[@"store_code"]],[NSString stringWithFormat:@"门店名称：%@",data[@"store_name"]],[NSString stringWithFormat:@"接单时间：%@",data[@"accept_time"]]],@[[NSString stringWithFormat:@"失效时间：%@",data[@"disabled_time"]],[NSString stringWithFormat:@"失效类型：%@",data[@"disabled_state"]],[NSString stringWithFormat:@"失效缘由：%@",data[@"disabled_reason"]]]];
    [_detailTable reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    //    if (![_state isEqualToString:@"1"] && ![_state isEqualToString:@"2"]) {
    //
    if (_contentArr.count) {
        
        return 1 + _contentArr.count;
    }else{
        
        return 0;
    }
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    //    if (![_state isEqualToString:@"1"] && ![_state isEqualToString:@"2"]) {
    //
    if (section < _contentArr.count) {
        
        return [_contentArr[section] count];
    }else{
        
        return _processArr.count;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
    if (section == _contentArr.count) {
        
        return 0;
    }else{
        
        return 40 *SIZE;
    }
    //    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    BaseHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BaseHeader"];
    if (!header) {
        
        header = [[BaseHeader alloc] initWithReuseIdentifier:@"BaseHeader"];
    }
    
    //    if (![_state isEqualToString:@"1"] && ![_state isEqualToString:@"2"]) {
    
    if (section == 0) {
        
        header.titleL.text = @"报备信息";
    }else if(section == 1){
        
        header.titleL.text = @"抢单信息";
    }else{
        
        header.titleL.text = @"失效信息";
    }
    
    header.lineView.hidden = YES;
    
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 7 *SIZE;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [[UIView alloc] init];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SingleContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SingleContentCell"];
    if (!cell) {
        
        cell = [[SingleContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SingleContentCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.lineView.hidden = YES;
    
    cell.contentL.text = _contentArr[indexPath.section][indexPath.row];
    
    return cell;
}

- (void)initUI{
    
    self.titleLabel.text = @"失效详情";
    self.navBackgroundView.hidden = NO;
    
    _detailTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - 47 *SIZE - TAB_BAR_MORE) style:UITableViewStyleGrouped];
    
    _detailTable.rowHeight = UITableViewAutomaticDimension;
    _detailTable.estimatedRowHeight = 31 *SIZE;
    _detailTable.backgroundColor = self.view.backgroundColor;
    _detailTable.delegate = self;
    _detailTable.dataSource = self;
    _detailTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_detailTable];
    
    _complaintBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _complaintBtn.frame = CGRectMake(0, SCREEN_Height - TAB_BAR_MORE - 47 *SIZE, SCREEN_Width, 47 *SIZE + TAB_BAR_MORE);
    _complaintBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_complaintBtn addTarget:self action:@selector(ActionComplaintBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_complaintBtn setTitle:@"申诉" forState:UIControlStateNormal];
    [_complaintBtn setBackgroundColor:YJBlueBtnColor];
    [self.view addSubview:_complaintBtn];
}

-(void)refresh{
    
    [BaseRequest GET:FlushDate_URL parameters:nil success:^(id resposeObject) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"recommendReload" object:nil];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

@end
