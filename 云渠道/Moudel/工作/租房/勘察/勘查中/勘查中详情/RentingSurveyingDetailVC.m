//
//  RentingSurveyingDetailVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/7/26.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RentingSurveyingDetailVC.h"
#import "SurveyInvalidVC.h"
//#import "CompleteSurveyInfoVC.h"
#import "RentingCompleteSurveyInfoVC.h"
#import "ModifyTimeVC.h"
#import "ModifyRecordVC.h"

#import "CountDownCell2.h"
#import "SingleContentCell.h"
#import "BaseHeader.h"
#import "SurveyingDetailCell.h"

@interface RentingSurveyingDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSArray *_titleArr;
    NSArray *_contentArr;
}
@property (nonatomic, strong) UITableView *detailTable;

@property (nonatomic, strong) UIButton *invalidBtn;

@property (nonatomic, strong) UIButton *validBtn;

@end

@implementation RentingSurveyingDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _titleArr = @[@"",@"抢单信息",@"报备信息"];
    _contentArr = @[@[@"预约勘察时间：2017-10-23  19:00:00"],@[@"抢单时间：2017-10-23  19:00:00",@"经纪人：张三",@"联系电话：18745561223",@"房源真实性判断失效倒计时："],@[@"天鹅湖小区 - 17栋 - 2单元 - 103",@"房源编号：CD - TEH - 20170810 - 1（F）",@"归属门店：MDBHNO1",@"联系人：李四",@"性别：男",@"身份证号：5130291556231203",@"联系电话：13932452456",@"与业主关系：业主本人",@"报备时间：2017-10-23  19:00:00",@"备注：**********************"]];
    [self initUI];
}

-(void)refresh{
    
    [BaseRequest GET:FlushDate_URL parameters:nil success:^(id resposeObject) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"recommendReload" object:nil];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

- (void)ActionInValidBtn:(UIButton *)btn{
    
    SurveyInvalidVC *nextVC = [[SurveyInvalidVC alloc] init];
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (void)ActionValidBtn:(UIButton *)btn{
    
    RentingCompleteSurveyInfoVC *nextVC = [[RentingCompleteSurveyInfoVC alloc] initWithTitle:@"完成勘察信息"];
    
//    nextVC.surveyId = _surveyId;
//    nextVC.dataDic = _dataDic;
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 2;
    }else if (section == 1){
        
        return 3;
    }else{
        
        return [_contentArr[section] count];
    }
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
                
                ModifyRecordVC *nextVC = [[ModifyRecordVC alloc] init];
                [self.navigationController pushViewController:nextVC animated:YES];
            };
            cell.titleL.textColor = YJTitleLabColor;
            [cell setcountdownbyendtime:@"1529044650"];
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
                
                ModifyTimeVC *nextVC = [[ModifyTimeVC alloc] init];
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
