//
//  RentingRoomMaintainVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/7/30.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RentingRoomMaintainVC.h"
#import "RentingMaintainDetailVC.h"
#import "CompleteSurveyInfoVC.h"
#import "SecdaryCommunityRoomVC.h"

#import "RoomMaintainCell.h"

@interface RentingRoomMaintainVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>


@property (nonatomic, strong) UITextField *searchBar;

@property (nonatomic, strong) UITableView *table;

@end

@implementation RentingRoomMaintainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)ActionAddBtn:(UIButton *)btn{
    
    SecdaryCommunityRoomVC *nextVC = [[SecdaryCommunityRoomVC alloc] init];
    nextVC.status = @"挂牌信息编辑";
    nextVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:nextVC animated:YES];
    //    CompleteSurveyInfoVC *nextVC = [[CompleteSurveyInfoVC alloc] initWithTitle:@"挂牌信息编辑"];
    //    [self.navigationController pushViewController:nextVC animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RoomMaintainCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomMaintainCell"];
    if (!cell) {
        
        cell = [[RoomMaintainCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomMaintainCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.tag = indexPath.row;
    
    cell.nameL.text = @"张三";
    cell.roomL.text = @"天鹅湖小区 - 17栋 - 2单元 - 103";
    cell.codeL.text = @"房源编号：CD - TEH - 20170810 - 1（F）";
    cell.numL.text = @"跟进次数：3";
    cell.timeL.text = @"上次跟进时间：2017-12-15  13:00:00";
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:@"13438339177"];
    [attr addAttribute:NSForegroundColorAttributeName value:YJBlueBtnColor range:NSMakeRange(0, 11)];
    [attr addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:NSMakeRange(0, 11)];
    cell.phoneL.attributedText = attr;
    cell.roomMaintainPhoneBlock = ^(NSInteger index) {
        
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
    
    RentingMaintainDetailVC *nextVC = [[RentingMaintainDetailVC alloc] init];
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"勘察维护";
    
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, 40 *SIZE)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiteView];
    
    _searchBar = [[UITextField alloc] initWithFrame:CGRectMake(10 *SIZE, 3 *SIZE, 340 *SIZE, 33 *SIZE)];
    _searchBar.backgroundColor = YJBackColor;
    _searchBar.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 11 *SIZE, 0)];
    //设置显示模式为永远显示(默认不显示)
    _searchBar.leftViewMode = UITextFieldViewModeAlways;
    _searchBar.placeholder = @"输入电话/姓名";
    _searchBar.font = [UIFont systemFontOfSize:12 *SIZE];
    _searchBar.layer.cornerRadius = 2 *SIZE;
    _searchBar.returnKeyType = UIReturnKeySearch;
    
    UIImageView *rightImg = [[UIImageView alloc] initWithFrame:CGRectMake(0 *SIZE, 8 *SIZE, 17 *SIZE, 17 *SIZE)];
    //    rightImg.backgroundColor = [UIColor whiteColor];
    rightImg.image = [UIImage imageNamed:@"search"];
    _searchBar.rightView = rightImg;
    _searchBar.rightViewMode = UITextFieldViewModeUnlessEditing;
    _searchBar.clearButtonMode = UITextFieldViewModeWhileEditing;
    _searchBar.delegate = self;
    [whiteView addSubview:_searchBar];
    
    self.rightBtn.hidden = NO;
    [self.rightBtn setImage:[UIImage imageNamed:@"add_3"] forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(ActionAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT + 40 *SIZE, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - 40 *SIZE) style:UITableViewStylePlain];
    _table.estimatedRowHeight = 108 *SIZE;
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.backgroundColor = self.view.backgroundColor;
    _table.delegate = self;
    _table.dataSource = self;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_table];
}

@end
