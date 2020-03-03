//
//  ActiveRoomDetailVC.m
//  云渠道
//
//  Created by 谷治墙 on 2020/2/25.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "ActiveRoomDetailVC.h"

#import "ActiveRoomDetailHeader.h"
#import "BaseHeader.h"

#import "ActionRoomDetailThreeCell.h"
#import "ActionRoomDetailTwoCell.h"
#import "SingleContentCell.h"
#import "ActionRoomDetailRecommendCell.h"

#import "YBImageBrowser.h"

@interface ActiveRoomDetailVC ()<UITableViewDelegate,UITableViewDataSource,YBImageBrowserDelegate>
{
    
    NSString *_house_id;
    NSString *_info_id;
    NSString *_title;
    NSString *_content;
    
    NSMutableDictionary *_dataDic;
    
    NSMutableArray *_imgArr;
}

@property (nonatomic, strong) UITableView *houseTable;

@property (nonatomic, strong) YBImageBrowser *browser;

@property (nonatomic, strong) UIButton *recommendBtn;

@property (nonatomic, strong) UIButton *cancelBtn;

@end

@implementation ActiveRoomDetailVC

- (instancetype)initWithHouseId:(NSString *)house_id info_id:(NSString *)info_id
{
    self = [super init];
    if (self) {
        
        _info_id = info_id;
        _house_id = house_id;
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
    
    _dataDic = [@{} mutableCopy];
    _imgArr = [@[] mutableCopy];
}

- (void)RequestMethod{
    
    [BaseRequest GET:ProjectGetHouseDetail_URL parameters:@{@"house_id":_house_id,@"config_id":self.config_id} success:^(id resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            _dataDic = [NSMutableDictionary dictionaryWithDictionary:resposeObject[@"data"]];
            [_dataDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
               
                if ([obj isKindOfClass:[NSNull class]]) {
                    
                    [_dataDic setValue:@"" forKey:key];
                }
            }];
            
            if ([_dataDic[@"recommend_house_info"][@"recommend_id"] integerValue] != 0) {
                           
                _content = [NSString stringWithFormat:@"%@",_dataDic[@"recommend_house_info"][@"comment"]];
                _title = [NSString stringWithFormat:@"%@",_dataDic[@"recommend_house_info"][@"title"]];
                
                self.cancelBtn.hidden = NO;
                self.recommendBtn.frame = CGRectMake(120 *SIZE, SCREEN_Height - 40 *SIZE - TAB_BAR_MORE, 240 *SIZE, 40 *SIZE + TAB_BAR_MORE);
            }
            
            if ([_dataDic[@"imgInfo"][@"51"] count]) {
                
                [_imgArr addObject:@{@"type":@"户型图",@"list":_dataDic[@"imgInfo"][@"51"]}];
            }
            if ([_dataDic[@"imgInfo"][@"52"] count]) {
                
                [_imgArr addObject:@{@"type":@"3D图",@"list":_dataDic[@"imgInfo"][@"52"]}];
            }
            if ([_dataDic[@"imgInfo"][@"53"] count]) {
                
                [_imgArr addObject:@{@"type":@"效果图",@"list":_dataDic[@"imgInfo"][@"53"]}];
            }
            if ([_dataDic[@"imgInfo"][@"54"] count]) {
                
                [_imgArr addObject:@{@"type":@"平面图",@"list":_dataDic[@"imgInfo"][@"54"]}];
            }
            if ([_dataDic[@"imgInfo"][@"55"] count]) {
                
                [_imgArr addObject:@{@"type":@"实景图",@"list":_dataDic[@"imgInfo"][@"55"]}];
            }
            [_houseTable reloadData];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [self showContent:@"网络错误"];
    }];
}

- (void)ActionRecommendBtn:(UIButton *)btn{
    
    if (!_title.length) {
        
        [self showContent:@"请输入推荐标题"];
        return;
    }
    if (!_content.length) {
        
        [self showContent:@"请输入推荐理由"];
        return;
    }
    
    if ([_dataDic[@"recommend_house_info"][@"recommend_id"] integerValue] != 0) {
    
        _recommendBtn.userInteractionEnabled = NO;
        [BaseRequest POST:ProjectUpdateRecommendHouse_URL parameters:@{@"recommend_id":[NSString stringWithFormat:@"%@",_dataDic[@"recommend_house_info"][@"recommend_id"]],@"house_id":_house_id,@"title":_title,@"comment":_content} success:^(id resposeObject) {
            
            if ([resposeObject[@"code"] integerValue] == 200) {
                
                [self showContent:@"保存成功"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [self.navigationController popViewControllerAnimated:YES];
                });
            }else{
                
                _recommendBtn.userInteractionEnabled = YES;
                [self showContent:resposeObject[@"msg"]];
            }
        } failure:^(NSError *error) {
            
            _recommendBtn.userInteractionEnabled = YES;
            [self showContent:@"网络错误"];
        }];
    }else{
        
        _recommendBtn.userInteractionEnabled = NO;
        [BaseRequest POST:ProjectAddRecommendHouse_URL parameters:@{@"project_id":self.project_id,@"house_id":_house_id,@"title":_title,@"comment":_content,@"config_id":self.config_id} success:^(id resposeObject) {
            
            if ([resposeObject[@"code"] integerValue] == 200) {
                
                [self showContent:@"保存成功"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [self.navigationController popViewControllerAnimated:YES];
                });
            }else{
                
                _recommendBtn.userInteractionEnabled = YES;
                [self showContent:resposeObject[@"msg"]];
            }
        } failure:^(NSError *error) {
            
            _recommendBtn.userInteractionEnabled = YES;
            [self showContent:@"网络错误"];
        }];
    }
}

- (void)ActionMoreBtn:(UIButton *)btn{
    
    [self alertControllerWithNsstring:@"放弃推荐" And:@"该操作将会把该房间从我的店铺移除，是否继续？" WithCancelBlack:^{
        
    } WithDefaultBlack:^{
        
        if (![_dataDic count]) {
            
            [self showContent:@"未找到房间信息"];
            return;
        }
        [BaseRequest POST:ProjectUpdateRecommendHouse_URL parameters:@{@"recommend_id":[NSString stringWithFormat:@"%@",_dataDic[@"recommend_house_info"][@"recommend_id"]],@"house_id":_house_id,@"is_recommend":@"0"} success:^(id resposeObject) {
            
            if ([resposeObject[@"code"] integerValue] == 200) {
                
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                
                [self showContent:resposeObject[@"msg"]];
            }
        } failure:^(NSError *error) {
            
            [self showContent:@"网络错误"];
        }];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 0;
    }
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 1 *SIZE;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 5) {
        
        return 0;
    }
    return UITableViewAutomaticDimension;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 5) {
        
        return nil;
    }else{
        
        if (section == 0) {
            
            ActiveRoomDetailHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"ActiveRoomDetailHeader"];
            if (!header) {
                
                header = [[ActiveRoomDetailHeader alloc] initWithReuseIdentifier:@"ActiveRoomDetailHeader"];
            }
            header.imgArr = [NSMutableArray arrayWithArray:_imgArr];
            header.activeRoomDetailHeaderImgBtnBlock = ^(NSInteger num, NSArray *imgArr) {
                
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
                browser.infoid = _info_id;
                browser.currentIndex = num;
                [browser show];
                }
            };
            return header;
        }else{
            
            BaseHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BaseHeader"];
            if (!header) {
                
                header = [[BaseHeader alloc] initWithReuseIdentifier:@"BaseHeader"];
            }
            
            if (section == 1) {
                
                header.titleL.text = @"房号：";
                if ([_dataDic count]) {
                    
                    header.titleL.text = [NSString stringWithFormat:@"房号：%@",_dataDic[@"house_name"]];
                }
            }else if (section == 2){
                
                header.titleL.text = @"价格：";
                if ([_dataDic count]) {
                    
                    header.titleL.text = [NSString stringWithFormat:@"价格：%@万",_dataDic[@"total_price"]];
                }
            }else if (section == 3){
                
                header.titleL.text = @"物业：";
                if ([_dataDic count]) {
                    
                    header.titleL.text = [NSString stringWithFormat:@"物业：%@",_dataDic[@"property_type"]];
                }
            }else{
                
                header.titleL.text = @"房源推荐：";
                
            }
            return header;
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = CLBackColor;
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        return nil;
    }else{
        
        if (indexPath.section == 2) {
            
            ActionRoomDetailTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ActionRoomDetailTwoCell"];
            if (!cell) {
                
                cell = [[ActionRoomDetailTwoCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ActionRoomDetailTwoCell"];
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.oneL.text = [NSString stringWithFormat:@"计价规则：%@",[_dataDic[@"price_way"] integerValue] == 1?@"按建筑面积":@"按套内面积"];
            cell.twoL.text = [NSString stringWithFormat:@"单价：%@元/㎡",_dataDic[@"unit_price"]];
            return cell;
        }else if (indexPath.section == 4){
            
            SingleContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SingleContentCell"];
            if (!cell) {
                
                cell = [[SingleContentCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"SingleContentCell"];
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.contentL.font = [UIFont systemFontOfSize:11 *SIZE];
            
            cell.contentL.text = _dataDic[@"sell_point"];
            return cell;
        }else if (indexPath.section == 3 || indexPath.section == 1){
            
            ActionRoomDetailThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ActionRoomDetailThreeCell"];
            if (!cell) {
                
                cell = [[ActionRoomDetailThreeCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ActionRoomDetailThreeCell"];
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
            if (indexPath.section == 1) {
                
                cell.oneL.text = [NSString stringWithFormat:@"楼栋：%@",_dataDic[@"build_name"]];
                cell.twoL.text = [NSString stringWithFormat:@"单元：%@",_dataDic[@"unit_name"]];
                cell.threeL.text= [NSString stringWithFormat:@"楼层：%@层",_dataDic[@"floor_num"]];
            }else{
                
                cell.oneL.text = [NSString stringWithFormat:@"建筑面积：%@㎡",_dataDic[@"build_size"]];
                cell.twoL.text = [NSString stringWithFormat:@"套内面积：%@㎡",_dataDic[@"indoor_size"]];
                cell.threeL.text= [NSString stringWithFormat:@"公摊面积：%@㎡",_dataDic[@"public_size"]];
            }
            return cell;
        }else{
            
            ActionRoomDetailRecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ActionRoomDetailRecommendCell"];
            if (!cell) {
                
                cell = [[ActionRoomDetailRecommendCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ActionRoomDetailRecommendCell"];
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
             
            
            cell.actionRoomDetailRecommendCellBlock = ^(NSString *title, NSString *content) {
                
                _title = title;
                _content = content;
            };
            
            if (_content.length) {
                
                cell.commentPlaceL.hidden = YES;
            }else{
                
                cell.commentPlaceL.hidden = NO;
            }
            cell.contentTV.text = _content;
            cell.titleTF.textfield.text = _title;
            
            return cell;
        }
    }
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"房间详情";
    
    
    _houseTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - 40 *SIZE - TAB_BAR_MORE) style:UITableViewStyleGrouped];
    _houseTable.estimatedRowHeight = 150 *SIZE;
    _houseTable.rowHeight = UITableViewAutomaticDimension;
    _houseTable.backgroundColor = self.view.backgroundColor;
    _houseTable.delegate = self;
    _houseTable.dataSource = self;
    _houseTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_houseTable];
    
    _recommendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _recommendBtn.frame = CGRectMake(0 *SIZE, SCREEN_Height - 40 *SIZE - TAB_BAR_MORE, 360 *SIZE, 40 *SIZE + TAB_BAR_MORE);
    [_recommendBtn addTarget:self action:@selector(ActionRecommendBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_recommendBtn setTitle:@"添加到我的店铺" forState:UIControlStateNormal];
    [_recommendBtn setBackgroundColor:YJBlueBtnColor];
    _recommendBtn.titleLabel.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.view addSubview:_recommendBtn];
    
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancelBtn.frame = CGRectMake(0 *SIZE, SCREEN_Height - 40 *SIZE - TAB_BAR_MORE, 120 *SIZE, 40 *SIZE + TAB_BAR_MORE);
    [_cancelBtn addTarget:self action:@selector(ActionMoreBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_cancelBtn setTitle:@"取消推荐" forState:UIControlStateNormal];
    [_cancelBtn setBackgroundColor:YJ170Color];
    _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:13 *SIZE];
    _cancelBtn.hidden = YES;
    [self.view addSubview:_cancelBtn];
}

@end
