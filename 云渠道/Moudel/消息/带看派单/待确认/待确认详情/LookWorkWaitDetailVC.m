//
//  LookWorkWaitDetailVC.m
//  云渠道
//
//  Created by 谷治墙 on 2019/1/8.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "LookWorkWaitDetailVC.h"
#import "LookWorkConfirmDetailVC.h"

#import "SingleContentCell.h"
#import "BaseHeader.h"

@interface LookWorkWaitDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSArray *_titleArr;
    NSString *_pushId;
}

@property (nonatomic, strong) UITableView *detailTable;

@property (nonatomic, strong) UIButton *invalidBtn;

@property (nonatomic, strong) UIButton *validBtn;

@end

@implementation LookWorkWaitDetailVC

- (instancetype)initWithPushId:(NSString *)pushId
{
    self = [super init];
    if (self) {
        
        _pushId = pushId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    [self RequestMethod];
}

- (void)RequestMethod{
    
    [BaseRequest GET:TakeLookWaitDetail_URL parameters:@{@"push_id":_pushId} success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [self SetData:resposeObject[@"data"]];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        [self showContent:@"网络错误"];
    }];
}

- (void)SetData:(NSDictionary *)data{

//    _titleArr = @[@[[NSString stringWithFormat:@"来源：%@",data[@"project_name"]],[NSString stringWithFormat:@"客源编号：%@",data[@"project_name"]],[NSString stringWithFormat:@"客户姓名：%@",data[@"house_code"]],[NSString stringWithFormat:@"客户性别：%@",data[@"store_name"]],[NSString stringWithFormat:@"推荐时间：%@",data[@"name"]],[NSString stringWithFormat:@"备注%@",data[@"project_name"]]],@[[NSString stringWithFormat:@"意向城市：%@",data[@"project_name"]],[NSString stringWithFormat:@"意向区域：%@",data[@"project_name"]],[NSString stringWithFormat:@"意向单价：%@",data[@"house_code"]],[NSString stringWithFormat:@"意向总价：%@",data[@"store_name"]],[NSString stringWithFormat:@"推荐时间：%@",data[@"name"]],[NSString stringWithFormat:@"备注%@",data[@"project_name"]]]];
    
    NSString *sex =@"";
    if ([data[@"recommend_info"][@"client_sex"] integerValue]==1) {
        sex =@"男";
    }
    if ([data[@"recommend_info"][@"client_sex"] integerValue]==2) {
        sex =@"女";
    }
    _titleArr = @[@[[NSString stringWithFormat:@"来源：%@",data[@"recommend_info"][@"source"]],[NSString stringWithFormat:@"客源编号：%@",data[@"recommend_info"][@"recommend_code"]],[NSString stringWithFormat:@"客户姓名：%@",data[@"recommend_info"][@"client_name"]],[NSString stringWithFormat:@"客户性别：%@",sex],[NSString stringWithFormat:@"推荐时间：%@",data[@"recommend_info"][@"recommend_time"]],[NSString stringWithFormat:@"备注：%@",data[@"recommend_info"][@"comment"]]]];
    
    [_detailTable reloadData];
}

- (void)ActionInValidBtn:(UIButton *)btn{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)ActionValidBtn:(UIButton *)btn{
    
    [self alertControllerWithNsstring:@"温馨提示" And:@"确认接受派单" WithCancelBlack:^{
        
        
    } WithDefaultBlack:^{
        
        [BaseRequest POST:HouseRecordPushAccept_URL parameters:@{@"push_id":_pushId} success:^(id resposeObject) {
            
            if ([resposeObject[@"code"] integerValue] == 200) {
                
                [self alertControllerWithNsstring:@"接单成功" And:@"" WithDefaultBlack:^{
                    
                    //                    [self RequestMethod];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"SystemWork" object:nil];
                    LookWorkConfirmDetailVC *nextVC = [[LookWorkConfirmDetailVC alloc] initWithSurveyId:[NSString stringWithFormat:@"%@",resposeObject[@"data"][@"survey_id"]] type:resposeObject[@"data"][@"type"]];
                    [self.navigationController pushViewController:nextVC animated:YES];
                }];
            }else{
                
                [self showContent:resposeObject[@"msg"]];
            }
        } failure:^(NSError *error) {
            
            [self showContent:@"网络错误"];
        }];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _titleArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [_titleArr[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40 *SIZE;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    BaseHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BaseHeader"];
    if (!header) {
        
        header = [[BaseHeader alloc] initWithReuseIdentifier:@"BaseHeader"];
    }
    if (section==0) {
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
    
    SingleContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SingleContentCell"];
    if (!cell) {
        
        cell = [[SingleContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SingleContentCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.lineView.hidden = YES;
    
    cell.contentL.text = _titleArr[indexPath.section][indexPath.row];
    
    return cell;
}

- (void)initUI{
    
    self.titleLabel.text = @"待接单详情";
    self.navBackgroundView.hidden = NO;
    
    _detailTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - 47 *SIZE - TAB_BAR_MORE) style:UITableViewStyleGrouped];
    
    _detailTable.rowHeight = UITableViewAutomaticDimension;
    _detailTable.estimatedRowHeight = 31 *SIZE;
    _detailTable.backgroundColor = self.view.backgroundColor;
    _detailTable.delegate = self;
    _detailTable.dataSource = self;
    _detailTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_detailTable];
    
    _invalidBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _invalidBtn.frame = CGRectMake(0, SCREEN_Height - 47 *SIZE - TAB_BAR_MORE, 119 *SIZE, 47 *SIZE + TAB_BAR_MORE);
    [_invalidBtn setBackgroundColor:COLOR(191, 191, 191, 1)];
    _invalidBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_invalidBtn addTarget:self action:@selector(ActionInValidBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_invalidBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.view addSubview:_invalidBtn];
    
    _validBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _validBtn.frame = CGRectMake(120 *SIZE, SCREEN_Height - 47 *SIZE - TAB_BAR_MORE, 240 *SIZE, 47 *SIZE + TAB_BAR_MORE);
    
    _validBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_validBtn addTarget:self action:@selector(ActionValidBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_validBtn setBackgroundColor:YJBlueBtnColor];
    [_validBtn setTitle:@"接受派单" forState:UIControlStateNormal];
    [self.view addSubview:_validBtn];
}

@end
