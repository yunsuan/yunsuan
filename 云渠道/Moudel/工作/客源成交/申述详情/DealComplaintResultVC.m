//
//  DealComplaintResultVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/5/8.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "DealComplaintResultVC.h"

#import "BaseHeader.h"
#import "CountDownCell.h"
#import "InfoDetailCell.h"
#import "BrokerageDetailTableCell3.h"

@interface DealComplaintResultVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_data;
    NSArray *_titleArr;
    NSString *_clientId;
    NSString *_appealId;
    NSMutableDictionary *_dataDic;
    NSString *_endtime;
    NSString *_name;
    NSArray *_Pace;
}
@property (nonatomic , strong) UITableView *unCompleteTable;

@property (nonatomic , strong) UIButton *cancelBtn;

@end

@implementation DealComplaintResultVC

- (instancetype)initWithAppealId:(NSString *)appealId
{
    self = [super init];
    if (self) {
        
        _appealId = appealId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSouce];
    [self initUI];
}


-(void)initDataSouce
{
    
    _titleArr = @[@"申诉信息",@"无效信息",@"推荐信息",@"到访信息"];
    [self AppealRequestMethod];
}

- (void)AppealRequestMethod{
    
    [BaseRequest GET:BrokerAppealDetail_URL parameters:@{@"appeal_id":_appealId} success:^(id resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            _dataDic = [NSMutableDictionary dictionaryWithDictionary:resposeObject[@"data"]];
            [_dataDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                
                if ([obj isKindOfClass:[NSNull class]]) {
                    
                    [_dataDic setObject:@"" forKey:key];
                }
            }];
            
            NSString *sex = @"客户性别：";
            if ([_dataDic[@"sex"] integerValue] == 1) {
                sex = @"客户性别：男";
            }
            if([_dataDic[@"sex"] integerValue] == 2)
            {
                sex =@"客户性别：女";
            }
            _name = _dataDic[@"name"];
            NSString *tel = _dataDic[@"tel"];
            NSArray *arr = [tel componentsSeparatedByString:@","];
            if (arr.count>0) {
                tel = [NSString stringWithFormat:@"联系方式：%@",arr[0]];
            }
            else{
                tel = @"联系方式：";
            }
            NSString *adress = _dataDic[@"absolute_address"];
            adress = [NSString stringWithFormat:@"项目地址：%@-%@-%@ %@",_dataDic[@"province_name"],_dataDic[@"city_name"],_dataDic[@"district_name"],adress];
            
            if ([_dataDic[@"comsulatent_advicer"] isEqualToString:@""]) {
                
                _data = @[@[[NSString stringWithFormat:@"申诉类型：%@",_dataDic[@"type"]],[NSString stringWithFormat:@"申诉描述：%@",_dataDic[@"comment"]],[NSString stringWithFormat:@"处理状态：%@",_dataDic[@"state"]],[NSString stringWithFormat:@"处理结果：%@",_dataDic[@"solve_info"]]],@[[NSString stringWithFormat:@"无效类型：%@",_dataDic[@"disabled_state"]],[NSString stringWithFormat:@"无效描述：%@",_dataDic[@"disabled_reason"]],[NSString stringWithFormat:@"无效时间：%@",_dataDic[@"disabled_time"]]],@[[NSString stringWithFormat:@"推荐编号：%@",_dataDic[@"client_id"]],[NSString stringWithFormat:@"推荐时间：%@",_dataDic[@"recommend_time"]],[NSString stringWithFormat:@"推荐类别：%@",_dataDic[@"recommend_type"]],[NSString stringWithFormat:@"推荐人：%@",_dataDic[@"broker_name"]],[NSString stringWithFormat:@"联系方式：%@",_dataDic[@"broker_tel"]],[NSString stringWithFormat:@"项目名称：%@",_dataDic[@"project_name"]],adress,[NSString stringWithFormat:@"客户姓名：%@",_dataDic[@"name"]],sex,tel,[NSString stringWithFormat:@"备注：%@",_dataDic[@"client_comment"]]],@[[NSString stringWithFormat:@"客户姓名：%@",_dataDic[@"confirm_name"]],[NSString stringWithFormat:@"联系方式：%@",_dataDic[@"confirm_tel"]],[NSString stringWithFormat:@"到访人数：%@人",_dataDic[@"visit_num"]],[NSString stringWithFormat:@"到访时间：%@",_dataDic[@"visit_time"]],[NSString stringWithFormat:@"置业顾问：%@",_dataDic[@"property_advicer_wish"]],[NSString stringWithFormat:@"到访确认人：%@",_dataDic[@"butter_name"]],[NSString stringWithFormat:@"确认人电话：%@",_dataDic[@"butter_tel"]]]];
            }else{
                
                _data = @[@[[NSString stringWithFormat:@"申诉类型：%@",_dataDic[@"type"]],[NSString stringWithFormat:@"申诉描述：%@",_dataDic[@"comment"]],[NSString stringWithFormat:@"处理状态：%@",_dataDic[@"state"]],[NSString stringWithFormat:@"处理结果：%@",_dataDic[@"solve_info"]]],@[[NSString stringWithFormat:@"无效类型：%@",_dataDic[@"disabled_state"]],[NSString stringWithFormat:@"无效描述：%@",_dataDic[@"disabled_reason"]],[NSString stringWithFormat:@"无效时间：%@",_dataDic[@"disabled_time"]]],@[[NSString stringWithFormat:@"推荐编号：%@",_dataDic[@"client_id"]],[NSString stringWithFormat:@"推荐时间：%@",_dataDic[@"recommend_time"]],[NSString stringWithFormat:@"推荐类别：%@",_dataDic[@"recommend_type"]],[NSString stringWithFormat:@"推荐人：%@",_dataDic[@"broker_name"]],[NSString stringWithFormat:@"联系方式：%@",_dataDic[@"broker_tel"]],[NSString stringWithFormat:@"项目名称：%@",_dataDic[@"project_name"]],adress,[NSString stringWithFormat:@"客户姓名：%@",_dataDic[@"name"]],sex,tel,[NSString stringWithFormat:@"置业顾问：%@",_dataDic[@"comsulatent_advicer"]],[NSString stringWithFormat:@"备注：%@",_dataDic[@"client_comment"]]],@[[NSString stringWithFormat:@"客户姓名：%@",_dataDic[@"confirm_name"]],[NSString stringWithFormat:@"联系方式：%@",_dataDic[@"confirm_tel"]],[NSString stringWithFormat:@"到访人数：%@人",_dataDic[@"visit_num"]],[NSString stringWithFormat:@"到访时间：%@",_dataDic[@"visit_time"]],[NSString stringWithFormat:@"置业顾问：%@",_dataDic[@"property_advicer_wish"]],[NSString stringWithFormat:@"到访确认人：%@",_dataDic[@"butter_name"]],[NSString stringWithFormat:@"确认人电话：%@",_dataDic[@"butter_tel"]]]];
            }
            _endtime = _dataDic[@"timeLimit"];
            _Pace = _dataDic[@"process"];
            
            [_unCompleteTable reloadData];
        }
        else
        {
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [self showContent:@"网络错误"];
    }];
}

- (void)ActionCancelBtn:(UIButton *)btn{
    
    [BaseRequest POST:AppealCancel_URL parameters:@{@"appeal_id":_appealId} success:^(id resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"inValidReload" object:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"appealReload" object:nil];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [self showContent:@"网络错误"];
    }];
}

#pragma mark    -----  delegate   ------

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 3) {
        
        return _Pace.count;
    }
    else
    {
        NSArray *arr = _data[section];
        return arr.count;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    BaseHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BaseHeader"];
    if (!header) {
        
        header = [[BaseHeader alloc] initWithReuseIdentifier:@"BaseHeader"];
    }
    header.lineView.hidden = YES;
    
    if (section < 3) {
        
        header.titleL.text = _titleArr[section];
    }
    
    return header;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section < 3) {
        
        return 40 *SIZE;
    }
    return 0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return _data.count ? _Pace.count?_data.count + 1:_data.count:0;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 3) {
        
        BrokerageDetailTableCell3 *cell = [tableView dequeueReusableCellWithIdentifier:@"BrokerageDetailTableCell3"];
        if (!cell) {
            
            cell = [[BrokerageDetailTableCell3 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BrokerageDetailTableCell3"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.titleL.text = [NSString stringWithFormat:@"%@时间：%@",_Pace[indexPath.row][@"process_name"],_Pace[indexPath.row][@"time"]];
        if (indexPath.row == 0) {
            
            cell.upLine.hidden = YES;
        }else{
            
            cell.upLine.hidden = NO;
        }
        if (indexPath.row == _Pace.count - 1) {
            
            cell.downLine.hidden = YES;
        }else{
            
            cell.downLine.hidden = NO;
        }
        return cell;
        
    }else{
        
        static NSString *CellIdentifier = @"InfoDetailCell";
        InfoDetailCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[InfoDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        [cell SetCellContentbystring:_data[indexPath.section][indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"申诉详情";

    _unCompleteTable = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, 360*SIZE, SCREEN_Height - NAVIGATION_BAR_HEIGHT- 40 *SIZE - TAB_BAR_MORE) style:UITableViewStyleGrouped];
    _unCompleteTable.rowHeight = UITableViewAutomaticDimension;
    _unCompleteTable.estimatedRowHeight = 150 *SIZE;
    _unCompleteTable.backgroundColor = YJBackColor;
    _unCompleteTable.delegate = self;
    _unCompleteTable.dataSource = self;
    [_unCompleteTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:_unCompleteTable];
    
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancelBtn.frame = CGRectMake(0, SCREEN_Height - 40 *SIZE - TAB_BAR_MORE, SCREEN_Width, 40 *SIZE + TAB_BAR_MORE);
    _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_cancelBtn addTarget:self action:@selector(ActionCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_cancelBtn setTitle:@"取消申诉" forState:UIControlStateNormal];
    [_cancelBtn setBackgroundColor:YJBlueBtnColor];
    [_cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:_cancelBtn];
    
}

@end
