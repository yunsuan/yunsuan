//
//  StoreAuthVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/9/27.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "StoreAuthVC.h"

#import "SelectStoreVC.h"
#import "SelectCompanyVC.h"

#import "SinglePickView.h"

#import "StoreAuthCell.h"
#import "StoreAuthCollCell.h"

@interface StoreAuthVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSArray *_titleArr;
//    NSArray *_imgArr;
    
    NSMutableArray *_contentArr;
    NSMutableArray *_selectArr;
    NSMutableArray *_roleArr;
    
    NSString *_companyId;
    NSString *_storeId;
    NSString *_departId;
    NSString *_postId;
    NSString *_roleId;

    BOOL _isEmp;
}

@property (nonatomic, strong) UITableView *table;

@property (nonatomic, strong) UIButton *commitBtn;

@end

@implementation StoreAuthVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
    [self RequestMethod];
}

- (void)initDataSource{
    
    _isEmp = YES;
    _titleArr = @[@"选择公司",@"申请门店",@"是否为本店员工",@"部门",@"岗位",@"角色"];
//    _imgArr = @[@"rightarrow",@"",@"downarrow1"];
    
    _contentArr = [[NSMutableArray alloc] initWithArray:@[@" ",@" ",@" ",@" ",@" ",@" "]];
    
    _selectArr = [@[] mutableCopy];
    _roleArr = [@[] mutableCopy];
}

- (void)RequestMethod{
    
    [BaseRequest GET:StoreAuthStoreRole_URL parameters:nil success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            _roleArr = [NSMutableArray arrayWithArray:resposeObject[@"data"]];
            for (int i = 0; i < _roleArr.count; i++) {
                
                [_selectArr addObject:@(0)];
            }
            [_table reloadData];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [self showContent:@"获取权限列表失败,请返回重试"];
        NSLog(@"%@",error);
    }];
}

- (void)ActionConfirmBtn:(UIButton *)btn{
    
//    if (!_storeL.text.length) {
//
//        [self alertControllerWithNsstring:@"温馨提示" And:@"请选择门店"];
//        return;
//    }
//    _role = @"";
//    for (int i = 0; i < _selectArr.count; i++) {
//
//        if ([_selectArr[i] integerValue] == 1) {
//
//            if (!_role.length) {
//
//                _role = [NSString stringWithFormat:@"%@",_roleArr[i][@"id"]];
//            }else{
//
//                _role = [NSString stringWithFormat:@"%@,%@",_role,_roleArr[i][@"id"]];
//            }
//        }
//    }
//    if (!_role.length) {
//
//        [self alertControllerWithNsstring:@"温馨提示" And:@"请选择权限"];
//        return;
//    }
//
//    if ([_employeeL.text isEqualToString:@"是"]) {
//
//        _isEmp = YES;
//    }else{
//
//        _isEmp = NO;
//    }
//    [BaseRequest POST:PersonalSoreAuth_URL parameters:@{@"store_id":@([_storeId integerValue]),@"role":_role,@"is_store_staff":@(_isEmp)} success:^(id resposeObject) {
//
//        NSLog(@"%@",resposeObject);
//        if ([resposeObject[@"code"] integerValue] == 200) {
//
//            [self alertControllerWithNsstring:@"温馨提示" And:@"申请成功，等待审核通过" WithDefaultBlack:^{
//
//                [self.navigationController popToRootViewControllerAnimated:YES];
//            }];
//        }else{
//
//            [self showContent:resposeObject[@"msg"]];
//        }
//    } failure:^(NSError *error) {
//
//        [self showContent:@"服务器网络错误，请稍后尝试"];
//        NSLog(@"%@",error);
//    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (_isEmp) {
     
        return 6;
    }
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_isEmp) {
        
        StoreAuthCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StoreAuthCell"];
        if (!cell) {
            
            cell = [[StoreAuthCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"StoreAuthCell"];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
//        cell.dataDic = @{};
        cell.titleL.text = _titleArr[indexPath.row];
        cell.contentL.text = _contentArr[indexPath.row];
        
        return cell;
    }else{
        
        if (indexPath.row < 3) {
            
            StoreAuthCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StoreAuthCell"];
            if (!cell) {
                
                cell = [[StoreAuthCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"StoreAuthCell"];
            }
                    
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
            //        cell.dataDic = @{};
            cell.titleL.text = _titleArr[indexPath.row];
            cell.contentL.text = _contentArr[indexPath.row];
                    
            return cell;
        }else{
            
            StoreAuthCollCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StoreAuthCollCell"];
            if (!cell) {
                
                cell = [[StoreAuthCollCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"StoreAuthCollCell"];
            }
                    
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.dataArr = @[_roleArr,_selectArr];
            return cell;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        SelectCompanyVC *nextVC = [[SelectCompanyVC alloc] init];
        nextVC.selectCompanyVCBlock = ^(NSString *companyId, NSString *name) {
            
            self->_companyId = [NSString stringWithFormat:@"%@",companyId];
            self->_storeId = @"";
            self->_departId = @"";
            self->_postId = @"";
            self->_roleId = @"";
        };
        [self.navigationController pushViewController:nextVC animated:YES];
    }else if (indexPath.row == 1){
        
        SelectStoreVC *nextVC = [[SelectStoreVC alloc] initWithCompanyId:self->_companyId];
        nextVC.selectStoreVCBlock = ^(NSString * _Nonnull storeId, NSString * _Nonnull storeName) {
            
            self->_storeId = storeId;
            [self->_contentArr replaceObjectAtIndex:1 withObject:storeName];
            self->_departId = @"";
            self->_postId = @"";
            self->_roleId = @"";
            [tableView reloadData];
        };
        [self.navigationController pushViewController:nextVC animated:YES];
    }else if (indexPath.row == 2){
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否为本店员工" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *male = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            
            _isEmp = YES;
            [_contentArr replaceObjectAtIndex:2 withObject:@"是"];
            [tableView reloadData];
        }];
        
        UIAlertAction *female = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            _isEmp = NO;
            [_contentArr replaceObjectAtIndex:2 withObject:@"否"];
            [tableView reloadData];
        }];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alert addAction:male];
        [alert addAction:female];
        [alert addAction:cancel];
        [self.navigationController presentViewController:alert animated:YES completion:^{
            
        }];
    }else if (indexPath.row == 3){
        
        if (_isEmp) {
            
            if (!_companyId.length) {
                
                [self showContent:@"请先选择公司"];
                return;
            }
            [BaseRequest GET:@"agent/company/person/organize/list" parameters:@{@"company_id":_companyId} success:^(id resposeObject) {
                
                if ([resposeObject[@"code"] integerValue] == 200) {
                    
                    NSMutableArray *tempArr = [@[] mutableCopy];
                    for (int i = 0; i < [resposeObject[@"data"] count]; i++) {
                        
                        NSDictionary *dic = resposeObject[@"data"][i];
                        [tempArr addObject:@{@"id":dic[@"department_id"],@"param":dic[@"department_name"]}];
                    }
                    SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:tempArr];
                    view.selectedBlock = ^(NSString *MC, NSString *ID) {
                        
                        [_contentArr replaceObjectAtIndex:3 withObject:MC];
                        _departId = [NSString stringWithFormat:@"%@",ID];
                        [tableView reloadData];
                    };
                    [self.view addSubview:view];
                }else{
                    
                    [self showContent:resposeObject[@"msg"]];
                }
            } failure:^(NSError *error) {
               
                [self showContent:@"网络错误"];
            }];
        }
    }else if (indexPath.row == 4){
        
        if (!_departId.length) {
            
            [self showContent:@"请先选择部门"];
            return;
        }
        [BaseRequest GET:@"agent/company/person/organize/post/list" parameters:@{@"department_id":_departId} success:^(id resposeObject) {
            
            if ([resposeObject[@"code"] integerValue] == 200) {
                
                NSMutableArray *tempArr = [@[] mutableCopy];
                for (int i = 0; i < [resposeObject[@"data"] count]; i++) {
                    
                    NSDictionary *dic = resposeObject[@"data"][i];
                    [tempArr addObject:@{@"id":dic[@"post_id"],@"param":dic[@"post_name"]}];
                }
                SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:tempArr];
                view.selectedBlock = ^(NSString *MC, NSString *ID) {
                    
                    [_contentArr replaceObjectAtIndex:4 withObject:MC];
                    _postId = [NSString stringWithFormat:@"%@",ID];
                };
                [self.view addSubview:view];
            }else{
                
                [self showContent:resposeObject[@"msg"]];
            }
        } failure:^(NSError *error) {
           
            [self showContent:@"网络错误"];
        }];
    }else{
        
        
    }
    
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"门店认证";
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(37 *SIZE, 14 *SIZE + NAVIGATION_BAR_HEIGHT, 200 *SIZE, 13 *SIZE)];
    label.textColor = YJTitleLabColor;
    label.font = [UIFont systemFontOfSize:13 *SIZE];
    label.text = @"认证需要审核 请仔细填写信息";
    [self.view addSubview:label];
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 27 *SIZE + NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - 27 *SIZE - NAVIGATION_BAR_HEIGHT - 40 *SIZE - TAB_BAR_MORE) style:UITableViewStylePlain];
    _table.backgroundColor = CLBackColor;
    _table.delegate = self;
    _table.dataSource = self;
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 100 *SIZE;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_table];
    
    _commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _commitBtn.frame = CGRectMake(0, SCREEN_Height - TAB_BAR_MORE - 40 *SIZE, SCREEN_Width, 40 *SIZE + TAB_BAR_MORE);
    _commitBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_commitBtn addTarget:self action:@selector(ActionConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_commitBtn setTitle:@"提交申请" forState:UIControlStateNormal];
    [_commitBtn setBackgroundColor:YJBlueBtnColor];
    [self.view addSubview:_commitBtn];
}

@end
