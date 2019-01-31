//
//  LookMaintainDetailVC.m
//  云渠道
//
//  Created by 谷治墙 on 2019/1/23.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "LookMaintainDetailVC.h"

#import "LookMaintainDetailAddFollowVC.h"
#import "LookMaintainDetailLookRecordVC.h"
#import "LookMaintainCustomDetailVC.h"
#import "LookMaintainModifyCustomDetailVC.h"

#import "LookMaintainDetailHeader.h"
#import "LookMaintainDetailRoomCell.h"
#import "LookMaintainDetailContactCell.h"
#import "AddPeopleCell.h"
#import "LookMaintainAddFollowCell.h"
#import "LookMaintainDetailFollowCell.h"

@interface LookMaintainDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSInteger _index;
    NSString *_takeId;
    NSMutableArray *_contactArr;
    NSMutableDictionary *_baseInfoDic;
    NSMutableArray *_followArr;
    NSMutableDictionary *_needInfoDic;
    NSMutableArray *_takeHouseArr;
}
@property (nonatomic, strong) UITableView *mainTable;

@end

@implementation LookMaintainDetailVC

- (instancetype)initWithTakeId:(NSString *)takeId
{
    self = [super init];
    if (self) {
        
        _takeId = takeId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
    [self RequestMethod];
}

- (void)initDataSource{

    _contactArr = [@[] mutableCopy];
    _baseInfoDic = [@{} mutableCopy];
    _followArr = [@[] mutableCopy];
    _needInfoDic = [@{} mutableCopy];
    _takeHouseArr = [@[] mutableCopy];
}

- (void)RequestMethod{
    
    [BaseRequest GET:TakeMaintainDetail_URL parameters:@{@"take_id":_takeId} success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [self SetData:resposeObject[@"data"]];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [self showContent:@"网络错误"];
    }];
}

- (void)SetData:(NSDictionary *)data{
    
    _baseInfoDic = [NSMutableDictionary dictionaryWithDictionary:data[@"base_info"]];
    [_baseInfoDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
       
        if ([obj isKindOfClass:[NSNull class]]) {
            
            [_baseInfoDic setObject:@"" forKey:key];
        }else{
            
            [_baseInfoDic setObject:[NSString stringWithFormat:@"%@",obj] forKey:key];
        }
    }];
    
    _contactArr = [NSMutableArray arrayWithArray:data[@"contact"]];
    _followArr = [NSMutableArray arrayWithArray:data[@"follow"]];
    _needInfoDic = [NSMutableDictionary dictionaryWithDictionary:data[@"need_info"]];
    [_needInfoDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        if ([key isEqualToString:@"pay_type"] || [key isEqualToString:@"match_tags"] || [key isEqualToString:@"shop_type"]) {
            
            if ([obj isKindOfClass:[NSNull class]]) {
                
                [_needInfoDic setObject:@[] forKey:key];
            }
        }else{
            
            if ([obj isKindOfClass:[NSNull class]]) {
                
                [_needInfoDic setObject:@"" forKey:key];
            }else{
                
                [_needInfoDic setObject:[NSString stringWithFormat:@"%@",obj] forKey:key];
            }
        }
    }];
    _takeHouseArr = [NSMutableArray arrayWithArray:data[@"take_house"]];
    
    [_mainTable reloadData];
}

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

    if (_index == 0) {
        
        if (section == 0) {
            
            if ([self.edit integerValue]) {
                
                return 1;
            }
            return 0;
        }else{
            
            return _takeHouseArr.count;
        }
    }else if (_index == 1){
        
        if (section == 0) {
            
            return _contactArr.count;
        }else{
            
            if ([self.edit integerValue]) {
                
                return 1;
            }
            return 0;
        }
    }else{
        
        if (section == 0) {
            
            if ([self.edit integerValue]) {
                
                return 1;
            }
            return 0;
        }else{
            
            return _followArr.count;
        }
    }
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

    if (section == 0) {

        LookMaintainDetailHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"LookMaintainDetailHeader"];
        if (!header) {
            
            header = [[LookMaintainDetailHeader alloc] initWithReuseIdentifier:@"LookMaintainDetailHeader"];
        }
        header.dataDic = _baseInfoDic;
        header.needDic = _needInfoDic;
        
        [header.roomBtn setBackgroundColor:COLOR(219, 219, 219, 1)];
        [header.roomBtn setTitleColor:YJ86Color forState:UIControlStateNormal];
        [header.contactBtn setBackgroundColor:COLOR(219, 219, 219, 1)];
        [header.contactBtn setTitleColor:YJ86Color forState:UIControlStateNormal];
        [header.followBtn setBackgroundColor:COLOR(219, 219, 219, 1)];
        [header.followBtn setTitleColor:YJ86Color forState:UIControlStateNormal];
        
        if (_takeHouseArr.count) {
            
            [header.roomBtn setTitle:[NSString stringWithFormat:@"带看房源(%ld)",_takeHouseArr.count] forState:UIControlStateNormal];
        }else{
            
            [header.roomBtn setTitle:@"带看房源(0)" forState:UIControlStateNormal];
        }
        [header.followBtn setTitle:@"跟进记录" forState:UIControlStateNormal];
        [header.contactBtn setTitle:@"联系人信息" forState:UIControlStateNormal];
        if (_index == 0) {
            
            [header.roomBtn setBackgroundColor:YJBlueBtnColor];
            [header.roomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }else if (_index == 2){
            
            [header.followBtn setBackgroundColor:YJBlueBtnColor];
            [header.followBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }else{
            
            [header.contactBtn setBackgroundColor:YJBlueBtnColor];
            [header.contactBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
        
        header.lookMaintainDetailHeaderBlock = ^(NSInteger index) {
            
            _index = index;
            if (index == 1) {
                
                
            }else if (index == 2){
                
                
            }
            [tableView reloadData];
        };
        
        return header;
    }else{
        
        return nil;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (_index == 0) {

        if (indexPath.section == 0) {

            NSString * Identifier = @"LookMaintainAddFollowCell";
            LookMaintainAddFollowCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
            if (!cell) {

                cell = [[LookMaintainAddFollowCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.addLabel.text = @"添加带看";

            return cell;
        }else{

            NSString * Identifier = @"LookMaintainDetailRoomCell";
            LookMaintainDetailRoomCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
            if (!cell) {
                
                cell = [[LookMaintainDetailRoomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.dataDic = _takeHouseArr[indexPath.row];
            return cell;
        }
    }else{

        if (_index == 1) {

            if (indexPath.section == 0) {
                
                NSString * Identifier = @"LookMaintainDetailContactCell";
                LookMaintainDetailContactCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
                if (!cell) {
                    
                    cell = [[LookMaintainDetailContactCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                cell.tag = indexPath.row;
                cell.dataDic = _contactArr[indexPath.row];
                if (indexPath.row == 0) {
                    
                    cell.typeL.text = @"主权益人";
                    cell.upBtn.hidden = YES;
                }else{
                    
                    cell.typeL.text = @"副权益人";
                    cell.upBtn.hidden = NO;
                    if (indexPath.row == _contactArr.count - 1) {
                        
                        cell.downBtn.hidden = YES;
                    }else{
                        
                        cell.downBtn.hidden = NO;
                    }
                }
                
                cell.lookMaintainDetailContactCellBlock = ^(NSInteger index, NSInteger btn) {
                    
                    if (btn == 0){
                        
                        if (index == 0) {
                            
                            
                        }else{
                            
                            [BaseRequest GET:TakeMaintainContactChangeSort_URL parameters:@{@"contact_id":_contactArr[index][@"contact_id"],@"top_contact_id":_contactArr[index - 1][@"contact_id"]} success:^(id resposeObject) {
                                
                                NSLog(@"%@",resposeObject);
                                if ([resposeObject[@"code"] integerValue] == 200) {
                                    
                                    [_contactArr exchangeObjectAtIndex:index withObjectAtIndex:(index - 1)];
                                    [_mainTable reloadData];
                                }else{
                                    
                                    [self showContent:resposeObject[@"msg"]];
                                }
                            } failure:^(NSError *error) {
                                
                                NSLog(@"%@",error);
                                [self showContent:@"网络错误"];
                            }];
                        }
                    }else{
                        
                        if (index == _contactArr.count - 1) {
                            
                            
                        }else{
                            
                            [BaseRequest GET:TakeMaintainContactChangeSort_URL parameters:@{@"contact_id":_contactArr[index][@"contact_id"],@"top_contact_id":_contactArr[index + 1][@"contact_id"]} success:^(id resposeObject) {
                                
                                NSLog(@"%@",resposeObject);
                                if ([resposeObject[@"code"] integerValue] == 200) {
                                    
                                    [_contactArr exchangeObjectAtIndex:index withObjectAtIndex:(index + 1)];
                                    [_mainTable reloadData];
                                }else{
                                    
                                    [self showContent:resposeObject[@"msg"]];
                                }
                            } failure:^(NSError *error) {
                                
                                NSLog(@"%@",error);
                                [self showContent:@"网络错误"];
                            }];
                        }
                    }
                };
                return cell;
            }else{
                
                AddPeopleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddPeopleCell"];
                if (!cell) {
                    
                    cell = [[AddPeopleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AddPeopleCell"];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                cell.addImg.image = [UIImage imageNamed:@"add10"];
                
                return cell;
            }
        }else{

            if (indexPath.section == 0) {
                
                NSString * Identifier = @"LookMaintainAddFollowCell";
                LookMaintainAddFollowCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
                if (!cell) {
                    
                    cell = [[LookMaintainAddFollowCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.addLabel.text = @"添加跟进记录";
                return cell;
            }else{
                
                NSString * Identifier = @"LookMaintainDetailFollowCell";
                LookMaintainDetailFollowCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
                if (!cell) {
                    
                    cell = [[LookMaintainDetailFollowCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                cell.dataDic = _followArr[indexPath.row];
                
                return cell;
            }
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_index == 0) {
        
        if (indexPath.section == 0) {
            
            NSMutableDictionary *tempDic = [_needInfoDic mutableCopy];
            [tempDic setObject:_baseInfoDic[@"client_level"] forKey:@"client_level"];
            LookMaintainDetailAddFollowVC *nextVC = [[LookMaintainDetailAddFollowVC alloc] initWithTakeId:_takeId dataDic:tempDic];
            nextVC.property = _needInfoDic[@"property_type"];
            nextVC.status = @"2";
            nextVC.lookMaintainDetailAddFollowVCBlock = ^{
                
                [self RequestMethod];
            };
            [self.navigationController pushViewController:nextVC animated:YES];
        }else{
            
            LookMaintainDetailLookRecordVC *nextVC = [[LookMaintainDetailLookRecordVC alloc] initWithData:_takeHouseArr[indexPath.row]];
            [self.navigationController pushViewController:nextVC animated:YES];
        }
    }else if (_index == 1){
        
        if (indexPath.section == 0) {
            
            LookMaintainCustomDetailVC *nextVC = [[LookMaintainCustomDetailVC alloc] initWithDataDic:_contactArr[indexPath.row]];
            nextVC.lookMaintainCustomDetailVCBlock = ^{
                
                [self RequestMethod];
            };
            [self.navigationController pushViewController:nextVC animated:YES];
        }else{
            
            LookMaintainModifyCustomDetailVC *nextVC = [[LookMaintainModifyCustomDetailVC alloc] init];
//            nextVC.houseId = _houseId;
            nextVC.status = @"添加";
            nextVC.lookMaintainModifyCustomDetailVCBlock = ^(NSDictionary *dic) {
                
//                if (self.maintainDetailVCBlock) {
//
//                    self.maintainDetailVCBlock();
//                }
                [self RequestMethod];
            };
            [self.navigationController pushViewController:nextVC animated:YES];
        }
    }else{
        
        if (indexPath.section == 0) {
            
            NSMutableDictionary *tempDic = [_needInfoDic mutableCopy];
            [tempDic setObject:_baseInfoDic[@"client_level"] forKey:@"client_level"];
            LookMaintainDetailAddFollowVC *nextVC = [[LookMaintainDetailAddFollowVC alloc] initWithTakeId:_takeId dataDic:tempDic];
            nextVC.property = _needInfoDic[@"property_type"];
            nextVC.lookMaintainDetailAddFollowVCBlock = ^{
                
                [self RequestMethod];
            };
            [self.navigationController pushViewController:nextVC animated:YES];
        }else{
            
            
        }
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_index == 1) {
        
        if (indexPath.section == 0) {
            
            if (indexPath.row == 0) {
                
                return NO;
            }
            return YES;
        }else{
            
            return NO;
        }
    }
    return NO;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self alertControllerWithNsstring:@"温馨提示" And:@"你确定要删除联系人?" WithCancelBlack:^{
        
        
    } WithDefaultBlack:^{
        
        [BaseRequest POST:TakeMaintainContactDelete_URL parameters:@{@"contact_id":_contactArr[indexPath.row][@"contact_id"]} success:^(id resposeObject) {
            
            if ([resposeObject[@"code"] integerValue] == 200) {
                
                [self RequestMethod];
            }else{
                
                [self showContent:resposeObject[@"msg"]];
            }
        } failure:^(NSError *error) {
            
            [self showContent:@"网络错误"];
        }];
    }];
}


- (void)initUI{

    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"带看详情";

    _mainTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - TAB_BAR_MORE) style:UITableViewStyleGrouped];
    _mainTable.estimatedRowHeight = 367 *SIZE;
    _mainTable.rowHeight = UITableViewAutomaticDimension;
    _mainTable.estimatedSectionHeaderHeight = 584 *SIZE;
    //    _customDetailTable.sectionHeaderHeight = UITableViewAutomaticDimension;
    _mainTable.backgroundColor = YJBackColor;
    _mainTable.delegate = self;
    _mainTable.dataSource = self;
    _mainTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_mainTable];
}

@end
