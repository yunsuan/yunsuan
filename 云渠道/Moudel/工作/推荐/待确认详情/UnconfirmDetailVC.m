//
//  UnconfirmDetailVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/9.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "UnconfirmDetailVC.h"
#import "CountDownCell.h"
#import "InfoDetailCell.h"
#import "CompleteCustomVC1.h"
#import "InvalidView.h"

@interface UnconfirmDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_checkArr;
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

@implementation UnconfirmDetailVC

- (instancetype)initWithString:(NSString *)str
{
    self = [super init];
    if (self) {
        
        _str = str;
        
    }
    return self;
}

-(void)post{
    [BaseRequest GET:WaitConfirmDetail_URL parameters:@{
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
                     
                     if ([_dataDic[@"tel_check_info"] isKindOfClass:[NSDictionary class]] && [_dataDic[@"tel_check_info"] count]) {
                         
                         _checkArr = @[[NSString stringWithFormat:@"确认人：%@",_dataDic[@"tel_check_info"][@"confirmed_agent_name"]],[NSString stringWithFormat:@"性别：%@",[_dataDic[@"tel_check_info"][@"confirmed_agent_sex"] integerValue] == 0 ? @"":[_dataDic[@"tel_check_info"][@"confirmed_agent_sex"] integerValue] == 1?@"男":@"女"],[NSString stringWithFormat:@"联系方式：%@",_dataDic[@"tel_check_info"][@"confirmed_agent_tel"]],[NSString stringWithFormat:@"确认时间：%@",_dataDic[@"tel_check_info"][@"confirmed_time"]]];
                     }
                     if (![_dataDic[@"comsulatent_advicer"] isEqualToString:@""]) {
                         
                         _data = @[@[[NSString stringWithFormat:@"推荐编号：%@",_dataDic[@"client_id"]],[NSString stringWithFormat:@"推荐时间：%@",_dataDic[@"create_time"]],[NSString stringWithFormat:@"推荐类别：%@",_dataDic[@"recommend_type"]],[NSString stringWithFormat:@"推荐人：%@",_dataDic[@"broker_name"]],[NSString stringWithFormat:@"联系方式：%@",_dataDic[@"broker_tel"]],[NSString stringWithFormat:@"项目名称：%@",_dataDic[@"project_name"]],adress,[NSString stringWithFormat:@"客户姓名：%@",_dataDic[@"name"]],sex,tel,[NSString stringWithFormat:@"置业顾问：%@",_dataDic[@"comsulatent_advicer"]],[NSString stringWithFormat:@"备注：%@",_dataDic[@"client_comment"]]]];
                     }else{
                         
                         _data = @[@[[NSString stringWithFormat:@"推荐编号：%@",_dataDic[@"client_id"]],[NSString stringWithFormat:@"推荐时间：%@",_dataDic[@"create_time"]],[NSString stringWithFormat:@"推荐类别：%@",_dataDic[@"recommend_type"]],[NSString stringWithFormat:@"推荐人：%@",_dataDic[@"broker_name"]],[NSString stringWithFormat:@"联系方式：%@",_dataDic[@"broker_tel"]],[NSString stringWithFormat:@"项目名称：%@",_dataDic[@"project_name"]],adress,[NSString stringWithFormat:@"客户姓名：%@",_dataDic[@"name"]],sex,tel,[NSString stringWithFormat:@"备注：%@",_dataDic[@"client_comment"]]]];
                     }
                     _endtime = _dataDic[@"timeLimit"];
                     [_Maintableview reloadData];
                     
                 }
             }
             failure:^(NSError *error) {
                 
                 [self showContent:@"网络错误"];
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
    _titleArr = @[@"推荐信息",@"判重信息"];
    _data =@[];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(post) name:@"reloadCustom" object:nil];
}

- (void)ActionConfirmBtn:(UIButton *)btn{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认到访" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *valid = [UIAlertAction actionWithTitle:@"已到访" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        CompleteCustomVC1 *nextVC = [[CompleteCustomVC1 alloc] initWithClientID:_str name:_name dataDic:_dataDic];
        [self.navigationController pushViewController:nextVC animated:YES];
    }];
    
    UIAlertAction *invalid = [UIAlertAction actionWithTitle:@"未到访" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        self.invalidView.client_id = _str;
        [[UIApplication sharedApplication].keyWindow addSubview:self.invalidView];
    }];
    
    [alert addAction:valid];
    [alert addAction:invalid];
    [alert addAction:cancel];
    [self.navigationController presentViewController:alert animated:YES completion:^{
        
    }];
}

#pragma mark    -----  delegate   ------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (_checkArr.count) {
        
        return _data.count + 1;
    }
    return _data.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (section == 0) {
        
        NSArray *arr = _data[section];
        return arr.count? arr.count + 1:0;
    }else{
        
        return _checkArr.count;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *backview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 360*SIZE, 53*SIZE)];
    backview.backgroundColor = [UIColor whiteColor];
    UIView * header = [[UIView alloc]initWithFrame:CGRectMake(10*SIZE , 19*SIZE, 6.7*SIZE, 13.3*SIZE)];
    header.backgroundColor = YJBlueBtnColor;
    [backview addSubview:header];
    UILabel * title = [[UILabel alloc]initWithFrame:CGRectMake(27.3*SIZE, 19*SIZE, 300*SIZE, 16*SIZE)];
    title.font = [UIFont systemFontOfSize:15.3*SIZE];
    title.textColor = YJTitleLabColor;
    title.text = _titleArr[section];
    [backview addSubview:title];
    return backview;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 53*SIZE;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            static NSString *CellIdentifier = @"CountDownCell";
            CountDownCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (!cell) {
                cell = [[CountDownCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            
            cell.frame = CGRectMake(0, 0, 360*SIZE, 75*SIZE);
            cell.countdownblock = ^{
                [self refresh];
            };
            [cell setcountdownbyendtime:_endtime];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else{
            static NSString *CellIdentifier = @"InfoDetailCell";
            InfoDetailCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (!cell) {
                cell = [[InfoDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            [cell SetCellContentbystring:_data[indexPath.section][indexPath.row - 1]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }else{
        
        static NSString *CellIdentifier = @"InfoDetailCell";
        InfoDetailCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[InfoDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        [cell SetCellContentbystring:_checkArr[indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"确认中详情";
    
    _Maintableview = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, 360*SIZE, SCREEN_Height - NAVIGATION_BAR_HEIGHT- 40 *SIZE - TAB_BAR_MORE) style:UITableViewStyleGrouped];
    _Maintableview.rowHeight = UITableViewAutomaticDimension;
    _Maintableview.estimatedRowHeight = 150 *SIZE;
    _Maintableview.backgroundColor = YJBackColor;
    _Maintableview.delegate = self;
    _Maintableview.dataSource = self;
    [_Maintableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    if ([[UserModel defaultModel].agent_identity integerValue] == 1) {
        
        _Maintableview.frame = CGRectMake(0, NAVIGATION_BAR_HEIGHT, 360*SIZE, SCREEN_Height - NAVIGATION_BAR_HEIGHT);
    }
    
    [self.view addSubview:_Maintableview];
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirmBtn.frame = CGRectMake(0, SCREEN_Height - 40 *SIZE - TAB_BAR_MORE, SCREEN_Width, 40 *SIZE + TAB_BAR_MORE);
    _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_confirmBtn addTarget:self action:@selector(ActionConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
    [_confirmBtn setBackgroundColor:YJBlueBtnColor];
    [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    if ([[UserModel defaultModel].agent_identity integerValue] == 2) {
        
        [self.view addSubview:_confirmBtn];
    }
    
}

- (InvalidView *)invalidView{
    
    if (!_invalidView) {
        
        _invalidView = [[InvalidView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
        
        WS(weakSelf);
        _invalidView.invalidViewBlock = ^(NSDictionary *dic) {
            
            [BaseRequest POST:ConfirmDisabled_URL parameters:dic success:^(id resposeObject) {
                
                if ([resposeObject[@"code"] integerValue] == 200) {
                    
                    [weakSelf alertControllerWithNsstring:@"失效确认成功" And:nil];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"recommendReload" object:nil];
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                }else{
                    
                    [weakSelf alertControllerWithNsstring:@"温馨提示" And:resposeObject[@"msg"]];
                }
            } failure:^(NSError *error) {
                
            }];
        };
        
        _invalidView.invalidViewBlockFail = ^(NSString *str) {
            
            [weakSelf alertControllerWithNsstring:@"温馨提示" And:str];
        };
    }
    return _invalidView;
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
