//
//  LookMaintainDetailLookRecordVC.m
//  云渠道
//
//  Created by 谷治墙 on 2019/1/28.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "LookMaintainDetailLookRecordVC.h"

#import "LookMaintainDetailLookRecordSingleVC.h"

#import "BaseHeader.h"
#import "SingleContentCell.h"
#import "LookMaintainDetailLookRecordCell.h"
#import "LookMaintainDetailRoomCell.h"

@interface LookMaintainDetailLookRecordVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSArray *_customArr;
    NSMutableArray *_lookArr;
    NSMutableDictionary *_dataDic;
}
@property (nonatomic, strong) UITableView *table;

@end

@implementation LookMaintainDetailLookRecordVC

- (instancetype)initWithData:(NSDictionary *)data
{
    self = [super init];
    if (self) {
        
//        _customArr = [@[] mutableCopy];
        _dataDic = [data mutableCopy];
        _lookArr = [@[] mutableCopy];
        _lookArr = [data[@"list"] mutableCopy];
        _customArr = @[[NSString stringWithFormat:@"意向度：%@",data[@"intent"]],[NSString stringWithFormat:@"带看时间：%@",data[@"take_time"]],[NSString stringWithFormat:@"带看人数：%@",data[@"take_visit_num"]],[NSString stringWithFormat:@"客户中意点：%@",data[@"client_like"]],[NSString stringWithFormat:@"客户抗性：%@",data[@"client_dislike"]],[NSString stringWithFormat:@"是否出价：%@",[data[@"price"] integerValue] == 0 ? @"否":@"是"],[NSString stringWithFormat:@"出价金额：%@万",data[@"price"]],[NSString stringWithFormat:@"付款方式：%@",[data[@"pay_way"] componentsJoinedByString:@","]],[NSString stringWithFormat:@"附带看：%@",data[@"attach_agent"]],[NSString stringWithFormat:@"备注：%@",data[@"take_comment"]]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (_customArr.count) {
        
        return 2;
    }else{
        
        return 0;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return _customArr.count;
    }else{
        
        return _lookArr.count + 1;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    BaseHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BaseHeader"];
    if (!header) {
        
        header = [[BaseHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
    }
    
    if (section == 0) {
        
        header.titleL.text = @"最近一次信息";
    }else{
        
        header.titleL.text = [NSString stringWithFormat:@"带看次数(%ld次)",_lookArr.count];
    }
    
    return header;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [[UIView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 6 *SIZE;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            
            LookMaintainDetailRoomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LookMaintainDetailRoomCell"];
            if (!cell) {
                
                cell = [[LookMaintainDetailRoomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LookMaintainDetailRoomCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.data = _dataDic;
            return cell;
        }
        SingleContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SingleContentCell"];
        if (!cell) {
            
            cell = [[SingleContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SingleContentCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.contentL.text = _customArr[indexPath.row];
        cell.lineView.hidden = YES;
        return cell;
    }else{
        
        LookMaintainDetailLookRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LookMaintainDetailLookRecordCell"];
        if (!cell) {
            
            cell = [[LookMaintainDetailLookRecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LookMaintainDetailLookRecordCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.tag = indexPath.row;
        
        if (indexPath.row == 0) {
            
            cell.contentView.backgroundColor = YJBackColor;
            cell.editBtn.hidden = YES;
            cell.timeL.text = @"时间";
            cell.intentL.text = @"意向度";
            cell.isBuyL.text = @"是否出价";
            cell.priceL.text = @"出价详情";
        }else{
            
            cell.timeL.text = _lookArr[indexPath.row - 1][@"time"];
            cell.intentL.text = [NSString stringWithFormat:@"%@",_lookArr[indexPath.row - 1][@"intent"]];
            cell.isBuyL.text = [_lookArr[indexPath.row - 1][@"price"] integerValue] == 0 ? @"否":@"是";
            cell.priceL.text = [NSString stringWithFormat:@"%@万",_lookArr[indexPath.row - 1][@"price"]];
            cell.editBtn.hidden = NO;
            cell.contentView.backgroundColor = [UIColor whiteColor];
        }
        
        cell.lookMaintainDetailLookRecordCellBlock = ^(NSInteger index) {
          
            LookMaintainDetailLookRecordSingleVC *nextVC = [[LookMaintainDetailLookRecordSingleVC alloc] initWithHouseTakeFollowId:[NSString stringWithFormat:@"%@",_lookArr[index - 1][@"house_take_follow_id"]]];
            [self.navigationController pushViewController:nextVC animated:YES];
        };
        return cell;
    }
}




- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"已看房源详情";
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    _table.backgroundColor = self.view.backgroundColor;
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 100 *SIZE;
    _table.delegate = self;
    _table.dataSource = self;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_table];
}

@end
