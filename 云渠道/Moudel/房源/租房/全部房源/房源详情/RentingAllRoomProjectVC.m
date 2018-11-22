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

#import "RentingAllRoomProjectVC.h"
#import "RentingAllRoomDetailInfoVC.h"

#import "SecAllRoomDetailTableHeader.h"
#import "SecAllRoomDetailTableHeader2.h"
#import "RentingAllRoomTableCell.h"
#import "SecAllRoomTableCell2.h"
#import "SecAllRoomTableCell3.h"
#import "SecAllRoomTableCell4.h"
#import "RoomDetailTableCell4.h"
#import "RoomDetailTableCell5.h"

@interface RentingAllRoomProjectVC ()<UITableViewDelegate,UITableViewDataSource,BMKMapViewDelegate,RoomDetailTableCell4Delegate,BMKPoiSearchDelegate,UIGestureRecognizerDelegate>
{
    
    CLLocationCoordinate2D _leftBottomPoint;
    CLLocationCoordinate2D _rightBottomPoint;//地图矩形的顶点
    NSString *_phone;
    NSString *_phone_url;
    NSString *_name;
}
@property (nonatomic, strong) UITableView *roomTable;

@property (nonatomic, strong) UIButton *attentBtn;

@property (nonatomic, strong) UIButton *recommendBtn;

@property (nonatomic, strong) BMKMapView *mapView;

@property (nonatomic, strong) BMKPoiSearch *poisearch;

@end

@implementation RentingAllRoomProjectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
}

- (void)ActionRecommendBtn:(UIButton *)btn{
    
    //    CustomListVC *nextVC = [[CustomListVC alloc] initWithProjectId:_projectId];
    //    [self.navigationController pushViewController:nextVC animated:YES];
}

- (void)ActionAttentBtn:(UIButton *)btn{
    
    
}

#pragma mark -- tableview

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 0;
    }
    return 1;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//
//    if (!section) {
//
//        return UITableViewAutomaticDimension;
//    }else{
//
//        return 40 *SIZE;
//    }
//}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    return <#expression#>
//}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 4;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (!section) {
        
        SecAllRoomDetailTableHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"SecAllRoomDetailTableHeader"];
        if (!header) {
            
            header = [[SecAllRoomDetailTableHeader alloc] initWithReuseIdentifier:@"SecAllRoomDetailTableHeader"];
        }
        header.titleL.text = @"FUNX自由青年公寓";
        //        [header.tagview setData:@[@"学区房",@"地铁房",@"电梯房"]];
        header.attentL.text = @"关注人数:23";
        
        header.propertyL.text = @"住宅";
        header.priceL.text = @"¥16000元/m2";
        header.typeL.text = @"2室2厅";
        header.areaL.text = @"99m2";
        return header;
    }else{
        
        SecAllRoomDetailTableHeader2 *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"SecAllRoomDetailTableHeader2"];
        if (!header) {
            
            header = [[SecAllRoomDetailTableHeader2 alloc] initWithReuseIdentifier:@"SecAllRoomDetailTableHeader2"];
        }
        header.moreBtn.hidden = NO;
        header.addBtn.hidden = NO;
        
        switch (section) {
            case 1:
            {
                header.titleL.text = @"房源信息";
                [header.moreBtn setTitle:@"查看全部 >>" forState:UIControlStateNormal];
                header.secAllRoomDetailMoreBlock = ^{
                    
                    RentingAllRoomDetailInfoVC *nextVC = [RentingAllRoomDetailInfoVC new];
                    [self.navigationController pushViewController:nextVC animated:YES];
                };
                header.addBtn.hidden = YES;
                break;
            }
            case 2:{
                
                return nil;
                break;
            }
            case 3:
            {
                header.titleL.text = @"房源动态";
                header.moreBtn.hidden = YES;
                header.addBtn.hidden = YES;
                break;
            }
            case 4:
            {
                header.titleL.text = @"运算公馆";
                [header.moreBtn setTitle:@"小区详情 >>" forState:UIControlStateNormal];
                header.addBtn.hidden = YES;
                break;
            }
            case 5:
            {
                header.titleL.text = @"匹配的客户（23）";
                header.moreBtn.hidden = YES;
                break;
            }
            default:
                break;
        }
        
        return header;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [[UIView alloc] init];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1) {
        
        RentingAllRoomTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RentingAllRoomTableCell"];
        if (!cell) {
            
            cell = [[RentingAllRoomTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RentingAllRoomTableCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell.tagView setData:@[@"学区房",@"地铁房",@"电梯房"]];
        [cell.tagView2 setData:@[@"高性价比",@"房东人很好"]];
        
//        cell.plotL.text = @"小区：云算公馆";
//        cell.floorL.text = @"楼层：32/12层";
//        cell.classL.text = @"租赁类型：合租";
        cell.payWayL.text = @"付款方式：押一付三";
//        cell.periodL.text = @"租期：3~12个月";
        cell.liftL.text = @"电梯：有";
        cell.faceL.text = @"朝向：东南";
        cell.seeL.text = @"看房方式：预约看房";
        cell.decorateL.text = @"装修：中装";
//        cell.intakeL.text = @"入住：随时入住";
        cell.intentL.text = @"出租意愿度：45";
        cell.urgentL.text = @"出租急迫度：56";
        return cell;
    }else if (indexPath.section == 2){
        
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
        //            CLLocationCoordinate2D cllocation = CLLocationCoordinate2DMake([_model.latitude floatValue] , [_model.longitude floatValue]);
        //            [_mapView setCenterCoordinate:cllocation animated:YES];
        //            BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
        //            annotation.coordinate = cllocation;
        //            annotation.title = _model.project_name;
        //            [_mapView addAnnotation:annotation];
        //            cell.delegate = self;
        //            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else if (indexPath.section == 3) {
        
        SecAllRoomTableCell4 *cell = [tableView dequeueReusableCellWithIdentifier:@"SecAllRoomTableCell4"];
        if (!cell) {
            
            cell = [[SecAllRoomTableCell4 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SecAllRoomTableCell4"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.daysL.text = @"16";
        cell.allL.text = @"18";
        cell.intentL.text = @"56";
        //        cell.recentL.text = @"最近带看2018-03-12 >>";
        
        return cell;
    }else if (indexPath.section == 4){
        
        SecAllRoomTableCell3 *cell = [tableView dequeueReusableCellWithIdentifier:@"SecAllRoomTableCell3"];
        if (!cell) {
            
            cell = [[SecAllRoomTableCell3 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SecAllRoomTableCell3"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.priceL.text = @"参考均价：8000元/m2";
        //        cell.timeL.text = @"建筑年代：2017年建";
        cell.buildL.text = @"楼栋总数：7栋";
        cell.roomL.text = @"房屋总数：115户";
        return cell;
    }else{
        
        RoomDetailTableCell5 *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomDetailTableCell5"];
        if (!cell) {
            
            cell = [[RoomDetailTableCell5 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomDetailTableCell5"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.nameL.text = @"张三";
        cell.priceL.text = @"意向总价：80-100万";
        cell.typeL.text = @"意向户型：三室一厅一卫";
        cell.areaL.text = @"意向区域：郫都区- 德源大道";
        cell.intentionRateL.text = @"购买意向度：23";
        cell.urgentRateL.text = @"购买紧迫度：23";
        cell.matchRateL.text = @"匹配度：80%";
        cell.phoneL.text = @"1587374859";
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
    _attentBtn.frame = CGRectMake(0, self.view.frame.size.height - NAVIGATION_BAR_HEIGHT - 47 *SIZE - TAB_BAR_MORE, SCREEN_Width, 47 *SIZE + TAB_BAR_MORE);
    _attentBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_attentBtn addTarget:self action:@selector(ActionAttentBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_attentBtn setTitle:@"关注" forState:UIControlStateNormal];
    [_attentBtn setBackgroundColor:COLOR(255, 188, 88, 1)];
    [_attentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:_attentBtn];
    
    _recommendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _recommendBtn.frame = CGRectMake(0, self.view.frame.size.height - NAVIGATION_BAR_HEIGHT - 47 *SIZE - TAB_BAR_MORE, SCREEN_Width, 47 *SIZE + TAB_BAR_MORE);
    _recommendBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_recommendBtn addTarget:self action:@selector(ActionRecommendBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_recommendBtn setTitle:@"快速推荐" forState:UIControlStateNormal];
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
        
        //        CLLocationCoordinate2D cllocation = CLLocationCoordinate2DMake([_model.latitude floatValue] , [_model.longitude floatValue]);
        //        [_mapView setCenterCoordinate:cllocation animated:YES];
        //        BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
        //        annotation.coordinate = cllocation;
        //        annotation.title = _model.project_name;
        //        [_mapView addAnnotation:annotation];
        
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

@end
