//
//  NewDealRuleVC.m
//  云渠道
//
//  Created by 谷治墙 on 2019/8/26.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "NewDealRuleVC.h"
#import "NewDealRuleCell.h"

@interface NewDealRuleVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableArray *_dataArr;
}
@property (nonatomic, strong) UITableView *table;

@end

@implementation NewDealRuleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataArr = [@[] mutableCopy];
    [self initUI];
    [self RequestMethod];
}

- (void)RequestMethod{
    
    [BaseRequest GET:@"agent/work/deal/ruleList" parameters:@{@"project_id":self.project_id,@"company_id":[UserModel defaultModel].company_id} success:^(id resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            self->_dataArr = [NSMutableArray arrayWithArray:resposeObject[@"data"]];
            [_table reloadData];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    }failure:^(NSError *error) {
        
        [self showContent:@"获取规则失败"];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NewDealRuleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewDealRuleCell"];
    if (!cell) {
        
        cell = [[NewDealRuleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NewDealRuleCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.dic = _dataArr[indexPath.section];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.newDealRuleVCBlock) {
        
        self.newDealRuleVCBlock(_dataArr[indexPath.section]);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"选择佣金规则";
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    _table.backgroundColor = self.view.backgroundColor;
    _table.delegate = self;
    _table.dataSource = self;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 100 *SIZE;
    [self.view addSubview:_table];
}

@end
