//
//  RentingSurveyWaitDetailVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/7/26.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RentingSurveyWaitDetailVC.h"
#import "RentingInvalidApplyVC.h"
#import "RentingValidApplyVC.h"

#import "CountDownCell.h"
#import "SingleContentCell.h"
#import "BaseHeader.h"

@interface RentingSurveyWaitDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSArray *_titleArr;
}
@property (nonatomic, strong) UITableView *detailTable;

@property (nonatomic, strong) UIButton *invalidBtn;

@property (nonatomic, strong) UIButton *validBtn;

@end

@implementation RentingSurveyWaitDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _titleArr = @[@[@"抢单时间：2017-10-23  19:00:00",@"经纪人：张三",@"联系电话：18745561223",@"房源真实性判断失效倒计时："],@[@"天鹅湖小区 - 17栋 - 2单元 - 103",@"房源编号：CD - TEH - 20170810 - 1（F）",@"归属门店：MDBHNO1",@"联系人：李四",@"性别：男",@"身份证号：5130291556231203",@"联系电话：13932452456",@"与业主关系：业主本人",@"报备时间：2017-10-23  19:00:00",@"备注：**********************"]];
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
    
    RentingInvalidApplyVC *nextVC = [[RentingInvalidApplyVC alloc] init];
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (void)ActionValidBtn:(UIButton *)btn{
    
    RentingValidApplyVC *nextVC = [[RentingValidApplyVC alloc] init];
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 4;
    }else{
        
        return [_titleArr[section] count];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40 *SIZE;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    BaseHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BaseHeader"];
    if (!header) {
        
        header = [[BaseHeader alloc] initWithReuseIdentifier:@"BaseHeader"];
    }
    
    if (section == 0) {
        
        header.titleL.text = @"抢单信息";
    }else{
        
        header.titleL.text = @"报备信息";
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
    
    if (indexPath.section == 0 && indexPath.row == 3) {
        
        static NSString *CellIdentifier = @"CountDownCell";
        CountDownCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[CountDownCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.titleL.text = @"房源真实性判断失效倒计时：";
        cell.frame = CGRectMake(0, 0, 360*SIZE, 75*SIZE);
        cell.countdownblock = ^{
            
            //            [self refresh];
        };
        cell.titleL.textColor = YJTitleLabColor;
        [cell setcountdownbyendtime:@"1529044650"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        
        SingleContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SingleContentCell"];
        if (!cell) {
            
            cell = [[SingleContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SingleContentCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.lineView.hidden = YES;
        
        cell.contentL.text = _titleArr[indexPath.section][indexPath.row];
        
        return cell;
    }
}

- (void)initUI{
    
    self.titleLabel.text = @"待确认详情";
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
    [_invalidBtn setTitle:@"房源无效" forState:UIControlStateNormal];
    [self.view addSubview:_invalidBtn];
    
    _validBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _validBtn.frame = CGRectMake(120 *SIZE, SCREEN_Height - 47 *SIZE - TAB_BAR_MORE, 240 *SIZE, 47 *SIZE + TAB_BAR_MORE);
    
    _validBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_validBtn addTarget:self action:@selector(ActionValidBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_validBtn setBackgroundColor:YJBlueBtnColor];
    [_validBtn setTitle:@"房源有效" forState:UIControlStateNormal];
    [self.view addSubview:_validBtn];
}

@end
