//
//  RentingMaintainDetailVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/7/30.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RentingMaintainDetailVC.h"
#import "SurveySuccessRoomDetailVC.h"
#import "SurveySuccessOwnerDetailVC.h"
#import "RoomSoldOutVC.h"
#import "RentingMaintainAddFollowVC.h"
#import "MaintainLookRecordVC.h"
#import "RoomAgencyAddProtocolVC.h"
#import "RentingMaintainRoomInfoVC.h"
#import "MaintainCustomVC.h"
#import "MaintainModifyCustomVC.h"
#import "ModifyTagVC.h"
#import "RentingModifyProjectAnalysisVC.h"
#import "ModifyProjectImageVC.h"

#import "MaintainCell.h"
#import "BlueTitleMoreHeader.h"
#import "RentingMaintainDetailHeader.h"
#import "SecAllRoomDetailTableHeader2.h"
#import "SecAllRoomTableCell2.h"
#import "MaintainAddFollowHeader.h"
#import "CustomDetailTableCell2.h"
#import "AddPeopleCell.h"
#import "MaintainRoomInfoCell.h"
#import "MaintainRoomInfoCell2.h"
#import "MaintainRoomInfoCell3.h"

@interface RentingMaintainDetailVC ()<UITableViewDataSource,UITableViewDelegate>
{
    NSInteger _item;
    NSArray *_titleArr;
    NSArray *_titleArr2;
    NSArray *_roomInfoArr;
    NSArray *_headerArr;
    NSInteger _num;
}
@property (nonatomic, strong) UITableView *mainTable;

@end

@implementation RentingMaintainDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
    _num = 3;
    _titleArr = @[@"",@"联系信息",@"业主信息",@"房源信息",@"房源真实图片"];
    _titleArr2 = @[@"",@"房源实景图片",@"房源配套",@"房源分析"];
    _headerArr = @[@"挂牌标题：新希望国际大厦   套三   清水房",@"挂牌价格：500月/平",@"物业类型：住宅",@"户型：二室二厅",@"收款方式：押一付三",@"类型：合租",@"卖房意愿度：45",@"卖房急迫度：45",@"参考价格：400月/平",@"关注人数：23",@"预估卖出周期：3周"];
    _roomInfoArr = @[@[],@[],@[@"高性价比",@"清水房",@"房东人很好"],@[@[@"房源概括：",@"套二，住家装修，高楼层，对中庭。"],@[@"装修描述：",@"房子是业主自住装修，客厅和卧室铺了木地板，有吊顶，卫生间做的蹲便，贴的瓷砖。"],@[@"备注：",@"希望租客是女生；不养宠物；一经发现存在黄赌毒，甲方有权收回房源；"]]];
}

- (void)ActionRightBtn:(UIButton *)btn{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"操作" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *protocol = [UIAlertAction actionWithTitle:@"转合同" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        //        RoomAgencyAddProtocolVC *nextVC = [[RoomAgencyAddProtocolVC alloc] init];
        //        [self.navigationController pushViewController:nextVC animated:YES];
    }];
    
    UIAlertAction *buy = [UIAlertAction actionWithTitle:@"转代购" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        RoomAgencyAddProtocolVC *nextVC = [[RoomAgencyAddProtocolVC alloc] init];
        [self.navigationController pushViewController:nextVC animated:YES];
        //        GetAgencyProtocolVC *nextVC = [[GetAgencyProtocolVC alloc] init];
        //        [self.navigationController pushViewController:nextVC animated:YES];
    }];
    
    UIAlertAction *soldout = [UIAlertAction actionWithTitle:@"下架房源" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        RoomSoldOutVC *nextVC = [[RoomSoldOutVC alloc] init];
        [self.navigationController pushViewController:nextVC animated:YES];
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:protocol];
    [alert addAction:buy];
    [alert addAction:soldout];
    [alert addAction:cancel];
    
    [self.navigationController presentViewController:alert animated:YES completion:^{
        
    }];
    
}


#pragma mark -- tableView;
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (_item == 0) {
        
        return 1;
    }else if (_item == 1){
        
        return 4;
    }else{
        
        return 3;
    }
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//
//    return UITableViewAutomaticDimension;
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        RentingMaintainDetailHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"RentingMaintainDetailHeader"];
        if (!header) {
            
            header = [[RentingMaintainDetailHeader alloc] initWithReuseIdentifier:@"RentingMaintainDetailHeader"];
            
        }
        [header.infoBtn setBackgroundColor:COLOR(219, 219, 219, 1)];
        [header.infoBtn setTitleColor:YJ86Color forState:UIControlStateNormal];
        [header.advantageBtn setBackgroundColor:COLOR(219, 219, 219, 1)];
        [header.advantageBtn setTitleColor:YJ86Color forState:UIControlStateNormal];
        [header.followBtn setBackgroundColor:COLOR(219, 219, 219, 1)];
        [header.followBtn setTitleColor:YJ86Color forState:UIControlStateNormal];
        
        header.codeL.text = @"房源编号：SCCDPDHPXQ-0302102";
        header.projectL.text = @"云算公馆  4栋-3单元-904";
        header.titleL.text = _headerArr[0];
        header.priceL.text = _headerArr[1];
        header.propertyL.text = _headerArr[2];
        header.houseTypeL.text = _headerArr[3];
        header.payWayL.text = _headerArr[4];
        header.typeL.text = _headerArr[5];
        header.intentL.text = _headerArr[6];
        header.urgentL.text = _headerArr[7];
        header.RePriceL.text = _headerArr[8];
        header.attentL.text = _headerArr[9];
        header.periodL.text = _headerArr[10];
        
        if (_item == 0) {
            
            [header.infoBtn setBackgroundColor:YJBlueBtnColor];
            [header.infoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }else if (_item == 1){
            
            [header.advantageBtn setBackgroundColor:YJBlueBtnColor];
            [header.advantageBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }else{
            
            [header.followBtn setBackgroundColor:YJBlueBtnColor];
            [header.followBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
        
        header.rentingMaintainTagHeaderBlock = ^(NSInteger index) {
            
            _item = index;
            [tableView reloadData];
        };
        
        header.rentingMaintainDetailHeaderBlock = ^{
            
            RentingMaintainRoomInfoVC *nextVC = [[RentingMaintainRoomInfoVC alloc] init];
            [self.navigationController pushViewController:nextVC animated:YES];
        };
        return header;
    }else{
        
        if (_item == 0) {
            
            return nil;
        }else if (_item == 1){
            
            BlueTitleMoreHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BlueTitleMoreHeader"];
            if (!header) {
                
                header = [[BlueTitleMoreHeader alloc] initWithReuseIdentifier:@"BlueTitleMoreHeader"];
            }
            
            header.titleL.text = _titleArr2[section];
            header.lineView.backgroundColor = [UIColor whiteColor];
            
            [header.moreBtn setImage:[UIImage imageNamed:@"edit"] forState:UIControlStateNormal];
            [header.moreBtn setTitle:@"" forState:UIControlStateNormal];
            [header.moreBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(header.contentView).offset(327 *SIZE);
                make.top.equalTo(header.contentView).offset(8 *SIZE);
                make.width.mas_equalTo(26 *SIZE);
                make.height.mas_equalTo(26 *SIZE);
            }];
            if (section == 4) {
                
                header.moreBtn.hidden = YES;
            }else{
                
                header.moreBtn.hidden = NO;
            }
            header.blueTitleMoreHeaderBlock = ^{
                
                if (section == 1) {
                    
                    ModifyProjectImageVC *nextVC = [[ModifyProjectImageVC alloc] init];
                    [self.navigationController pushViewController:nextVC animated:YES];
                }
                
                if (section == 2) {
                    
                    ModifyTagVC *nextVC = [[ModifyTagVC alloc] initWithArray:@[] type:0];
                    [self.navigationController pushViewController:nextVC animated:YES];
                };
                if (section == 3) {
                    
                    RentingModifyProjectAnalysisVC *nextVC = [[RentingModifyProjectAnalysisVC alloc] init];
                    [self.navigationController pushViewController:nextVC animated:YES];
                }
            };
            return header;
        }else{
            
            if (section == 2) {
                
                MaintainAddFollowHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"MaintainAddFollowHeader"];
                if (!header) {
                    
                    header = [[MaintainAddFollowHeader alloc] initWithReuseIdentifier:@"MaintainAddFollowHeader"];
                }
                
                header.maintainAddFollowHeaderBlock = ^{
                    
                    RentingMaintainAddFollowVC *nextVC = [[RentingMaintainAddFollowVC alloc] init];
                    [self.navigationController pushViewController:nextVC animated:YES];
                };
                
                return header;
            }else {
                
                SecAllRoomDetailTableHeader2 *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"SecAllRoomDetailTableHeader2"];
                if (!header) {
                    
                    header = [[SecAllRoomDetailTableHeader2 alloc] initWithReuseIdentifier:@"SecAllRoomDetailTableHeader2"];
                }
                header.moreBtn.hidden = NO;
                header.addBtn.hidden = NO;
                
                switch (section) {
                    case 1:
                    {
                        header.titleL.text = @"最新房源动态";
                        header.moreBtn.hidden = YES;
                        header.addBtn.hidden = YES;
                        break;
                    }
//                    case 2:
//                    {
//                        header.titleL.text = @"出价情况";
//                        header.moreBtn.hidden = YES;
//                        header.addBtn.hidden = YES;
//                        break;
//                    }
                        
                    default:
                        break;
                }
                
                return header;
            }
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if (_item == 2) {
        
        if (section == 0) {
            
            return CGFLOAT_MIN;;
        }else{
            
            return 8 *SIZE;
        }
    }else{
        
        return SIZE;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [[UIView alloc] init];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (_item == 0) {
        
        return _num;
    }else if (_item == 1){
        
        if (section == 0) {
            
            return 0;
        }else if (section == 1 || section == 2){
            
            return 1;
        }else{
            
            return [_roomInfoArr[section] count];
        }
    }else{
        
        if (section == 0) {
            
            return 0;
        }else if (section == 3){
            
            return 2;
        }else{
            
            return 1;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_item == 0) {
        
        if (indexPath.row == _num - 1) {
            
            AddPeopleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddPeopleCell"];
            if (!cell) {
                
                cell = [[AddPeopleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AddPeopleCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.addImg.image = [UIImage imageNamed:@"add10"];
            
            return cell;
        }else{
            
            MaintainCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MaintainCell"];
            if (!cell) {
                
                cell = [[MaintainCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MaintainCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            if (indexPath.row == 0) {
                
                cell.upBtn.hidden = YES;
            }else{
                
                cell.upBtn.hidden = NO;
            }
            
            if (indexPath.row == 1) {
                
                cell.downBtn.hidden = YES;
            }else{
                
                cell.downBtn.hidden = NO;
            }
            
            cell.tag = indexPath.row;
            cell.nameL.text = @"联系人：张三";
            cell.typeL.text = @"类型：业主- 主权益人";
            cell.phoneL.text = @"联系电话：15201234567";
            [cell.nameL mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(cell.contentView).offset(28 *SIZE);
                make.top.equalTo(cell.contentView).offset(21 *SIZE);
                make.width.mas_equalTo(cell.nameL.mj_textWith + 10 *SIZE);
            }];
            
            cell.maintainCellBlock = ^(NSInteger index, NSInteger btn) {
                if (btn == 0) {
                    
                    MaintainCustomVC *nextVC = [[MaintainCustomVC alloc] init];
                    [self.navigationController pushViewController:nextVC animated:YES];
                }else if (btn == 1){
                    
                    
                }else{
                    
                    
                }
            };
            
            return cell;
        }
    }else if (_item == 1){
        
        if (indexPath.section > 2) {
            
            MaintainRoomInfoCell3 *cell = [tableView dequeueReusableCellWithIdentifier:@"MaintainRoomInfoCell3"];
            if (!cell) {
                
                cell = [[MaintainRoomInfoCell3 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MaintainRoomInfoCell3"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            if (indexPath.section == 4) {
                
                cell.contentL.textColor = YJBlueBtnColor;
            }else{
                
                cell.contentL.textColor = YJContentLabColor;
            }
            cell.titleL.text = _roomInfoArr[indexPath.section][indexPath.row][0];
            cell.contentL.text = _roomInfoArr[indexPath.section][indexPath.row][1];
            
            return cell;
        }else{
            
            if (indexPath.section == 1) {
                
                MaintainRoomInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MaintainRoomInfoCell"];
                if (!cell) {
                    
                    cell = [[MaintainRoomInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MaintainRoomInfoCell"];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                cell.dataArr = [NSMutableArray arrayWithArray:@[@"",@"",@"",@""]];
                [cell.imgColl reloadData];
                
                return cell;
            }else{
                
                MaintainRoomInfoCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"MaintainRoomInfoCell2"];
                if (!cell) {
                    
                    cell = [[MaintainRoomInfoCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MaintainRoomInfoCell2"];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                [cell.tagView setData:@[@"高性价比",@"清水房",@"房东人很好"]];
                //                [cell.tagView];
                
                return cell;
            }
        }
    }else{
        
        if (indexPath.section == 2) {
            
            NSString * Identifier = @"CustomDetailTableCell2";
            CustomDetailTableCell2 *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
            if (!cell) {
                
                cell = [[CustomDetailTableCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            //            NSArray *arr = [self getDetailConfigArrByConfigState:FOLLOW_TYPE];
            //                [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            //
            //                    if ([_FollowArr[indexPath.row][@"follow_type"] integerValue] == [obj[@"id"] integerValue]) {
            //
            //                        cell.wayL.text = [NSString stringWithFormat:@"跟进方式:%@",obj[@"param"]];
            //                        *stop = YES;
            //                    }
            //                }];
            
            //                cell.intentionL.text = [NSString stringWithFormat:@"购买意向度:%@",_FollowArr[indexPath.row][@"intent"]];
            //                cell.urgentL.text = [NSString stringWithFormat:@"购买紧迫度:%@",_FollowArr[indexPath.row][@"urgency"]];
            //                cell.contentL.text = _FollowArr[indexPath.row][@"comment"];
            //                cell.timeL.text = [NSString stringWithFormat:@"跟进时间:%@",_FollowArr[indexPath.row][@"follow_time"]];
            
            return cell;
        }else{
            
            SecAllRoomTableCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"SecAllRoomTableCell2"];
            if (!cell) {
                
                cell = [[SecAllRoomTableCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SecAllRoomTableCell2"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.daysL.text = @"16";
            cell.allL.text = @"18";
            cell.intentL.text = @"56";
            cell.recentL.text = @"最近带看2018-03-12 >>";
            
            cell.lookRecordBlock = ^{
                
                MaintainLookRecordVC *nextVC = [[MaintainLookRecordVC alloc] init];
                [self.navigationController pushViewController:nextVC animated:YES];
            };
            return cell;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_item == 0) {
        
        if (indexPath.row == _num - 1) {
            
            MaintainModifyCustomVC *nextVC = [[MaintainModifyCustomVC alloc] init];
            [self.navigationController pushViewController:nextVC animated:YES];
            //            _num += 1;
            //            [tableView reloadData];
        }
    }
}

- (void)initUI{
    
    self.titleLabel.text = @"房源详情";
    self.navBackgroundView.hidden = NO;
    
    self.rightBtn.hidden = NO;
    [self.rightBtn setTitleColor:YJ86Color forState:UIControlStateNormal];
    self.rightBtn.titleLabel.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.rightBtn addTarget:self action:@selector(ActionRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightBtn setImage:[UIImage imageNamed:@"add_1"] forState:UIControlStateNormal];
    //    [self.rightBtn setTitle:@"下架" forState:UIControlStateNormal];
    
    _mainTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStyleGrouped];
    _mainTable.rowHeight = UITableViewAutomaticDimension;
    _mainTable.estimatedRowHeight = 260 *SIZE;
    _mainTable.estimatedSectionHeaderHeight = 476 *SIZE;
    _mainTable.sectionHeaderHeight = UITableViewAutomaticDimension;
    _mainTable.backgroundColor = self.view.backgroundColor;
    _mainTable.delegate = self;
    _mainTable.dataSource = self;
    _mainTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_mainTable];
}

@end
