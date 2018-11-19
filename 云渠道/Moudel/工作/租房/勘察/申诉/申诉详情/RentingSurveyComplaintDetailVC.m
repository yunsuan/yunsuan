//
//  RentingSurveyComplaintDetailVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/7/26.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RentingSurveyComplaintDetailVC.h"

#import "SingleContentCell.h"
#import "BlueTitleMoreHeader.h"
#import "BaseHeader.h"

@interface RentingSurveyComplaintDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSArray *_titleArr;
    NSArray *_contentArr;
}
@property (nonatomic, strong) UITableView *detailTable;

@property (nonatomic, strong) UILabel *statusL;

@property (nonatomic, strong) UIButton *cancelBtn;

@end

@implementation RentingSurveyComplaintDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _titleArr = @[@"申诉信息",@"失效信息",@"抢单信息",@"报备信息"];
    _contentArr = @[@[@"申诉类型：规定时间内未判断房源真实性申诉",@"申诉时间：2017-10-23  19:00:00",@"申诉描述：***************************"],@[@"失效类型：业主不售房源",@"失效时间：2017-10-23  19:00:00",@"失效描述：***************************"],@[@"抢单时间：2017-10-23  19:00:00",@"经纪人：李四",@"联系电话：13932452456"],@[@"天鹅湖小区 - 17栋 - 2单元 - 103",@"房源编号：CD - TEH - 20170810 - 1（F）",@"归属门店：MDBHNO1",@"联系人：李四",@"性别：男",@"身份证号：5130291556231203",@"联系电话：13932452456",@"与业主关系：业主本人",@"报备时间：2017-10-23  19:00:00",@"备注：**********************"]];
    [self initUI];
}

- (void)ActionCancelBtn:(UIButton *)btn{
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _titleArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [_contentArr[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40 *SIZE;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        BlueTitleMoreHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BlueTitleMoreHeader"];
        if (!header) {
            
            header = [[BlueTitleMoreHeader alloc] initWithReuseIdentifier:@"BlueTitleMoreHeader"];
        }
        
        header.titleL.text = _titleArr[section];
        [header.moreBtn setTitle:@"处理完成" forState:UIControlStateNormal];
        [header.moreBtn setTitleColor:YJBlueBtnColor forState:UIControlStateNormal];
        header.lineView.hidden = YES;
        
        return header;
    }else{
        
        BaseHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BaseHeader"];
        if (!header) {
            
            header = [[BaseHeader alloc] initWithReuseIdentifier:@"BaseHeader"];
        }
        
        header.titleL.text = _titleArr[section];
        header.lineView.hidden = YES;
        
        return header;
    }
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
    
    cell.contentL.text = _contentArr[indexPath.section][indexPath.row];
    
    return cell;
}

- (void)initUI{
    
    self.titleLabel.text = @"申诉详情";
    self.navBackgroundView.hidden = NO;
    
    _detailTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - 40 *SIZE - TAB_BAR_MORE) style:UITableViewStyleGrouped];
    
    _detailTable.rowHeight = UITableViewAutomaticDimension;
    _detailTable.estimatedRowHeight = 31 *SIZE;
    _detailTable.backgroundColor = self.view.backgroundColor;
    _detailTable.delegate = self;
    _detailTable.dataSource = self;
    _detailTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_detailTable];
    
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancelBtn.frame = CGRectMake(0, SCREEN_Height - 40 *SIZE - TAB_BAR_MORE, SCREEN_Width, 40 *SIZE + TAB_BAR_MORE);
    _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14 *sIZE];
    [_cancelBtn addTarget:self action:@selector(ActionCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_cancelBtn setTitle:@"取消申诉" forState:UIControlStateNormal];
    [_cancelBtn setBackgroundColor:YJBlueBtnColor];
    [_cancelBtn setTitleColor:CH_COLOR_white forState:UIControlStateNormal];
    [self.view addSubview:_cancelBtn];
}

@end
