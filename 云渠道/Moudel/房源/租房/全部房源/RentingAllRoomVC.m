//
//  RentingAllRoomVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/7/23.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RentingAllRoomVC.h"
#import "PYSearchViewController.h"

#import "BoxView.h"
#import "BoxAddressView.h"
#import "AdressChooseView.h"
#import "MoreView.h"

#import "RentingCell.h"
#import <BaiduMapAPI_Location/BMKLocationService.h>

@interface RentingAllRoomVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,BMKLocationServiceDelegate,PYSearchViewControllerDelegate>
{
    
//    NSInteger _page;
//    NSMutableArray *_dataArr;
//    NSString *_provice;
    NSString *_city;
//    NSString *_district;
//    NSString *_price;
    NSString *_type;
//    NSString *_more;
    NSString *_tag;
    NSString *_houseType;
    NSString *_status;
    NSMutableArray *_searchArr;
//    NSArray *_tagsArr;
    NSArray *_propertyArr;
    BOOL _is1;
    BOOL _is2;
    BOOL _is3;
    BOOL _is4;
}

@property (nonatomic , strong) UITableView *MainTableView;

@property (nonatomic , strong) UIView *headerView;

@property (nonatomic, strong) UIButton *cityBtn;

@property (nonatomic, strong) UIView *searchBar;

@property (nonatomic, strong) UIButton *areaBtn;

@property (nonatomic, strong) UIButton *priceBtn;

@property (nonatomic, strong) UIButton *typeBtn;

@property (nonatomic, strong) UIButton *moreBtn;

@property (nonatomic, strong) UIButton *sortBtn;

@property (nonatomic, strong) BoxAddressView *areaView;

@property (nonatomic, strong) BoxView *priceView;

@property (nonatomic, strong) BoxView *typeView;

@property (nonatomic, strong) UIImageView *upImg;

@property (nonatomic, strong) MoreView *moreView;

@end

@implementation RentingAllRoomVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = YJBackColor;
    self.navBackgroundView.hidden = NO;
    [self initDateSouce];
    [self initUI];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

-(void)initDateSouce
{
    
//    _searchArr = [@[] mutableCopy];
//    _dataArr = [@[] mutableCopy];
//    _page = 1;
//    _tagsArr = [self getDetailConfigArrByConfigState:PROJECT_TAGS_DEFAULT];
//    _propertyArr = [self getDetailConfigArrByConfigState:PROPERTY_TYPE];
    //    [self RequestMethod];
}

#pragma mark -- Method

- (void)ActionTagBtn:(UIButton *)btn{
    
    btn.selected = !btn.selected;
    
    switch (btn.tag) {
        case 1:
        {
            _is2 = NO;
            _is3 = NO;
            _is4 = NO;
            _priceBtn.selected = NO;
            _typeBtn.selected = NO;
            _moreBtn.selected = NO;
            [self.priceView removeFromSuperview];
            [self.typeView removeFromSuperview];
            [self.moreView removeFromSuperview];
            if (_is1) {
                
                _is1 = !_is1;
                [_areaView removeFromSuperview];
            }else{
                
                _is1 = YES;
//                _district = @"0";
                
                NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"region" ofType:@"json"]];
                
                NSError *err;
                NSArray *pro = [NSJSONSerialization JSONObjectWithData:JSONData
                                                               options:NSJSONReadingMutableContainers
                                                                 error:&err];
                NSMutableArray * tempArr;
                for (NSDictionary *proDic in pro) {
                    
                    for (NSDictionary *cityDic in proDic[@"city"]) {
                        
                        if ([cityDic[@"code"] integerValue] == [_city integerValue]) {
                            
                            tempArr = [NSMutableArray arrayWithArray:cityDic[@"district"]];
                            break;
                        }
                    }
                }
                [tempArr insertObject:@{@"code":@"0",@"name":@"不限"} atIndex:0];
                self.areaView.dataArr = [NSMutableArray arrayWithArray:tempArr];
                [tempArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    if (idx == 0) {
                        
                        [tempArr replaceObjectAtIndex:idx withObject:@(1)];
                    }else{
                        
                        [tempArr replaceObjectAtIndex:idx withObject:@(0)];
                    }
                    
                }];
                self.areaView.selectArr = [NSMutableArray arrayWithArray:tempArr];
                [self.areaView.mainTable reloadData];
                [[UIApplication sharedApplication].keyWindow addSubview:self.areaView];
            }
            break;
        }
        case 2:
        {
            _is1 = NO;
            _is3 = NO;
            _is4 = NO;
            _areaBtn.selected = NO;
            _typeBtn.selected = NO;
            _moreBtn.selected = NO;
            [self.areaView removeFromSuperview];
            [self.typeView removeFromSuperview];
            [self.moreView removeFromSuperview];
            if (_is2) {
                
                _is2 = !_is2;
                [self.priceView removeFromSuperview];
            }else{
                
                _is2 = YES;
//                _price = @"0";
                NSArray *array = [self getDetailConfigArrByConfigState:AVERAGE];
                NSMutableArray * tempArr = [NSMutableArray arrayWithArray:array];
                [tempArr insertObject:@{@"id":@"0",@"param":@"不限"} atIndex:0];
                self.priceView.dataArr = [NSMutableArray arrayWithArray:tempArr];
                [tempArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    if (idx == 0) {
                        
                        [tempArr replaceObjectAtIndex:idx withObject:@(1)];
                    }else{
                        
                        [tempArr replaceObjectAtIndex:idx withObject:@(0)];
                    }
                }];
                self.priceView.selectArr = [NSMutableArray arrayWithArray:tempArr];
                [self.priceView.mainTable reloadData];
                [[UIApplication sharedApplication].keyWindow addSubview:self.priceView];
            }
            break;
        }
        case 3:
        {
            _is1 = NO;
            _is2 = NO;
            _is4 = NO;
            _areaBtn.selected = NO;
            _priceBtn.selected = NO;
            _moreBtn.selected = NO;
            [self.areaView removeFromSuperview];
            [self.priceView removeFromSuperview];
            [self.moreView removeFromSuperview];
            if (_is3) {
                
                _is3 = !_is3;
                [self.typeView removeFromSuperview];
            }else{
                
                _is3 = YES;
                _type = @"0";
                
                NSMutableArray * tempArr = [NSMutableArray arrayWithArray:_propertyArr];
                [tempArr insertObject:@{@"id":@"0",@"param":@"不限"} atIndex:0];
                self.typeView.dataArr = [NSMutableArray arrayWithArray:tempArr];
                [tempArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    if (idx == 0) {
                        
                        [tempArr replaceObjectAtIndex:idx withObject:@(1)];
                    }else{
                        [tempArr replaceObjectAtIndex:idx withObject:@(0)];
                    }
                }];
                self.typeView.selectArr = [NSMutableArray arrayWithArray:tempArr];
                [self.typeView.mainTable reloadData];
                [[UIApplication sharedApplication].keyWindow addSubview:self.typeView];
            }
            break;
        }
        case 4:
        {
            _is1 = NO;
            _is2 = NO;
            _is3 = NO;
            _areaBtn.selected = NO;
            _priceBtn.selected = NO;
            _typeBtn.selected = NO;
            [self.areaView removeFromSuperview];
            [self.priceView removeFromSuperview];
            [self.typeView removeFromSuperview];
            if (_is4) {
                
                _is4 = !_is4;
                [self.moreView removeFromSuperview];
            }else{
                
                _is4 = YES;
//                _more = @"0";
                
                [self.moreView.moreColl reloadData];
                [[UIApplication sharedApplication].keyWindow addSubview:self.moreView];
            }
            break;
        }
        case 5:
        {
            break;
        }
        default:
            break;
    }
}


- (void)ActionSearchBtn:(UIButton *)btn{
    
    // 1.创建热门搜索
    //    NSArray *hotSeaches = @[@"Java", @"Python", @"Objective-C", @"Swift", @"C", @"C++", @"PHP", @"C#", @"Perl", @"Go", @"JavaScript", @"R", @"Ruby", @"MATLAB"];
    
    // 2. 创建控制器
    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:_searchArr searchBarPlaceholder:@"请输入楼盘名或地址" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        // 开始搜索执行以下代码
        // 如：跳转到指定控制器
        
        //            if ([self.ways isEqualToString:@"quickAdd"]) {
        //
        //
        //            }else{
        //
        //                [searchViewController.navigationController pushViewController:[[QuickSearchVC alloc] initWithTitle:searchText city:_city model:_model] animated:YES];
        //            }
    }];
    // 3. 设置风格
    searchViewController.searchBar.returnKeyType = UIReturnKeySearch;
    searchViewController.hotSearchStyle = 3; // 热门搜索风格根据选择
    searchViewController.searchHistoryStyle = PYHotSearchStyleDefault; // 搜索历史风格为
    // 4. 设置代理
    searchViewController.delegate = self;
    // 5. 跳转到搜索控制器
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:searchViewController];
    [self presentViewController:nav  animated:NO completion:nil];
    
    //    [self.navigationController presentViewController:nav animated:NO completion:nil];
    //    [self.navigationController pushViewController:nav animated:NO];
}


//textfieldDelegate;
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    return YES;
}

#pragma mark  ---  delegate   ---

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    return _dataArr.count;
    return 2;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}

//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 120*SIZE;
//}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    RentingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RentingCell"];
    if (!cell) {
        
        cell = [[RentingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RentingCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleL.text = @"新希望国际大厦 套三 清水房";
    cell.contentL.text = @"3室2厅/103㎡/东南/天鹅湖小区";
    cell.priceL.text = @"108万";
    cell.averageL.text = @"10342元/㎡";
    cell.typeL.text = @"物业类型：住宅";
    cell.classL.text = @"合租";
    [cell.tagView setData:@[@"学区房",@"地铁房",@"商业房"]];
    [cell.tagView2 setData:@[@"高性价比",@"房东人很好"]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    SecAllRoomDetailVC *nextVC = [[SecAllRoomDetailVC alloc] init];
//    nextVC.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:nextVC animated:YES];
}

-(void)initUI
{
    [self.view addSubview:self.headerView];
    self.leftButton.center = CGPointMake(25 * SIZE,  30 *SIZE);
    self.leftButton.bounds = CGRectMake(0, 0, 80 * SIZE, 33 * SIZE);
    self.maskButton.frame = CGRectMake(0, 0, 60 * SIZE, 44 *SIZE);
    
    [self.headerView addSubview:self.leftButton];
    [self.headerView addSubview:self.maskButton];
    
    
    _searchBar = [[UIView alloc] initWithFrame:CGRectMake(58 *SIZE, 13 *SIZE, 272 *SIZE, 33 *SIZE)];
    _searchBar.backgroundColor = YJBackColor;
    [self.headerView addSubview:_searchBar];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(11 *SIZE, 11 *SIZE, 100 *SIZE, 12 *SIZE)];
    label.textColor = COLOR(147, 147, 147, 1);
    label.text = @"小区/楼盘/商铺";
    label.font = [UIFont systemFontOfSize:11 *SIZE];
    [_searchBar addSubview:label];
    
    UIImageView *rightImg = [[UIImageView alloc] initWithFrame:CGRectMake(236 *SIZE, 8 *SIZE, 17 *SIZE, 17 *SIZE)];
    rightImg.image = [UIImage imageNamed:@"search_2"];
    [_searchBar addSubview:rightImg];
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame = _searchBar.bounds;
    [searchBtn addTarget:self action:@selector(ActionSearchBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_searchBar addSubview:searchBtn];
    
    for (int i = 0; i < 5; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(80 * i, 62 *SIZE, 80 *SIZE, 40 *SIZE);
        btn.tag = i + 1;
        [btn setBackgroundColor:[UIColor whiteColor]];
        [btn addTarget:self action:@selector(ActionTagBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        switch (i) {
            case 0:
            {
                [btn setTitle:@"区域" forState:UIControlStateNormal];
                [btn setTitleColor:YJ86Color forState:UIControlStateNormal];
                btn.titleLabel.font = [UIFont systemFontOfSize:12 *SIZE];
                [btn setImage:[UIImage imageNamed:@"downarrow1"] forState:UIControlStateNormal];
                [btn setImage:[UIImage imageNamed:@"uparrow2"] forState:UIControlStateSelected];
                _areaBtn = btn;
                [self.headerView addSubview:_areaBtn];
                break;
            }
            case 1:
            {
                [btn setTitle:@"均价" forState:UIControlStateNormal];
                [btn setTitleColor:YJ86Color forState:UIControlStateNormal];
                btn.titleLabel.font = [UIFont systemFontOfSize:12 *SIZE];
                [btn setImage:[UIImage imageNamed:@"downarrow1"] forState:UIControlStateNormal];
                [btn setImage:[UIImage imageNamed:@"uparrow2"] forState:UIControlStateSelected];
                _priceBtn = btn;
                [self.headerView addSubview:_priceBtn];
                break;
            }
            case 2:
            {
                [btn setTitle:@"类型" forState:UIControlStateNormal];
                [btn setTitleColor:YJ86Color forState:UIControlStateNormal];
                btn.titleLabel.font = [UIFont systemFontOfSize:12 *SIZE];
                [btn setImage:[UIImage imageNamed:@"downarrow1"] forState:UIControlStateNormal];
                [btn setImage:[UIImage imageNamed:@"uparrow2"] forState:UIControlStateSelected];
                _typeBtn = btn;
                [self.headerView addSubview:_typeBtn];
                break;
            }
            case 3:
            {
                [btn setTitle:@"更多" forState:UIControlStateNormal];
                [btn setTitleColor:YJ86Color forState:UIControlStateNormal];
                btn.titleLabel.font = [UIFont systemFontOfSize:12 *SIZE];
                [btn setImage:[UIImage imageNamed:@"downarrow1"] forState:UIControlStateNormal];
                [btn setImage:[UIImage imageNamed:@"uparrow2"] forState:UIControlStateSelected];
                _moreBtn = btn;
                [self.headerView addSubview:_moreBtn];
                break;
            }
            case 4:
            {
                btn.frame = CGRectMake(80 * i, 62 *SIZE, 40 *SIZE, 40 *SIZE);
                [btn setImage:[UIImage imageNamed:@"downarrow1"] forState:UIControlStateNormal];
                [btn setImage:[UIImage imageNamed:@"uparrow2"] forState:UIControlStateSelected];
                _sortBtn = btn;
                [self.headerView addSubview:_sortBtn];
                break;
            }
            default:
                break;
        }
    }
    
    
    [self.view addSubview:self.MainTableView];
    self.MainTableView.mj_footer.state = MJRefreshStateNoMoreData;
}

#pragma mark  ---  懒加载   ---
-(UITableView *)MainTableView
{
    if(!_MainTableView)
    {
        _MainTableView =   [[UITableView alloc]initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT + 105*SIZE, 360*SIZE, SCREEN_Height-STATUS_BAR_HEIGHT-105*SIZE) style:UITableViewStylePlain];
        _MainTableView.rowHeight = UITableViewAutomaticDimension;
        _MainTableView.estimatedRowHeight = 120 *SIZE;
        _MainTableView.backgroundColor = YJBackColor;
        _MainTableView.delegate = self;
        _MainTableView.dataSource = self;
        [_MainTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        _MainTableView.mj_header = [GZQGifHeader headerWithRefreshingBlock:^{
            
        }];
        
        _MainTableView.mj_footer = [GZQGifFooter footerWithRefreshingBlock:^{
            
            
        }];
    }
    return _MainTableView;
}

-(UIView *)headerView
{
    if (!_headerView ) {
        _headerView = [[UIView alloc ]initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT,360*SIZE , 102*SIZE)];
        _headerView.backgroundColor = [UIColor whiteColor];
    }
    return _headerView;
}

- (BoxAddressView *)areaView{
    
    if (!_areaView) {
        
        _areaView = [[BoxAddressView alloc] initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT + 102 *SIZE, SCREEN_Width, SCREEN_Height - 102 *SIZE)];
        WS(weakSelf);
        _areaView.boxAddressComfirmBlock = ^(NSString *ID, NSString *str, NSInteger index) {
            
            if ([str isEqualToString:@"不限"]) {
                
                [weakSelf.areaBtn setTitle:@"区域" forState:UIControlStateNormal];
//                _district = @"";
            }else{
                
                if (str.length) {
                    
                    [weakSelf.areaBtn setTitle:str forState:UIControlStateNormal];
                }else{
                    
                    [weakSelf.areaBtn setTitle:@"区域" forState:UIControlStateNormal];
                }
//                if ([ID integerValue]) {
//
//                    _district = [NSString stringWithFormat:@"%@",ID];
//                }
            }
            _is1 = NO;
            weakSelf.areaBtn.selected = NO;
            [weakSelf.areaView removeFromSuperview];
//            [weakSelf RequestMethod];
        };
        
        _areaView.boxAddressCancelBlock = ^{
            
            _is1 = NO;
            weakSelf.areaBtn.selected = NO;
        };
    }
    return _areaView;
}

- (BoxView *)priceView{
    
    if (!_priceView) {
        
        _priceView = [[BoxView alloc] initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT + 102 *SIZE, SCREEN_Width, SCREEN_Height - 102 *SIZE)];
        WS(weakSelf);
        _priceView.confirmBtnBlock = ^(NSString *ID, NSString *str) {
            
            if ([str isEqualToString:@"不限"]) {
                
                [weakSelf.priceBtn setTitle:@"均价" forState:UIControlStateNormal];
            }else{
                
                [weakSelf.priceBtn setTitle:str forState:UIControlStateNormal];
            }
            _is2 = NO;
//            _price = [NSString stringWithFormat:@"%@",ID];
            weakSelf.priceBtn.selected = NO;
            [weakSelf.priceView removeFromSuperview];
            
        };
        
        _priceView.cancelBtnBlock = ^{
            
            _is2 = NO;
            weakSelf.priceBtn.selected = NO;
        };
    }
    return _priceView;
}

- (BoxView *)typeView{
    
    if (!_typeView) {
        
        _typeView = [[BoxView alloc] initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT + 102 *SIZE, SCREEN_Width, SCREEN_Height - 102 *SIZE)];
        WS(weakSelf);
        _typeView.confirmBtnBlock = ^(NSString *ID, NSString *str) {
            
            if ([str isEqualToString:@"不限"]) {
                
                [weakSelf.typeBtn setTitle:@"类型" forState:UIControlStateNormal];
            }else{
                
                [weakSelf.typeBtn setTitle:str forState:UIControlStateNormal];
            }
            _is3 = NO;
            _type = [NSString stringWithFormat:@"%@",ID];
            weakSelf.typeBtn.selected = NO;
            [weakSelf.typeView removeFromSuperview];
//            [weakSelf RequestMethod];
            
        };
        
        _typeView.cancelBtnBlock = ^{
            
            _is3 = NO;
            weakSelf.typeBtn.selected = NO;
        };
    }
    return _typeView;
}

- (MoreView *)moreView{
    
    if (!_moreView) {
        
        _moreView = [[MoreView alloc] initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT + 103 *SIZE, SCREEN_Width, SCREEN_Height - 103 *SIZE - STATUS_BAR_HEIGHT - TAB_BAR_MORE)];
        
//        WS(weakSelf);
        _moreView.moreBtnBlock = ^(NSString *tag, NSString *houseType, NSString *status) {
            
            if (tag) {
                
                _tag = [NSString stringWithFormat:@"%@",tag];
            }
            
            if (houseType) {
                
                _houseType = [NSString stringWithFormat:@"%@",houseType];
            }
            
            if (status) {
                
                _status = [NSString stringWithFormat:@"%@",status];
            }
            //
//            [weakSelf RequestMethod];
            
        };
        
    }
    return _moreView;
}
@end
