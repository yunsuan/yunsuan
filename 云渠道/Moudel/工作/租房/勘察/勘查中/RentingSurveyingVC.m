//
//  RentingSurveyingVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/7/26.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RentingSurveyingVC.h"
#import "RentingSurveyingDetailVC.h"
#import "RentingCompleteSurveyInfoVC.h"
#import "SurveyInvalidVC.h"

#import "RoomSurveyingCell.h"

@interface RentingSurveyingVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *waitTable;

@end

@implementation RentingSurveyingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RoomSurveyingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomSurveyingCell"];
    if (!cell) {
        
        cell = [[RoomSurveyingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomSurveyingCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.tag = indexPath.row;
    
    cell.nameL.text = @"张三";
    cell.roomL.text = @"天鹅湖小区 - 17栋 - 2单元 - 103";
    cell.codeL.text = @"房源编号：CD - TEH - 20170810 - 1（F）";
    cell.statusL.text = @"他人";
    cell.countDownL.text = @"勘察失效倒计时： 23:56:00";
    //    cell.timeL.text = @"抢单日期：2017-12-15  13:00:00";
    //    cell.appointTimeL.text = @"预约勘察日期：2017-12-15  13:00:00";
    
    cell.roomSyrveyingConfirmBlock = ^(NSInteger index) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认房源" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        UIAlertAction *valid = [UIAlertAction actionWithTitle:@"完成勘察信息" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            RentingCompleteSurveyInfoVC *nextVC = [[RentingCompleteSurveyInfoVC alloc] init];//WithTitle:@"完成勘察信息"];
            [self.navigationController pushViewController:nextVC animated:YES];
        }];
        
        UIAlertAction *invalid = [UIAlertAction actionWithTitle:@"勘察失效" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            SurveyInvalidVC *nextVC = [[SurveyInvalidVC alloc] init];
            [self.navigationController pushViewController:nextVC animated:YES];
        }];
        
        [alert addAction:valid];
        [alert addAction:invalid];
        [alert addAction:cancel];
        [self.navigationController presentViewController:alert animated:YES completion:^{
            
        }];
    };
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:@"13438339177"];
    [attr addAttribute:NSForegroundColorAttributeName value:YJBlueBtnColor range:NSMakeRange(0, 11)];
    [attr addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:NSMakeRange(0, 11)];
    cell.phoneL.attributedText = attr;
    cell.roomSurveyingPhoneBlock = ^(NSInteger index) {
        
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
    
    RentingSurveyingDetailVC *nextVC = [[RentingSurveyingDetailVC alloc] init];
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (void)initUI{
    
    _waitTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, self.view.bounds.size.height) style:UITableViewStylePlain];
    
    _waitTable.rowHeight = UITableViewAutomaticDimension;
    _waitTable.estimatedRowHeight = 87 *SIZE;
    _waitTable.backgroundColor = self.view.backgroundColor;
    _waitTable.delegate = self;
    _waitTable.dataSource = self;
    _waitTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_waitTable];
}

@end
