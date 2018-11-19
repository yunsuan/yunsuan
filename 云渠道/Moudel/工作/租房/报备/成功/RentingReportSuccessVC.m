//
//  RentingReportSuccessVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/7/24.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RentingReportSuccessVC.h"
#import "ReportSuccessDetailVC.h"

#import "RoomReportSucCell.h"

@interface RentingReportSuccessVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *succussTable;
@end

@implementation RentingReportSuccessVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RoomReportSucCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomReportSucCell"];
    if (!cell) {
        
        cell = [[RoomReportSucCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomReportSucCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.tag = indexPath.row;
    
    cell.nameL.text = @"张三";
    cell.roomL.text = @"天鹅湖小区 - 17栋 - 2单元 - 103";
    cell.codeL.text = @"房源编号：CD - TEH - 20170810 - 1（F）";
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:@"13438339177"];
    [attr addAttribute:NSForegroundColorAttributeName value:YJBlueBtnColor range:NSMakeRange(0, 11)];
    [attr addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:NSMakeRange(0, 11)];
    cell.phoneL.attributedText = attr;
    cell.roomReportSucPhoneBlock = ^(NSInteger index) {
        
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
    
    ReportSuccessDetailVC *nextVC = [[ReportSuccessDetailVC alloc] init];
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (void)initUI{
    
    _succussTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, self.view.bounds.size.height) style:UITableViewStylePlain];
    
    _succussTable.rowHeight = UITableViewAutomaticDimension;
    _succussTable.estimatedRowHeight = 87 *SIZE;
    _succussTable.backgroundColor = self.view.backgroundColor;
    _succussTable.delegate = self;
    _succussTable.dataSource = self;
    _succussTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_succussTable];
}

@end
