//
//  LookMaintainCustomDetailVC.m
//  云渠道
//
//  Created by 谷治墙 on 2019/1/25.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "LookMaintainCustomDetailVC.h"
#import "LookMaintainModifyCustomDetailVC.h"

#import "SingleContentCell.h"
#import "NameSexImgCell.h"
#import "BaseHeader.h"

@interface LookMaintainCustomDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableArray *_contentArr;
    NSMutableDictionary *_dataDic;
}
@property (nonatomic, strong) UITableView *table;

@end

@implementation LookMaintainCustomDetailVC

- (instancetype)initWithDataDic:(NSDictionary *)dataDic
{
    self = [super init];
    if (self) {
        
        
        _dataDic = [NSMutableDictionary dictionaryWithDictionary:dataDic];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
    _contentArr = [@[] mutableCopy];
    
    NSArray *tempArr = @[[NSString stringWithFormat:@"姓名：%@",_dataDic[@"name"]],[NSString stringWithFormat:@"类型：%@",_dataDic[@"report_type"]],[NSString stringWithFormat:@"证件类型：%@",_dataDic[@"card_type_name"]],[NSString stringWithFormat:@"证件号：%@",_dataDic[@"card_id"]],[NSString stringWithFormat:@"通讯地址：%@",_dataDic[@"address"]]];
    _contentArr = [NSMutableArray arrayWithArray:tempArr];
    for (int i = 0; i < [_dataDic[@"tel"] count]; i++) {
        
        [_contentArr insertObject:[NSString stringWithFormat:@"联系号码：%@",_dataDic[@"tel"][i]] atIndex:(2 + i)];
    }
}

- (void)ActionRightBtn:(UIButton *)btn{
    
    LookMaintainModifyCustomDetailVC *nextVC = [[LookMaintainModifyCustomDetailVC alloc] init];
    nextVC.contactId = _dataDic[@"contact_id"];
    nextVC.dataDic = _dataDic;
    nextVC.lookMaintainModifyCustomDetailVCBlock = ^(NSDictionary *dic) {

        if (dic[@"address"]) {

            [_dataDic setObject:dic[@"address"] forKey:@"address"];
        }

        if (dic[@"card_id"]) {

            [_dataDic setObject:dic[@"card_id"] forKey:@"card_id"];
        }

        if (dic[@"card_type"]) {

            [_dataDic setObject:dic[@"card_type"] forKey:@"card_type"];
        }

        NSArray *tempArr = [self getDetailConfigArrByConfigState:2];
        for (NSDictionary *tempDic in tempArr) {

            if ([tempDic[@"id"] integerValue] == [dic[@"card_type"] integerValue]) {

                [_dataDic setObject:tempDic[@"param"] forKey:@"card_type_name"];
            }
        }
        [_dataDic setObject:dic[@"contact_id"] forKey:@"contact_id"];
        [_dataDic setObject:dic[@"name"] forKey:@"name"];
        NSArray *tempArr1 = [self getDetailConfigArrByConfigState:30];
        for (NSDictionary *tempDic in tempArr1) {

            if ([tempDic[@"id"] integerValue] == [dic[@"report_type"] integerValue]) {

                [_dataDic setObject:tempDic[@"param"] forKey:@"report_type"];
            }
        }
        [_dataDic setObject:dic[@"sex"] forKey:@"sex"];

        [_dataDic setObject:[dic[@"tel"] componentsSeparatedByString:@","] forKey:@"tel"];

        [_contentArr removeAllObjects];
        NSArray *tempArr2 = @[[NSString stringWithFormat:@"姓名：%@",_dataDic[@"name"]],[NSString stringWithFormat:@"类型：%@",_dataDic[@"report_type"]],[NSString stringWithFormat:@"证件类型：%@",_dataDic[@"card_type_name"]],[NSString stringWithFormat:@"证件号：%@",_dataDic[@"card_id"]],[NSString stringWithFormat:@"通讯地址：%@",_dataDic[@"address"]]];
        _contentArr = [NSMutableArray arrayWithArray:tempArr2];
        [_table reloadData];
        if (self.lookMaintainCustomDetailVCBlock) {

            self.lookMaintainCustomDetailVCBlock();
        }
    };
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _contentArr.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    BaseHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BaseHeader"];
    if (!header) {
        
        header = [[BaseHeader alloc] initWithReuseIdentifier:@"BaseHeader"];
    }
    
    header.titleL.text = @"联系人信息";
    header.lineView.hidden = YES;
    
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        NameSexImgCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NameSexImgCell"];
        if (!cell) {
            
            cell = [[NameSexImgCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NameSexImgCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.contentL.text = _contentArr[indexPath.row];
        [cell.contentL mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(cell.contentView).offset(27*SIZE);
            make.top.equalTo(cell.contentView).offset(9*SIZE);
            make.width.mas_equalTo(cell.contentL.mj_textWith + 10 *SIZE);
        }];
        [cell.sexImg mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(cell.contentL.mas_right).offset(0*SIZE);
            make.top.equalTo(cell.contentView).offset(12 *SIZE);
            make.width.height.mas_equalTo(16 *SIZE);
        }];
        cell.sexImg.hidden = NO;
        cell.lineView.hidden = YES;
        return cell;
    }else{
        
        SingleContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SingleContentCell"];
        if (!cell) {
            
            cell = [[SingleContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SingleContentCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.contentL.text = _contentArr[indexPath.row];
        cell.lineView.hidden = YES;
        return cell;
    }
}

- (void)initUI{
    
    self.titleLabel.text = @"联系人信息";
    self.navBackgroundView.hidden = NO;
    
    self.rightBtn.hidden = NO;
    [self.rightBtn setImage:[UIImage imageNamed:@"edit"] forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(ActionRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.backgroundColor = self.view.backgroundColor;
    _table.delegate = self;
    _table.dataSource = self;
    [self.view addSubview:_table];
}

@end
