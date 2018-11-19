//
//  MaintainDetailVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/6/20.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "MaintainDetailVC.h"
#import "SurveySuccessRoomDetailVC.h"
#import "SurveySuccessOwnerDetailVC.h"
#import "RoomSoldOutVC.h"
#import "MaintainAddFollowVC.h"
#import "MaintainLookRecordVC.h"
#import "RoomAgencyAddProtocolVC.h"
#import "MaintainRoomInfoVC.h"
#import "MaintainCustomVC.h"
#import "MaintainModifyCustomVC.h"
#import "ModifyTagVC.h"
#import "ModifyProjectAnalysisVC.h"
#import "ModifyProjectImageVC.h"
#import "AddEquipmentVC.h"
#import "MaintainFollowDetailVC.h"
#import "ModifyNerborVC.h"

#import "MaintainCell.h"
//#import "SingleContentCell.h"
#import "BlueTitleMoreHeader.h"
#import "MaintainDetailHeader.h"
//#import "SurveySuccessImgCell.h"
#import "SecAllRoomDetailTableHeader2.h"
#import "SecAllRoomTableCell2.h"
#import "MaintainAddFollowHeader.h"
#import "CustomDetailTableCell2.h"
#import "AddPeopleCell.h"
#import "MaintainRoomInfoCell.h"
#import "MaintainRoomInfoCell2.h"
#import "MaintainRoomInfoCell3.h"
#import "MaintainRoomInfoEquipMentCell.h"
#import "MaintainRoomInfoNeiborCell.h"

@interface MaintainDetailVC ()<UITableViewDataSource,UITableViewDelegate>
{
    NSString *_surveyId;
    NSString *_houseId;
    NSInteger _item;
    NSArray *_titleArr;
    NSArray *_titleArr2;
    NSArray *_roomInfoArr;
    NSMutableDictionary *_houseDic;
    NSMutableArray *_peopleArr;
    NSMutableDictionary *_infoDic;
    NSMutableDictionary *_moreDic;
    NSMutableArray *_followArr;
    NSMutableArray *_tagArr;
    NSMutableArray *_matchArr;
    NSMutableDictionary *_detailDic;
    NSInteger _type;
}
@property (nonatomic, strong) UITableView *mainTable;

@end

@implementation MaintainDetailVC

- (instancetype)initWithSurveyId:(NSString *)surveyId houseId:(NSString *)houseId type:(NSInteger)type
{
    self = [super init];
    if (self) {
        
        _surveyId = surveyId;
        _houseId = houseId;
        _type = type;
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
    
    _titleArr = @[@"",@"联系信息",@"业主信息",@"房源信息",@"房源真实图片"];
    if (_type == 1) {
        
        _titleArr2 = @[@"",@"房源实景图片",@"房源标签",@"项目分析",@"其他费项"];
    }else if (_type == 2){
        
        _titleArr2 = @[@"",@"房源实景图片",@"房源标签",@"配套设施",@"左云右算",@"房源分析",@"其他费项"];
    }else if (_type == 3){
        
        _titleArr2 = @[@"",@"房源实景图片",@"房源标签",@"配套设施",@"左云右算",@"房源分析",@"其他费项"];
    }
    
    _houseDic = [@{} mutableCopy];
    _peopleArr = [@[] mutableCopy];
    _infoDic = [@{} mutableCopy];
    _followArr = [@[] mutableCopy];
    _tagArr = [@[] mutableCopy];
    _matchArr = [@[] mutableCopy];
    _detailDic = [@{} mutableCopy];
    _moreDic = [@{} mutableCopy];
}

- (void)RequestMethod{
    
    [BaseRequest GET:HouseSurveyDetail_URL parameters:@{@"house_id":_houseId,@"type":@(_type)} success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {

            [self SetData:resposeObject[@"data"]];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
       
        NSLog(@"%@",error);
        [self showContent:@"网络错误"];
    }];
}

- (void)SetData:(NSDictionary *)data{
    
    _detailDic = [NSMutableDictionary dictionaryWithDictionary:data[@"detail"]];
    [_tagArr removeAllObjects];
    NSArray *arr = _detailDic[@"house_tags"];
    for (NSDictionary *dic in arr) {
        
        [_tagArr addObject:dic[@"tag_name"]];
    }
    if ([data[@"house"] isKindOfClass:[NSDictionary class]]) {
        
        _houseDic = [NSMutableDictionary dictionaryWithDictionary:data[@"house"]];
        [_houseDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
           
            if ([key isEqualToString:@"pay_way"]) {
                
                if ([obj isKindOfClass:[NSNull class]]) {
                    
                    [_houseDic setObject:@[] forKey:key];
                }else{
                    
                    if ([obj isKindOfClass:[NSString class]]) {
                        
                        [_houseDic setObject:@[] forKey:key];
                    }else{
                        
                        [_houseDic setObject:obj forKey:key];
                    }
                }
            }else{
                
                if ([obj isKindOfClass:[NSNull class]]) {
                    
                    [_houseDic setObject:@"" forKey:key];
                }else{
                    
                    [_houseDic setObject:[NSString stringWithFormat:@"%@",obj] forKey:key];
                }
            }
            
        }];
    }
    
    if ([data[@"contact"] isKindOfClass:[NSArray class]]) {
        
        _peopleArr = [NSMutableArray arrayWithArray:data[@"contact"]];
    }
    
    if ([data[@"info"] isKindOfClass:[NSDictionary class]]) {
        
        _infoDic = [NSMutableDictionary dictionaryWithDictionary:data[@"info"]];

//        [_tagArr removeAllObjects];
//        NSArray *arr = _detailDic[@"house_tags"];
//        for (NSDictionary *dic in arr) {
//
//            [_tagArr addObject:dic[@"tag_name"]];
//        }
    }
    _matchArr = [NSMutableArray arrayWithArray:_detailDic[@"match_tags"]];
    
    if ([data[@"follow"] isKindOfClass:[NSArray class]]) {
        
        _followArr = [NSMutableArray arrayWithArray:data[@"follow"]];
    }
    
    if ([data[@"more"] isKindOfClass:[NSDictionary class]]) {

        _moreDic = [NSMutableDictionary dictionaryWithDictionary:data[@"more"]];
    }
    [_mainTable reloadData];
}
- (void)ActionRightBtn:(UIButton *)btn{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"操作" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *protocol = [UIAlertAction actionWithTitle:@"转合同" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
//        RoomAgencyAddProtocolVC *nextVC = [[RoomAgencyAddProtocolVC alloc] init];
//        [self.navigationController pushViewController:nextVC animated:YES];
    }];
    
    UIAlertAction *buy = [UIAlertAction actionWithTitle:@"转代购" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [BaseRequest GET:HouseSubNeedAgent_URL parameters:nil success:^(id resposeObject) {
            
            NSLog(@"%@",resposeObject);
            if ([resposeObject[@"code"] integerValue] == 200) {
                
                RoomAgencyAddProtocolVC *nextVC = [[RoomAgencyAddProtocolVC alloc] initWithDataArr:@[]];
                nextVC.handleDic = [[NSMutableDictionary alloc] initWithDictionary:resposeObject[@"data"]];
                nextVC.housedic = [NSMutableDictionary dictionaryWithDictionary:_houseDic];
                nextVC.roomAgencyAddProtocolVCBlock = ^{
                    
                    if (self.maintainDetailVCBlock) {
                        
                        self.maintainDetailVCBlock();
                    }
                };
                [self.navigationController pushViewController:nextVC animated:YES];
            }else{
                
                [self showContent:resposeObject[@"msg"]];
            }
        } failure:^(NSError *error) {
            
            NSLog(@"%@",error);
            [self showContent:@"网络错误"];
        }];
    }];
    
    UIAlertAction *soldout = [UIAlertAction actionWithTitle:@"下架房源" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        RoomSoldOutVC *nextVC = [[RoomSoldOutVC alloc] initWithHouseId:_houseId];
        nextVC.dataDic = @{@"absolute_address":_moreDic[@"absolute_address"],@"house_code":_moreDic[@"house_code"]};
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
    
        if (_type == 1) {
            
            return 4;
        }else{
            
            return 6;
        }
        
    }else{
        
        return 2;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return UITableViewAutomaticDimension;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        MaintainDetailHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"MaintainDetailHeader"];
        if (!header) {
            
            header = [[MaintainDetailHeader alloc] initWithReuseIdentifier:@"MaintainDetailHeader"];
            
        }
        [header.infoBtn setBackgroundColor:COLOR(219, 219, 219, 1)];
        [header.infoBtn setTitleColor:YJ86Color forState:UIControlStateNormal];
        [header.advantageBtn setBackgroundColor:COLOR(219, 219, 219, 1)];
        [header.advantageBtn setTitleColor:YJ86Color forState:UIControlStateNormal];
        [header.followBtn setBackgroundColor:COLOR(219, 219, 219, 1)];
        [header.followBtn setTitleColor:YJ86Color forState:UIControlStateNormal];

        header.dataDic = _houseDic;
        if (_type == 1) {
            
            header.typeL.text = @"住宅";
            
        }else if (_type == 2){
            
            header.typeL.text = @"商铺";
            
        }else if (_type == 3){
            
            header.typeL.text = @"写字楼";
        }
        
        
        if (_item == 0) {
            
            [header.infoBtn setBackgroundColor:YJBlueBtnColor];
            [header.infoBtn setTitleColor:CH_COLOR_white forState:UIControlStateNormal];
        }else if (_item == 1){
            
            [header.advantageBtn setBackgroundColor:YJBlueBtnColor];
            [header.advantageBtn setTitleColor:CH_COLOR_white forState:UIControlStateNormal];
        }else{
            
            [header.followBtn setBackgroundColor:YJBlueBtnColor];
            [header.followBtn setTitleColor:CH_COLOR_white forState:UIControlStateNormal];
        }
        
        header.maintainTagHeaderBlock = ^(NSInteger index) {
          
            _item = index;
            [tableView reloadData];
        };
        
        header.maintainDetailHeaderBlock = ^{
            
            MaintainRoomInfoVC *nextVC = [[MaintainRoomInfoVC alloc] initWithDataDic:_moreDic];
            nextVC.progressArr = [[NSMutableArray alloc] initWithArray:_detailDic[@"progress"]];
            nextVC.type = _type;
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
            header.lineView.backgroundColor = CH_COLOR_white;
            
            if (self.edit) {
                
                header.moreBtn.hidden = NO;
            }else{
                
                header.moreBtn.hidden = YES;
            }
            
            [header.moreBtn setImage:[UIImage imageNamed:@"edit"] forState:UIControlStateNormal];
            [header.moreBtn setTitle:@"" forState:UIControlStateNormal];
            [header.moreBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(header.contentView).offset(327 *SIZE);
                make.top.equalTo(header.contentView).offset(8 *SIZE);
                make.width.mas_equalTo(26 *SIZE);
                make.height.mas_equalTo(26 *SIZE);
            }];

            header.blueTitleMoreHeaderBlock = ^{
                
                if (section == 1) {
                    
                    ModifyProjectImageVC *nextVC = [[ModifyProjectImageVC alloc] initWithImgArr:_detailDic[@"img_list"]];
                    nextVC.modifyProjectImageVCBlock = ^{
                      
                        [self RequestMethod];
                    };
                    nextVC.houseId = _houseId;
                    [self.navigationController pushViewController:nextVC animated:YES];
                }
              
                if (section == 2) {
                    
                    ModifyTagVC *nextVC = [[ModifyTagVC alloc] initWithArray:_detailDic[@"house_tags"]];
                    nextVC.houseId = _houseId;
                    nextVC.typeId = [NSString stringWithFormat:@"%ld",_type];
                    nextVC.modifyTagSaveBtnBlock = ^(NSArray *array) {
                        
                        [self RequestMethod];
                    };
                    [self.navigationController pushViewController:nextVC animated:YES];
                };
                if (section == 3) {
                    
                    if (_type == 1) {
                        
                        ModifyProjectAnalysisVC *nextVC = [[ModifyProjectAnalysisVC alloc] initWithData:_detailDic];
                        nextVC.typeId = [NSString stringWithFormat:@"%ld",_type];
                        nextVC.modifyProjectAnalysisVCBlock = ^{
                            
                            [self RequestMethod];
                        };
                        nextVC.houseId = _houseId;
                        [self.navigationController pushViewController:nextVC animated:YES];
                    }else{
                        
                        AddEquipmentVC *nextVC = [[AddEquipmentVC alloc] initWithType:_type];
                        nextVC.titleStr = @"修改";
                        nextVC.type = [NSString stringWithFormat:@"%ld",_type];
                        nextVC.houseId = _houseId;
                        nextVC.data = [NSMutableArray arrayWithArray:_matchArr];
                        nextVC.addEquipmentVCBlock = ^(NSArray * _Nonnull data) {
                            
                            _matchArr = [NSMutableArray arrayWithArray:data];
                            [tableView reloadData];
                        };
                        [self.navigationController pushViewController:nextVC animated:YES];
                    }
                }
                if (section == 4) {
                    
                    ModifyNerborVC *nextVC = [[ModifyNerborVC alloc] initWithData:_detailDic];
                    nextVC.houseId = _houseId;
                    nextVC.type = [NSString stringWithFormat:@"%ld",_type];
                    nextVC.seeWay = _houseDic[@"check_way"];
                    nextVC.modifyNerborVCBlock = ^{
                        
                        [self RequestMethod];
                    };
                    [self.navigationController pushViewController:nextVC animated:YES];
                }
                if (section == 5) {
                    
                    ModifyProjectAnalysisVC *nextVC = [[ModifyProjectAnalysisVC alloc] initWithData:_detailDic];
                    nextVC.modifyProjectAnalysisVCBlock = ^{
                        
                        [self RequestMethod];
                    };
                    nextVC.typeId = [NSString stringWithFormat:@"%ld",_type];
                    nextVC.houseId = _houseId;
                    [self.navigationController pushViewController:nextVC animated:YES];
                }
            };
            return header;
        }else{
            
            if (section == 1) {
                
                if (!self.edit) {
                    
                    return nil;
                }
                
                MaintainAddFollowHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"MaintainAddFollowHeader"];
                if (!header) {
                    
                    header = [[MaintainAddFollowHeader alloc] initWithReuseIdentifier:@"MaintainAddFollowHeader"];
                }
                
                header.maintainAddFollowHeaderBlock = ^{
                  
                    MaintainAddFollowVC *nextVC = [[MaintainAddFollowVC alloc] initWithHouseId:_houseId dataDic:_houseDic];
                    nextVC.maintainAddFollowVCBlock = ^{
                        
                        if (self.maintainDetailVCBlock) {
                            
                            self.maintainDetailVCBlock();
                        }
                        [self RequestMethod];
                    };
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
                    case 2:
                    {
                        header.titleL.text = @"出价情况";
                        header.moreBtn.hidden = YES;
                        header.addBtn.hidden = YES;
                        break;
                    }
                    
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
            
            return CGFLOAT_MIN;
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
        
        if (self.edit) {
            
            return _peopleArr.count + 1;
        }else{
            
            return _peopleArr.count;
        }
        
    }else if (_item == 1){
     
        if (section == 0) {
            
            return 0;
        }else if (section == 5 || section == 3){
            
            if (_type == 1) {
                
                return 2;
            }else{
                
                if (section == 3) {
                    
                    return 1;
                }else{
                    
                    return 2;
                }
            }
        }else{
        
            return 1;
        }
    }else{
        
        if (section == 0) {
            
            return 0;
        }else{
            
            return _followArr.count;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_item == 0) {
        
        if (indexPath.row == _peopleArr.count) {
            
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
            
            if (indexPath.row == _peopleArr.count - 1) {
                
                cell.downBtn.hidden = YES;
            }else{
                
                cell.downBtn.hidden = NO;
            }
            
            cell.tag = indexPath.row;
            
            cell.dataDic = _peopleArr[indexPath.row];
            
            [cell.nameL mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(cell.contentView).offset(28 *SIZE);
                make.top.equalTo(cell.contentView).offset(21 *SIZE);
                make.width.mas_equalTo(cell.nameL.mj_textWith + 10 *SIZE);
            }];
            
            if (self.edit) {
                
                cell.downBtn.hidden = NO;
                cell.upBtn.hidden = NO;
            }else{
                
                cell.downBtn.hidden = YES;
                cell.upBtn.hidden = YES;
            }
            cell.maintainCellBlock = ^(NSInteger index, NSInteger btn) {
                if (btn == 0) {
                    
                    MaintainCustomVC *nextVC = [[MaintainCustomVC alloc] initWithDataDic:_peopleArr[index]];
                    nextVC.edit = self.edit;
                    nextVC.maintainCustomVCBlock = ^{
                      
                        [self RequestMethod];
                    };
                    [self.navigationController pushViewController:nextVC animated:YES];
                }else if (btn == 1){
                    
                    if (index == 0) {
                        
                        
                    }else{
                        
                        [BaseRequest GET:HouseSurveyContactChangeSort_URL parameters:@{@"contact_id":_peopleArr[index][@"contact_id"],@"another_contact_id":_peopleArr[index - 1][@"contact_id"]} success:^(id resposeObject) {
                            
                            NSLog(@"%@",resposeObject);
                            if ([resposeObject[@"code"] integerValue] == 200) {
                                
                                [_peopleArr exchangeObjectAtIndex:index withObjectAtIndex:(index - 1)];
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
                    
                    if (index == _peopleArr.count - 1) {
                        
                        
                    }else{
                        
                        [BaseRequest GET:HouseSurveyContactChangeSort_URL parameters:@{@"contact_id":_peopleArr[index][@"contact_id"],@"another_contact_id":_peopleArr[index + 1][@"contact_id"]} success:^(id resposeObject) {
                            
                            NSLog(@"%@",resposeObject);
                            if ([resposeObject[@"code"] integerValue] == 200) {
                                
                                [_peopleArr exchangeObjectAtIndex:index withObjectAtIndex:(index + 1)];
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
        }
    }else if (_item == 1){
        
        if (_type == 1) {
            
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
                
                if (indexPath.row == 0) {
                    
                    cell.titleL.text = @"核心卖点:";
                    if (_detailDic[@"core_selling"]) {
                        
                        cell.contentL.text = _detailDic[@"core_selling"];
                    }else{
                        
                        cell.contentL.text = @"暂无数据";
                    }
                    
                }else{
                    
                    cell.titleL.text = @"装修描述:";
                    if (_detailDic[@"decoration_standard"]) {
                        
                        cell.contentL.text = _detailDic[@"decoration_standard"];
                    }else{
                        
                        cell.contentL.text = @"暂无数据";
                    }
                }
                
                return cell;
            }else{
                
                if (indexPath.section == 1) {
                    
                    MaintainRoomInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MaintainRoomInfoCell"];
                    if (!cell) {
                        
                        cell = [[MaintainRoomInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MaintainRoomInfoCell"];
                    }
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
                    if (_detailDic.count) {
                        
                        cell.dataArr = _detailDic[@"img_list"];
                    }else{
                        
                        cell.dataArr = [@[] mutableCopy];
                    }
                    
                    [cell.imgColl reloadData];
                    return cell;
                }else{
                    
                    MaintainRoomInfoCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"MaintainRoomInfoCell2"];
                    if (!cell) {
                        
                        cell = [[MaintainRoomInfoCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MaintainRoomInfoCell2"];
                    }
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
                    if (_detailDic.count) {
                        
                        [cell.tagView setData:_tagArr];
                    }else{
                        
                        [cell.tagView setData:@[]];
                    }
                    
                    return cell;
                }
            }
        }else{
            
            if (indexPath.section > 4) {
                
                MaintainRoomInfoCell3 *cell = [tableView dequeueReusableCellWithIdentifier:@"MaintainRoomInfoCell3"];
                if (!cell) {
                    
                    cell = [[MaintainRoomInfoCell3 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MaintainRoomInfoCell3"];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                if (indexPath.section == 6) {
                    
                    cell.contentL.textColor = YJBlueBtnColor;
                }else{
                    
                    cell.contentL.textColor = YJContentLabColor;
                    if (indexPath.row == 0) {
                        
                        cell.titleL.text = @"核心卖点:";
                        if (_type == 1) {
                            
                            if (_detailDic[@"core_selling"]) {
                                
                                cell.contentL.text = _detailDic[@"core_selling"];
                            }else{
                                
                                cell.contentL.text = @"暂无数据";
                            }
                        }else{
                            
                            if (_detailDic[@"advantage"]) {
                                
                                cell.contentL.text = _detailDic[@"advantage"];
                            }else{
                                
                                cell.contentL.text = @"暂无数据";
                            }
                        }
                    }else{
                        
                        cell.titleL.text = @"装修描述:";
                        if (_type == 1) {
                            
                            if (_detailDic[@"decoration_standard"]) {
                                
                                cell.contentL.text = _detailDic[@"decoration_standard"];
                            }else{
                                
                                cell.contentL.text = @"暂无数据";
                            }
                        }else{
                            
                            if (_detailDic[@"describe"]) {
                                
                                cell.contentL.text = _detailDic[@"describe"];
                            }else{
                                
                                cell.contentL.text = @"暂无数据";
                            }
                        }
                    }
                }
                
                return cell;
            }else{
                
                if (indexPath.section == 1) {
                    
                    MaintainRoomInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MaintainRoomInfoCell"];
                    if (!cell) {
                        
                        cell = [[MaintainRoomInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MaintainRoomInfoCell"];
                    }
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
                    if (_detailDic.count) {
                        
                        cell.dataArr = _detailDic[@"img_list"];
                    }else{
                        
                        cell.dataArr = [@[] mutableCopy];
                    }
                    
                    [cell.imgColl reloadData];
                    
                    return cell;
                }else{
                    
                    if (indexPath.section == 2) {
                        
                        MaintainRoomInfoCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"MaintainRoomInfoCell2"];
                        if (!cell) {
                            
                            cell = [[MaintainRoomInfoCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MaintainRoomInfoCell2"];
                        }
                        cell.selectionStyle = UITableViewCellSelectionStyleNone;
                        
                        if (_detailDic.count) {
                            
                            
                            [cell.tagView setData:_tagArr];
                        }else{
                            
                            [cell.tagView setData:@[]];
                        }
                        
                        
                        return cell;
                    }else if (indexPath.section == 3){
                        
                        MaintainRoomInfoEquipMentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MaintainRoomInfoEquipMentCell"];
                        if (!cell) {
                            
                            cell = [[MaintainRoomInfoEquipMentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MaintainRoomInfoEquipMentCell"];
                        }
                        cell.selectionStyle = UITableViewCellSelectionStyleNone;
                        
                        cell.dataArr = [NSMutableArray arrayWithArray:_matchArr];
                        
                        return cell;
                        
                    }else{
                        
                        MaintainRoomInfoNeiborCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MaintainRoomInfoNeiborCell"];
                        if (!cell) {
                            
                            cell = [[MaintainRoomInfoNeiborCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MaintainRoomInfoNeiborCell"];
                        }
                        cell.selectionStyle = UITableViewCellSelectionStyleNone;
                        
                        cell.type = _type;
                        cell.seeWayL.text = [NSString stringWithFormat:@"看房方式：%@",_houseDic[@"check_way"]];
                        cell.dataDic = [NSMutableDictionary dictionaryWithDictionary:_detailDic];
                        
                        return cell;
                    }
                }
            }
        }
    }else{
        
        if (indexPath.section == 1) {
            
            NSString * Identifier = @"CustomDetailTableCell2";
            CustomDetailTableCell2 *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
            if (!cell) {
                
                cell = [[CustomDetailTableCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.wayL.text = [NSString stringWithFormat:@"跟进方式：%@",_followArr[indexPath.row][@"follow_type"]];
            cell.contentL.text = _followArr[indexPath.row][@"comment"];
            cell.timeL.text = _followArr[indexPath.row][@"follow_time"];
            
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
        
        if (indexPath.row == _peopleArr.count) {
            
            MaintainModifyCustomVC *nextVC = [[MaintainModifyCustomVC alloc] init];
            nextVC.houseId = _houseId;
            nextVC.status = @"添加";
            nextVC.maintainModifyCustomVCBlock = ^(NSDictionary *dic) {
                
                if (self.maintainDetailVCBlock) {
                    
                    self.maintainDetailVCBlock();
                }
                [self RequestMethod];
            };
            [self.navigationController pushViewController:nextVC animated:YES];
        }
    }
    if (_item == 2) {
        
        MaintainFollowDetailVC *nextVC = [[MaintainFollowDetailVC alloc] initWithDataDic:_followArr[indexPath.row]];
        [self.navigationController pushViewController:nextVC animated:YES];
        
    }
}

- (void)initUI{
    
    self.titleLabel.text = @"房源详情";
    self.navBackgroundView.hidden = NO;
    
    if (self.edit) {
        
        self.rightBtn.hidden = NO;
    }
    [self.rightBtn setTitleColor:YJ86Color forState:UIControlStateNormal];
    self.rightBtn.titleLabel.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.rightBtn addTarget:self action:@selector(ActionRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightBtn setImage:[UIImage imageNamed:@"add_1"] forState:UIControlStateNormal];
//    [self.rightBtn setTitle:@"下架" forState:UIControlStateNormal];
    
    _mainTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStyleGrouped];
    _mainTable.rowHeight = UITableViewAutomaticDimension;
    _mainTable.estimatedRowHeight = 260 *SIZE;
    _mainTable.estimatedSectionHeaderHeight = 476 *SIZE;
    _mainTable.backgroundColor = self.view.backgroundColor;
    _mainTable.delegate = self;
    _mainTable.dataSource = self;
    _mainTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_mainTable];
}

@end
