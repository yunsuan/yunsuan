//
//  CompanyDetailVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/3/28.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "CompanyDetailVC.h"
#import "AuthenticationVC.h"

#import "CompanyDetailCell.h"
#import "SelectCompanyTableCell.h"

@interface CompanyDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    CompanyModel *_model;
}
@property (nonatomic, strong) UITableView *mainTable;

@property (nonatomic, strong) UIButton *selectBtn;

@end

@implementation CompanyDetailVC

- (instancetype)initWithModel:(CompanyModel *)model
{
    self = [super init];
    if (self) {
        
        _model = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self initUI];
}

- (void)ActionSelectBtn:(UIButton *)btn{
    
    for (UIViewController *vc in self.navigationController.viewControllers) {
        
        if ([vc isKindOfClass:[AuthenticationVC class]]) {
            
            if (self.companyDetailVCBlock) {
                
                self.companyDetailVCBlock(_model.company_id, _model.company_name);
                [self.navigationController popToViewController:vc animated:YES];
            }
            
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 9 *SIZE;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return [[UIView alloc] init];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [[UIView alloc] init];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        NSString * Identifier = @"SelectCompanyTableCell";
        SelectCompanyTableCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
        if (!cell) {
            
            cell = [[SelectCompanyTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.model = _model;
        return cell;
    }else{
        
        NSString * Identifier = @"CompanyDetailCell";
        CompanyDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
        if (!cell) {
            
            cell = [[CompanyDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.briefL.text = _model.comment;
        
        return cell;
    }
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"公司详情";
    
    
    _mainTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - 43 *SIZE - TAB_BAR_MORE) style:UITableViewStyleGrouped];
    _mainTable.rowHeight = UITableViewAutomaticDimension;
    _mainTable.estimatedRowHeight = 100 *SIZE;
    _mainTable.backgroundColor = self.view.backgroundColor;
    _mainTable.delegate = self;
    _mainTable.dataSource = self;
    [self.view addSubview:_mainTable];
    
    _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _selectBtn.frame = CGRectMake(0, SCREEN_Height - 43 *SIZE - TAB_BAR_MORE, SCREEN_Width, 43 *SIZE + TAB_BAR_MORE);
    _selectBtn.titleLabel.font = [UIFont systemFontOfSize:14 *sIZE];
    [_selectBtn addTarget:self action:@selector(ActionSelectBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_selectBtn setTitle:@"选择该公司" forState:UIControlStateNormal];
    [_selectBtn setBackgroundColor:COLOR(27, 152, 255, 1)];
    [_selectBtn setTitleColor:CH_COLOR_white forState:UIControlStateNormal];
    [self.view addSubview:_selectBtn];
}


@end
