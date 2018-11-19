//
//  RentingReportFailVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/7/24.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RentingReportFailVC.h"
#import "RentingReportFailDetailVC.h"

#import "RoomReportFailCell.h"

@interface RentingReportFailVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *failTable;

@end

@implementation RentingReportFailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RoomReportFailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomReportFailCell"];
    if (!cell) {
        
        cell = [[RoomReportFailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomReportFailCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.tag = indexPath.row;
    
    cell.nameL.text = @"张三";
    cell.roomL.text = @"天鹅湖小区";
    cell.codeL.text = @"房源编号：CD - TEH - 20170810 - 1（F）";
    cell.timeL.text = @"失效时间：2017-12-15  13:00:00";
    cell.reasonL.text = @"失效类型：房源信息无效";
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:@"13438339177"];
    [attr addAttribute:NSForegroundColorAttributeName value:YJBlueBtnColor range:NSMakeRange(0, 11)];
    [attr addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:NSMakeRange(0, 11)];
    cell.phoneL.attributedText = attr;
    cell.roomReportFailPhoneBlock = ^(NSInteger index) {
        
        //        NSString *phone = [_validArr[index][@"tel"] componentsSeparatedByString:@","][0];
        NSString *phone = @"13438339177";
        if (phone.length) {
            
            //获取目标号码字符串,转换成URL
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phone]];
            //调用系统方法拨号
            [[UIApplication sharedApplication] openURL:url];
        }else{
            
            [self alertControllerWithNsstring:@"温馨提示" And:@"暂时未获取到联系电话"];
        }
    };
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RentingReportFailDetailVC *nextVC = [[RentingReportFailDetailVC alloc] init];
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (void)initUI{
    
    _failTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, self.view.bounds.size.height) style:UITableViewStylePlain];
    
    _failTable.rowHeight = UITableViewAutomaticDimension;
    _failTable.estimatedRowHeight = 87 *SIZE;
    _failTable.backgroundColor = self.view.backgroundColor;
    _failTable.delegate = self;
    _failTable.dataSource = self;
    _failTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_failTable];
}

@end
