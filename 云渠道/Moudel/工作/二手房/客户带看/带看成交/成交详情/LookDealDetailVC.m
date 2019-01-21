//
//  LookDealDetailVC.m
//  云渠道
//
//  Created by 谷治墙 on 2019/1/8.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "LookDealDetailVC.h"

#import "BaseHeader.h"
#import "RoomBrokerageTableHeader.h"
#import "SingleContentCell.h"
#import "BrokerageDetailTableCell3.h"

@interface LookDealDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSString *_lookId;
    NSMutableArray *_proArr;
    NSArray *_Pace;
}

@property (nonatomic, strong) UITableView *detailTable;
@end

@implementation LookDealDetailVC

//- (instancetype)initWithLookId:(NSString *)lookId
//{
//    self = [super init];
//    if (self) {
//        
//        _lookId = lookId;
//    }
//    return self;
//}
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    
//    [self initUI];
//}
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    
//    return 4 + _proArr.count;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    
//    if (section == 3) {
//        
//        return 0;
//    }else if (section > 3) {
//        
//        return [_proArr[section - 4] count];
//    }else{
//        
//        return 1;
//    }
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    
//    if (section == 1) {
//        
//        return nil;
//    }else if (section > 3){
//        
//        RoomBrokerageTableHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"RoomBrokerageTableHeader"];
//        if (!header) {
//            
//            header = [[RoomBrokerageTableHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 51 *SIZE)];
//        }
//        
//        header.titleL.text = [NSString stringWithFormat:@"%@ 带看记录",_proArr[section][@""]];
//        header.dropBtn.tag = section;
//        
//        header.dropBtnBlock = ^(NSInteger index) {
//            
//            [tableView reloadData];
//        };
//        
//        return header;
//    }else{
//        
//        BaseHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BaseHeader"];
//        if (!header) {
//            
//            header = [[BaseHeader alloc] initWithReuseIdentifier:@"BaseHeader"];
//        }
//        
//        if (section == 0) {
//            
//            header.titleL.text = @"成交信息";
//        }else if (section == 2){
//            
//            header.titleL.text = @"成交信息";
//        }else{
//            
//            header.titleL.text = @"成交信息";
//        }
//        
//        return header;
//    }
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    if (indexPath.section == 0) {
//        
//        SingleContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SingleContentCell"];
//        if (!cell) {
//            
//            cell = [[SingleContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SingleContentCell"];
//        }
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        
//        cell.lineView.hidden = YES;
//        
//        cell.contentL.text = [NSString stringWithFormat:@"成交时间：%@",@""];
//        
//        return cell;
//    }else if (indexPath.section == 1){
//        
//        SingleContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SingleContentCell"];
//        if (!cell) {
//            
//            cell = [[SingleContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SingleContentCell"];
//        }
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        
//        cell.lineView.hidden = YES;
//        
//        cell.contentL.text = @"";
//        
//        return cell;
//    }else if (indexPath.section == 2){
//        
//        SingleContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SingleContentCell"];
//        if (!cell) {
//            
//            cell = [[SingleContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SingleContentCell"];
//        }
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        
//        cell.lineView.hidden = YES;
//        
//        cell.contentL.text = @"";
//        
//        return cell;
//    }else{
//        
//        BrokerageDetailTableCell3 *cell = [tableView dequeueReusableCellWithIdentifier:@"BrokerageDetailTableCell3"];
//        if (!cell) {
//            cell = [[BrokerageDetailTableCell3 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BrokerageDetailTableCell3"];
//        }
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        
//        cell.titleL.text = [NSString stringWithFormat:@"%@时间：%@",_Pace[indexPath.row][@"process_name"],_Pace[indexPath.row][@"time"]];
//        if (indexPath.row == 0) {
//            
//            cell.upLine.hidden = YES;
//        }else{
//            
//            cell.upLine.hidden = NO;
//        }
//        if (indexPath.row == _Pace.count - 1) {
//            
//            cell.downLine.hidden = YES;
//        }else{
//            
//            cell.downLine.hidden = NO;
//        }
//        return cell;
//    }
//}
//
//- (void)initUI{
//    
//    self.navBackgroundView.hidden = NO;
//    self.titleLabel.text = @"成交详情";
//    
//    _detailTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
//    _detailTable.backgroundColor = self.view.backgroundColor;
//    _detailTable.delegate = self;
//    _detailTable.dataSource = self;
//    
//    [self.view addSubview:_detailTable];
//}

@end
