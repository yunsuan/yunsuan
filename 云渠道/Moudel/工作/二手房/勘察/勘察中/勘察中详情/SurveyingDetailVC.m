//
//  SurveyingDetailVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/6/15.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "SurveyingDetailVC.h"
#import "SurveyInvalidVC.h"
#import "CompleteSurveyInfoVC.h"
#import "ModifyTimeVC.h"
#import "ModifyRecordVC.h"

//#import "CountDownCell.h"
#import "CountDownCell2.h"
#import "SingleContentCell.h"
#import "BaseHeader.h"
#import "SurveyingDetailCell.h"

@interface SurveyingDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSArray *_titleArr;
    NSMutableArray *_contentArr;
    NSString *_surveyId;
    NSMutableDictionary *_dataDic;
}
@property (nonatomic, strong) UITableView *detailTable;

@property (nonatomic, strong) UIButton *invalidBtn;

@property (nonatomic, strong) UIButton *validBtn;

@end

@implementation SurveyingDetailVC

- (instancetype)initWithSurveyId:(NSString *)surveyId
{
    self = [super init];
    if (self) {
        
        _surveyId = surveyId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _titleArr = @[@"",@"抢单信息",@"报备信息"];
    _contentArr = [@[] mutableCopy];
    _dataDic = [@{} mutableCopy];
    [self initUI];
    [self RequestMethod];
}

-(void)refresh{
    
    [BaseRequest GET:HouseSurveyTimeOut_URL parameters:nil success:^(id resposeObject) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"secReload" object:nil];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

- (void)RequestMethod{
    
    [BaseRequest GET:HouseSurveyUnderWayDetail_URL parameters:@{@"survey_id":_surveyId} success:^(id resposeObject) {
        
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
    
    _dataDic = [NSMutableDictionary dictionaryWithDictionary:data];
    _contentArr = [NSMutableArray arrayWithArray:@[@[[NSString stringWithFormat:@"预约勘察时间：%@",[data[@"reserve_time"] substringWithRange:NSMakeRange(0, 10)]],data[@"timeLimit"]],@[[NSString stringWithFormat:@"抢单时间：%@",data[@"survey_time"]],[NSString stringWithFormat:@"经纪人：%@",data[@"agent_name"]],[NSString stringWithFormat:@"联系电话：%@",data[@"agent_tel"]]],@[[NSString stringWithFormat:@"%@",data[@"house"]],[NSString stringWithFormat:@"房源编号：%@",data[@"house_code"]],[NSString stringWithFormat:@"归属门店：%@",data[@"store_name"]],[NSString stringWithFormat:@"联系人：%@",data[@"name"]],[NSString stringWithFormat:@"性别：%@",[data[@"sex"] integerValue] == 2? @"女":@"男"],[NSString stringWithFormat:@"证件类型：%@",data[@"card_type"]],[NSString stringWithFormat:@"证件编号：%@",data[@"card_id"]],[NSString stringWithFormat:@"联系电话：%@",data[@"tel"]],[NSString stringWithFormat:@"与业主关系：%@",data[@"report_type"]],[NSString stringWithFormat:@"报备时间：%@",data[@"record_time"]],[NSString stringWithFormat:@"备注：%@",data[@"comment"]]]]];

    [_detailTable reloadData];
}

- (void)ActionInValidBtn:(UIButton *)btn{
    
    if (_dataDic.count) {
        
        SurveyInvalidVC *nextVC = [[SurveyInvalidVC alloc] initWithData:_dataDic];
        nextVC.surveyId = _surveyId;
        nextVC.surveyInvalidVCBlock = ^{
          
            if (self.surveyingDetailVCBlock) {
                
                self.surveyingDetailVCBlock();
            }
        };
        [self.navigationController pushViewController:nextVC animated:YES];
    }
}

- (void)ActionValidBtn:(UIButton *)btn{
    
    if (_dataDic) {
        
        CompleteSurveyInfoVC *nextVC = [[CompleteSurveyInfoVC alloc] initWithTitle:@"完成勘察信息"];
        nextVC.completeSurveyInfoVCBlock = ^{
            
            self.surveyingDetailVCBlock();
        };
        nextVC.surveyId = _surveyId;
        nextVC.dataDic = _dataDic;
        [self.navigationController pushViewController:nextVC animated:YES];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _contentArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [_contentArr[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return CGFLOAT_MIN;
    }else{
        
        return 40 *SIZE;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    BaseHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BaseHeader"];
    if (!header) {
        
        header = [[BaseHeader alloc] initWithReuseIdentifier:@"BaseHeader"];
    }
    
    header.titleL.text = _titleArr[section];
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
    
    if (indexPath.section == 0 ) {
        
        
        if (indexPath.row == 1) {
            
            static NSString *CellIdentifier = @"CountDownCell2";
            CountDownCell2 *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (!cell) {
                cell = [[CountDownCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            cell.titleL.text = @"勘察失效倒计时：";
            cell.frame = CGRectMake(0, 0, 360*SIZE, 75*SIZE);
            cell.countdown2block = ^{
                
                //            [self refresh];
            };
            cell.countDownMoreBlock = ^{
              
                ModifyRecordVC *nextVC = [[ModifyRecordVC alloc] initWithSurveyId:_surveyId];
//                nextVC
                [self.navigationController pushViewController:nextVC animated:YES];
            };
            cell.titleL.textColor = YJTitleLabColor;
            [cell setcountdownbyendtime:_contentArr[indexPath.section][indexPath.row]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else{
            
            static NSString *CellIdentifier = @"SurveyingDetailCell";
            SurveyingDetailCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (!cell) {
                cell = [[SurveyingDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.lineView.hidden = YES;
            cell.surveyingDetailChangeBlock = ^{
                
                ModifyTimeVC *nextVC = [[ModifyTimeVC alloc] initWithSurveyId:_surveyId];
                nextVC.modifyTimeVCBlock = ^{
                  
                    [self RequestMethod];
                };
                nextVC.dataDic = _dataDic;
                [self.navigationController pushViewController:nextVC animated:YES];
            };
            cell.contentL.text = _contentArr[indexPath.section][indexPath.row];
            return cell;
        }
    }else{
        
        SingleContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SingleContentCell"];
        if (!cell) {
            
            cell = [[SingleContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SingleContentCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.lineView.hidden = YES;
        
        cell.contentL.text = _contentArr[indexPath.section][indexPath.row];
        
        return cell;
    }
}

- (void)initUI{
    
    self.titleLabel.text = @"勘察详情";
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
    [_invalidBtn setTitle:@"勘察失效" forState:UIControlStateNormal];
    [self.view addSubview:_invalidBtn];
    
    _validBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _validBtn.frame = CGRectMake(120 *SIZE, SCREEN_Height - 47 *SIZE - TAB_BAR_MORE, 240 *SIZE, 47 *SIZE + TAB_BAR_MORE);
    _validBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_validBtn addTarget:self action:@selector(ActionValidBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_validBtn setBackgroundColor:YJBlueBtnColor];
    [_validBtn setTitle:@"完成勘察信息" forState:UIControlStateNormal];
    [self.view addSubview:_validBtn];
}

@end
