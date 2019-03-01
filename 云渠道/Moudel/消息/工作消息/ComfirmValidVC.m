//
//  ComfirmValidVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/5/16.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "ComfirmValidVC.h"
//#import "BaseHeader.h"
#import "InfoDetailCell.h"
#import "BrokerageDetailTableCell3.h"

@interface ComfirmValidVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_checkArr;
    NSArray *_data;
    NSArray *_titleArr;
    NSString *_clientid;
    NSString *_messageId;
//    NSString *_endtime;
    NSString *_name;
    NSArray *_Pace;
    NSMutableDictionary *_dataDic;
}
@property (nonatomic , strong) UITableView *validTable;

@property (nonatomic , strong) UIButton *printBtn;

@end

@implementation ComfirmValidVC

-(instancetype)initWithClientId:(NSString *)ClientID messageId:(NSString *)messageId
{
    self =[super init];
    if (self) {
        
        _clientid = ClientID;
        _messageId = messageId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self post];
    [self initDataSouce];
    [self initUI];
}

-(void)post{
    [BaseRequest GET:MessageProejectValueDetail_URL
          parameters:@{
                       @"client_id":_clientid,
                       @"message_id":_messageId
                       }
             success:^(id resposeObject) {

                 if ([resposeObject[@"code"] integerValue] ==200) {
                     
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
                     
                     if ([_dataDic[@"tel_check_info"] isKindOfClass:[NSDictionary class]] && [_dataDic[@"tel_check_info"] count]) {
                         
                         _checkArr = @[[NSString stringWithFormat:@"确认人：%@",_dataDic[@"tel_check_info"][@"confirmed_agent_name"]],[NSString stringWithFormat:@"性别：%@",[_dataDic[@"tel_check_info"][@"confirmed_agent_sex"] integerValue] == 0 ? @"":[_dataDic[@"tel_check_info"][@"confirmed_agent_sex"] integerValue] == 1?@"男":@"女"],[NSString stringWithFormat:@"联系方式：%@",_dataDic[@"tel_check_info"][@"confirmed_agent_tel"]],[NSString stringWithFormat:@"确认时间：%@",_dataDic[@"tel_check_info"][@"confirmed_time"]]];
                     }
                     
                     if ([_dataDic[@"comsulatent_advicer"] isEqualToString:@""]) {
                         
                         _data = @[@[[NSString stringWithFormat:@"推荐编号：%@",_dataDic[@"client_id"]],[NSString stringWithFormat:@"推荐时间：%@",_dataDic[@"create_time"]],[NSString stringWithFormat:@"推荐类别：%@",_dataDic[@"recommend_type"]],[NSString stringWithFormat:@"推荐人：%@",_dataDic[@"broker_name"]],[NSString stringWithFormat:@"联系方式：%@",_dataDic[@"broker_tel"]],[NSString stringWithFormat:@"项目名称：%@",_dataDic[@"project_name"]],adress,[NSString stringWithFormat:@"客户姓名：%@",_dataDic[@"name"]],sex,tel,[NSString stringWithFormat:@"备注：%@",_dataDic[@"client_comment"]]],@[[NSString stringWithFormat:@"客户姓名：%@",_dataDic[@"confirm_name"]],[NSString stringWithFormat:@"联系方式：%@",_dataDic[@"confirm_tel"]],[NSString stringWithFormat:@"到访人数：%@人",_dataDic[@"visit_num"]],[NSString stringWithFormat:@"到访时间：%@",_dataDic[@"process"][1][@"time"]],[NSString stringWithFormat:@"置业顾问：%@",_dataDic[@"property_advicer_wish"]],[NSString stringWithFormat:@"到访确认人：%@",_dataDic[@"butter_name"]],[NSString stringWithFormat:@"确认人电话：%@",_dataDic[@"butter_tel"]]]];
                     }else{
                         
                         _data = @[@[[NSString stringWithFormat:@"推荐编号：%@",_dataDic[@"client_id"]],[NSString stringWithFormat:@"推荐时间：%@",_dataDic[@"create_time"]],[NSString stringWithFormat:@"推荐类别：%@",_dataDic[@"recommend_type"]],[NSString stringWithFormat:@"推荐人：%@",_dataDic[@"broker_name"]],[NSString stringWithFormat:@"联系方式：%@",_dataDic[@"broker_tel"]],[NSString stringWithFormat:@"项目名称：%@",_dataDic[@"project_name"]],adress,[NSString stringWithFormat:@"客户姓名：%@",_dataDic[@"name"]],sex,tel,[NSString stringWithFormat:@"置业顾问：%@",_dataDic[@"comsulatent_advicer"]],[NSString stringWithFormat:@"备注：%@",_dataDic[@"client_comment"]]],@[[NSString stringWithFormat:@"客户姓名：%@",_dataDic[@"confirm_name"]],[NSString stringWithFormat:@"联系方式：%@",_dataDic[@"confirm_tel"]],[NSString stringWithFormat:@"到访人数：%@人",_dataDic[@"visit_num"]],[NSString stringWithFormat:@"到访时间：%@",_dataDic[@"process"][1][@"time"]],[NSString stringWithFormat:@"置业顾问：%@",_dataDic[@"property_advicer_wish"]],[NSString stringWithFormat:@"到访确认人：%@",_dataDic[@"butter_name"]],[NSString stringWithFormat:@"确认人电话：%@",_dataDic[@"butter_tel"]]]];
                     }
                     
//                     _endtime = _dataDic[@"timeLimit"];
                     _Pace = resposeObject[@"data"][@"process"];
                     [_validTable reloadData];
                 }
             }
             failure:^(NSError *error) {
                 [self showContent:@"网络错误"];
             }];
}


-(void)initDataSouce
{
    
    _dataDic = [@{} mutableCopy];
    _titleArr = @[@"推荐信息",@"到访信息",@"判重信息"];
}

//- (void)ActionPrintBtn:(UIButton *)btn{
//
//
//}

#pragma mark    -----  delegate   ------

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (_checkArr.count) {
        
        if (section == 3) {
            
            return _Pace.count;
        }else if (section == 2){
            
            return _checkArr.count;
        }
        else
        {
            NSArray *arr = _data[section];
            return arr.count;
        }
    }else{
        
        if (section == 2) {
            
            return _Pace.count;
        }
        else
        {
            NSArray *arr = _data[section];
            return arr.count;
        }
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *backview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 360*SIZE, 53*SIZE)];
    backview.backgroundColor = [UIColor whiteColor];
    UIView * header = [[UIView alloc]initWithFrame:CGRectMake(10*SIZE , 19*SIZE, 6.7*SIZE, 13.3*SIZE)];
    header.backgroundColor = YJBlueBtnColor;
    
    UILabel * title = [[UILabel alloc]initWithFrame:CGRectMake(27.3*SIZE, 19*SIZE, 300*SIZE, 16*SIZE)];
    title.font = [UIFont systemFontOfSize:15.3*SIZE];
    title.textColor = YJTitleLabColor;
    if (section < 3) {
        
        [backview addSubview:header];
        title.text = _titleArr[section];
        [backview addSubview:title];
    }
    return backview;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if (section < 3) {
        
        return 53*SIZE;
    }
    return 0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    if (_checkArr.count) {
        
        return _data.count ? _Pace.count?_data.count + 2:_data.count + 1:0;
    }else{
        
        return _data.count ? _Pace.count?_data.count + 1:_data.count:0;
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_checkArr.count) {
        
        if(indexPath.section == 3){
            
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
            if (indexPath.section == 2) {
                
                [cell SetCellContentbystring:_checkArr[indexPath.row]];
            }else{
                
                [cell SetCellContentbystring:_data[indexPath.section][indexPath.row]];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }else{
        
        if(indexPath.section == 2){
            
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
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"客户到访有效详情";
    
    _validTable = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, 360*SIZE, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStyleGrouped];
    _validTable.rowHeight = UITableViewAutomaticDimension;
    _validTable.estimatedRowHeight = 150 *SIZE;
    _validTable.backgroundColor = YJBackColor;
    _validTable.delegate = self;
    _validTable.dataSource = self;
    [_validTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:_validTable];
    
}

@end
