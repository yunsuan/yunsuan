//
//  HouseTypeDetailVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/4.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "HouseTypeDetailVC.h"
//#import "HouseTypeDetailVC.h"
#import "BuildingAlbumVC.h"
#import "CustomMatchListVC.h"

#import "RoomDetailTableCell5.h"
#import "HouseTypeTableCell.h"
#import "HouseTypeTableCell2.h"
#import "HouseTypeTableHeader.h"
#import "HouseTypeTableHeader2.h"
#import "YBImageBrowser.h"

#import "SelectWorkerView.h"
#import "ReportCustomConfirmView.h"
#import "ReportCustomSuccessView.h"

@interface HouseTypeDetailVC ()<UITableViewDelegate,UITableViewDataSource,YBImageBrowserDelegate>
{
    
    NSString *_area;
    NSString *_houseType;
    NSString *_houseTypeId;
    NSMutableDictionary *_baseInfoDic;
    NSMutableArray *_imgArr;
    NSMutableArray *_houseArr;
    NSString *_projectId;
    NSString *_infoid;
    NSMutableArray *_matchList;
    NSString *_url;
    NSInteger _state;
    NSInteger _selected;
    NSString *_imgStr;
    NSString *_titleStr;
}
@property (nonatomic, strong) SelectWorkerView *selectWorkerView;

@property (nonatomic, strong) UIButton *recommendBtn;

@property (nonatomic, strong) UITableView *houseTable;

@property (nonatomic, strong) TransmitView *transmitView;

@property (nonatomic, strong) YBImageBrowser *browser;

@end

@implementation HouseTypeDetailVC

- (instancetype)initWithHouseTypeId:(NSString *)houseTypeId index:(NSInteger)index dataArr:(NSArray *)dataArr projectId:(NSString *)projectId infoid:(NSString *)infoid
{
    self = [super init];
    if (self) {
        _infoid = infoid;
        _projectId = projectId;
        _houseTypeId = houseTypeId;
        _imgArr = [@[] mutableCopy];
        _matchList = [@[] mutableCopy];
        self.dataArr = [NSMutableArray arrayWithArray:dataArr];
        _houseArr = [NSMutableArray arrayWithArray:self.dataArr];
        [_houseArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([[NSString stringWithFormat:@"%@",obj[@"id"]] isEqualToString:houseTypeId]) {
                
                _imgStr = obj[@"img_url"];
                _titleStr = obj[@"house_type_name"];
                [_houseArr removeObjectAtIndex:idx];
                _houseType = obj[@"house_type"];
                _area = obj[@"property_area_min"];
                *stop = YES;
            }
        }];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    
    dispatch_queue_t queue1 = dispatch_queue_create("com.houseType.gcg.group", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_async(group, queue1, ^{
        
        [self RequestMethod];
        
    });
    dispatch_group_async(group, queue1, ^{
        
        [self MatchListRequest];
        
    });
}

- (void)ActionRightBtn:(UIButton *)btn{
    
    [BaseRequest GET:@"user/project/getHouseType" parameters:@{@"house_type_id":_houseTypeId} success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            _url = resposeObject[@"data"][@"url"];
            [[UIApplication sharedApplication].keyWindow addSubview:self.transmitView];
        }else{
            
            [self showContent:@"分享失败"];
        }
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        [self showContent:@"分享失败"];
    }];
}


- (void)RequestMethod{
    
    [BaseRequest GET:HouseTypeDetail_URL parameters:@{@"id":_houseTypeId} success:^(id resposeObject) {
        
        //        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if (![resposeObject[@"data"] isKindOfClass:[NSNull class]]) {
                
                [self SetData:resposeObject[@"data"]];
            }else{
                
                [self showContent:@"暂无信息"];
            }
        }
    } failure:^(NSError *error) {
        
        //        NSLog(@"%@",error);
        [self showContent:@"网络错误"];
    }];
}

- (void)SetData:(NSDictionary *)data{
    
    if ([data[@"baseInfo"] isKindOfClass:[NSDictionary class]]) {
        
        _baseInfoDic = [NSMutableDictionary dictionaryWithDictionary:data[@"baseInfo"]];
        [_baseInfoDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            
            if ([obj isKindOfClass:[NSNull class]]) {
                
                [_baseInfoDic setObject:@"" forKey:key];
            }
        }];
    }
    
    if ([data[@"imgInfo"] isKindOfClass:[NSArray class]]) {
        
        NSArray *arr = data[@"imgInfo"];
        for ( int i = 0; i < arr.count; i++) {
            
            if ([arr[i] isKindOfClass:[NSDictionary class]]) {
                
                NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:arr[i]];
                
                [_imgArr addObject:tempDic];
            }
        }
    }
    
    [_houseTable reloadData];
}

- (void)MatchListRequest{
    
    [BaseRequest GET:HouseTypeMatching_URL parameters:@{@"project_id":_projectId,@"house_type_id":_houseTypeId} success:^(id resposeObject) {
        
        //        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [self SetMatchPeople:resposeObject[@"data"]];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        //        NSLog(@"%@",error);
        [self showContent:@"网络错误"];
    }];
}

- (void)SetMatchPeople:(NSArray *)data{
    
    for (int i = 0 ; i < data.count; i++) {
        
        NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:data[i]];
        
        [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            
            if ([obj isKindOfClass:[NSNull class]]) {
                
                [tempDic setObject:@"" forKey:key];
            }
        }];
        
        CustomMatchModel *model = [[CustomMatchModel alloc] initWithDictionary:tempDic];
        [_matchList addObject:model];
    }
    [_houseTable reloadData];
}



//- (void)ActionRecommendBtn:(UIButton *)btn{
//
//    [[UIApplication sharedApplication].keyWindow addSubview:self.transmitView];
//}

#pragma mark -- Method --

- (void)RequestRecommend:(NSDictionary *)dic model:(CustomMatchModel *)model{
    
    [BaseRequest POST:RecommendClient_URL parameters:dic success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            ReportCustomSuccessView *reportCustomSuccessView = [[ReportCustomSuccessView alloc] initWithFrame:self.view.frame];
            NSDictionary *tempDic = @{@"project":_model.project_name,
                                      @"sex":model.sex,
                                      @"tel":model.tel,
                                      @"name":model.name
                                      };
            reportCustomSuccessView.state = _state;
            reportCustomSuccessView.dataDic = [NSMutableDictionary dictionaryWithDictionary:tempDic];
            reportCustomSuccessView.reportCustomSuccessViewBlock = ^{
                
            };
            [self.view addSubview:reportCustomSuccessView];
        }else if ([resposeObject[@"code"] integerValue] == 401){
            
            [self alertControllerWithNsstring:@"温馨提示" And:resposeObject[@"msg"]];
        }
        else{
            
            [self alertControllerWithNsstring:@"温馨提示" And:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        [self showContent:@"网络错误"];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 2) {
        
        return _matchList.count;
    }
    if (section == 1) {
        
        if (_houseArr.count) {
            
            return 1;
        }
        return 0;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 8 *SIZE;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 203.5 *SIZE;
    }
    if (section == 1) {
        
        if (_houseArr.count) {
            
            return 33 *SIZE;
        }else{
            
            return 0;
        }
    }
    return 33 *SIZE;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        HouseTypeTableHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"HouseTypeTableHeader"];
        if (!header) {
            
            header = [[HouseTypeTableHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 203.5 *SIZE)];
        }
        header.imgArr = [NSMutableArray arrayWithArray:_imgArr];
        header.houseTypeImgBtnBlock = ^(NSInteger num, NSArray *imgArr) {
            
            NSMutableArray *tempArr = [NSMutableArray array];
            
            NSMutableArray *tempArr1 = [NSMutableArray array];
            for (NSDictionary *dic in imgArr) {
                
                for (NSDictionary *subDic in dic[@"list"]) {
                    
                    [tempArr1 addObject:subDic];
                }
            }
            [tempArr1 enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                YBImageBrowserModel *model = [YBImageBrowserModel new];
                model.url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,obj[@"img_url"]]];
                if ([obj[@"img_url_3d"] length]) {
                    
                    model.third_URL = [NSString stringWithFormat:@"%@%@",TestBase_Net,obj[@"img_url_3d"]];
                }
                
                [tempArr addObject:model];
            }];
            
            [_imgArr enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:obj];
                [tempDic setObject:obj[@"type"] forKey:@"name"];
                
                [tempDic setObject:obj[@"list"] forKey:@"data"];
                [_imgArr replaceObjectAtIndex:idx withObject:tempDic];
                
            }];
            
             YBImageBrowserModel *YBmodel = tempArr[num];
            if (YBmodel.third_URL.length) {
                
                BuildingAlbumVC *nextVC = [[BuildingAlbumVC alloc] init];
                nextVC.weburl = YBmodel.third_URL;
                [self.navigationController pushViewController:nextVC animated:YES];
            }else{
            YBImageBrowser *browser = [YBImageBrowser new];
            browser.delegate = self;
            browser.dataArray = tempArr;
            browser.albumArr = _imgArr;
            browser.infoid = _infoid;
            browser.currentIndex = num;
            [browser show];
            }
        };
        return header;
    }else{
        
        HouseTypeTableHeader2 *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"HouseTypeTableHeader2"];
        
        if (!header) {
            
            header = [[HouseTypeTableHeader2 alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 33 *SIZE)];
        }
        if (section == 1) {
            
            header.titleL.font = [UIFont systemFontOfSize:15 *SIZE];
            header.titleL.text = @"本楼盘其他户型";
            header.moreBtn.hidden = YES;
        }else{
            
            header.titleL.font = [UIFont systemFontOfSize:13 *SIZE];
            header.titleL.text = [NSString stringWithFormat:@"匹配的客户(%ld)",_matchList.count];
        }
        header.houseTypeTableHeader2Block = ^{
            
            CustomMatchListVC *nextVC = [[CustomMatchListVC alloc] initWithDataArr:_matchList projectId:_projectId];
            nextVC.model = _model;
            [self.navigationController pushViewController:nextVC animated:YES];
        };
        return header;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        HouseTypeTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HouseTypeTableCell"];
        if (!cell) {
            
            cell = [[HouseTypeTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HouseTypeTableCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.typeL.text = _baseInfoDic[@"house_type_name"];
        if ([_baseInfoDic[@"property_area_max"] integerValue] && [_baseInfoDic[@"property_area_min"] integerValue]) {
            
            cell.areaL.text = [NSString stringWithFormat:@"建筑面积：%@㎡-%@㎡",_baseInfoDic[@"property_area_min"],_baseInfoDic[@"property_area_max"]];
        }else{
            
            if ([_baseInfoDic[@"property_area_min"] integerValue]) {
                
                cell.areaL.text = [NSString stringWithFormat:@"建筑面积：%@㎡",_baseInfoDic[@"property_area_min"]];
            }else{
                
                cell.areaL.text = [NSString stringWithFormat:@"建筑面积：%@㎡",_baseInfoDic[@"property_area_max"]];
            }
        }
        
        //        cell.houseDisL.text = @"户型分布：1栋、3栋";
        cell.titleL.text = @"户型卖点";
        cell.contentL.text = _baseInfoDic[@"sell_point"];
        
        return cell;
    }else{
        if (indexPath.section == 1) {
            
            HouseTypeTableCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"HouseTypeTableCell2"];
            if (!cell) {
                
                cell = [[HouseTypeTableCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HouseTypeTableCell2"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.num = _houseArr.count;
            if (_houseArr.count) {
                
                cell.dataArr = [NSMutableArray arrayWithArray:_houseArr];
                [cell.cellColl reloadData];
            }
            cell.collCellBlock = ^(NSInteger index) {
                
                HouseTypeDetailVC *nextVC = [[HouseTypeDetailVC alloc] initWithHouseTypeId:[NSString stringWithFormat:@"%@",_houseArr[index][@"id"]] index:index dataArr:self.dataArr projectId:_projectId infoid:_infoid];
                    nextVC.model = self.model;
                //                nextVC.dataArr = _houseArr;
                [self.navigationController pushViewController:nextVC animated:YES];
            };
            
            return cell;
        }else{
            
            RoomDetailTableCell5 *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomDetailTableCell5"];
            if (!cell) {
                
                cell = [[RoomDetailTableCell5 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomDetailTableCell5"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model = _matchList[indexPath.row];
            cell.recommendBtn.tag = indexPath.row;
            cell.recommendBtnBlock5 = ^(NSInteger index) {
                
                CustomMatchModel *model = _matchList[index];
                self.selectWorkerView = [[SelectWorkerView alloc] initWithFrame:self.view.bounds];
                SS(strongSelf);
                WS(weakSelf);
                self.selectWorkerView.selectWorkerRecommendBlock = ^{
                    
                    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"project_id":strongSelf->_projectId,@"client_need_id":model.need_id,@"client_id":model.client_id}];
                    if (weakSelf.selectWorkerView.nameL.text) {
                        
                        [dic setObject:weakSelf.selectWorkerView.ID forKey:@"consultant_advicer_id"];
                    }
                    
                    ReportCustomConfirmView *reportCustomConfirmView = [[ReportCustomConfirmView alloc] initWithFrame:weakSelf.view.frame];
                    NSDictionary *tempDic = @{@"project":weakSelf.model.project_name,
                                              @"sex":model.sex,
                                              @"tel":model.tel,
                                              @"name":model.name
                                              };
                    reportCustomConfirmView.state = strongSelf->_state;
                    reportCustomConfirmView.dataDic = [NSMutableDictionary dictionaryWithDictionary:tempDic];
                    reportCustomConfirmView.reportCustomConfirmViewBlock = ^{
                        
                        [BaseRequest POST:RecommendClient_URL parameters:dic success:^(id resposeObject) {
                            
                            if ([resposeObject[@"code"] integerValue] == 200) {
                                
                                ReportCustomSuccessView *reportCustomSuccessView = [[ReportCustomSuccessView alloc] initWithFrame:weakSelf.view.frame];
                                NSDictionary *tempDic = @{@"project":weakSelf.model.project_name,
                                                          @"sex":model.sex,
                                                          @"tel":model.tel,
                                                          @"name":model.name
                                                          };
                                reportCustomSuccessView.state = strongSelf->_state;
                                reportCustomSuccessView.dataDic = [NSMutableDictionary dictionaryWithDictionary:tempDic];
                                reportCustomSuccessView.reportCustomSuccessViewBlock = ^{
                                    
                                };
                                [weakSelf.view addSubview:reportCustomSuccessView];
                            }else if ([resposeObject[@"code"] integerValue] == 400){
                                
                                [weakSelf alertControllerWithNsstring:@"温馨提示" And:resposeObject[@"msg"]];
                            }
                            else{
                                [weakSelf alertControllerWithNsstring:@"温馨提示" And:resposeObject[@"msg"]];
                            }
                        } failure:^(NSError *error) {
                            
                            [weakSelf showContent:@"网络错误"];
                        }];
                    };
                    [weakSelf.view addSubview:reportCustomConfirmView];
                };
                
                [BaseRequest GET:ProjectAdvicer_URL parameters:@{@"project_id":strongSelf->_projectId} success:^(id resposeObject) {
                    
                    if ([resposeObject[@"code"] integerValue] == 200) {
                        
                        if ([resposeObject[@"data"][@"rows"] count]) {
                            
                            weakSelf.selectWorkerView.dataArr = [NSMutableArray arrayWithArray:resposeObject[@"data"][@"rows"]];
                            _state = [resposeObject[@"data"][@"tel_complete_state"] integerValue];
                            _selected = [resposeObject[@"data"][@"advicer_selected"] integerValue];
                            weakSelf.selectWorkerView.advicerSelect = _selected;
                            [self.view addSubview:weakSelf.selectWorkerView];
                        }else{
                            
                            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"project_id":strongSelf->_projectId,@"client_need_id":model.need_id,@"client_id":model.client_id}];
                            
                            ReportCustomConfirmView *reportCustomConfirmView = [[ReportCustomConfirmView alloc] initWithFrame:weakSelf.view.frame];
                            NSDictionary *tempDic = @{@"project":weakSelf.model.project_name,
                                                      @"sex":model.sex,
                                                      @"tel":model.tel,
                                                      @"name":model.name
                                                      };
                            reportCustomConfirmView.state = strongSelf->_state;
                            reportCustomConfirmView.dataDic = [NSMutableDictionary dictionaryWithDictionary:tempDic];
                            reportCustomConfirmView.reportCustomConfirmViewBlock = ^{
                                
                                [weakSelf RequestRecommend:dic model:model];
                            };
                            [weakSelf.view addSubview:reportCustomConfirmView];
                        }
                    }else{
                        
                        [self showContent:resposeObject[@"msg"]];
                    }
                } failure:^(NSError *error) {
                    
                    [self showContent:@"网络错误"];
                }];
            };
            return cell;
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc] init];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}



- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"户型详情";
    self.line.hidden = YES;
    
    self.rightBtn.hidden = NO;
    [self.rightBtn setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    self.rightBtn.titleLabel.font = [UIFont systemFontOfSize:15 *SIZE];
    [self.rightBtn setTitleColor:YJTitleLabColor forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(ActionRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    _houseTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStyleGrouped];
    _houseTable.estimatedRowHeight = 150 *SIZE;
    _houseTable.rowHeight = UITableViewAutomaticDimension;
    _houseTable.backgroundColor = self.view.backgroundColor;
    _houseTable.delegate = self;
    _houseTable.dataSource = self;
    _houseTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_houseTable];
    
}

- (TransmitView *)transmitView{
    
    if (!_transmitView) {
        
        _transmitView = [[TransmitView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
        WS(weakSelf);
        _transmitView.transmitTagBtnBlock = ^(NSInteger index) {
            
            if (index == 0) {
                
                if ([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_QQ]) {
                    
                    [weakSelf shareWebPageToPlatformType:UMSocialPlatformType_QQ];
                }else{
                    
                    [weakSelf alertControllerWithNsstring:@"温馨提示" And:@"请先安装手机QQ"];
                }
            }else if (index == 1){
                
                if ([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_QQ]) {
                    
                    [weakSelf shareWebPageToPlatformType:UMSocialPlatformType_Qzone];
                }else{
                    
                    [weakSelf alertControllerWithNsstring:@"温馨提示" And:@"请先安装手机QQ"];
                }
            }else if (index == 2){
                
                if ([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_WechatSession]) {
                    
                    [weakSelf shareWebPageToPlatformType:UMSocialPlatformType_WechatSession];
                }else{
                    
                    [weakSelf alertControllerWithNsstring:@"温馨提示" And:@"请先安装微信"];
                }
            }else{
                
                if ([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_WechatSession]) {
                    
                    [weakSelf shareWebPageToPlatformType:UMSocialPlatformType_WechatTimeLine];
                }else{
                    
                    [weakSelf alertControllerWithNsstring:@"温馨提示" And:@"请先安装微信"];
                }
            }
            
        };
    }
    return _transmitView;
}

//
- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    UMShareWebpageObject *shareObject;
    //创建网页内容对象
    if (_imgStr.length) {
        
        shareObject = [UMShareWebpageObject shareObjectWithTitle:_titleStr descr:@""  thumImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,_imgStr]]]]];
    }else{
        
        shareObject = [UMShareWebpageObject shareObjectWithTitle:_titleStr descr:@""  thumImage:[UIImage imageNamed:@"shareimg"]];

    }
    
    //设置网页地址
    shareObject.webpageUrl = _url;
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    if (platformType == UMSocialPlatformType_WechatTimeLine || platformType ==  UMSocialPlatformType_Qzone) {
        shareObject.title = [NSString stringWithFormat:@"%@(%@)-%@-%.0f㎡",_model.project_name,_model.city_name,_houseType,[_area floatValue]];
    }else if (platformType == UMSocialPlatformType_QQ || platformType == UMSocialPlatformType_WechatSession){
        
        shareObject.title = [NSString stringWithFormat:@"%@|%@",_model.project_name,_titleStr];
        shareObject.descr = [NSString stringWithFormat:@"面积 %.0f㎡ \n%@",[_area floatValue],_houseType];
    }
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            //            NSLog(@"************Share fail with error %@*********",error);
        }else{
            //            NSLog(@"response data is %@",data);
            [self showContent:@"分享成功"];
            [self.transmitView removeFromSuperview];
        }
    }];
}
@end
