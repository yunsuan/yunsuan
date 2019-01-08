//
//  LookFailDetailVC.m
//  云渠道
//
//  Created by 谷治墙 on 2019/1/8.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "LookFailDetailVC.h"

#import "BrokerageDetailTableCell3.h"
#import "SingleContentCell.h"
#import "BaseHeader.h"

@interface LookFailDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSArray *_titleArr;
    NSArray *_contentArr;
    NSString *_recordId;
    NSMutableArray *_processArr;
}
@property (nonatomic, strong) UITableView *detailTable;

@end

@implementation LookFailDetailVC

- (instancetype)initWithRecordId:(NSString *)recordId
{
    self = [super init];
    if (self) {
        
        _recordId = recordId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _titleArr = @[@"失效信息",@"抢单信息"];
    [self initDataSource];
    [self initUI];
    [self RequestMethod];
}

- (void)initDataSource{
    
    
    _processArr = [@[] mutableCopy];
}

- (void)RequestMethod{
    
    [BaseRequest GET:HouseRecordDisabledDetail_URL parameters:@{@"survey_id":_recordId} success:^(id resposeObject) {
        
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
    
    _contentArr = @[@[[NSString stringWithFormat:@"失效时间：%@",data[@"disabled_time"]],[NSString stringWithFormat:@"失效类型：%@",data[@"disabled_state"]],[NSString stringWithFormat:@"失效描述：%@",data[@"disabled_reason"]]],@[[NSString stringWithFormat:@"推荐编号：%@",data[@"house_code"]],[NSString stringWithFormat:@"归属门店：%@",data[@"store_name"]],[NSString stringWithFormat:@"客户姓名：%@",data[@"name"]],[NSString stringWithFormat:@"客户性别：%@",[data[@"sex"] integerValue] == 2? @"女":@"男"],[NSString stringWithFormat:@"联系电话：%@",data[@"tel"]],[NSString stringWithFormat:@"抢单时间：%@",data[@"survey_time"]]]];
//
//    _processArr = [NSMutableArray arrayWithArray:data[@"process"]];
    [_detailTable reloadData];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
//    return _contentArr.count? _contentArr.count + 1:0;
    return _contentArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
//    if (section < _contentArr.count) {
    
        return [_contentArr[section] count];
//    }else{
//
//        return _processArr.count;
//    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
//    if (section < _contentArr.count) {
    
        return 40 *SIZE;
//    }
//    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    BaseHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BaseHeader"];
    if (!header) {
        
        header = [[BaseHeader alloc] initWithReuseIdentifier:@"BaseHeader"];
    }
    
//    if (section < _contentArr.count) {
    
        header.titleL.text = _titleArr[section];
//    }
//    header.lineView.hidden = YES;
    
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 7 *SIZE;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [[UIView alloc] init];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    if (indexPath.section < _contentArr.count) {
    
        SingleContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SingleContentCell"];
        if (!cell) {
            
            cell = [[SingleContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SingleContentCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.lineView.hidden = YES;
        
        cell.contentL.text = _contentArr[indexPath.section][indexPath.row];
        
        return cell;
//    }else{
//
//        BrokerageDetailTableCell3 *cell = [tableView dequeueReusableCellWithIdentifier:@"BrokerageDetailTableCell3"];
//        if (!cell) {
//            cell = [[BrokerageDetailTableCell3 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BrokerageDetailTableCell3"];
//        }
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//
//        cell.titleL.text = [NSString stringWithFormat:@"%@时间：%@",_processArr[indexPath.row][@"process_name"],_processArr[indexPath.row][@"time"]];
//        if (indexPath.row == 0) {
//
//            cell.upLine.hidden = YES;
//        }else{
//
//            cell.upLine.hidden = NO;
//        }
//        if (indexPath.row == _processArr.count - 1) {
//
//            cell.downLine.hidden = YES;
//        }else{
//
//            cell.downLine.hidden = NO;
//        }
//        return cell;
//    }
}

- (void)initUI{
    
    self.titleLabel.text = @"失效详情";
    self.navBackgroundView.hidden = NO;
    
    _detailTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStyleGrouped];
    
    _detailTable.rowHeight = UITableViewAutomaticDimension;
    _detailTable.estimatedRowHeight = 31 *SIZE;
    _detailTable.backgroundColor = self.view.backgroundColor;
    _detailTable.delegate = self;
    _detailTable.dataSource = self;
    _detailTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_detailTable];
}

@end
