//
//  SecAllRoomBrokerageVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/11/6.
//  Copyright © 2018 xiaoq. All rights reserved.
//

#import "SecAllRoomBrokerageVC.h"

//#import "RoomBrokerageTableCell.h"
//#import "RoomBrokerageTableCell2.h"
#import "RoomBrokerageTableHeader.h"
#import "SecBrokerCell.h"
#import "BlueTitleBaseCell.h"

@interface SecAllRoomBrokerageVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSArray *_titleArr;
    NSMutableArray *_selectArr;
    NSString *_houseId;
    NSMutableArray *_dataArr;
}

@property (nonatomic, strong) UITableView *brokerageTable;
@property (nonatomic, strong) UIView *DefaultView;

@end

@implementation SecAllRoomBrokerageVC

- (instancetype)initWithHouseId:(NSString *)houseId
{
    self = [super init];
    if (self) {
        
        _houseId = houseId;
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
    
    _titleArr = @[@"房源报备",@"勘察",@"客源推荐",@"带看",@"成交"];
    _selectArr = [@[] mutableCopy];
    _dataArr = [@[] mutableCopy];
    //    _selectArr = [NSMutableArray arrayWithArray:@[@1]];
}

- (void)RequestMethod{
    
    [BaseRequest GET:HouseHouseGetDistrictRule_URL parameters:@{@"house_id":_houseId} success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            _dataArr = [NSMutableArray arrayWithArray:resposeObject[@"data"]];
            for (int i = 0; i < _dataArr.count; i++) {
                
                if (i == 0) {
                    
                    [_selectArr addObject:@1];
                }else{
                    
                    [_selectArr addObject:@0];
                }
            }
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
        [_brokerageTable reloadData];
    } failure:^(NSError *error) {
        
        [self showContent:@"网络错误"];
        NSLog(@"%@",error);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _dataArr.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 51 *SIZE;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if ([_selectArr[section] integerValue]) {
        
        return 6;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    RoomBrokerageTableHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"RoomBrokerageTableHeader"];
    if (!header) {
        
        header = [[RoomBrokerageTableHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 51 *SIZE)];
    }
    
    if ([_dataArr[section][@"end_time"] isEqual:@"2037-12-31 23:59:59"]) {
        header.titleL.text = [NSString stringWithFormat:@"%@起",_dataArr[section][@"start_time"]];
    }
    else{
        header.titleL.text = [NSString stringWithFormat:@"%@至%@",_dataArr[section][@"start_time"],_dataArr[section][@"end_time"]];//@"2017-07-11至2017-08-10";
    }
    header.dropBtn.tag = section;
    if ([_selectArr[section] integerValue]) {
        
        [header.dropBtn setImage:[UIImage imageNamed:@"uparrow"] forState:UIControlStateNormal];
    }else{
        
        [header.dropBtn setImage:[UIImage imageNamed:@"downarrow"] forState:UIControlStateNormal];
    }
    header.dropBtnBlock = ^(NSInteger index) {
        
        if ([_selectArr[index] integerValue]) {
            
            [_selectArr replaceObjectAtIndex:index withObject:@0];
        }else{
            
            [_selectArr replaceObjectAtIndex:index withObject:@1];
        }
        [tableView reloadData];
    };
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        BlueTitleBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BlueTitleBaseCell"];
        if (!cell) {
            
            cell = [[BlueTitleBaseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BlueTitleBaseCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.titleL.text = @"佣金规则";
        
        return cell;
    }else{
        
        SecBrokerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SecBrokerCell"];
        if (!cell) {
            
            cell = [[SecBrokerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SecBrokerCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (indexPath.row == 1) {
            
            cell.upLine.hidden = YES;
        }else{
            
            cell.upLine.hidden = NO;
        }
        
        if (indexPath.row == 5) {
            
            cell.downLine.hidden = YES;
        }else{
            
            cell.downLine.hidden = NO;
        }
//        indexPath.row == 1 ? cell.upLine.hidden = YES : NO;
//        indexPath.row == 5 ? cell.downLine.hidden = YES : NO;
        
        cell.titleL.text = _titleArr[indexPath.row - 1];
        switch (indexPath.row) {
            case 1:
            {
                cell.contentL.text = _dataArr[indexPath.section][@"record_desc"];
                break;
            }
            case 2:
            {
                cell.contentL.text = _dataArr[indexPath.section][@"survey_desc"];
                break;
            }
            case 3:
            {
                cell.contentL.text = _dataArr[indexPath.section][@"recommend_desc"];
                break;
            }
            case 4:
            {
                cell.contentL.text = _dataArr[indexPath.section][@"take_look_desc"];
                break;
            }
            case 5:
            {
                cell.contentL.text = _dataArr[indexPath.section][@"contract_desc"];
                break;
            }
            default:
                break;
        }
        
        
        return cell;
    }
}

- (void)initUI{
    
    _brokerageTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, self.view.frame.size.height - NAVIGATION_BAR_HEIGHT - TAB_BAR_MORE) style:UITableViewStylePlain];
    _brokerageTable.rowHeight = UITableViewAutomaticDimension;
    _brokerageTable.estimatedRowHeight = 214 *SIZE;
    _brokerageTable.backgroundColor = [UIColor whiteColor];;
    _brokerageTable.delegate = self;
    _brokerageTable.dataSource = self;
    _brokerageTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_brokerageTable];
}

-(UIView *)DefaultView
{
    if (!_DefaultView) {
        _DefaultView = [[UIView alloc]initWithFrame:CGRectMake(0, 100*SIZE , SCREEN_Width , 20*SIZE)];
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, 20*SIZE)];
        lab.text = @"暂无渠道规则，还不能推荐哦";
        lab.textColor = YJContentLabColor;
        lab.textAlignment = NSTextAlignmentCenter;
        lab.font = [UIFont systemFontOfSize:13*SIZE];
        [_DefaultView addSubview:lab];
    }
    return _DefaultView;
}

@end
