//
//  IdentifyingVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/5/7.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "IdentifyingVC.h"
#import "IdentifyTableCell.h"
#import "IdentifyHeader.h"

@interface IdentifyingVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSArray *_titleArr;
    NSArray *_contentArr;
    NSDictionary *_dataDic;
}
@property (nonatomic, strong) UITableView *identifyTable;

@end

@implementation IdentifyingVC

- (instancetype)initWithData:(NSDictionary *)data
{
    self = [super init];
    if (self) {
        
        _dataDic = data;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _titleArr = @[@[@"姓名",@"身份证号"],@[@"上传正面人像页",@"上传背面国徽页",@"手持正面身份证"]];
    if ([_dataDic[@"state"] isEqualToString:@"认证中"]) {
        
        _contentArr = @[@[_dataDic[@"name"],_dataDic[@"card_id"]],@[@"验证中",@"验证中",@"验证中"]];
    }else{
        
        _contentArr = @[@[_dataDic[@"name"],_dataDic[@"card_id"]],@[@"已验证",@"已验证",@"已验证"]];
    }
    [self initUI];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 2;
    }
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 117 *SIZE;
    }
    return 6 *SIZE;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        IdentifyHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"IdentifyHeader"];
        if (!header) {
            
            header = [[IdentifyHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 117 *SIZE)];
        }
        header.statusL.text = _dataDic[@"state"];
        return header;
    }
    return [[UIView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50 *SIZE;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [[UIView alloc] init];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    IdentifyTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IdentifyTableCell"];
    if (!cell) {
        
        cell = [[IdentifyTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"IdentifyTableCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.titleL.text = _titleArr[indexPath.section][indexPath.row];
    cell.contentL.text = _contentArr[indexPath.section][indexPath.row];
    if ([_dataDic[@"state"] isEqualToString:@"认证中"]) {
        
        if (indexPath.section == 1) {
            
            cell.contentL.textColor = COLOR(255, 59, 59, 1);
        }
    }else{
        
        if (indexPath.section == 1) {
            
            cell.contentL.textColor = YJContentLabColor;
        }
    }
    return cell;
}


- (void)initUI{
        
    self.titleLabel.text = @"身份证认证";
    self.navBackgroundView.hidden = NO;
    
    _identifyTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStyleGrouped];
    _identifyTable.backgroundColor = self.view.backgroundColor;
    _identifyTable.delegate = self;
    _identifyTable.dataSource = self;
    
    [self.view addSubview:_identifyTable];
}
@end
