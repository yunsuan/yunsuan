//
//  UnDealVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/5/8.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "UnDealVC.h"
#import "CompleteCustomVC1.h"

#import "BaseHeader.h"
#import "CountDownCell.h"
#import "InfoDetailCell.h"
#import "InvalidView.h"

@interface UnDealVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_data;
    NSArray *_titleArr;
    NSString *_str;
    NSString *_endtime;
    NSString *_name;
    NSMutableDictionary *_dataDic;
}
@property (nonatomic , strong) UITableView *Maintableview;
@property (nonatomic , strong) UIButton *confirmBtn;
@property (nonatomic, strong) InvalidView *invalidView;

@end

@implementation UnDealVC

- (instancetype)initWithString:(NSString *)str
{
    self = [super init];
    if (self) {
        
        _str = str;
        
    }
    return self;
}

-(void)post{
    [BaseRequest GET:ProjectWaitDealDetail_URL parameters:@{
                                                        @"client_id":_str
                                                        }
             success:^(id resposeObject) {

                 if ([resposeObject[@"code"] integerValue]==200) {
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
                         
                         _data = @[@[[NSString stringWithFormat:@"推荐编号：%@",_dataDic[@"client_id"]],[NSString stringWithFormat:@"推荐时间：%@",_dataDic[@"create_time"]],[NSString stringWithFormat:@"推荐类别：%@",_dataDic[@"recommend_type"]],[NSString stringWithFormat:@"推荐人：%@",_dataDic[@"broker_name"]],[NSString stringWithFormat:@"联系方式：%@",_dataDic[@"broker_tel"]],[NSString stringWithFormat:@"项目名称：%@",_dataDic[@"project_name"]],adress,[NSString stringWithFormat:@"客户姓名：%@",_dataDic[@"name"]],sex,tel,[NSString stringWithFormat:@"备注：%@",_dataDic[@"client_comment"]]],@[[NSString stringWithFormat:@"客户姓名：%@",_dataDic[@"confirm_name"]],[NSString stringWithFormat:@"联系方式：%@",_dataDic[@"confirm_tel"]],[NSString stringWithFormat:@"到访人数：%@人",_dataDic[@"visit_num"]],[NSString stringWithFormat:@"到访时间：%@",_dataDic[@"visit_time"]],[NSString stringWithFormat:@"置业顾问：%@",_dataDic[@"property_advicer_wish"]],[NSString stringWithFormat:@"到访确认人：%@",_dataDic[@"butter_name"]],[NSString stringWithFormat:@"确认人电话：%@",_dataDic[@"butter_tel"]]]];
                     }else{
                         
                         _data = @[@[[NSString stringWithFormat:@"推荐编号：%@",_dataDic[@"client_id"]],[NSString stringWithFormat:@"推荐时间：%@",_dataDic[@"create_time"]],[NSString stringWithFormat:@"推荐人：%@",_dataDic[@"broker_name"]],[NSString stringWithFormat:@"联系方式：%@",_dataDic[@"broker_tel"]],[NSString stringWithFormat:@"项目名称：%@",_dataDic[@"project_name"]],adress,[NSString stringWithFormat:@"客户姓名：%@",_dataDic[@"name"]],sex,tel],@[[NSString stringWithFormat:@"客户姓名：%@",_dataDic[@"confirm_name"]],[NSString stringWithFormat:@"联系方式：%@",_dataDic[@"confirm_tel"]],[NSString stringWithFormat:@"到访人数：%@人",_dataDic[@"visit_num"]],[NSString stringWithFormat:@"到访时间：%@",_dataDic[@"visit_time"]],[NSString stringWithFormat:@"置业顾问：%@",_dataDic[@"property_advicer_wish"]],[NSString stringWithFormat:@"到访确认人：%@",_dataDic[@"butter_name"]],[NSString stringWithFormat:@"确认人电话：%@",_dataDic[@"butter_tel"]]]];
                     }
                     _endtime = _dataDic[@"timeLimit"];
                     [_Maintableview reloadData];
                
                 }
             }
             failure:^(NSError *error) {
                 
             }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDataSouce];
    [self initUI];
    [self post];
    
}


-(void)initDataSouce
{
    _titleArr = @[@"推荐信息",@"到访信息"];
}


#pragma mark    -----  delegate   ------

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *arr = _data[section];
    if (section == 0) {
        
        return arr.count? arr.count + 1:0;
    }else{
        
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
    header.titleL.text = _titleArr[section];
    
    return header;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40 *SIZE;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return _data.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        static NSString *CellIdentifier = @"CountDownCell";
        CountDownCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[CountDownCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        //                [cell setcountdownbyday:0 hours:0 min:0 sec:30];
        [cell setcountdownbyendtime:_dataDic[@"timeLimit"]];
        cell.countdownblock = ^{
            
            [self refresh];
        };
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        static NSString *CellIdentifier = @"InfoDetailCell";
        InfoDetailCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[InfoDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.section == 0) {
            
            [cell SetCellContentbystring:_data[indexPath.section][indexPath.row - 1]];
        }else{
            
            [cell SetCellContentbystring:_data[indexPath.section][indexPath.row]];
        }
        return cell;
    }
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"待成交详情";
  

    
    _Maintableview = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, 360*SIZE, SCREEN_Height - NAVIGATION_BAR_HEIGHT - TAB_BAR_MORE) style:UITableViewStyleGrouped];
    _Maintableview.rowHeight = UITableViewAutomaticDimension;
    _Maintableview.estimatedRowHeight = 150 *SIZE;
    _Maintableview.backgroundColor = YJBackColor;
    _Maintableview.delegate = self;
    _Maintableview.dataSource = self;
    [_Maintableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:_Maintableview];
    
}

- (InvalidView *)invalidView{
    
    if (!_invalidView) {
        
        _invalidView = [[InvalidView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    }
    return _invalidView;
}

-(void)refresh{

    [BaseRequest GET:FlushDate_URL parameters:nil success:^(id resposeObject) {
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

@end
