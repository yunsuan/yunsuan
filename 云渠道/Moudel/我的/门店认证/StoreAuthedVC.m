//
//  StoreAuthedVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/9/27.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "StoreAuthedVC.h"

#import "StoreAuthVC.h"

#import "TitleContentBaseCell.h"

@interface StoreAuthedVC ()<UITableViewDataSource,UITableViewDelegate>
{
    
    NSArray *_titleArr;
    NSDictionary *_data;
}

@property (nonatomic, strong) UITableView *table;

@property (nonatomic, strong) UIButton *reCommitBtn;

@property (nonatomic, strong) UIButton *cancelBtn;

@end

@implementation StoreAuthedVC

- (instancetype)initWithData:(NSDictionary *)data;
{
    self = [super init];
    if (self) {
        
        _data = data;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
    _titleArr = @[@"所属门店",@"申请权限",@"是否为本店员工"];
}

- (void)ActionRecommitBtn:(UIButton *)btn{
    
    StoreAuthVC *nextVC = [[StoreAuthVC alloc] init];
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (void)ActionCancelBtn:(UIButton *)btn{
    
    [BaseRequest GET:@"agent/personal/store/auth/cancel" parameters:@{@"id":_data[@"id"]} success:^(id resposeObject) {
        
        //        NSLog(@"%@",resposeObject);
        [self showContent:resposeObject[@"msg"]];
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [self alertControllerWithNsstring:@"取消认证成功" And:nil WithDefaultBlack:^{
                
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }
    } failure:^(NSError *error) {
        
        [self showContent:@"网络错误"];
        //        NSLog(@"%@",error);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TitleContentBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TitleContentBaseCell"];
    if (!cell) {
        
        cell = [[TitleContentBaseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TitleContentBaseCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.titleL.text = _titleArr[indexPath.row];
    cell.contentL.textAlignment = NSTextAlignmentRight;
    if (indexPath.row == 0) {
        
        cell.contentL.text = _data[@"store_name"];
    }else if (indexPath.row == 1){
        
        cell.contentL.text = _data[@"role"];
    }else{
        
        cell.contentL.text = [_data[@"is_store_staff"] integerValue] == 1?@"是":@"否";
    }
    return cell;
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"门店认证";
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - TAB_BAR_MORE - 40 *SIZE) style:UITableViewStylePlain];
    _table.bounces = NO;
    _table.backgroundColor = self.view.backgroundColor;
    _table.delegate = self;
    _table.dataSource = self;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_table];
    
    _reCommitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _reCommitBtn.frame = CGRectMake(21 *SIZE, SCREEN_Height - TAB_BAR_MORE - 100 *SIZE, 317 *SIZE, 40 *SIZE);
    _reCommitBtn.layer.masksToBounds = YES;
    _reCommitBtn.layer.cornerRadius = 2 *SIZE;
    _reCommitBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_reCommitBtn addTarget:self action:@selector(ActionRecommitBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_reCommitBtn setTitle:@"重新认证" forState:UIControlStateNormal];
    [_reCommitBtn setBackgroundColor:YJLoginBtnColor];
    [self.view addSubview:_reCommitBtn];
    
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancelBtn.frame = CGRectMake(21 *SIZE, SCREEN_Height - TAB_BAR_MORE - 50 *SIZE, 317 *SIZE, 40 *SIZE);
    _cancelBtn.layer.masksToBounds = YES;
    _cancelBtn.layer.cornerRadius = 2 *SIZE;
    _cancelBtn.backgroundColor = YJLoginBtnColor;
    [_cancelBtn setTitle:@"取消认证" forState:UIControlStateNormal];
    [_cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:16 *SIZE];
    [_cancelBtn addTarget:self action:@selector(ActionCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_cancelBtn];
}

@end
