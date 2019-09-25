//
//  RentingComRoomProjectVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/7/23.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <BaiduMapAPI_Search/BMKPoiSearch.h>
#import <BaiduMapAPI_Map/BMKMapView.h>
#import <BaiduMapAPI_Map/BMKPointAnnotation.h>
#import <BaiduMapAPI_Map/BMKPinAnnotationView.h>

#import "YBImageBrowser.h"

#import "RentingComRoomProjectVC.h"
#import "BuildingInfoVC.h"
//#import "SecHouseTypeDetailVC.h"

#import "DynamicListVC.h"
#import "CustomMatchListVC.h"
#import "BuildingAlbumVC.h"
#import "DynamicDetailVC.h"
#import "CustomListVC.h"
#import "SecDistributVC.h"
#import "OverviewVC.h"
#import "DealRecordVC.h"
#import "DistributVC.h"
#import "RentingComAllRoomListVC.h"
#import "RentingComTypeRoomListVC.h"

#import "RentingComRoomDetailTableHeader.h"
#import "RoomDetailTableHeader5.h"
#import "RoomDetailTableCell1.h"
#import "RoomDetailTableCell2.h"
#import "RoomDetailTableCell3.h"
#import "RoomDetailTableCell4.h"
#import "RoomDetailTableCell5.h"

//#import "ContentTimeBtnBaseView.h"

@interface RentingComRoomProjectVC ()<UITableViewDelegate,UITableViewDataSource,BMKMapViewDelegate,RoomDetailTableCell4Delegate,BMKPoiSearchDelegate,UIGestureRecognizerDelegate>
{
    CLLocationCoordinate2D _leftBottomPoint;
    CLLocationCoordinate2D _rightBottomPoint;//地图矩形的顶点
    NSMutableDictionary *_dynamicDic;
    NSString *_projectId;
    NSMutableDictionary *_focusDic;
    NSString *_dynamicNum;
    NSMutableArray *_imgArr;
    NSMutableArray *_albumArr;
    //    NSString *_focusId;
    NSMutableArray *_houseArr;
    NSMutableArray *_peopleArr;
    //    NSMutableDictionary *_buildDic;
    NSString *_phone;
    //    NSString *_phone_url;
    NSString *_name;
    SecAllRoomDetailHeaderModel *_model;
    NSString *_city;
    NSString *_subId;
    NSString *_info_id;
}

@property (nonatomic, strong) UITableView *roomTable;

@property (nonatomic, strong) UIButton *recommendBtn;

@property (nonatomic, strong) UIView *parting;

@property (nonatomic, strong) UIButton *attentBtn;

@property (nonatomic, strong) UIButton *counselBtn;

@property (nonatomic, strong) BMKMapView *mapView;

@property (nonatomic, strong) BMKPoiSearch *poisearch;

@end

@implementation RentingComRoomProjectVC

- (instancetype)initWithProjectId:(NSString *)projectId infoid:(NSString *)infoid city:(NSString *)city
{
    self = [super init];
    if (self) {
        _info_id = infoid;
        _projectId = projectId;
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

- (void)MapViewDismissNoti:(NSNotification *)noti{
    
    self.mapView.delegate = nil;
    [self.mapView removeFromSuperview];
}


- (void)initDataSource{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(MapViewDismissNoti:) name:@"mapViewDismiss" object:nil];
    
    
    _dynamicNum = @"";
    _imgArr = [@[] mutableCopy];
    _focusDic = [@{} mutableCopy];
    _dynamicDic = [@{} mutableCopy];
    _houseArr = [@[] mutableCopy];
    _peopleArr = [@[] mutableCopy];
//    _buildDic = [@{} mutableCopy];
    
}

//- (void)MatchRequest{
//
//    [BaseRequest GET:ProjectMatching_URL parameters:@{@"project_id":_projectId} success:^(id resposeObject) {
//
//        //        NSLog(@"%@",resposeObject);
//        if ([resposeObject[@"code"] integerValue] == 200) {
//
//            [self SetMatchPeople:resposeObject[@"data"]];
//        }
//    } failure:^(NSError *error) {
//
//        //        NSLog(@"%@",error);
//        [self showContent:@"网络错误"];
//    }];
//}

//- (void)SetMatchPeople:(NSArray *)data{
//
//    for (int i = 0 ; i < data.count; i++) {
//
//        NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:data[i]];
//
//        [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
//
//            if ([obj isKindOfClass:[NSNull class]]) {
//
//                [tempDic setObject:@"" forKey:key];
//            }
//        }];
//
//        CustomMatchModel *model = [[CustomMatchModel alloc] initWithDictionary:tempDic];
//        [_peopleArr addObject:model];
//    }
//    [_roomTable reloadData];
//}
//
- (void)RequestMethod{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:_projectId forKey:@"project_id"];
    [dic setObject:self.type forKey:@"type"];
    [dic setObject:[UserModelArchiver unarchive].agent_id forKey:@"agent_id"];
    [BaseRequest GET:RentProjectDetail_URL parameters:dic success:^(id resposeObject) {
        //        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {

            if ([resposeObject[@"data"] isKindOfClass:[NSDictionary class]]) {

                [self SetData:resposeObject[@"data"]];

            }else{

                [self showContent:@"暂时没有数据"];
            }
        }
    } failure:^(NSError *error) {

        //        NSLog(@"%@",error);
        [self showContent:@"网络错误"];
    }];
}
//
- (void)SetData:(NSDictionary *)data{
    
    if (data[@"butter_tel"]) {
        
        _phone = [NSString stringWithFormat:@"%@",data[@"butter_tel"]];
    }
    
    //    if ([data[@"build_info"] isKindOfClass:[NSDictionary class]]) {
    //
    //        _buildDic = [NSMutableDictionary dictionaryWithDictionary:data[@"build_info"]];
    //    }
    
    if ([data[@"dynamic"] isKindOfClass:[NSDictionary class]]) {
        
        if (![data[@"dynamic"][@"count"] isKindOfClass:[NSNull class]]) {
            
            _dynamicNum = data[@"dynamic"][@"count"];
        }
        
        if ([data[@"dynamic"][@"first"] isKindOfClass:[NSDictionary class]]) {
            
            _dynamicDic = [[NSMutableDictionary alloc] initWithDictionary:data[@"dynamic"][@"first"]];
            [_dynamicDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                
                if ([obj isKindOfClass:[NSNull class]]) {
                    
                    [_dynamicDic setObject:@"" forKey:key];
                }
            }];
        }
    }
    
    if ([data[@"focus"] isKindOfClass:[NSDictionary class]]) {
        
        if ([data[@"focus"][@"is_focus"] integerValue]) {
            
            _subId = [NSString stringWithFormat:@"%@",data[@"focus"][@"is_focus"]];
            [_attentBtn setTitle:@"取消订阅" forState:UIControlStateNormal];
        }
        _focusDic = [NSMutableDictionary dictionaryWithDictionary:data[@"focus"]];
    }
    _attentBtn.userInteractionEnabled = YES;
    
    if ([data[@"house_type"] isKindOfClass:[NSArray class]]) {
        
        _houseArr = [NSMutableArray arrayWithArray:data[@"house_type"]];
    }
    
    if ([data[@"project_basic_info"] isKindOfClass:[NSDictionary class]]) {
        
        NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:data[@"project_basic_info"]];
        [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            
            if ([obj isKindOfClass:[NSNull class]]) {
                
                if ([key isEqualToString:@"property_type"] || [key isEqualToString:@"project_tags"]) {
                    
                    [tempDic setObject:@[] forKey:key];
                }else{
                    
                    [tempDic setObject:@"" forKey:key];
                }
            }
        }];
        _model = [[SecAllRoomDetailHeaderModel alloc] initWithDictionary:tempDic];
    }
    
    if ([data[@"project_img"] isKindOfClass:[NSDictionary class]]) {
        
        if ([data[@"project_img"][@"url"] isKindOfClass:[NSArray class]]) {
            
            _imgArr = [[NSMutableArray alloc] initWithArray:data[@"project_img"][@"url"]];
            
            [_imgArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if ([obj isKindOfClass:[NSDictionary class]]) {
                    
                    if ([obj[@"img_url"] isKindOfClass:[NSNull class]]) {
                        
                        [_imgArr replaceObjectAtIndex:idx withObject:@{@"img_url":@""}];
                    }
                }else{
                    
                    [_imgArr replaceObjectAtIndex:idx withObject:@{@"img_url":@""}];
                }
            }];
        }
    }
    
    
    [_roomTable reloadData];
}

- (void)ActionMoreBtn:(UIButton *)btn{
    
    if (btn.tag == 1) {
        
        BuildingInfoVC *next_vc = [[BuildingInfoVC alloc]initWithinfoid:_info_id];
        [self.navigationController pushViewController:next_vc animated:YES];
    }
    
    if (btn.tag == 2) {
        
        DynamicListVC *next_vc = [[DynamicListVC alloc]initWithinfoid:_info_id];
        [self.navigationController pushViewController:next_vc animated:YES];
    }
    
}

- (void)ActionRecommendBtn:(UIButton *)btn{
    
    CustomListVC *nextVC = [[CustomListVC alloc] initWithProjectId:_projectId];
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (void)ActionCounselBtn:(UIButton *)btn{
    
    if (_phone.length) {
        
        //获取目标号码字符串,转换成URL
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",_phone]];
        //调用系统方法拨号
        [[UIApplication sharedApplication] openURL:url];
    }else{
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"暂时未获取到联系电话"];
    }
}

- (void)ActionAttentBtn:(UIButton *)btn{
    
    if (_subId.length) {
        
        [BaseRequest GET:CancelFocusProject_URL parameters:@{@"sub_id":_subId} success:^(id resposeObject) {
            
            NSLog(@"%@",resposeObject);
            
            if ([resposeObject[@"code"] integerValue] == 200) {
                
                _subId = @"";
                [self showContent:@"取消订阅成功"];
                [_attentBtn setTitle:@"订阅" forState:UIControlStateNormal];
                [self RequestMethod];
            }else{
                
                [self showContent:resposeObject[@"msg"]];
            }
        } failure:^(NSError *error) {
            
            NSLog(@"%@",error);
            [self showContent:@"网络错误"];
        }];
    }else{
        
        [BaseRequest GET:PersonalFocusProject_URL parameters:@{@"project_id":_model.project_id,@"type":@"1"} success:^(id resposeObject) {
            
            NSLog(@"%@",resposeObject);
            
            if ([resposeObject[@"code"] integerValue] == 200) {
                
                _subId = [NSString stringWithFormat:@"%@",resposeObject[@"data"]];
                [self showContent:@"订阅成功"];
                [_attentBtn setTitle:@"取消订阅" forState:UIControlStateNormal];
                [self RequestMethod];
            }else{
                
                [self showContent:resposeObject[@"msg"]];
            }
        } failure:^(NSError *error) {
            
            NSLog(@"%@",error);
            [self showContent:@"网络错误"];
        }];
    }
}

#pragma mark -- BMKMap

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
    
    
}


#pragma mark -- delegate

- (void)Cell4collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray * namearr = @[@"教育",@"公交站点",@"医院",@"购物",@"餐饮"];
    [self beginSearchWithname:namearr[indexPath.row]];
}


#pragma mark -- tableview

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 6) {
        
        return _peopleArr.count > 2? 2:_peopleArr.count;
    }else{
        
        if (section == 0 || section == 1) {
            
            return 0;
        }else{
            
            if (section == 2) {
                
                if (_dynamicDic.count) {
                    
                    return 1;
                }else{
                    
                    return 0;
                }
            }else{
                
                if (section == 4) {
                    
                    if (_houseArr.count) {
                        
                        return 1;
                    }
                    return 0;
                }
                return 1;
            }
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (!section) {
        
        return UITableViewAutomaticDimension;
    }else{
        
        if (section == 6) {
            
            return 33 *SIZE;
        }else{
            
            return 6 *SIZE;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (!section) {
        
        RentingComRoomDetailTableHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"RentingComRoomDetailTableHeader"];
        if (!header) {
            
            header = [[RentingComRoomDetailTableHeader alloc] initWithReuseIdentifier:@"RentingComRoomDetailTableHeader"];
            
        }
        header.rentingComHeaderTagBlock = ^(NSInteger btnNum) {
            
            if (btnNum == 1) {
                
                SecDistributVC *nextVC = [[SecDistributVC alloc] init];
                nextVC.projiect_id = _projectId;
                nextVC.img_name = _model.total_float_url_phone;
                nextVC.status = @"rent";
                nextVC.comName = _model.project_name;
                [self.navigationController pushViewController:nextVC animated:YES];
            }else if (btnNum == 2){
                
                RentingComAllRoomListVC *nextVC = [[RentingComAllRoomListVC alloc] initWithProjectId:_projectId city:_city];
                [self.navigationController pushViewController:nextVC animated:YES];
            }else if (btnNum == 3){
                
//                DealRecordVC *nextVC = [[DealRecordVC alloc] init];
//                [self.navigationController pushViewController:nextVC animated:YES];
            }else{
                
                OverviewVC *nextVC = [[OverviewVC alloc] initWithinfoid:_info_id];
                [self.navigationController pushViewController:nextVC animated:YES];
            }
        };
        
        header.model = _model;
        header.imgArr = _imgArr;
        
        if (_focusDic.count) {
            
            header.attentL.text = [NSString stringWithFormat:@"订阅人数:%@",_focusDic[@"num"]];
            if ([_focusDic[@"is_focus"] integerValue]) {
                
                [header.attentBtn setImage:[UIImage imageNamed:@"subscribe_click"] forState:UIControlStateNormal];
            }else{
                
                [header.attentBtn setImage:[UIImage imageNamed:@"subscribe"] forState:UIControlStateNormal];
            }
        }else{
            
            [header.attentBtn setImage:[UIImage imageNamed:@"subscribe"] forState:UIControlStateNormal];
        }
        
        header.rentingAllDetailHeaderImgBtnBlock = ^(NSInteger num, NSArray *imgArr) {
            
            NSMutableArray *tempArr = [NSMutableArray array];
            [imgArr enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                YBImageBrowserModel *model = [YBImageBrowserModel new];
                model.url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,obj[@"img_url"]]];
                [tempArr addObject:model];
            }];
            if (_albumArr.count) {
                
                YBImageBrowser *browser = [YBImageBrowser new];
                browser.delegate = self;
                browser.dataArray = tempArr;
                browser.albumArr = _albumArr;
                browser.infoid = _info_id;
                browser.currentIndex = num;
                [browser show];
            }else{
                
                [BaseRequest GET:GetImg_URL parameters:@{@"info_id":_info_id} success:^(id resposeObject) {
                    
                    if ([resposeObject[@"code"] integerValue] == 200) {
                        
                        if (![resposeObject[@"data"] isKindOfClass:[NSNull class]]) {
                            
                            [_albumArr removeAllObjects];
                            for ( int i = 0; i < [resposeObject[@"data"] count]; i++) {
                                
                                if ([resposeObject[@"data"][i] isKindOfClass:[NSDictionary class]]) {
                                    
                                    NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:resposeObject[@"data"][i]];
                                    
                                    [_albumArr addObject:tempDic];
                                    YBImageBrowser *browser = [YBImageBrowser new];
                                    browser.delegate = self;
                                    browser.albumArr = _albumArr;
                                    browser.dataArray = tempArr;
                                    browser.infoid  = _info_id;
                                    browser.currentIndex = num;
                                    [browser show];
                                }
                            }
                        }else{
                            
                        }
                    }
                } failure:^(NSError *error) {
                    
                    NSLog(@"%@",error);
                }];
            }
        };
        
        return header;
        
    }else{
        
        if (section == 6) {
            
            RoomDetailTableHeader5 *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"RoomDetailTableHeader5"];
            if (!header) {
                
                header = [[RoomDetailTableHeader5 alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 383 *SIZE)];
            }
            header.numL.text = [NSString stringWithFormat:@"匹配的客户(%ld)",_peopleArr.count];
            if (_peopleArr.count == 0) {
                
                header.moreBtn.hidden = YES;
            }else{
                
                header.moreBtn.hidden = NO;
            }
            header.moreBtnBlock = ^{
                
                CustomMatchListVC *nextVC = [[CustomMatchListVC alloc] initWithDataArr:_peopleArr projectId:_projectId];
                [self.navigationController pushViewController:nextVC animated:YES];
            };
            return header;
        }else{
            
            return [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 6 *SIZE)];
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [[UIView alloc] init];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:
        case 1:
        case 2:
        {
            
            RoomDetailTableCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomDetailTableCell1"];
            if (!cell) {
                
                cell = [[RoomDetailTableCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomDetailTableCell1"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            if (_dynamicDic) {
                
                cell.numL.text = [NSString stringWithFormat: @"（共%@条）",_dynamicNum];
                cell.titleL.text = _dynamicDic[@"title"];
                cell.timeL.text = _dynamicDic[@"update_time"];
                cell.contentL.text = _dynamicDic[@"abstract"];
            }
            
            cell.moreBtn.tag = indexPath.section;
            [cell.moreBtn addTarget:self action:@selector(ActionMoreBtn:) forControlEvents:UIControlEventTouchUpInside];
            return cell;
            break;
        }
        case 3:
        {
            
            RoomDetailTableCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomDetailTableCell2"];
            if (!cell) {
                
                cell = [[RoomDetailTableCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomDetailTableCell2"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            if (_model.total_float_url.length>0) {
                [cell.bigImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,_model.total_float_url]] placeholderImage:[UIImage imageNamed:@"banner_default_2"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                    
                    if (error) {
                        
                        cell.bigImg.image =  [UIImage imageNamed:@"banner_default_2"];
                    }
                }];
            }
            else{
                cell.bigImg.image =   [UIImage imageNamed:@"banner_default_2"];
                
            }
            
            return cell;
            break;
        }
        case 4:
        {
            
            RoomDetailTableCell3 *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomDetailTableCell3"];
            if (!cell) {
                cell = [[RoomDetailTableCell3 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomDetailTableCell3"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
            if (_houseArr.count) {
                
                cell.num = _houseArr.count;
            }else{
                
                cell.num = 1;
            }
            if (_houseArr.count) {
                
                cell.dataArr = [NSMutableArray arrayWithArray:_houseArr];
                [cell.cellColl reloadData];
            }else{
                
                [cell.cellColl reloadData];
            }
            
            cell.collCellBlock = ^(NSInteger index) {
                
                if (_houseArr.count > index) {
                    
                    RentingComTypeRoomListVC *nextVC = [[RentingComTypeRoomListVC alloc] initWithProjectId:_projectId city:_city name:_houseArr[index][@"house_type_name"]];
                    [self.navigationController pushViewController:nextVC animated:YES];
                }
            };
            
            return cell;
            break;
        }
        case 5:
        {
            
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
            cell.delegate = self;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
            break;
        }
            
        case 6:
        {
            
            
            RoomDetailTableCell5 *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomDetailTableCell5"];
            if (!cell) {
                
                cell = [[RoomDetailTableCell5 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomDetailTableCell5"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model = _peopleArr[indexPath.row];
            cell.recommendBtn.tag = indexPath.row;
            cell.recommendBtnBlock5 = ^(NSInteger index) {
                
                CustomMatchModel *model = _peopleArr[index];
                [BaseRequest POST:RecommendClient_URL parameters:@{@"project_id":_projectId,@"client_need_id":model.need_id,@"client_id":model.client_id} success:^(id resposeObject) {
                    
                    NSLog(@"%@",resposeObject);
                    
                    if ([resposeObject[@"code"] integerValue] == 200) {
                        
                        [self alertControllerWithNsstring:@"推荐成功" And:nil WithDefaultBlack:^{
                            
                            //                            [self MatchRequest];
                        }];
                    }else if ([resposeObject[@"code"] integerValue] == 400){
                        
                        
                    }
                    else{
                        
                        [self alertControllerWithNsstring:@"温馨提示" And:resposeObject[@"msg"]];
                    }
                } failure:^(NSError *error) {
                    
                    NSLog(@"%@",error);
                    [self showContent:@"网络错误"];
                }];
            };
            return cell;
            break;
        }
        default:{
            RoomDetailTableCell5 *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomDetailTableCell5"];
            if (!cell) {
                
                cell = [[RoomDetailTableCell5 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomDetailTableCell5"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
            break;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 3) {
        
        SecDistributVC *nextVC = [[SecDistributVC alloc] init];
        nextVC.urlfor3d = _model.total_float_url_panorama;
        nextVC.projiect_id = _projectId;
        nextVC.img_name = _model.total_float_url_phone;
        nextVC.status = @"rent";
        nextVC.comName = _model.project_name;
        [self.navigationController pushViewController:nextVC animated:YES];
        //        DistributVC *nextVC = [[DistributVC alloc] init];
        ////        nextVC.img_name = _model.total_float_url_phone;
        //        nextVC.projiect_id = _projectId;
        //        [self.navigationController pushViewController:nextVC animated:YES];
    }
    if (indexPath.section == 2) {
        
        //        DynamicDetailVC *nextVC = [[DynamicDetailVC alloc] initWithStr:_dynamicDic[@"url"] titleStr:@"动态详情"];
        //        [self.navigationController pushViewController:nextVC animated:YES];
    }
}


-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    if ([gestureRecognizer.view isKindOfClass:[BMKMapView class]]) {
        _roomTable.scrollEnabled=NO;
        
    }else{
        _roomTable.scrollEnabled=YES;
        
    }
    
    return NO;
}



- (void)initUI{
    
    
    _roomTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, self.view.frame.size.height - NAVIGATION_BAR_HEIGHT - 47 *SIZE - TAB_BAR_MORE) style:UITableViewStyleGrouped];
    
    _roomTable.rowHeight = UITableViewAutomaticDimension;
    _roomTable.estimatedRowHeight = 360 *SIZE;
    
    _roomTable.estimatedSectionHeaderHeight = 450 *SIZE;
    
    _roomTable.backgroundColor = self.view.backgroundColor;
    _roomTable.delegate = self;
    _roomTable.dataSource = self;
    _roomTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_roomTable];
    
    _attentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _attentBtn.frame = CGRectMake(0, self.view.frame.size.height - NAVIGATION_BAR_HEIGHT - 47 *SIZE - TAB_BAR_MORE, 100 *SIZE, 47 *SIZE + TAB_BAR_MORE);
    _attentBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_attentBtn addTarget:self action:@selector(ActionAttentBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_attentBtn setTitle:@"订阅" forState:UIControlStateNormal];
    [_attentBtn setBackgroundColor:COLOR(74, 211, 195, 1)];
    [_attentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:_attentBtn];
    
    _counselBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _counselBtn.frame = CGRectMake(100 *SIZE, self.view.frame.size.height - NAVIGATION_BAR_HEIGHT - 47 *SIZE - TAB_BAR_MORE, 260 *SIZE, 47 *SIZE + TAB_BAR_MORE);
    _counselBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_counselBtn addTarget:self action:@selector(ActionCounselBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_counselBtn setTitle:@"电话咨询" forState:UIControlStateNormal];
    [_counselBtn setBackgroundColor:COLOR(255, 188, 88, 1)];
    [_counselBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    if ([[UserModel defaultModel].agent_identity integerValue] == 2) {
    //        _counselBtn.frame = CGRectMake(0, self.view.frame.size.height - NAVIGATION_BAR_HEIGHT - 47 *SIZE - TAB_BAR_MORE, SCREEN_Width, 47 *SIZE + TAB_BAR_MORE);
    //    }
    [self.view addSubview:_counselBtn];
    
    _recommendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _recommendBtn.frame = CGRectMake(120 *SIZE, self.view.frame.size.height - NAVIGATION_BAR_HEIGHT - 47 *SIZE - TAB_BAR_MORE, 240 *SIZE, 47 *SIZE + TAB_BAR_MORE);
    _recommendBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_recommendBtn addTarget:self action:@selector(ActionRecommendBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_recommendBtn setTitle:@"快速报备" forState:UIControlStateNormal];
    [_recommendBtn setBackgroundColor:YJBlueBtnColor];
    //    if ([[UserModel defaultModel].agent_identity integerValue] == 1) {
    
    //        [self.view addSubview:_recommendBtn];
    //    }
    
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
    BMKPOIBoundSearchOption *boundSearchOption = [[BMKPOIBoundSearchOption alloc]init];
    boundSearchOption.pageIndex = 0;
    boundSearchOption.pageSize = 20;
    boundSearchOption.keywords = @[name];
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

- (void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPOISearchResult *)poiResult errorCode:(BMKSearchErrorCode)errorCode{
    
    if (errorCode == BMK_SEARCH_NO_ERROR) {
        NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
        [_mapView removeAnnotations:array];
        array = [NSArray arrayWithArray:_mapView.overlays];
        [_mapView removeOverlays:array];
        //在此处理正常结果
        for (int i = 0; i < poiResult.poiInfoList.count; i++)
        {
            BMKPoiInfo* poi = [poiResult.poiInfoList objectAtIndex:i];
            [self addAnimatedAnnotationWithName:poi.name withAddress:poi.pt];
        }
        
        CLLocationCoordinate2D cllocation = CLLocationCoordinate2DMake([_model.latitude floatValue] , [_model.longitude floatValue]);
        [_mapView setCenterCoordinate:cllocation animated:YES];
        BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
        annotation.coordinate = cllocation;
        annotation.title = _model.project_name;
        [_mapView addAnnotation:annotation];
        
    } else if (errorCode == BMK_SEARCH_AMBIGUOUS_ROURE_ADDR){
        NSLog(@"起始点有歧义");
    } else {
        // 各种情况的判断。。。
    }
}
//- (void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPoiResult*)result errorCode:(BMKSearchErrorCode)error
//{
//    if (error == BMK_SEARCH_NO_ERROR) {
//        NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
//        [_mapView removeAnnotations:array];
//        array = [NSArray arrayWithArray:_mapView.overlays];
//        [_mapView removeOverlays:array];
//        //在此处理正常结果
//        for (int i = 0; i < result.poiInfoList.count; i++)
//        {
//            BMKPoiInfo* poi = [result.poiInfoList objectAtIndex:i];
//            [self addAnimatedAnnotationWithName:poi.name withAddress:poi.pt];
//        }
//
//        //        CLLocationCoordinate2D cllocation = CLLocationCoordinate2DMake([_model.latitude floatValue] , [_model.longitude floatValue]);
//        //        [_mapView setCenterCoordinate:cllocation animated:YES];
//        //        BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
//        //        annotation.coordinate = cllocation;
//        //        annotation.title = _model.project_name;
//        //        [_mapView addAnnotation:annotation];
//
//    } else if (error == BMK_SEARCH_AMBIGUOUS_ROURE_ADDR){
//        NSLog(@"起始点有歧义");
//    } else {
//        // 各种情况的判断。。。
//    }
//}
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
        //        if ([annotation.title isEqualToString:_model.project_name]) {
        //            newAnnotationView.image = [UIImage imageNamed:@"coordinates"];
        //        }
        //        else
        //        {
        //            NSArray *arr= @[@"教育",@"公交站点",@"医院",@"购物",@"餐饮"];
        //            if ([_name isEqualToString:arr[0]]) {
        //                newAnnotationView.image = [UIImage imageNamed:@"education"];
        //            }
        //            else if ([_name isEqualToString:arr[1]]) {
        //                newAnnotationView.image = [UIImage imageNamed:@"traffic"];
        //            }
        //            else if ([_name isEqualToString:arr[2]]) {
        //                newAnnotationView.image = [UIImage imageNamed:@"hospital"];
        //            }
        //            else if ([_name isEqualToString:arr[3]]) {
        //                newAnnotationView.image = [UIImage imageNamed:@"shopping"];
        //            }
        //            else
        //            {
        //                newAnnotationView.image = [UIImage imageNamed:@"caterin"];
        //            }
        //
        //        }
        
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
