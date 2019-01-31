//
//  CustomLookConfirmDetailVC.m
//  云渠道
//
//  Created by 谷治墙 on 2019/1/8.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "CustomLookConfirmDetailVC.h"

#import "SingleContentCell.h"
#import "BaseHeader.h"
#import "CountDownCell.h"
#import "BrokerageDetailTableCell3.h"

@interface CustomLookConfirmDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSString *_recordId;
    NSArray *_contentArr;
    NSString *_state;
    NSMutableArray *_processArr;
//    NSString *_endtime;
}
@property (nonatomic, strong) UITableView *detailTable;

@property (nonatomic, strong) UIButton *gotoBtn;

@end

@implementation CustomLookConfirmDetailVC

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
    
    [self initDataSource];
    [self initUI];
    [self RequestMethod];
}

- (void)initDataSource{
    
    
    _processArr = [@[] mutableCopy];
}

- (void)RequestMethod{
    
//    [BaseRequest GET:HouseRecordValueDetail_URL parameters:@{@"survey_id":_recordId} success:^(id resposeObject) {
//        
//        NSLog(@"%@",resposeObject);
//        if ([resposeObject[@"code"] integerValue] == 200) {
//            
//            [self SetData:resposeObject[@"data"]];
//        }else{
//            
//            [self showContent:resposeObject[@"msg"]];
//        }
//    } failure:^(NSError *error) {
//        
//        NSLog(@"%@",error);
//        [self showContent:@"网络错误"];
//    }];
}


- (void)SetData:(NSDictionary *)data{
    
    _contentArr = @[@[[NSString stringWithFormat:@"来源：%@",data[@""]]],@[[NSString stringWithFormat:@"推荐编号：%@",data[@""]],[NSString stringWithFormat:@"归属门店：%@",data[@""]],[NSString stringWithFormat:@"客户姓名：%@",data[@""]],[NSString stringWithFormat:@"客户性别：%@",data[@""]],[NSString stringWithFormat:@"联系方式：%@",data[@""]],[NSString stringWithFormat:@"推荐时间：%@",data[@""]],[NSString stringWithFormat:@"报备时间：%@",data[@""]]],@[[NSString stringWithFormat:@"意向城市：%@",data[@""]],[NSString stringWithFormat:@"区域街道：%@",data[@""]],[NSString stringWithFormat:@"意向单价：%@",data[@""]],[NSString stringWithFormat:@"意向总价：%@",data[@""]],[NSString stringWithFormat:@"意向面积：%@",data[@""]],[NSString stringWithFormat:@"意向户型：%@",data[@""]],[NSString stringWithFormat:@"意向楼层：%@",data[@""]],[NSString stringWithFormat:@"装修标准：%@",data[@""]],[NSString stringWithFormat:@"超想要求：%@",data[@""]],[NSString stringWithFormat:@"付款方式：%@",data[@""]],[NSString stringWithFormat:@"关注配套：%@",data[@""]],[NSString stringWithFormat:@"已选标签：%@",data[@""]],[NSString stringWithFormat:@"备注：%@",data[@""]]]];
    
//    _endtime = [NSString stringWithFormat:@"%@",data[@"timeLimit"]];
    _processArr = [NSMutableArray arrayWithArray:data[@"process"]];
    _state = [NSString stringWithFormat:@"%@",data[@"current_state"]];//data[@"current_state"];
    [_detailTable reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (_contentArr.count) {
        
        return 1 + _contentArr.count;
    }else{
        
        return 0;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
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
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    BaseHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BaseHeader"];
    if (!header) {
        
        header = [[BaseHeader alloc] initWithReuseIdentifier:@"BaseHeader"];
    }
    
    if (section == 0) {
        
        header.titleL.text = @"抢单时间";
    }else if(section == 1){
        
        header.titleL.text = @"推荐信息";
    }else{
        
        header.titleL.text = @"需求信息";
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
    
    if (indexPath.section < _contentArr.count) {
        
        SingleContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SingleContentCell"];
        if (!cell) {
            
            cell = [[SingleContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SingleContentCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.lineView.hidden = YES;
        
        cell.contentL.text = _contentArr[indexPath.section][indexPath.row];
        
        return cell;
    }else{
        
        BrokerageDetailTableCell3 *cell = [tableView dequeueReusableCellWithIdentifier:@"BrokerageDetailTableCell3"];
        if (!cell) {
            cell = [[BrokerageDetailTableCell3 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BrokerageDetailTableCell3"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.titleL.text = [NSString stringWithFormat:@"%@时间：%@",_processArr[indexPath.row][@"process_name"],_processArr[indexPath.row][@"time"]];
        if (indexPath.row == 0) {
            
            cell.upLine.hidden = YES;
        }else{
            
            cell.upLine.hidden = NO;
        }
        if (indexPath.row == _processArr.count - 1) {
            
            cell.downLine.hidden = YES;
        }else{
            
            cell.downLine.hidden = NO;
        }
        return cell;
    }
}

- (void)initUI{
    
    self.titleLabel.text = @"已确认详情";
    self.navBackgroundView.hidden = NO;
    
    _detailTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - 40 *SIZE - TAB_BAR_MORE) style:UITableViewStyleGrouped];
    
    _detailTable.rowHeight = UITableViewAutomaticDimension;
    _detailTable.estimatedRowHeight = 31 *SIZE;
    _detailTable.backgroundColor = self.view.backgroundColor;
    _detailTable.delegate = self;
    _detailTable.dataSource = self;
    _detailTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_detailTable];
    
    _gotoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _gotoBtn.frame = CGRectMake(0, SCREEN_Height - 40 *SIZE - TAB_BAR_MORE, SCREEN_Width, 40 *SIZE + TAB_BAR_MORE);
//    [_gotoBtn addTarget:self action:@selector(<#selector#>) forControlEvents:UIControlEventTouchUpInside];
    [_gotoBtn setTitle:@"前往带看维护" forState:UIControlStateNormal];
    [self.view addSubview:_gotoBtn];
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
