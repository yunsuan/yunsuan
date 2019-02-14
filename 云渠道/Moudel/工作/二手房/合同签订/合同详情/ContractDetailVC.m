//
//  ContractDetailVC.m
//  云渠道
//
//  Created by xiaoq on 2019/1/23.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "ContractDetailVC.h"

@interface ContractDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger _index;
    NSMutableArray *_contactArr;
    NSMutableDictionary *_baseInfoDic;
    NSMutableArray *_followArr;
    NSMutableDictionary *_needInfoDic;
    NSMutableArray *_takeHouseArr;
}
@property (nonatomic , strong) UITableView *mainTable;

-(void)InitInterFace;
-(void)InitDataSouce;
@end

@implementation ContractDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self InitDataSouce];
    [self InitInterFace];
}

-(void)InitInterFace
{
    self.titleLabel.text = @"合同详情";
    self.navBackgroundView.hidden = NO;
    self.rightBtn.hidden = NO;
    [self.rightBtn setTitleColor:YJ86Color forState:UIControlStateNormal];
    self.rightBtn.titleLabel.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.rightBtn addTarget:self action:@selector(ActionRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightBtn setImage:[UIImage imageNamed:@"add_1"] forState:UIControlStateNormal];
    [self.view addSubview:self.mainTable];
}

-(void)InitDataSouce
{
    [self Post];
}

-(void)Post{
    [BaseRequest GET:ContractDetail_URL parameters:@{@"deal_id":_deal_id} success:^(id resposeObject) {
        NSLog(@"%@",resposeObject);
        
    } failure:^(NSError *error) {
        
    }];
}


#pragma mark ---  action ----

- (void)ActionRightBtn:(UIButton *)btn{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"操作" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *buy = [UIAlertAction actionWithTitle:@"买方违约" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
    }];
    
    UIAlertAction *sell = [UIAlertAction actionWithTitle:@"卖方违约" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
    }];
    
    UIAlertAction *soldout = [UIAlertAction actionWithTitle:@"审核合同" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:buy];
    [alert addAction:sell];
    [alert addAction:soldout];
    [alert addAction:cancel];
    
    [self.navigationController presentViewController:alert animated:YES completion:^{
        
        
    }];
}



#pragma mark ---  delegeta ----
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (_baseInfoDic.count) {
        
        if (_index == 0) {
            
            return 2;
        }
        return 2;
    }else{
        
        return 0;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return UITableViewAutomaticDimension;
    }else{
        
        if (_index == 0) {
            
            return SIZE;
        }else{
            
            return CGFLOAT_MIN;
        }
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [[UIView alloc] init];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc] init];
}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//
//
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
   
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self alertControllerWithNsstring:@"温馨提示" And:@"你确定要删除联系人?" WithCancelBlack:^{
        
        
    } WithDefaultBlack:^{
        
        [BaseRequest POST:TakeMaintainContactDelete_URL parameters:@{@"contact_id":_contactArr[indexPath.row][@"contact_id"]} success:^(id resposeObject) {
            
        } failure:^(NSError *error) {
            
            [self showContent:@"网络错误"];
        }];
    }];
}


-(UITableView *)mainTable{
    if (!_mainTable) {
        _mainTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStyleGrouped];
        _mainTable.rowHeight = UITableViewAutomaticDimension;
        _mainTable.estimatedRowHeight = 260 *SIZE;
        _mainTable.estimatedSectionHeaderHeight = 476 *SIZE;
        _mainTable.backgroundColor = self.view.backgroundColor;
        _mainTable.delegate = self;
        _mainTable.dataSource = self;
        _mainTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _mainTable;
}



@end
