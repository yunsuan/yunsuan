//
//  AuditStatusVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/10.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "AuditStatusVC.h"
#import "InfoDetailCell.h"

@interface AuditStatusVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_data;
//    NSArray *_titleArr;
    NSDictionary *_dataDic;
}
@property (nonatomic , strong) UITableView *statusTable;

@property (nonatomic, strong) UIButton *cancelBtn;

@end

@implementation AuditStatusVC

- (instancetype)initWithData:(NSDictionary *)data
{
    self = [super init];
    if (self) {
        
        _dataDic = data;
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
    
    _data = @[[NSString stringWithFormat:@"姓名：%@",[UserInfoModel defaultModel].name],[NSString stringWithFormat:@"公司名称：%@",_dataDic[@"company_name"]],[NSString stringWithFormat:@"工号：%@",_dataDic[@"work_code"]],[NSString stringWithFormat:@"部门：%@",_dataDic[@"department"]],[NSString stringWithFormat:@"位置：%@",_dataDic[@"position"]],[NSString stringWithFormat:@"申请时间：%@",_dataDic[@"create_time"]]];
    
}

- (void)ActionCancelBtn:(UIButton *)btn{
    
    [self alertControllerWithNsstring:@"温馨提示" And:@"你确认要取消当前公司认证？" WithCancelBlack:^{
        
    } WithDefaultBlack:^{
        
        [BaseRequest GET:CancelAuth_URL parameters:@{@"id":_dataDic[@"id"]} success:^(id resposeObject) {
            
            //        NSLog(@"%@",resposeObject);
            [self showContent:resposeObject[@"msg"]];
            if ([resposeObject[@"code"] integerValue] == 200) {
                
                [self alertControllerWithNsstring:@"取消认证成功" And:nil WithDefaultBlack:^{
                    
                    [self.navigationController popViewControllerAnimated:YES];
                }];
            }
        } failure:^(NSError *error) {
            
            [self showContent:@"网络错误"];
            //        NSLog(@"%@",error);
        }];
    }];
    
}

#pragma mark    -----  delegate   ------

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 6;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *backview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 360*SIZE, 162*SIZE)];
    backview.backgroundColor = [UIColor whiteColor];
    UIView *blueView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 117 *SIZE)];
    blueView.backgroundColor = YJBlueBtnColor;
    [backview addSubview:blueView];
    
    UILabel *statusL = [[UILabel alloc] initWithFrame:CGRectMake(0, 31 *SIZE, SCREEN_Width, 17 *SIZE)];
    statusL.textColor = [UIColor whiteColor];
    statusL.font = [UIFont systemFontOfSize:19 *SIZE];
    statusL.textAlignment = NSTextAlignmentCenter;
    statusL.text = @"审核中";
    [backview addSubview:statusL];
    
    UIView * header = [[UIView alloc]initWithFrame:CGRectMake(10*SIZE , 136*SIZE, (CGFloat) (6.7*SIZE),(CGFloat)  13.3*SIZE)];
    header.backgroundColor = YJBlueBtnColor;
    [backview addSubview:header];
    UILabel * title = [[UILabel alloc]initWithFrame:CGRectMake((CGFloat) 27.3*SIZE, 137*SIZE, 300*SIZE, 16*SIZE)];
    title.font = [UIFont systemFontOfSize:(CGFloat) 15.3*SIZE];
    title.textColor = YJTitleLabColor;
    title.text = @"申请信息";
    [backview addSubview:title];
    return backview;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 162*SIZE;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"InfoDetailCell";
    InfoDetailCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[InfoDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [cell SetCellContentbystring:_data[(NSUInteger) indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"审核状态";

    _statusTable = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, 360*SIZE, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStyleGrouped];
    _statusTable.rowHeight = UITableViewAutomaticDimension;
    _statusTable.estimatedRowHeight = 150 *SIZE;
    _statusTable.backgroundColor = YJBackColor;
    _statusTable.delegate = self;
    _statusTable.dataSource = self;
    [_statusTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:_statusTable];

    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancelBtn.frame = CGRectMake(0 *SIZE, SCREEN_Height - 40 *SIZE - TAB_BAR_MORE, SCREEN_Width, 40 *SIZE + TAB_BAR_MORE);
    _cancelBtn.layer.masksToBounds = YES;
    _cancelBtn.layer.cornerRadius = 2 *SIZE;
    _cancelBtn.backgroundColor = YJLoginBtnColor;
    [_cancelBtn setTitle:@"取消认证" forState:UIControlStateNormal];
    [_cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:16 *SIZE];
    [_cancelBtn addTarget:self action:@selector(ActionCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_cancelBtn];
}


@end
