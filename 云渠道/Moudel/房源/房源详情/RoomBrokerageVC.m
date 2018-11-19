//
//  RoomBrokerageVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/17.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RoomBrokerageVC.h"
#import "RoomBrokerageTableCell.h"
#import "RoomBrokerageTableCell2.h"
#import "RoomBrokerageTableHeader.h"
#import "C_brokerageCell.h"
#import "BrokerModel.h"

@interface RoomBrokerageVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableArray *_dataArr;
    NSMutableArray *_selectArr;
    RoomListModel *_roomModel;
    BrokerModel *_model;
    

}
@property (nonatomic, strong) UITableView *brokerageTable;
@property (nonatomic, strong) UIView *DefaultView;

@end

@implementation RoomBrokerageVC

- (instancetype)initWithModel:(RoomListModel *)model
{
    self = [super init];
    if (self) {
        
        _roomModel = model;
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
    
    _selectArr = [@[] mutableCopy];
    _dataArr = [@[] mutableCopy];
    _selectArr = [NSMutableArray arrayWithArray:@[@1,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0]];

    
}

- (void)RequestMethod{
    
    [BaseRequest GET:GetRuleNew_URL parameters:@{@"project_id":_roomModel.project_id,
                   @"agent_id":[UserModelArchiver unarchive].agent_id
                                              } success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {

            _model = [[BrokerModel alloc]initWithdata:resposeObject[@"data"]];
            [_brokerageTable reloadData];
            if ([_brokerage isEqualToString:@"no"]) {
                if (_model.companyarr.count == 0) {
                    [self.view addSubview:self.DefaultView];
                }
            }
            else
            {
                if (_model.dataarr.count == 0) {
                    [self.view addSubview:self.DefaultView];
                }
            }
        }
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        [self showContent:@"网络错误"];
    }];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
  
    if ([_brokerage isEqualToString:@"no"]) {
        return _model.companyarr.count;
    }
    else{
        return _model.dataarr.count;
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 51 *SIZE;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if ([_selectArr[section] integerValue]) {
        
        return 1;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
     if ([_brokerage isEqualToString:@"no"])
     {
         RoomBrokerageTableHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"RoomBrokerageTableHeader"];
         if (!header) {
             
             header = [[RoomBrokerageTableHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 51 *SIZE)];
         }
         
         if ([_model.companyarr[section][@"end_time"] isEqual:@"2037-12-31 23:59:59"]) {
             header.titleL.text = [NSString stringWithFormat:@"%@起",_model.companyarr[section][@"begin_time"]];
         }
         else{
             header.titleL.text = [NSString stringWithFormat:@"%@至%@",_model.companyarr[section][@"begin_time"],_model.companyarr[section][@"end_time"]];//@"2017-07-11至2017-08-10";
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
     }else
     {
        RoomBrokerageTableHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"RoomBrokerageTableHeader"];
        if (!header) {
            
            header = [[RoomBrokerageTableHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 51 *SIZE)];
        }
        
        if ([_model.dataarr[section][@"act_end"] isEqual:@"2037-12-31 23:59:59"]) {
            header.titleL.text = [NSString stringWithFormat:@"%@起",_model.dataarr[section][@"act_start"]];
        }
        else{
        header.titleL.text = [NSString stringWithFormat:@"%@至%@",_model.dataarr[section][@"act_start"],_model.dataarr[section][@"act_end"]];//@"2017-07-11至2017-08-10";
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
                _selectArr = [NSMutableArray arrayWithArray:@[@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0]];
                [_selectArr replaceObjectAtIndex:index withObject:@1];
            }
            [tableView reloadData];
        };
        
    

    return header;
     }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([_brokerage isEqualToString:@"no"])
    {
        C_brokerageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"C_brokerageCell"];
        if (!cell) {
            
            cell = [[C_brokerageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"C_brokerageCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.ruleView.titleImg.image = [UIImage imageNamed:@"rules"];
        cell.ruleView.titleL.text = @"报备规则";
        cell.ruleView.contentL.text = _model.companyarr[indexPath.row][@"basic"];
        return cell;
    }
    else{
    if (indexPath.section == 0) {
        
        RoomBrokerageTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomBrokerageTableCell"];
        if (!cell) {
            
            cell = [[RoomBrokerageTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomBrokerageTableCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (_roomModel.sort) {
            cell.rankL.text = [NSString stringWithFormat:@"第%@名",_roomModel.sort];
        }else
        {
            cell.rankL.text = @"无排名";
        }
        
        [cell.rankL mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(cell.contentView).offset(114 *SIZE);
            make.height.equalTo(@(13 *SIZE));
            make.top.equalTo(cell.contentView).offset(50 *SIZE);
            make.width.equalTo(@(cell.rankL.mj_textWith + 5 *SIZE));
        }];
        [cell SetLevel:[_roomModel.cycle integerValue]];
        cell.ruleView.titleImg.image = [UIImage imageNamed:@"rules"];
        cell.ruleView.titleL.text = @"报备规则";
        cell.ruleView.contentL.text = _model.bsicarr[indexPath.section][@"basic"];
        cell.standView.titleImg.image = [UIImage imageNamed:@"commission4"];
        cell.standView.titleL.text = @"结佣标准";
        NSMutableArray *arr = _model.breakerinfo;
        cell.standView.contentL.text = arr[indexPath.section];
        

        return cell;
    }else{
        
        RoomBrokerageTableCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomBrokerageTableCell2"];
        if (!cell) {
            
            cell = [[RoomBrokerageTableCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomBrokerageTableCell2"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.ruleView.titleImg.image = [UIImage imageNamed:@"rules"];
        cell.ruleView.titleL.text = @"报备规则";
        cell.ruleView.contentL.text = _model.bsicarr[indexPath.section][@"basic"];
        cell.standView.titleImg.image = [UIImage imageNamed:@"commission4"];
        cell.standView.titleL.text = @"结佣标准";
        NSMutableArray *arr = _model.breakerinfo;
        cell.standView.contentL.text = arr[indexPath.section];
        
        return cell;
    }
    }
}

- (void)initUI{
    
    _brokerageTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, self.view.frame.size.height - NAVIGATION_BAR_HEIGHT - TAB_BAR_MORE) style:UITableViewStylePlain];
    _brokerageTable.rowHeight = UITableViewAutomaticDimension;
    _brokerageTable.estimatedRowHeight = 214 *SIZE;
    _brokerageTable.backgroundColor = CH_COLOR_white;;
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
