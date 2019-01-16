//
//  RentingAllRoomProjectVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/7/23.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <BaiduMapAPI_Search/BMKPoiSearch.h>
#import <BaiduMapAPI_Map/BMKMapView.h>
#import <BaiduMapAPI_Map/BMKPointAnnotation.h>
#import <BaiduMapAPI_Map/BMKPinAnnotationView.h>
#import "YBImageBrowserModel.h"
#import "YBImageBrowser.h"

#import "RentingAllRoomProjectVC.h"
#import "RentingComRoomDetailVC.h"
#import "RentingAllRoomDetailVC.h"

#import "RentingAllRoomDetailTableHeader.h"
#import "SecAllRoomDetailTableHeader2.h"
#import "SecAllRoomStoreEquipCell.h"
#import "RentingAllRoomTableCell.h"
#import "SecAllRoomTableCell3.h"
#import "RoomDetailTableCell4.h"
#import "SecAllRoomTableOtherHouseCell.h"

@interface RentingAllRoomProjectVC ()<UITableViewDelegate,UITableViewDataSource,YBImageBrowserDelegate,BMKPoiSearchDelegate,BMKMapViewDelegate,RoomDetailTableCell4Delegate,UIGestureRecognizerDelegate>
{
    CLLocationCoordinate2D _leftBottomPoint;
    CLLocationCoordinate2D _rightBottomPoint;//地图矩形的顶点
    NSString *_name;
    NSString *_houseId;
    RentingAllRoomProjectModel *_model;
    NSMutableArray *_imgArr;
    NSMutableDictionary *_focusDic;
    NSMutableArray *_houseArr;
    NSString *_city;
    NSString *_focusId;
    NSString *_phone;
    
    NSInteger _numOfSec;
}
@property (nonatomic, strong) UITableView *roomTable;

@property (nonatomic, strong) UIButton *attentBtn;

@property (nonatomic, strong) UIButton *recommendBtn;

@property (nonatomic, strong) BMKMapView *mapView;

@property (nonatomic, strong) BMKPoiSearch *poisearch;

@end

@implementation RentingAllRoomProjectVC

- (instancetype)initWithHouseId:(NSString *)houseId city:(NSString *)city
{
    self = [super init];
    if (self) {
        
        _houseId = houseId;
        _city = city;
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
    
    _numOfSec = 6;
    _imgArr = [@[] mutableCopy];
    _model = [[RentingAllRoomProjectModel alloc] init];
    _focusDic = [@{} mutableCopy];
    _houseArr = [@[] mutableCopy];
}

- (void)RequestMethod{
    
    NSDictionary *dic = @{@"house_id":_houseId,
                          @"agent_id":[UserModel defaultModel].agent_id,
                          @"type":@(1)
                          };
    [BaseRequest GET:RentHouseDetail_URL parameters:dic success:^(id resposeObject) {
        
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
    
    _phone = [NSString stringWithFormat:@"%@",data[@"agent_info"]];
    
    if ([data[@"basic_info"] isKindOfClass:[NSDictionary class]]) {
        
        NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:data[@"basic_info"]];
        [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            
            if ([obj isKindOfClass:[NSNull class]]) {
                
                [tempDic setObject:@"" forKey:key];
            }else{
                
                if ([obj isKindOfClass:[NSNumber class]]) {
                    
                    [tempDic setObject:[NSString stringWithFormat:@"%@",obj] forKey:key];
                }
            }
        }];
        _model = [[RentingAllRoomProjectModel alloc] initWithDictionary:tempDic];
    }
    
    [_imgArr removeAllObjects];
    if ([data[@"img"] isKindOfClass:[NSArray class]]) {
        
        NSArray *arr = data[@"img"];
        for ( int i = 0; i < arr.count; i++) {
            
            if ([arr[i] isKindOfClass:[NSDictionary class]]) {
                
                NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:arr[i]];
                
                [_imgArr addObject:tempDic];
            }
        }
    }
    
    if ([data[@"focus"] isKindOfClass:[NSDictionary class]]) {
        
        if ([data[@"focus"][@"is_focus"] integerValue]) {
            
            _focusId = [NSString stringWithFormat:@"%@",data[@"focus"][@"is_focus"]];
            [_attentBtn setTitle:@"取消关注" forState:UIControlStateNormal];
        }
        _focusDic = [NSMutableDictionary dictionaryWithDictionary:data[@"focus"]];
    }
    _attentBtn.userInteractionEnabled = YES;
    
    if ([data[@"other"] isKindOfClass:[NSArray class]]) {
        
        _houseArr = [NSMutableArray arrayWithArray:data[@"other"]];
    }
    
    [_roomTable reloadData];
}


- (void)ActionRecommendBtn:(UIButton *)btn{
    
    if (_phone.length) {
        
        //获取目标号码字符串,转换成URL
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",_phone]];
        //调用系统方法拨号
        [[UIApplication sharedApplication] openURL:url];
    }else{
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"暂时未获取到联系电话"];
    }
    //    CustomListVC *nextVC = [[CustomListVC alloc] initWithProjectId:_projectId];
    //    [self.navigationController pushViewController:nextVC animated:YES];
}

- (void)ActionAttentBtn:(UIButton *)btn{
    
    if (_focusId.length) {
        
        [BaseRequest GET:PersonalCancelFocusHouse_URL parameters:@{@"focus_id":_focusId} success:^(id resposeObject) {
            
            NSLog(@"%@",resposeObject);
            if ([resposeObject[@"code"] integerValue] == 200) {
                
                _focusId = @"";
                [self showContent:@"取消关注成功"];
                [self RequestMethod];
                [_attentBtn setTitle:@"关注" forState:UIControlStateNormal];
            }else{
                
                [self showContent:resposeObject[@"msg"]];
            }
        } failure:^(NSError *error) {
            
            NSLog(@"%@",error);
            [self showContent:@"网络错误"];
        }];
    }else{
        
        [BaseRequest GET:PersonalFocusHouse_URL parameters:@{@"house_id":_houseId,@"type":@"2"} success:^(id resposeObject) {
            
            NSLog(@"%@",resposeObject);
            if ([resposeObject[@"code"] integerValue] == 200) {
                
                _focusId = [NSString stringWithFormat:@"%@",resposeObject[@"data"]];
                [self showContent:@"关注成功"];
                [self RequestMethod];
                [_attentBtn setTitle:@"取消关注" forState:UIControlStateNormal];
            }else{
                
                [self showContent:resposeObject[@"msg"]];
            }
        } failure:^(NSError *error) {
            
            NSLog(@"%@",error);
            [self showContent:@"网络错误"];
        }];
    }
}

#pragma mark -- delegate

- (void)Cell4collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray * namearr = @[@"教育",@"公交站点",@"医院",@"购物",@"餐饮"];
    [self beginSearchWithname:namearr[indexPath.row]];
}

#pragma mark -- tableview

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    _numOfSec = 6;
    if (!_houseArr.count) {
        
        _numOfSec = _numOfSec - 1;
    }
    if (!_model.match_tags.count) {
        
        _numOfSec = _numOfSec - 1;
    }
    return _numOfSec;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 0;
    }
    if (section == 3) {
        
        if (_model.match_tags.count) {
            
            return 1;
        }else{
            
            return 0;
        }
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 2) {
        
        return 0;
    }
    return UITableViewAutomaticDimension;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 4;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (!section) {
        
        RentingAllRoomDetailTableHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"RentingAllRoomDetailTableHeader"];
        if (!header) {
            
            header = [[RentingAllRoomDetailTableHeader alloc] initWithReuseIdentifier:@"RentingAllRoomDetailTableHeader"];
        }
        
        header.imgArr = [NSMutableArray arrayWithArray:_imgArr];
        
        header.model = _model;
        
        if (_focusDic.count) {
            
            header.attentL.text = [NSString stringWithFormat:@"关注人数：%@人",_focusDic[@"num"]];
        }else{
            
            header.attentL.text = @"关注人数：0人";
        }
        
        header.rentingAllRoomDetailTableHeaderImgBlock = ^(NSInteger num, NSArray *imgArr) {
            
            if (imgArr.count) {
                
                NSMutableArray *tempArr = [NSMutableArray array];
                
                NSMutableArray *tempArr1 = [NSMutableArray array];
                for (NSDictionary *dic in imgArr) {
                    
                    for (NSDictionary *subDic in dic[@"list"]) {
                        
                        [tempArr1 addObject:subDic[@"img_url"]];
                    }
                }
                [tempArr1 enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    YBImageBrowserModel *model = [YBImageBrowserModel new];
                    model.url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,obj]];
                    [tempArr addObject:model];
                }];
                
                [_imgArr enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:obj];
                    [tempDic setObject:obj[@"type"] forKey:@"name"];
                    
                    [tempDic setObject:obj[@"list"] forKey:@"data"];
                    [_imgArr replaceObjectAtIndex:idx withObject:tempDic];
                    
                }];
                YBImageBrowser *browser = [YBImageBrowser new];
                browser.delegate = self;
                browser.dataArray = tempArr;
                browser.albumArr = _imgArr;
                browser.infoid = _model.info_id;
                browser.currentIndex = num;
                browser.toolBar.titleLabel.text = @"房源相册";
                [browser show];
            }
        };
        
        return header;
    }else{
        
        SecAllRoomDetailTableHeader2 *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"SecAllRoomDetailTableHeader2"];
        if (!header) {
            
            header = [[SecAllRoomDetailTableHeader2 alloc] initWithReuseIdentifier:@"SecAllRoomDetailTableHeader2"];
        }
        header.moreBtn.hidden = NO;
        header.addBtn.hidden = NO;
        
        if (_model.match_tags.count) {
            
            switch (section) {
                case 1:
                {
                    if (_model.house_code.length) {
                        
                        header.titleL.text = [NSString stringWithFormat:@"房源信息(%@)",_model.house_code];
                    }else{
                        
                        header.titleL.text = @"房源信息";
                    }
                    
                    header.moreBtn.hidden = YES;
                    header.line.hidden = YES;
                    header.addBtn.hidden = YES;
                    break;
                }
                case 2:{
                    
                    header = nil;
                    break;
                }
                case 3:
                {
                    header = nil;
                    break;
                }
                case 4:
                {
                    header.titleL.text = _model.project_name;
                    [header.moreBtn setTitle:@"小区详情 >>" forState:UIControlStateNormal];
                    header.secAllRoomDetailMoreBlock = ^{
                        
                        if (_model.project_id) {
                            
                            RentingComRoomDetailVC *nextVC = [[RentingComRoomDetailVC alloc] initWithProjectId:_model.project_id infoid:_model.info_id city:_city];
                            nextVC.type = @"0";
                            [self.navigationController pushViewController:nextVC animated:YES];
                        }else{
                            
                            [self alertControllerWithNsstring:@"温馨提示" And:@"未获取到小区信息"];
                        }
                    };
                    header.addBtn.hidden = YES;
                    break;
                }
                case 5:
                {
                    header.titleL.text = @"小区其他房源";
                    header.moreBtn.hidden = YES;
                    header.addBtn.hidden = YES;
                    header.line.hidden = YES;
                    break;
                }
                default:
                    break;
            }
        }else{
            
            switch (section) {
                case 1:
                {
                    if (_model.house_code.length) {
                        
                        header.titleL.text = [NSString stringWithFormat:@"房源信息(%@)",_model.house_code];
                    }else{
                        
                        header.titleL.text = @"房源信息";
                    }
                    
                    header.moreBtn.hidden = YES;
                    header.line.hidden = YES;
                    header.addBtn.hidden = YES;
                    break;
                }
                case 2:
                {
                    header = nil;
                    break;
                }
                case 3:
                {
                    header.titleL.text = _model.project_name;
                    [header.moreBtn setTitle:@"小区详情 >>" forState:UIControlStateNormal];
                    header.secAllRoomDetailMoreBlock = ^{
                        
                        if (_model.project_id) {
                            
                            RentingComRoomDetailVC *nextVC = [[RentingComRoomDetailVC alloc] initWithProjectId:_model.project_id infoid:_model.info_id city:_city];
                            nextVC.type = @"0";
                            [self.navigationController pushViewController:nextVC animated:YES];
                        }else{
                            
                            [self alertControllerWithNsstring:@"温馨提示" And:@"未获取到小区信息"];
                        }
                    };
                    header.addBtn.hidden = YES;
                    break;
                }
                case 4:
                {
                    header.titleL.text = @"小区其他房源";
                    header.moreBtn.hidden = YES;
                    header.addBtn.hidden = YES;
                    header.line.hidden = YES;
                    break;
                }
                default:
                    break;
            }
        }
        return header;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [[UIView alloc] init];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_model.match_tags.count) {
        
        if (indexPath.section == 1) {
            
            RentingAllRoomTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RentingAllRoomTableCell"];
            if (!cell) {
                
                cell = [[RentingAllRoomTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RentingAllRoomTableCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.model = _model;
            
            return cell;
        }else if (indexPath.section == 2) {
            
            SecAllRoomStoreEquipCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SecAllRoomStoreEquipCell"];
            if (!cell) {
                
                cell = [[SecAllRoomStoreEquipCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SecAllRoomStoreEquipCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.dataArr = _model.match_tags;
            [cell.coll reloadData];
            return cell;
        }else if (indexPath.section == 3) {
            
            RoomDetailTableCell4 *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomDetailTableCell4"];
            if (!cell) {
                
                cell = [[RoomDetailTableCell4 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomDetailTableCell4"];
                cell.delegate = self;
                [cell.contentView addSubview:self.mapView];
                UIGestureRecognizer *gestur = [[UIGestureRecognizer alloc]init];
                gestur.delegate=self;
                [_roomTable addGestureRecognizer:gestur];
                
                UIGestureRecognizer *gestur1 = [[UIGestureRecognizer alloc]init];
                gestur1.delegate=self;
                [_mapView addGestureRecognizer:gestur1];
                
                
                [_mapView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(cell.contentView).offset(0);
                    make.top.equalTo(cell.contentView).offset(33 *SIZE);
                    make.right.equalTo(cell.contentView).offset(0);
                    make.width.equalTo(@(360 *SIZE));
                    make.height.equalTo(@(187 *SIZE));
                    make.bottom.equalTo(cell.contentView).offset(-59 *SIZE);
                }];
            }
            CLLocationCoordinate2D cllocation = CLLocationCoordinate2DMake([_model.latitude floatValue] , [_model.longitude floatValue]);
            [_mapView setCenterCoordinate:cllocation animated:YES];
            BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
            annotation.coordinate = cllocation;
            annotation.title = _model.project_name;
            [_mapView addAnnotation:annotation];
            //                    cell.delegate = self;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
            
        }else if (indexPath.section == 4){
            
            SecAllRoomTableCell3 *cell = [tableView dequeueReusableCellWithIdentifier:@"SecAllRoomTableCell3"];
            if (!cell) {
                
                cell = [[SecAllRoomTableCell3 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SecAllRoomTableCell3"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.model = _model;
            
            return cell;
        }else{
            
            SecAllRoomTableOtherHouseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SecAllRoomTableOtherHouseCell"];
            if (!cell) {
                
                cell = [[SecAllRoomTableOtherHouseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SecAllRoomTableOtherHouseCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            //        if (_houseArr.count) {
            //
            //            cell.num = _houseArr.count;
            //        }else{
            //
            //            cell.num = 1;
            //        }
            cell.num = _houseArr.count;
            
            if (_houseArr.count) {
                
                cell.dataArr = [NSMutableArray arrayWithArray:_houseArr];
                [cell.cellColl reloadData];
            }else{
                
                [cell.cellColl reloadData];
            }
            
            cell.secAllRoomTableOtherHouseCellCollBlock = ^(NSInteger index) {
                
                if (_houseArr.count) {
                    
                    RentingAllRoomDetailVC *nextVC = [[RentingAllRoomDetailVC alloc] initWithHouseId:_houseArr[index][@"house_id"] city:_city];
                    nextVC.type = [_houseArr[index][@"type"] integerValue];
                    [self.navigationController pushViewController:nextVC animated:YES];
                }
            };
            
            return cell;
            
        }
    }else{
        
        if (indexPath.section == 1) {
            
            RentingAllRoomTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RentingAllRoomTableCell"];
            if (!cell) {
                
                cell = [[RentingAllRoomTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RentingAllRoomTableCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.model = _model;
            
            return cell;
        }else if (indexPath.section == 2) {
            
            RoomDetailTableCell4 *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomDetailTableCell4"];
            if (!cell) {
                
                cell = [[RoomDetailTableCell4 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomDetailTableCell4"];
                cell.delegate = self;
                [cell.contentView addSubview:self.mapView];
                UIGestureRecognizer *gestur = [[UIGestureRecognizer alloc]init];
                gestur.delegate=self;
                [_roomTable addGestureRecognizer:gestur];
                
                UIGestureRecognizer *gestur1 = [[UIGestureRecognizer alloc]init];
                gestur1.delegate=self;
                [_mapView addGestureRecognizer:gestur1];
                
                
                [_mapView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(cell.contentView).offset(0);
                    make.top.equalTo(cell.contentView).offset(33 *SIZE);
                    make.right.equalTo(cell.contentView).offset(0);
                    make.width.equalTo(@(360 *SIZE));
                    make.height.equalTo(@(187 *SIZE));
                    make.bottom.equalTo(cell.contentView).offset(-59 *SIZE);
                }];
            }
            CLLocationCoordinate2D cllocation = CLLocationCoordinate2DMake([_model.latitude floatValue] , [_model.longitude floatValue]);
            [_mapView setCenterCoordinate:cllocation animated:YES];
            BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
            annotation.coordinate = cllocation;
            annotation.title = _model.project_name;
            [_mapView addAnnotation:annotation];
            //                    cell.delegate = self;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
            
        }else if (indexPath.section == 3){
            
            SecAllRoomTableCell3 *cell = [tableView dequeueReusableCellWithIdentifier:@"SecAllRoomTableCell3"];
            if (!cell) {
                
                cell = [[SecAllRoomTableCell3 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SecAllRoomTableCell3"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.model = _model;
            
            return cell;
        }else{
            
            SecAllRoomTableOtherHouseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SecAllRoomTableOtherHouseCell"];
            if (!cell) {
                
                cell = [[SecAllRoomTableOtherHouseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SecAllRoomTableOtherHouseCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.num = _houseArr.count;
            
            if (_houseArr.count) {
                
                cell.dataArr = [NSMutableArray arrayWithArray:_houseArr];
                [cell.cellColl reloadData];
            }else{
                
                [cell.cellColl reloadData];
            }
            
            cell.secAllRoomTableOtherHouseCellCollBlock = ^(NSInteger index) {
                
                if (_houseArr.count) {
                    
                    RentingAllRoomDetailVC *nextVC = [[RentingAllRoomDetailVC alloc] initWithHouseId:_houseArr[index][@"house_id"] city:_city];
                    nextVC.type = [_houseArr[index][@"type"] integerValue];
                    [self.navigationController pushViewController:nextVC animated:YES];
                }
            };
            
            return cell;
            
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_model.match_tags.count) {
        
        if (indexPath.section == 4) {
            
            if (_model.project_id.length) {
                
                RentingComRoomDetailVC *nextVC = [[RentingComRoomDetailVC alloc] initWithProjectId:_model.project_id infoid:_model.info_id city:_city];
                nextVC.type = @"0";
                [self.navigationController pushViewController:nextVC animated:YES];
            }else{
                
                [self alertControllerWithNsstring:@"温馨提示" And:@"未获取到小区信息"];
            }
        }
    }else{
        
        if (indexPath.section == 3) {
            
            if (_model.project_id.length) {
                
                RentingComRoomDetailVC *nextVC = [[RentingComRoomDetailVC alloc] initWithProjectId:_model.project_id infoid:_model.info_id city:_city];
                nextVC.type = @"0";
                [self.navigationController pushViewController:nextVC animated:YES];
            }else{
                
                [self alertControllerWithNsstring:@"温馨提示" And:@"未获取到小区信息"];
            }
        }
    }
}

- (void)initUI{
    
    
    _roomTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, self.view.frame.size.height - NAVIGATION_BAR_HEIGHT - 47 *SIZE - TAB_BAR_MORE) style:UITableViewStyleGrouped];
    
    _roomTable.rowHeight = UITableViewAutomaticDimension;
    _roomTable.estimatedRowHeight = 200 *SIZE;
    
    _roomTable.estimatedSectionHeaderHeight = 316 *SIZE;
    
    _roomTable.backgroundColor = self.view.backgroundColor;
    _roomTable.delegate = self;
    _roomTable.dataSource = self;
    _roomTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_roomTable];
    
    _attentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _attentBtn.frame = CGRectMake(0, self.view.frame.size.height - NAVIGATION_BAR_HEIGHT - 47 *SIZE - TAB_BAR_MORE, 100 *SIZE, 47 *SIZE + TAB_BAR_MORE);
    _attentBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_attentBtn addTarget:self action:@selector(ActionAttentBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_attentBtn setTitle:@"关注" forState:UIControlStateNormal];
    [_attentBtn setBackgroundColor:COLOR(74, 211, 195, 1)];
    [_attentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:_attentBtn];
    
    _recommendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _recommendBtn.frame = CGRectMake(100 *SIZE, self.view.frame.size.height - NAVIGATION_BAR_HEIGHT - 47 *SIZE - TAB_BAR_MORE, 260 *SIZE, 47 *SIZE + TAB_BAR_MORE);
    _recommendBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_recommendBtn addTarget:self action:@selector(ActionRecommendBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_recommendBtn setTitle:@"电话咨询" forState:UIControlStateNormal];
    [_recommendBtn setBackgroundColor:YJBlueBtnColor];
    [self.view addSubview:_recommendBtn];
    
}

- (BMKMapView *)mapView{
    
    if (!_mapView) {
        
        _mapView = [[BMKMapView alloc] init];
        _mapView.delegate = self;
        _mapView.zoomLevel = 15;
        _mapView.isSelectedAnnotationViewFront = YES;
    }
    return _mapView;
}

- (void)mapViewDidFinishLoading:(BMKMapView *)mapView
{
    _leftBottomPoint = [_mapView convertPoint:CGPointMake(0,_mapView.frame.size.height) toCoordinateFromView:mapView];  // //西南角（左下角） 屏幕坐标转地理经纬度
    _rightBottomPoint = [_mapView convertPoint:CGPointMake(_mapView.frame.size.width,0) toCoordinateFromView:mapView];  //东北角（右上角）同上
    //开始搜索
}

- (void)beginSearchWithname:(NSString *)name{
    
    _name = name;
    _poisearch = [self poisearch];
    BMKBoundSearchOption *boundSearchOption = [[BMKBoundSearchOption alloc]init];
    boundSearchOption.pageIndex = 0;
    boundSearchOption.pageCapacity = 20;
    boundSearchOption.keyword = name;
    boundSearchOption.leftBottom =_leftBottomPoint;
    boundSearchOption.rightTop =_rightBottomPoint;
    
    BOOL flag = [_poisearch poiSearchInbounds:boundSearchOption];
    if(flag)
    {
        NSLog(@"范围内检索发送成功");
    }
    else
    {
        NSLog(@"范围内检索发送失败");
    }
    
}

#pragma mark implement BMKSearchDelegate
- (void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPoiResult*)result errorCode:(BMKSearchErrorCode)error
{
    if (error == BMK_SEARCH_NO_ERROR) {
        NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
        [_mapView removeAnnotations:array];
        array = [NSArray arrayWithArray:_mapView.overlays];
        [_mapView removeOverlays:array];
        //在此处理正常结果
        for (int i = 0; i < result.poiInfoList.count; i++)
        {
            BMKPoiInfo* poi = [result.poiInfoList objectAtIndex:i];
            [self addAnimatedAnnotationWithName:poi.name withAddress:poi.pt];
        }
        
        CLLocationCoordinate2D cllocation = CLLocationCoordinate2DMake([_model.latitude floatValue] , [_model.longitude floatValue]);
        [_mapView setCenterCoordinate:cllocation animated:YES];
        BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
        annotation.coordinate = cllocation;
        annotation.title = _model.project_name;
        [_mapView addAnnotation:annotation];
        
    } else if (error == BMK_SEARCH_AMBIGUOUS_ROURE_ADDR){
        NSLog(@"起始点有歧义");
    } else {
        // 各种情况的判断。。。
    }
}
// 添加动画Annotation
- (void)addAnimatedAnnotationWithName:(NSString *)name withAddress:(CLLocationCoordinate2D)coor {
    BMKPointAnnotation*animatedAnnotation = [[BMKPointAnnotation alloc]init];
    animatedAnnotation.coordinate = coor;
    animatedAnnotation.title = name;
    [_mapView addAnnotation:animatedAnnotation];
}
-(BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor = BMKPinAnnotationColorRed;
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        if ([annotation.title isEqualToString:_model.project_name]) {
            newAnnotationView.image = [UIImage imageNamed:@"coordinates"];
        }
        else
        {
            NSArray *arr= @[@"教育",@"公交站点",@"医院",@"购物",@"餐饮"];
            if ([_name isEqualToString:arr[0]]) {
                newAnnotationView.image = [UIImage imageNamed:@"education"];
            }
            else if ([_name isEqualToString:arr[1]]) {
                newAnnotationView.image = [UIImage imageNamed:@"traffic"];
            }
            else if ([_name isEqualToString:arr[2]]) {
                newAnnotationView.image = [UIImage imageNamed:@"hospital"];
            }
            else if ([_name isEqualToString:arr[3]]) {
                newAnnotationView.image = [UIImage imageNamed:@"shopping"];
            }
            else
            {
                newAnnotationView.image = [UIImage imageNamed:@"caterin"];
            }
            
        }
        
        return newAnnotationView;
    }
    return nil;
    
}



- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    
    _leftBottomPoint = [_mapView convertPoint:CGPointMake(0,_mapView.frame.size.height) toCoordinateFromView:mapView];  // //西南角（左下角） 屏幕坐标转地理经纬度
    _rightBottomPoint = [_mapView convertPoint:CGPointMake(_mapView.frame.size.width,0) toCoordinateFromView:mapView];  //东北角（右上角）同上
}

-(BMKPoiSearch *)poisearch
{
    if (!_poisearch) {
        _poisearch =[[BMKPoiSearch alloc]init];
        _poisearch.delegate = self;
    }
    return _poisearch;
}

@end
