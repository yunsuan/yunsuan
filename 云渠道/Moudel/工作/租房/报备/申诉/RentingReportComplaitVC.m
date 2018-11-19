//
//  RentingReportComplaitVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/7/24.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RentingReportComplaitVC.h"
#import "ReportComplaintDetailVC.h"

#import "RoomReportComplaintCell.h"

@interface RentingReportComplaitVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *comTable;

@end

@implementation RentingReportComplaitVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RoomReportComplaintCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomReportComplaintCell"];
    if (!cell) {
        
        cell = [[RoomReportComplaintCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomReportComplaintCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.tag = indexPath.row;
    
    cell.nameL.text = @"张三";
    cell.roomL.text = @"天鹅湖小区";
    cell.codeL.text = @"房源编号：CD - TEH - 20170810 - 1（F）";
    cell.timeL.text = @"申诉日期：2017-12-15  13:00:00";
    cell.statusL.text = @"处理完成";
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:@"13438339177"];
    [attr addAttribute:NSForegroundColorAttributeName value:YJBlueBtnColor range:NSMakeRange(0, 11)];
    [attr addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:NSMakeRange(0, 11)];
    cell.phoneL.attributedText = attr;
    cell.roomReportComplaintPhoneBlock = ^(NSInteger index) {
        
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
    
    ReportComplaintDetailVC *nextVC = [[ReportComplaintDetailVC alloc] init];
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (void)initUI{
    
    _comTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, self.view.bounds.size.height) style:UITableViewStylePlain];
    
    _comTable.rowHeight = UITableViewAutomaticDimension;
    _comTable.estimatedRowHeight = 87 *SIZE;
    _comTable.backgroundColor = self.view.backgroundColor;
    _comTable.delegate = self;
    _comTable.dataSource = self;
    _comTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_comTable];
}

@end
