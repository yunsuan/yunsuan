//
//  AuthenedVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/10.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "AuthenedVC.h"
#import "AuthenTableCell.h"
#import "AuthenCollCell.h"
//#import "SelectCompanyVC.h"
#import "AuthenticationVC.h"
#import "AuthenedTableHeader.h"
#import "AuthenImgCell.h"
#import "AuthenBtnCell.h"

@interface AuthenedVC()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSArray *_titleArr;
    NSMutableArray *_contentArr;
//    NSMutableArray *_imgArr;
//    NSInteger _index;
    NSDictionary *_dataDic;
}
@property (nonatomic, strong) UITableView *authenTable;

//@property (nonatomic, strong) UIButton *commitBtn;
//
//@property (nonatomic, strong) UIButton *dimissionBtn;

@end

@implementation AuthenedVC

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
    
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
    _contentArr = [[NSMutableArray alloc] init];
    NSArray *tempArr = @[_dataDic[@"company_name"],/*_dataDic[@"work_code"],*/_dataDic[@"company_name"],_dataDic[@"butter_project"],[_dataDic[@"department"] length] ?_dataDic[@"department"]:@" ",[_dataDic[@"position"] length]?_dataDic[@"position"]:@" ",_dataDic[@"create_time"]];
    _contentArr = [NSMutableArray arrayWithArray:tempArr];
    if ([_dataDic[@"role"] integerValue] == 1) {
        
        _contentArr[1] = @"经纪人";
        _contentArr[2] = @" ";

    }else if ([_dataDic[@"role"] integerValue] == 2){
        
        _contentArr[1] = @"确认人";
        _contentArr[2] = _dataDic[@"butter_project"];

    }else{
        
        _contentArr[1] = @"确认单签字人";
        _contentArr[2] = _dataDic[@"butter_project"];

    }
    _titleArr = @[@"所属公司",/*@"工号",*/@"角色",@"申请项目",@"所属部门",@"职位",@"入职/申请时间"];
}

//- (void)ActionConfirmBtn:(UIButton *)btn{
//
//    AuthenticationVC *nextVC = [[AuthenticationVC alloc] init];
//    nextVC.status = @"重新认证";
//    nextVC.beforeId = _dataDic[@"id"];
//    [self.navigationController pushViewController:nextVC animated:YES];
//}
//
//- (void)ActionCancelBtn:(UIButton *)btn{
//
//    [self alertControllerWithNsstring:@"温馨提示" And:@"你确认要离职已认证的公司" WithCancelBlack:^{
//
//
//    } WithDefaultBlack:^{
//
//        [BaseRequest GET:QuitAuth_URL parameters:@{@"id":_dataDic[@"id"]} success:^(id resposeObject) {
//
//            if ([resposeObject[@"code"] integerValue] == 200) {
//
//                [self alertControllerWithNsstring:@"离职成功" And:nil WithDefaultBlack:^{
//
//                    [UserModel defaultModel].agent_identity = @"1";
//                    [UserModelArchiver archive];
//                    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadType" object:nil];
//                    [self.navigationController popViewControllerAnimated:YES];
//                }];
//            }else{
//
//                [self showContent:resposeObject[@"msg"]];
//            }
//        } failure:^(NSError *error) {
//
//            [self showContent:@"网络错误"];
//        }];
//    }];
//}

#pragma mark --table代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 6;
    }else{
        
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 117 *SIZE;
    }else{
        
        return 3 *SIZE;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        AuthenedTableHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"AuthenedTableHeader"];
        if (!header) {
            
            header = [[AuthenedTableHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 117 *SIZE)];
        }
        
        
        return header;
    }else{
        
        return nil;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section == 0) {
        
        NSString * Identifier = @"AuthenTableCell";
        AuthenTableCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
        if (!cell) {
            
            cell = [[AuthenTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.rightView.hidden = YES;
        cell.titleL.text = _titleArr[(NSUInteger) indexPath.row];
        cell.contentL.text = _contentArr[(NSUInteger) indexPath.row];
        return cell;
    }else{
        
        if (indexPath.section == 1) {
            
            AuthenImgCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AuthenImgCell"];
            if (!cell) {
                
                cell = [[AuthenImgCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AuthenImgCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            NSString *imgname = _dataDic[@"img_url"];
            if (imgname.length>0) {
                
                [cell.imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,_dataDic[@"img_url"]]] placeholderImage:[UIImage imageNamed:@"default_3"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                    
                    if (error) {
                        
                        cell.imgView.image = [UIImage imageNamed:@"default_3"];
                    }
                }];
            }else{
                
                cell.imgView.image = [UIImage imageNamed:@"default_3"];
            }
            
            return cell;
        }else{
            
            AuthenBtnCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AuthenBtnCell"];
            if (!cell) {
                
                cell = [[AuthenBtnCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AuthenBtnCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.authenBtnCellDimissionBtnBlock = ^{
                
                [self alertControllerWithNsstring:@"温馨提示" And:@"你确认要离职已认证的公司" WithCancelBlack:^{
                    
                    
                } WithDefaultBlack:^{
                    
                    [BaseRequest GET:QuitAuth_URL parameters:@{@"id":_dataDic[@"id"]} success:^(id resposeObject) {
                        
                        if ([resposeObject[@"code"] integerValue] == 200) {
                            
                            [self alertControllerWithNsstring:@"离职成功" And:nil WithDefaultBlack:^{
                                
                                [UserModel defaultModel].agent_identity = @"1";
                                [UserModelArchiver archive];
                                [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadType" object:nil];
                                [self.navigationController popViewControllerAnimated:YES];
                            }];
                        }else{
                            
                            [self showContent:resposeObject[@"msg"]];
                        }
                    } failure:^(NSError *error) {
                        
                        [self showContent:@"网络错误"];
                    }];
                }];
            };
            
            cell.authenBtnCellCommitBtnBlock = ^{
                
                AuthenticationVC *nextVC = [[AuthenticationVC alloc] init];
                nextVC.status = @"重新认证";
                nextVC.beforeId = _dataDic[@"id"];
                [self.navigationController pushViewController:nextVC animated:YES];
            };
            
            return cell;
        }
    }
}

- (void)initUI{
    
    self.titleLabel.text = @"公司认证";
    self.navBackgroundView.hidden = NO;

    _authenTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStyleGrouped];
    _authenTable.backgroundColor = self.view.backgroundColor;
    _authenTable.rowHeight = UITableViewAutomaticDimension;
    _authenTable.estimatedRowHeight = 51 *SIZE;
    _authenTable.delegate = self;
    _authenTable.dataSource = self;
    _authenTable.bounces = NO;
    _authenTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_authenTable];

}

@end
