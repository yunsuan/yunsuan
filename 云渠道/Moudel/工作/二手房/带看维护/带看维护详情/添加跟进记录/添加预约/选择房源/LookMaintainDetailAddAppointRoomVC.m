//
//  LookMaintainDetailAddAppointRoomVC.m
//  云渠道
//
//  Created by 谷治墙 on 2019/1/30.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "LookMaintainDetailAddAppointRoomVC.h"

#import "MakeDateLookVC.h"
#import "LookMaintainAddLookVC.h"

#import "BoxView.h"
#import "PriceSetView.h"

#import "LookMaintainDetailAddAppointRoomCell.h"

@interface LookMaintainDetailAddAppointRoomVC ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
{
    
    BOOL _is1;
    BOOL _is2;
    BOOL _is3;
    
    NSInteger _page;
    
    NSString *_takeId;
    NSString *_type;
    NSString *_pro;
    NSString *_min;
    NSString *_max;
    NSString *_search;
    
    NSMutableArray *_arr;
    NSMutableArray *_dataArr;
    NSMutableArray *_proArr;
    NSArray *_typeArr;
}
@property (nonatomic, strong) UITextField *searchBar;

@property (nonatomic, strong) UIButton *proBtn;

@property (nonatomic, strong) UIButton *priceBtn;

@property (nonatomic, strong) UIButton *typeBtn;

@property (nonatomic, strong) BoxView *proView;

@property (nonatomic, strong) PriceSetView *priceView;

@property (nonatomic, strong) BoxView *typeView;

@property (nonatomic, strong) UITableView *table;

@end

@implementation LookMaintainDetailAddAppointRoomVC

- (instancetype)initWithTakeId:(NSString *)takeId dataArr:(NSArray *)dataArr
{
    self = [super init];
    if (self) {
        
        _arr = [[NSMutableArray alloc] initWithArray:dataArr];
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
    
    _dataArr = [@[] mutableCopy];
    _proArr = [@[] mutableCopy];
    _typeArr = @[@{@"id":@"0",@"param":@"不限"},@{@"id":@"1",@"param":@"住宅"},@{@"id":@"2",@"param":@"商铺"},@{@"id":@"3",@"param":@"写字楼"}];
    _page = 1;
    _min = @"0";
    _max = @"0";
}

- (void)ActionMaskBtn:(UIButton *)btn{
    
    [self.proView removeFromSuperview];
    [self.priceView removeFromSuperview];
    [self.typeView removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)RequestMethod{
    
    NSMutableDictionary *dic = [@{} mutableCopy];
    if (!self.isSelect) {
        
        [dic setObject:_takeId forKey:@"take_id"];
    }
    
    [dic setObject:@"1" forKey:@"type"];
    [dic setObject:@(_page) forKey:@"page"];
    
    if ([_type integerValue]) {
        
        [dic setObject:_type forKey:@"property_type"];
    }
    if ([_pro integerValue]) {
        
        [dic setObject:_pro forKey:@"project_id"];
    }
    if (_search.length) {
        
        [dic setObject:_search forKey:@"search"];
    }
    
    [dic setObject:[NSString stringWithFormat:@"%@-%@",_min,_max] forKey:@"price"];
    _table.mj_footer.state = MJRefreshStateIdle;
    [BaseRequest GET:TakeMaintainFollowHouseList_URL parameters:dic success:^(id resposeObject) {
        
        [_table.mj_header endRefreshing];
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue]) {
            
            [_dataArr removeAllObjects];
            [self SetData:resposeObject[@"data"][@"data"]];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [_table.mj_header endRefreshing];
        [self showContent:@"网络错误"];
    }];
}

- (void)RequestAddMethod{
    
    NSMutableDictionary *dic = [@{} mutableCopy];
//    [dic setObject:_takeId forKey:@"take_id"];
    if (!self.isSelect) {
        
        [dic setObject:_takeId forKey:@"take_id"];
    }
    [dic setObject:@"1" forKey:@"type"];
    [dic setObject:@(_page) forKey:@"page"];
    
    if (_search.length) {
        
        [dic setObject:_search forKey:@"search"];
    }
    if ([_type integerValue]) {
        
        [dic setObject:_type forKey:@"property_type"];
    }
    if ([_pro integerValue]) {
        
        [dic setObject:_pro forKey:@"project_id"];
    }
    
    [dic setObject:[NSString stringWithFormat:@"%@-%@",_min,_max] forKey:@"price"];
    [BaseRequest GET:TakeMaintainFollowHouseList_URL parameters:dic success:^(id resposeObject) {
        
        [_table.mj_footer endRefreshing];
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue]) {
            
            [self SetData:resposeObject[@"data"][@"data"]];
        }else{
            
            _page -= 1;
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [_table.mj_footer endRefreshing];
        _page -= 1;
        [self showContent:@"网络错误"];
    }];
}

- (void)SetData:(NSArray *)data{
    
//    if (data.count < 15) {
//        
//        _table.mj_footer.state = MJRefreshStateNoMoreData;
//    }
    for (int i = 0; i < data.count; i++) {
        
        NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:data[i]];
        
        [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            
            if ([obj isKindOfClass:[NSNull class]]) {
                
                if ([key isEqualToString:@"house_tags"] || [key isEqualToString:@"project_tags"]) {
                    
                    [tempDic setObject:@[] forKey:key];
                }else{
                    
                    [tempDic setObject:@"" forKey:key];
                }
            }else{
                
                if ([key isEqualToString:@"house_tags"] || [key isEqualToString:@"project_tags"]) {
                    
                    
                }else{
                    
                    [tempDic setObject:[NSString stringWithFormat:@"%@",obj] forKey:key];
                }
            }
        }];
        
        LookMaintainDetailAddAppointRoomModel *model = [[LookMaintainDetailAddAppointRoomModel alloc] initWithDictionary:tempDic];
        [_dataArr addObject:model];
    }
    
    for ( int i = 0; i < _dataArr.count; i++) {
        
        for (int j = 0; j < _arr.count; j++) {
            
            LookMaintainDetailAddAppointRoomModel *model = _dataArr[i];
            LookMaintainDetailAddAppointRoomModel *tempModel = _arr[j][@"model"];
            if ([tempModel.house_id isEqualToString:model.house_id]) {
                
                [_arr removeObjectAtIndex:j];
                [_dataArr removeObjectAtIndex:i];
            }
        }
    }
    [_table reloadData];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (![self isEmpty:textField.text]) {
        
        _search = textField.text;
        [self RequestMethod];
    }else{
        
        _search = @"";
    }
    return YES;
}

- (void)ActionTagBtn:(UIButton *)btn{
    
    if (btn.tag == 1) {
        
        _is2 = NO;
        _is3 = NO;
        
        
        if (_is1) {
            
            _priceBtn.selected = NO;
            _typeBtn.selected = NO;
            [self.priceView removeFromSuperview];
            [self.typeView removeFromSuperview];
            _is1 = !_is1;
            [self.proView removeFromSuperview];
        }else{
            
            _priceBtn.selected = NO;
            _typeBtn.selected = NO;
            [self.priceView removeFromSuperview];
            [self.typeView removeFromSuperview];
            _is1 = YES;
            if (_proArr.count) {
                
                [[UIApplication sharedApplication].keyWindow addSubview:self.proView];
            }else{
                
                [BaseRequest GET:TakeMaintainFollowProjectList_URL parameters:nil success:^(id resposeObject) {
                    
                    if ([resposeObject[@"code"] integerValue] == 200) {
                        
                        _proArr = [NSMutableArray arrayWithArray:[resposeObject[@"data"] mutableCopy]];
                        for (int i = 0; i < _proArr.count; i++) {
                            
                            NSMutableDictionary *tempDic = [_proArr[i] mutableCopy];
                            [tempDic setObject:_proArr[i][@"project_id"] forKey:@"id"];
                            [tempDic setObject:_proArr[i][@"project_name"] forKey:@"param"];
                            [tempDic removeObjectForKey:@"project_name"];
                            [tempDic removeObjectForKey:@"project_id"];
                            [_proArr replaceObjectAtIndex:i withObject:tempDic];
                        }
                        [[UIApplication sharedApplication].keyWindow addSubview:self.proView];
                    }else{
                        
                        [self showContent:resposeObject[@"msg"]];
                    }
                } failure:^(NSError *error) {
                    
                    [self showContent:@"网络错误"];
                }];
            }
        }
    }else if (btn.tag == 2){
        
        _is1 = NO;
        _is3 = NO;
        _proBtn.selected = NO;
        _typeBtn.selected = NO;
        if (_proArr.count) {
            
            [[UIApplication sharedApplication].keyWindow addSubview:self.proView];
        }else{
            
            [BaseRequest GET:TakeMaintainFollowProjectList_URL parameters:nil success:^(id resposeObject) {
                
                if ([resposeObject[@"code"] integerValue] == 200) {
                    
                    _proArr = [NSMutableArray arrayWithArray:[resposeObject[@"data"] mutableCopy]];
                    for (int i = 0; i < _proArr.count; i++) {
                        
                        NSMutableDictionary *tempDic = [_proArr[i] mutableCopy];
                        [tempDic setObject:_proArr[i][@"project_id"] forKey:@"id"];
                        [tempDic setObject:_proArr[i][@"project_name"] forKey:@"param"];
                        [tempDic removeObjectForKey:@"project_name"];
                        [tempDic removeObjectForKey:@"project_id"];
                        [_proArr replaceObjectAtIndex:i withObject:tempDic];
                    }
                    [[UIApplication sharedApplication].keyWindow addSubview:self.proView];
                }else{
                    
                    [self showContent:resposeObject[@"msg"]];
                }
            } failure:^(NSError *error) {
                
                [self showContent:@"网络错误"];
            }];
        }
        
        if (_is2) {
            
            _is2 = !_is2;
            [self.priceView removeFromSuperview];
        }else{
            
            _is2 = YES;
            
            [self.proView removeFromSuperview];
            [self.typeView removeFromSuperview];
            self.priceView.minTF.textfield.text = _min.length ? _min:@"0";
            self.priceView.maxTF.textfield.text = _max.length ? _max:@"0";
            [[UIApplication sharedApplication].keyWindow addSubview:self.priceView];
        }
    }else{
        
        _is1 = NO;
        _is2 = NO;
        _proBtn.selected = NO;
        _priceBtn.selected = NO;
        
        if (_proArr.count) {
            
            [[UIApplication sharedApplication].keyWindow addSubview:self.proView];
        }else{
            
            [BaseRequest GET:TakeMaintainFollowProjectList_URL parameters:nil success:^(id resposeObject) {
                
                if ([resposeObject[@"code"] integerValue] == 200) {
                    
                    _proArr = [NSMutableArray arrayWithArray:[resposeObject[@"data"] mutableCopy]];
                    for (int i = 0; i < _proArr.count; i++) {
                        
                        NSMutableDictionary *tempDic = [_proArr[i] mutableCopy];
                        [tempDic setObject:_proArr[i][@"project_id"] forKey:@"id"];
                        [tempDic setObject:_proArr[i][@"project_name"] forKey:@"param"];
                        [tempDic removeObjectForKey:@"project_name"];
                        [tempDic removeObjectForKey:@"project_id"];
                        [_proArr replaceObjectAtIndex:i withObject:tempDic];
                    }
                    [[UIApplication sharedApplication].keyWindow addSubview:self.proView];
                }else{
                    
                    [self showContent:resposeObject[@"msg"]];
                }
            } failure:^(NSError *error) {
                
                [self showContent:@"网络错误"];
            }];
        }
        if (_is3) {
            
            _is3 = !_is3;
            [self.typeView removeFromSuperview];
        }else{
            
            [self.proView removeFromSuperview];
            [self.priceView removeFromSuperview];
            _is3 = YES;
            [[UIApplication sharedApplication].keyWindow addSubview:self.typeView];
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LookMaintainDetailAddAppointRoomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LookMaintainDetailAddAppointRoomCell"];
    if (!cell) {
        
        cell = [[LookMaintainDetailAddAppointRoomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LookMaintainDetailAddAppointRoomCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    LookMaintainDetailAddAppointRoomModel *model = _dataArr[indexPath.row];
    cell.model = model;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.status integerValue] == 1) {
        
        MakeDateLookVC *nextVC = [[MakeDateLookVC alloc] initWithModel:_dataArr[indexPath.row]];
        nextVC.dataDic = self.dataDic;
        nextVC.makeDateLookVCBlock = ^(NSDictionary * _Nonnull dic) {
            
            if (self.lookMaintainDetailAddAppointRoomVCBlock) {
                
                self.lookMaintainDetailAddAppointRoomVCBlock(dic);
            }
        };
        [self.navigationController pushViewController:nextVC animated:YES];
    }else{
        
        LookMaintainAddLookVC *nextVC = [[LookMaintainAddLookVC alloc] initWithModel:_dataArr[indexPath.row]];
        nextVC.dataDic = self.dataDic;
        nextVC.lookMaintainAddLookVCBlock = ^(NSDictionary * _Nonnull dic) {
          
            if (self.lookMaintainDetailAddAppointRoomVCBlock) {
                
                self.lookMaintainDetailAddAppointRoomVCBlock(dic);
            }
        };
        [self.navigationController pushViewController:nextVC animated:YES];
    }
}



- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"选择房源";
    
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, 80 *SIZE)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiteView];
    
    _searchBar = [[UITextField alloc] initWithFrame:CGRectMake(10 *SIZE, 3 *SIZE, 340 *SIZE, 33 *SIZE)];
    _searchBar.backgroundColor = YJBackColor;
    _searchBar.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 11 *SIZE, 0)];
    //设置显示模式为永远显示(默认不显示)
    _searchBar.delegate = self;
    _searchBar.leftViewMode = UITextFieldViewModeAlways;
    _searchBar.placeholder = @"请输入房源标题/编号";
    _searchBar.font = [UIFont systemFontOfSize:12 *SIZE];
    _searchBar.layer.cornerRadius = 2 *SIZE;
    _searchBar.returnKeyType = UIReturnKeySearch;
    
    UIImageView *rightImg = [[UIImageView alloc] initWithFrame:CGRectMake(0 *SIZE, 8 *SIZE, 17 *SIZE, 17 *SIZE)];
    //    rightImg.backgroundColor = [UIColor whiteColor];
    rightImg.image = [UIImage imageNamed:@"search"];
    _searchBar.rightView = rightImg;
    _searchBar.rightViewMode = UITextFieldViewModeUnlessEditing;
    _searchBar.clearButtonMode = UITextFieldViewModeWhileEditing;
    _searchBar.delegate = self;
    [whiteView addSubview:_searchBar];
    
    for (int i = 0; i < 3; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(120 *SIZE * i, 40 *SIZE, 120 *SIZE, 40 *SIZE);
        btn.tag = i + 1;
        [btn addTarget:self action:@selector(ActionTagBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        switch (i) {
            case 0:
            {
                [btn setTitle:@"项目" forState:UIControlStateNormal];
                [btn setTitleColor:YJ86Color forState:UIControlStateNormal];
                btn.titleLabel.font = [UIFont systemFontOfSize:12 *SIZE];
                [btn setImage:[UIImage imageNamed:@"downarrow1"] forState:UIControlStateNormal];
                [btn setImage:[UIImage imageNamed:@"uparrow2"] forState:UIControlStateSelected];
                _proBtn = btn;
                [whiteView addSubview:_proBtn];
                break;
            }
            case 1:
            {
                [btn setTitle:@"价格" forState:UIControlStateNormal];
                [btn setTitleColor:YJ86Color forState:UIControlStateNormal];
                btn.titleLabel.font = [UIFont systemFontOfSize:12 *SIZE];
                [btn setImage:[UIImage imageNamed:@"downarrow1"] forState:UIControlStateNormal];
                [btn setImage:[UIImage imageNamed:@"uparrow2"] forState:UIControlStateSelected];
                _priceBtn = btn;
                [whiteView addSubview:_priceBtn];
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
                [whiteView addSubview:_typeBtn];
                break;
            }
            default:
                break;
        }
    }
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT + 81 *SIZE, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - 81 *SIZE) style:UITableViewStylePlain];
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 120 *SIZE;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.backgroundColor = self.view.backgroundColor;
    _table.delegate = self;
    _table.dataSource = self;
    [self.view addSubview:_table];
    _table.mj_header = [GZQGifHeader headerWithRefreshingBlock:^{
        
        _page = 1;
        [self RequestMethod];
    }];
    
    _table.mj_footer = [GZQGifFooter footerWithRefreshingBlock:^{
        
        [self RequestAddMethod];
    }];
}

- (BoxView *)proView{
    
    if (!_proView) {
        
        _proView = [[BoxView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT + 80 *SIZE, SCREEN_Width, SCREEN_Height - 80 *SIZE - NAVIGATION_BAR_HEIGHT)];
        
        NSMutableArray * tempArr = [NSMutableArray arrayWithArray:_proArr];
        [tempArr insertObject:@{@"id":@"0",@"param":@"不限"} atIndex:0];
        _proView.dataArr = [NSMutableArray arrayWithArray:tempArr];
        [tempArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if (idx == 0) {
                
                [tempArr replaceObjectAtIndex:idx withObject:@(1)];
            }else{
                
                [tempArr replaceObjectAtIndex:idx withObject:@(0)];
            }
        }];
        _proView.selectArr = [NSMutableArray arrayWithArray:tempArr];
        [_proView.mainTable reloadData];
        
        
        WS(weakSelf);
        SS(strongSelf);
        _proView.confirmBtnBlock = ^(NSString *ID, NSString *str) {
            
            if ([str isEqualToString:@"不限"]) {
                
                [strongSelf->_proBtn setTitle:@"项目" forState:UIControlStateNormal];
            }else{
                
                [strongSelf->_proBtn setTitle:str forState:UIControlStateNormal];
            }
//            _is2 = NO;
            _pro = [NSString stringWithFormat:@"%@",ID];
            strongSelf->_proBtn.selected = NO;
            [weakSelf.proView removeFromSuperview];
            [weakSelf RequestMethod];
        };
        
        _proView.cancelBtnBlock = ^{
            
//            _is2 = NO;
            weakSelf.proBtn.selected = NO;
        };
    }
    return _proView;
}


- (PriceSetView *)priceView{

    if (!_priceView) {

        _priceView = [[PriceSetView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT + 80 *SIZE, SCREEN_Width, SCREEN_Height - 80 *SIZE - NAVIGATION_BAR_HEIGHT)];

        
        WS(weakSelf);
        SS(strongSelf);
        _priceView.priceSetViewConfirmBtnBlock = ^(NSString * _Nonnull min, NSString * _Nonnull max) {

            _min = min;
            _max = max;
            
            if ([_min integerValue] == 0 && [_max integerValue] == 0) {
                
                [strongSelf->_priceBtn setTitle:@"价格" forState:UIControlStateNormal];
            }else{
                
                if ([_max integerValue] == 0) {
                    
                    [strongSelf->_priceBtn setTitle:[NSString stringWithFormat:@"%@万以上",strongSelf->_min] forState:UIControlStateNormal];
                }else{
                    
                    [strongSelf->_priceBtn setTitle:[NSString stringWithFormat:@"%@-%@万",strongSelf->_min,strongSelf->_max] forState:UIControlStateNormal];
                }
            }
            strongSelf->_priceBtn.selected = NO;
            [weakSelf.priceView removeFromSuperview];
            [weakSelf RequestMethod];
        };

        _priceView.priceSetViewCancelBtnBlock = ^{

      
            weakSelf.priceBtn.selected = NO;
        };
    }
    return _priceView;
}

- (BoxView *)typeView{
    
    if (!_typeView) {
        
        _typeView = [[BoxView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT + 80 *SIZE, SCREEN_Width, SCREEN_Height - 80 *SIZE - NAVIGATION_BAR_HEIGHT)];
        
        NSMutableArray * tempArr = [NSMutableArray arrayWithArray:_typeArr];
        _typeView.dataArr = [NSMutableArray arrayWithArray:_typeArr];
        [tempArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if (idx == 0) {
                
                [tempArr replaceObjectAtIndex:idx withObject:@(1)];
            }else{
                [tempArr replaceObjectAtIndex:idx withObject:@(0)];
            }
        }];
        _typeView.selectArr = [NSMutableArray arrayWithArray:tempArr];
        [_typeView.mainTable reloadData];
        
        WS(weakSelf);
        SS(strongSelf);
        _typeView.confirmBtnBlock = ^(NSString *ID, NSString *str) {
            
            if ([str isEqualToString:@"不限"]) {
                
                [strongSelf->_typeBtn setTitle:@"类型" forState:UIControlStateNormal];
            }else{
                
                [strongSelf->_typeBtn setTitle:str forState:UIControlStateNormal];
            }
//            _is3 = NO;
            _type = [NSString stringWithFormat:@"%@",ID];
            strongSelf->_typeBtn.selected = NO;
            [weakSelf.typeView removeFromSuperview];
            [weakSelf RequestMethod];
        };
        
        _typeView.cancelBtnBlock = ^{
            
//            _is3 = NO;
            weakSelf.typeBtn.selected = NO;
        };
    }
    return _typeView;
}
@end
