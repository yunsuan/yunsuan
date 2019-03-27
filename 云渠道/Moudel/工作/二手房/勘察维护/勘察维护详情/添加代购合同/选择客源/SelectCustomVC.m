//
//  SelectCustomVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/10/11.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "SelectCustomVC.h"

//#import "CustomDetailVC.h"

#import "AddCustomerVC.h"
//#import "CustomSearchVC.h"

#import "CustomerTableCell.h"
//#import "CustomerCollCell.h"

#import "BoxView.h"
#import "AddressChooseView2.h"

@interface SelectCustomVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableArray *_dataArr;
//    NSMutableDictionary *_parameter;
    NSInteger _page;
    NSString *_type;
    NSString *_district;
    NSString *_sortType;
    NSString *_asc;
    NSArray *_propertyArr;
    BOOL _is1;
    BOOL _is2;
    BOOL _is3;
}

@property (nonatomic, strong) UITableView *customerTable;

@property (nonatomic, strong) BoxView *boxView;

@property (nonatomic, strong) UIView *searchBar;

@property (nonatomic, strong) UIButton *typeBtn;

@property (nonatomic, strong) UIButton *propertyBtn;

@property (nonatomic, strong) UIButton *areaBtn;

@property (nonatomic, strong) UIButton *intentBtn;

@property (nonatomic, strong) UIButton *urgencyBtn;

@property (nonatomic, strong) AddressChooseView2 *adressView;

@end

@implementation SelectCustomVC

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
    [self RequestMethod];
}

- (void)initDataSource{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(RequestMethod) name:@"reloadCustom" object:nil];
    _page = 1;
    _dataArr = [@[] mutableCopy];
    _propertyArr = [self getDetailConfigArrByConfigState:PROPERTY_TYPE];
}

- (void)RequestMethod{
    
    _customerTable.mj_footer.state = MJRefreshStateIdle;
    NSMutableDictionary *dic = [@{} mutableCopy];
    if (_sortType.length) {
        
        [dic setObject:_sortType forKey:@"sort_type"];
        [dic setObject:_asc forKey:@"sort"];
    }
    if ([_type integerValue]) {
        
        [dic setObject:_type forKey:@"property_type"];
    }
    if (_district.length) {
        
        [dic setObject:_district forKey:@"district"];
    }
    
    [BaseRequest GET:ListClient_URL parameters:dic success:^(id resposeObject) {
        
        //        NSLog(@"%@",resposeObject);
        [_customerTable.mj_header endRefreshing];
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if ([resposeObject[@"data"] isKindOfClass:[NSDictionary class]]) {
                
                if (_page == [resposeObject[@"data"][@"last_page"] integerValue]) {
                    
                    [_dataArr removeAllObjects];
                    [_customerTable reloadData];
                    _customerTable.mj_footer.state = MJRefreshStateNoMoreData;
                }
                
                if ([resposeObject[@"data"][@"data"] isKindOfClass:[NSArray class]]) {
                    
                    if ([resposeObject[@"data"][@"data"] count]) {
                        
                        [self SetData:resposeObject[@"data"][@"data"]];
                        
                    }else{
                        
                        [_dataArr removeAllObjects];
                        _customerTable.mj_footer.state = MJRefreshStateNoMoreData;
                        //                        [self showContent:@"暂无数据"];
                    }
                }else{
                    
                    [_dataArr removeAllObjects];
                    //                    [self showContent:@"暂无数据"];
                }
            }else{
                
                [_dataArr removeAllObjects];
                //                [self showContent:@"暂无数据"];
            }
            [_customerTable reloadData];
        }        else{
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [_customerTable.mj_header endRefreshing];
        //        NSLog(@"%@",error.localizedDescription);
        [self showContent:@"网络错误"];
    }];
}

- (void)RequestAddMethod{
    
    _page += 1;
    NSDictionary *tempDic = @{@"page":@(_page)};
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:tempDic];
    if (_sortType.length) {
        
        [dic setObject:_sortType forKey:@"sort_type"];
        [dic setObject:_asc forKey:@"sort"];
    }
    if (_type) {
        
        [dic setObject:_type forKey:@"property_type"];
    }
    if (_district.length) {
        
        [dic setObject:_district forKey:@"district"];
    }
    [BaseRequest GET:ListClient_URL parameters:dic success:^(id resposeObject) {
        
        //        NSLog(@"%@",resposeObject);
        
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if ([resposeObject[@"data"] isKindOfClass:[NSDictionary class]]) {
                
                if ([resposeObject[@"data"][@"data"] isKindOfClass:[NSArray class]]) {
                    
                    if ([resposeObject[@"data"][@"data"] count]) {
                        
                        [self SetData:resposeObject[@"data"][@"data"]];
                        if (_page == [resposeObject[@"data"][@"last_page"] integerValue]) {
                            
                            _customerTable.mj_footer.state = MJRefreshStateNoMoreData;
                        }else{
                            
                            [_customerTable.mj_footer endRefreshing];
                        }
                    }else{
                        
                        _customerTable.mj_footer.state = MJRefreshStateNoMoreData;
                    }
                }else{
                    
                    _customerTable.mj_footer.state = MJRefreshStateNoMoreData;
                }
            }else{
                
                [_customerTable.mj_footer endRefreshing];
            }
        }else{
            [self showContent:resposeObject[@"msg"]];
            
            [_customerTable.mj_footer endRefreshing];
        }
    } failure:^(NSError *error) {
        
        [_customerTable.mj_footer endRefreshing];
        //        NSLog(@"%@",error.localizedDescription);
        [self showContent:@"网络错误"];
    }];
}

- (void)SetData:(NSArray *)data{
    
    if (_page == 1) {
        
        [_dataArr removeAllObjects];
    }
    for (int i = 0; i < data.count; i++) {
        
        NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:data[i]];
        [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            
            if ([key isEqualToString:@"region"]) {
                
                if (![obj isKindOfClass:[NSArray class]]) {
                    
                    [tempDic setObject:@[] forKey:@"region"];
                }
            }
            
            if ([obj isKindOfClass:[NSNull class]]) {
                
                if ([key isEqualToString:@"region"]) {
                    
                    [tempDic setObject:@[] forKey:@"region"];
                }else{
                    
                    [tempDic setObject:@"" forKey:key];
                }
            }
        }];
        
        CustomerTableModel *model = [[CustomerTableModel alloc] initWithDictionary:tempDic];
        
        [_dataArr addObject:model];
    }
    [_customerTable reloadData];
}

#pragma mark -- Method

- (void)ActionTagBtn:(UIButton *)btn{
    
    btn.selected = !btn.selected;
    if (btn.tag < 4) {
        
        if (btn.tag == 1) {
            
            _is2 = NO;
            _is3 = NO;
            _areaBtn.selected = NO;
            _propertyBtn.selected = NO;
            [self.adressView removeFromSuperview];
            if (_is1) {
                
                _is1 = !_is1;
                [self.boxView removeFromSuperview];
            }else{
                
                _is1 = YES;
                _type = @"0";
                
                NSMutableArray * tempArr = [NSMutableArray arrayWithArray:[self getDetailConfigArrByConfigState:36]];
                [tempArr insertObject:@{@"id":@"0",@"param":@"不限"} atIndex:0];
                self.boxView.dataArr = [NSMutableArray arrayWithArray:tempArr];
                [tempArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    if (idx == 0) {
                        
                        [tempArr replaceObjectAtIndex:idx withObject:@(1)];
                    }else{
                        
                        [tempArr replaceObjectAtIndex:idx withObject:@(0)];
                    }
                }];
                self.boxView.selectArr = [NSMutableArray arrayWithArray:tempArr];
                [self.boxView.mainTable reloadData];
                [self.view addSubview:self.boxView];
            }
        }else if (btn.tag == 2){
            
            _is1 = NO;
            _is3 = NO;
            _areaBtn.selected = NO;
            _typeBtn.selected = NO;
            [self.adressView removeFromSuperview];
            if (_is2) {
                
                _is2 = !_is2;
                [self.boxView removeFromSuperview];
            }else{
                
                _is2 = YES;
                _type = @"0";
                
                NSMutableArray * tempArr = [NSMutableArray arrayWithArray:_propertyArr];
                [tempArr insertObject:@{@"id":@"0",@"param":@"不限"} atIndex:0];
                self.boxView.dataArr = [NSMutableArray arrayWithArray:tempArr];
                [tempArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    if (idx == 0) {
                        
                        [tempArr replaceObjectAtIndex:idx withObject:@(1)];
                    }else{
                        
                        [tempArr replaceObjectAtIndex:idx withObject:@(0)];
                    }
                }];
                self.boxView.selectArr = [NSMutableArray arrayWithArray:tempArr];
                [self.boxView.mainTable reloadData];
                [self.view addSubview:self.boxView];
            }
        }else{
            
            _is1 = NO;
            _is2 = NO;
            _typeBtn.selected = NO;
            _propertyBtn.selected = NO;
            [self.boxView removeFromSuperview];
            if (_is3) {
                
                _is3 = !_is3;
                [self.adressView removeFromSuperview];
            }else{
                
                _is3 = YES;
                [self.view addSubview:self.adressView];
            }
        }
    }else{
        
        _page = 1;
        _is1 = NO;
        _typeBtn.selected = NO;
        _areaBtn.selected = NO;
        if (btn.tag == 3) {
            
            _urgencyBtn.selected = NO;
            if ([_sortType isEqualToString:@"intent"]) {
                
                if ([_asc isEqualToString:@"desc"]) {
                    
                    _asc = @"asc";
                }else{
                    
                    _asc = @"desc";
                }
            }else{
                
                _asc = @"asc";
            }
            _sortType = @"intent";
        }else{
            
            _intentBtn.selected = NO;
            if ([_sortType isEqualToString:@"urgency"]) {
                
                
                if ([_asc isEqualToString:@"desc"]) {
                    
                    _asc = @"asc";
                }else{
                    
                    _asc = @"desc";
                }
            }else{
                
                _asc = @"asc";
            }
            _sortType = @"urgency";
        }
        [self.boxView removeFromSuperview];
        [self RequestMethod];
        if (_dataArr.count) {
            
            [_customerTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
        }
    }
}


#pragma mark -- TableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    return 110 *SIZE;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *Identifier = @"CustomerTableCell";
    CustomerTableCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (!cell) {
        
        cell = [[CustomerTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    CustomerTableModel *model = _dataArr[indexPath.row];
    cell.customerTableCellPhoneTapBlock = ^(NSString *phone) {
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phone]];
        //调用系统方法拨号
        [[UIApplication sharedApplication] openURL:url];
    };
    cell.model = model;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CustomerTableModel *model = _dataArr[indexPath.row];
    if (self.selectCustomVCBlock) {
        
        self.selectCustomVCBlock(model);
        [self.navigationController popViewControllerAnimated:YES];
    }
//    CustomDetailVC *nextVC = [[CustomDetailVC alloc] initWithClientId:model.client_id];
//    nextVC.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:nextVC animated:YES];
}


- (void)initUI{
    
    self.titleLabel.text = @"客源";
    self.navBackgroundView.hidden = NO;
//    self.leftButton.hidden = YES;
    self.view.backgroundColor = YJBackColor;
//    self.rightBtn.hidden = NO;
//    [self.rightBtn setImage:[UIImage imageNamed:@"add_3"] forState:UIControlStateNormal];
//    [self.rightBtn addTarget:self action:@selector(action_add) forControlEvents:UIControlEventTouchUpInside];
    
    self.line.hidden = YES;
    
    for (int i = 0; i < 5; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(SCREEN_Width / 5 * i, NAVIGATION_BAR_HEIGHT, SCREEN_Width / 5, 40 *SIZE);
        btn.tag = i + 1;
        [btn setBackgroundColor:[UIColor whiteColor]];
        [btn addTarget:self action:@selector(ActionTagBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        switch (i) {
            case 0:
            {
                [btn setTitle:@"需求类型" forState:UIControlStateNormal];
                [btn setTitleColor:YJ86Color forState:UIControlStateNormal];
                btn.titleLabel.font = [UIFont systemFontOfSize:12 *SIZE];
                [btn setImage:[UIImage imageNamed:@"downarrow1"] forState:UIControlStateNormal];
                [btn setImage:[UIImage imageNamed:@"uparrow2"] forState:UIControlStateSelected];
                _typeBtn = btn;
                [self.view addSubview:_typeBtn];
                break;
            }
            case 1:
            {
                [btn setTitle:@"意向物业" forState:UIControlStateNormal];
                [btn setTitleColor:YJ86Color forState:UIControlStateNormal];
                btn.titleLabel.font = [UIFont systemFontOfSize:12 *SIZE];
                [btn setImage:[UIImage imageNamed:@"downarrow1"] forState:UIControlStateNormal];
                [btn setImage:[UIImage imageNamed:@"uparrow2"] forState:UIControlStateSelected];
                _propertyBtn = btn;
                [self.view addSubview:_propertyBtn];
                break;
            }
            case 2:
            {
                [btn setTitle:@"意向区域" forState:UIControlStateNormal];
                [btn setTitleColor:YJ86Color forState:UIControlStateNormal];
                btn.titleLabel.font = [UIFont systemFontOfSize:12 *SIZE];
                [btn setImage:[UIImage imageNamed:@"downarrow1"] forState:UIControlStateNormal];
                [btn setImage:[UIImage imageNamed:@"uparrow2"] forState:UIControlStateSelected];
                _areaBtn = btn;
                [self.view addSubview:_areaBtn];
                break;
            }
            case 3:
            {
                [btn setTitle:@"意向度" forState:UIControlStateNormal];
                [btn setTitleColor:YJ86Color forState:UIControlStateNormal];
                btn.titleLabel.font = [UIFont systemFontOfSize:12 *SIZE];
                [btn setImage:[UIImage imageNamed:@"downarrow1"] forState:UIControlStateNormal];
                [btn setImage:[UIImage imageNamed:@"uparrow2"] forState:UIControlStateSelected];
                _intentBtn = btn;
                [self.view addSubview:_intentBtn];
                break;
            }
            case 4:
            {
                [btn setTitle:@"紧迫度" forState:UIControlStateNormal];
                [btn setTitleColor:YJ86Color forState:UIControlStateNormal];
                btn.titleLabel.font = [UIFont systemFontOfSize:12 *SIZE];
                [btn setImage:[UIImage imageNamed:@"downarrow1"] forState:UIControlStateNormal];
                [btn setImage:[UIImage imageNamed:@"uparrow2"] forState:UIControlStateSelected];
                _urgencyBtn = btn;
                [self.view addSubview:_urgencyBtn];
                break;
            }
            default:
                break;
        }
    }
    
    
    
    _customerTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 41 *SIZE + NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    
    _customerTable.rowHeight = UITableViewAutomaticDimension;
    _customerTable.estimatedRowHeight = 110 *SIZE;
    
    _customerTable.backgroundColor = YJBackColor;
    _customerTable.delegate = self;
    _customerTable.dataSource = self;
    _customerTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_customerTable];
    _customerTable.mj_header = [GZQGifHeader headerWithRefreshingBlock:^{
        
        _page = 1;
        [self RequestMethod];
    }];
    
    _customerTable.mj_footer = [GZQGifFooter footerWithRefreshingBlock:^{
        
        [self RequestAddMethod];
    }];
}


-(void)action_add
{
    AddCustomerVC *next_vc = [[AddCustomerVC alloc]init];
    [self.navigationController pushViewController:next_vc animated:YES];
    
}

- (AddressChooseView2 *)adressView{
    
    if (!_adressView) {
        
        _adressView = [[AddressChooseView2 alloc]initWithFrame:CGRectMake(0, 41 *SIZE + NAVIGATION_BAR_HEIGHT + 56 *SIZE, SCREEN_Width, SCREEN_Height - (41 *SIZE + NAVIGATION_BAR_HEIGHT + 56 *SIZE))];
        WS(weakSelf);
        _adressView.confirmAreaBlock = ^(NSString *pro, NSString *city, NSString *area, NSString *proviceid, NSString *cityid, NSString *areaid) {
            
            if (area.length) {
                
                _district = [NSString stringWithFormat:@"%@-%@-%@",proviceid,cityid,areaid];
                [weakSelf.areaBtn setTitle:area forState:UIControlStateNormal];
            }else if(city.length){
                
                _district = [NSString stringWithFormat:@"%@-%@",proviceid,cityid];
                [weakSelf.areaBtn setTitle:city forState:UIControlStateNormal];
            }else if (pro.length){
                
                _district = [NSString stringWithFormat:@"%@",proviceid];
                [weakSelf.areaBtn setTitle:pro forState:UIControlStateNormal];
            }else{
                
                [weakSelf.areaBtn setTitle:@"意向区域" forState:UIControlStateNormal];
            }
            
            _is2 = NO;
            weakSelf.areaBtn.selected = NO;
            [weakSelf.adressView removeFromSuperview];
            [weakSelf RequestMethod];
        };
        _adressView.cancelBtnBlock = ^{
            
            _is2 = NO;
            weakSelf.areaBtn.selected = NO;
        };
    }
    return _adressView;
}

- (BoxView *)boxView{
    if (!_boxView) {
        _boxView = [[BoxView alloc] initWithFrame:CGRectMake(0, 41 *SIZE + NAVIGATION_BAR_HEIGHT + 56 *SIZE, SCREEN_Width, SCREEN_Height - (41 *SIZE + NAVIGATION_BAR_HEIGHT + 56 *SIZE))];
        WS(weakSelf);
        _boxView.confirmBtnBlock = ^(NSString *ID,NSString *str) {
            
            if ([str isEqualToString:@"不限"]) {
                
                [weakSelf.typeBtn setTitle:@"需求类型" forState:UIControlStateNormal];
            }else{
                
                [weakSelf.typeBtn setTitle:str forState:UIControlStateNormal];
            }
            _is1 = NO;
            _type = [NSString stringWithFormat:@"ID"];
            weakSelf.typeBtn.selected = NO;
            [weakSelf.boxView removeFromSuperview];
            [weakSelf RequestMethod];
        };
        
        _boxView.cancelBtnBlock = ^{
            
            _is1 = NO;
            weakSelf.typeBtn.selected = NO;
        };
    }
    return _boxView;
}

@end
