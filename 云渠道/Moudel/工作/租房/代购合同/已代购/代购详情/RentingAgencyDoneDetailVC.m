//
//  RentingAgencyDoneDetailVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/7/30.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RentingAgencyDoneDetailVC.h"
#import "AgencyDoneCustomerDetailVC.h"

#import "AgencyDoneHeader.h"
#import "BlueTitleMoreHeader.h"
#import "SingleContentCell.h"
#import "NameSexImgCell.h"
#import "AddPeopleCell.h"

@interface RentingAgencyDoneDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSInteger _item;
    NSArray *_titleArr;
    NSArray *_headerArr;
    NSArray *_contentArr;
    NSArray *_contentArr2;
    NSArray *_contentArr3;
    NSInteger _count;
}

@property (nonatomic, strong) UITableView *table;

@end

@implementation RentingAgencyDoneDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
    _count = 2;
    _titleArr = @[@"",@"联系人1",@"联系人2"];
    _headerArr = @[@"房源编号：DSBNS1623266320",@"交易编号：SAF4535654316652",@"推荐编号：SAF4535654316652",@"有效",@"已审核",@"已收款",@"交易总价：103万",@"诚意金：20万",@"违约金：2万",@"佣金：2万",@"付款方式：一次性付清",@"约定签约时间：2017-11-11",@"审核人：张三",@"审核时间：2017-11-11"];
    _contentArr = @[@"名称：张三",@"证件类型：身份证",@"证件号码：5100000000000",@"通讯地址：成都市大禹东路94号"];
    _contentArr2 = @[@"公司名称：链家",@"门店名称：链家大禹东路",@"门店地址：成都市郫都区大禹东路77号",@"经办人名称：刘芮麟",@"联系电话：15201234567",@"登记日期：2017-11-11"];
    _contentArr3 =@[@"房源编号：56231245623232153",@"所属小区：成都市郫都区大禹东路77号 云算公馆",@"物业类型：住宅",@"房号：批次-1栋-1单元-102",@"户型：三室一厅",@"产权面积：103m2",@"房屋所有权证号：LJ51416532223",@"国土使用证号：AK51416532223"];
}


- (void)ActionRightBtn:(UIButton *)btn{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"操作" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *protocol = [UIAlertAction actionWithTitle:@"转合同" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
    }];
    
    UIAlertAction *set = [UIAlertAction actionWithTitle:@"挞定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
//        GetAgencyProtocolVC *nextVC = [[GetAgencyProtocolVC alloc] init];
//        [self.navigationController pushViewController:nextVC animated:YES];
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:protocol];
    [alert addAction:set];
    [alert addAction:cancel];
    
    [self.navigationController presentViewController:alert animated:YES completion:^{
        
    }];
}

#pragma mark -- tableView;
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (_item == 0) {
        
        return _count + 2;
    }else{
        
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (_item == 0) {
        
        if (section == 0) {
            
            return 0;
        }else if (section < _count + 1){
            
            return _contentArr.count;
        }else{
            
            return 1;
        }
    }else if (_item == 1){
        
        return _contentArr2.count;
    }else{
        
        return _contentArr3.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == _count + 1 && _item == 0) {
        
        return 0;
    }
    return UITableViewAutomaticDimension;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        AgencyDoneHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"AgencyDoneHeader"];
        if (!header) {
            
            header = [[AgencyDoneHeader alloc] initWithReuseIdentifier:@"AgencyDoneHeader"];
            
        }
        [header.infoBtn setBackgroundColor:COLOR(219, 219, 219, 1)];
        [header.infoBtn setTitleColor:YJ86Color forState:UIControlStateNormal];
        [header.agentBtn setBackgroundColor:COLOR(219, 219, 219, 1)];
        [header.agentBtn setTitleColor:YJ86Color forState:UIControlStateNormal];
        [header.roomBtn setBackgroundColor:COLOR(219, 219, 219, 1)];
        [header.roomBtn setTitleColor:YJ86Color forState:UIControlStateNormal];
        
        
        header.roomCodeL.text = _headerArr[0];
        header.tradeCodeL.text = _headerArr[1];
        header.recommendL.text = _headerArr[2];
        header.validL.text = _headerArr[3];
        header.auditL.text = _headerArr[4];
        header.payL.text = _headerArr[5];
        header.priceL.text = _headerArr[6];
        header.SincertyGoldL.text = _headerArr[7];
        header.breachL.text = _headerArr[8];
        header.commissionL.text = _headerArr[9];
        header.payWayL.text = _headerArr[10];
        header.timeL.text = _headerArr[11];
        header.reviewL.text = _headerArr[12];
        header.reviewTimeL.text = _headerArr[13];
        
        if (_item == 0) {
            
            [header.infoBtn setBackgroundColor:YJBlueBtnColor];
            [header.infoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }else if (_item == 1){
            
            [header.agentBtn setBackgroundColor:YJBlueBtnColor];
            [header.agentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }else{
            
            [header.roomBtn setBackgroundColor:YJBlueBtnColor];
            [header.roomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
        
        header.agencyDoneHeaderBlock = ^(NSInteger index) {
            
            _item = index;
            [tableView reloadData];
        };
        return header;
    }else{
        
        if (_item == 0) {
            
            if (section < 3) {
                
                BlueTitleMoreHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BlueTitleMoreHeader"];
                if (!header) {
                    
                    header = [[BlueTitleMoreHeader alloc] initWithReuseIdentifier:@"BlueTitleMoreHeader"];
                }
                
                header.titleL.text = _titleArr[section];
                header.lineView.backgroundColor = [UIColor whiteColor];
                header.blueTitleMoreHeaderBlock = ^{
                    
                    AgencyDoneCustomerDetailVC *nextVC = [[AgencyDoneCustomerDetailVC alloc] init];
                    [self.navigationController pushViewController:nextVC animated:YES];
                };
                return header;
            }else{
                
                return [[UIView alloc] init];
            }
        }else{
            
            BlueTitleMoreHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BlueTitleMoreHeader"];
            if (!header) {
                
                header = [[BlueTitleMoreHeader alloc] initWithReuseIdentifier:@"BlueTitleMoreHeader"];
            }
            
            header.titleL.text = _titleArr[section];
            header.lineView.backgroundColor = [UIColor whiteColor];
            return header;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if (_item == 2) {
        
        if (section == 0) {
            
            return 0;
        }else{
            
            return 8 *SIZE;
        }
    }else{
        
        return SIZE;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [[UIView alloc] init];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_item == 0) {
        
        if (indexPath.section == 3) {
            
            AddPeopleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddPeopleCell"];
            if (!cell) {
                
                cell = [[AddPeopleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AddPeopleCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.addImg.image = [UIImage imageNamed:@"add30"];
            
            return cell;
        }else{
            
            NameSexImgCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NameSexImgCell"];
            if (!cell) {
                
                cell = [[NameSexImgCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NameSexImgCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.lineView.hidden = YES;
            
            cell.contentL.text = _contentArr[indexPath.row];
            if (indexPath.row == 0) {
                
                cell.sexImg.hidden = NO;
            }else{
                
                cell.sexImg.hidden = YES;
            }
            [cell.contentL mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(cell.contentView).offset(27*SIZE);
                make.top.equalTo(cell.contentView).offset(9*SIZE);
                make.width.mas_equalTo(cell.contentL.mj_textWith + 10 *SIZE);
            }];
            return cell;
        }
    }else{
        
        SingleContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SingleContentCell"];
        if (!cell) {
            
            cell = [[SingleContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SingleContentCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.lineView.hidden = YES;
        
        if (_item == 1){
            
            cell.contentL.text = _contentArr2[indexPath.row];
        }else{
            
            cell.contentL.text = _contentArr3[indexPath.row];
        }
        
        return cell;
    }
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"代购详情";
    
    self.rightBtn.hidden = NO;
    [self.rightBtn setImage:[UIImage imageNamed:@"add_1"] forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(ActionRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStyleGrouped];
    _table.estimatedSectionHeaderHeight = 425 *SIZE;
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 30 *SIZE;
    _table.backgroundColor = self.view.backgroundColor;
    _table.delegate = self;
    _table.dataSource = self;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_table];
}

@end
