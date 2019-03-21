//
//  StoreListVC.m
//  云渠道
//
//  Created by xiaoq on 2019/1/24.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "StoreListVC.h"
#import "StoreAddressView.h"
#import "LocationManager.h"
#import "StoreDetailVC.h"
#import "StoreListCell.h"
#import "SelectStoreCollCell.h"
#import "SHRecommenView.h"
#import "SHRecomenSucessView.h"
#import "FailView.h"


@interface StoreListVC ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UITextFieldDelegate>
{
    
    NSString *_province;
    NSString *_city;
    NSString *_area;
    NSString *_name;
    NSString *_id;
    NSMutableArray *_dataArr;
    NSMutableArray *_selectArr;
    NSArray *_AddressArr;
    NSMutableArray *_cityArr;
    NSMutableArray *_areaArr;
    NSMutableArray *_titleArr;
    BOOL _isSearch;
    NSInteger _page;
    //    NSString *_cityCode;
}

@property (nonatomic, strong) UITableView *selecTable;

@property (nonatomic, strong) UITextField *searchBar;

@property (nonatomic, strong) UICollectionView *selectColl;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) SHRecommenView *recommendView;

@property (nonatomic, strong) FailView *failView;


@end

@implementation StoreListVC



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
    [self RequestMethod];
}

- (void)initDataSource{
    
    if ([LocationManager GetCityCode]) {
        
        _province = [NSString stringWithFormat:@"%@0000",[[LocationManager GetCityCode] substringToIndex:2]];
    }else{
        
        _province = @"110000";
    }
    
    _dataArr = [@[] mutableCopy];
    _selectArr = [@[] mutableCopy];
    
    _cityArr = [@[] mutableCopy];
    _areaArr = [@[] mutableCopy];
    
    NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"region" ofType:@"json"]];
    
    NSError *err;
    _AddressArr = [NSJSONSerialization JSONObjectWithData:JSONData
                                                  options:NSJSONReadingMutableContainers
                                                    error:&err];
    _cityArr = [NSMutableArray arrayWithArray:_AddressArr[0][@"city"]];
    _areaArr = [NSMutableArray arrayWithArray:_cityArr[0][@"district"]];
    
    NSString *str;
    if ([LocationManager GetCityName]) {
        
        str = [NSString stringWithFormat:@"%@0000",[[LocationManager GetCityCode] substringToIndex:2]];
        for (int i = 0; i < _AddressArr.count; i++) {
            
            if ([_province integerValue] == [_AddressArr[i][@"code"] integerValue]) {
                
                _cityArr = [NSMutableArray arrayWithArray:_AddressArr[i][@"city"]];
                break;
            }
        }
    }
    if ([LocationManager GetCityName]) {
        
        NSString *proName;
        for (int i = 0; i < _AddressArr.count; i++) {
            
            if ([str integerValue] == [_AddressArr[i][@"code"] integerValue]) {
                
                proName = _AddressArr[i][@"name"];
                break;
            }
        }
        _titleArr = [[NSMutableArray alloc] initWithArray:@[proName,@"不限",@"不限"]];
    }else{
        
        _titleArr = [[NSMutableArray alloc] initWithArray:@[@"北京",@"不限",@"不限"]];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    _page = 1;
    if (textField.text) {
         _isSearch = YES;
        [self SearchRequest];

    }else{
        
        [self RequestMethod];
    }
    return YES;
}

- (void)RequestMethod{
    
    _page = 1;
    _selecTable.mj_footer.state = MJRefreshStateIdle;
    NSDictionary *dic;
    
    if (_area.length) {
        
        dic = @{@"province":_province,
                @"city":_city,
                @"district":_area,
                @"type":_type
                
                };
    }else if (_city.length){
        
        dic = @{@"province":_province,
                @"city":_city,
                @"type":_type
                };
    }else{
        
        dic = @{@"province":_province,
                @"type":_type
                };
    }
    [BaseRequest GET:AllStore_URL parameters:dic success:^(id resposeObject) {
        
        [_dataArr removeAllObjects];
        [_selecTable reloadData];
        NSLog(@"%@",resposeObject);
        
        [_selecTable.mj_header endRefreshing];
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if ([resposeObject[@"data"][@"data"] count]) {
                
                _selecTable.mj_footer.state = MJRefreshStateIdle;
                [self SetData:resposeObject[@"data"][@"data"]];
            }else{
                
                _selecTable.mj_footer.state = MJRefreshStateNoMoreData;
            }
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [_selecTable.mj_header endRefreshing];
        [self showContent:@"网络错误"];
        NSLog(@"%@",error.localizedDescription);
    }];
}

- (void)RequestAddMethod{
    
    NSDictionary *dic;
    
    _page += 1;
    if (_area.length) {
        
        dic = @{@"province":_province,
                @"city":_city,
                @"district":_area,
                @"type":_type
                };
    }else if (_city.length){
        
        dic = @{@"province":_province,
                @"city":_city,
                @"type":_type
                };
    }else{
        
        dic = @{@"province":_province,
                @"type":_type
                };
    }
    NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:dic];
    [tempDic setObject:@(_page) forKey:@"page"];
    
    [BaseRequest GET:AllStore_URL parameters:tempDic success:^(id resposeObject) {
        
//        [_dataArr removeAllObjects];
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if ([resposeObject[@"data"][@"data"] count]) {
                
                _selecTable.mj_footer.state = MJRefreshStateIdle;
                [self SetData:resposeObject[@"data"][@"data"]];
            }else{
                
                _selecTable.mj_footer.state = MJRefreshStateNoMoreData;
            }
        }else{
            
            [_selecTable.mj_footer endRefreshing];
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [_selecTable.mj_footer endRefreshing];
        [self showContent:@"网络错误"];
        NSLog(@"%@",error.localizedDescription);
    }];
}

- (void)SearchRequest{
    
    NSDictionary *dic;
    
    if (_area.length) {
        
        dic = @{@"province":_province,
                @"city":_city,
                @"district":_area,
                @"store_name":_searchBar.text,
                @"type":_type
                };
    }else if (_city.length){
        
        dic = @{@"province":_province,
                @"city":_city,
                @"store_name":_searchBar.text,
                @"type":_type
                };
    }else{
        
        dic = @{@"province":_province,
                @"store_name":_searchBar.text,
                @"type":_type
                };
    }
    NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:dic];
    [tempDic setObject:@(_page) forKey:@"page"];
    
    if (_page == 1) {
        
        _selecTable.mj_footer.state = MJRefreshStateIdle;
        [_dataArr removeAllObjects];
        [_selecTable reloadData];
    }
    
    [BaseRequest GET:AllStore_URL parameters:dic success:^(id resposeObject) {
        
        
        NSLog(@"%@",resposeObject);
        [_selecTable.mj_header endRefreshing];
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if ([resposeObject[@"data"][@"data"] count]) {
                
                _selecTable.mj_footer.state = MJRefreshStateIdle;
                [self SetData:resposeObject[@"data"][@"data"]];
            }else{
                
                _selecTable.mj_footer.state = MJRefreshStateNoMoreData;
            }
        }else{
            
            [_selecTable.mj_footer endRefreshing];
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [_selecTable.mj_header endRefreshing];
        [_selecTable.mj_footer endRefreshing];
        [self showContent:@"网络错误"];
        NSLog(@"%@",error.localizedDescription);
    }];
}

- (void)SetData:(NSArray *)data{
    
    for (int i = 0; i < data.count; i++) {
        
        NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:data[i]];
        [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            
            if ([obj isKindOfClass:[NSNull class]]) {
                
                [tempDic setObject:@"" forKey:key];
            }
        }];
        
        [_selectArr addObject:@(0)];
        [_dataArr addObject:tempDic];
    }
    
    [_selecTable reloadData];
}

#pragma mark --action --
-(void)action_recoment:(UIButton *)sender
{

    [self.view addSubview:self.recommendView];
    if ([_sex integerValue]==2) {
        _recommendView.sexBtn.content.text =@"女";
        _recommendView.sexBtn->str = @"2";
    }
    else{
    _recommendView.sexBtn.content.text =@"男";
    _recommendView.sexBtn->str = @"1";
    }
    _recommendView.nameTF.textfield.text = _name;
    _recommendView.phoneTF.textfield.text = _tel;
    _recommendView.markTV.text =@"";
    [_recommendView.sexBtn addTarget:self action:@selector(action_sex) forControlEvents:UIControlEventTouchUpInside];
    WS(weakself);
    _recommendView.recommendViewConfirmBlock = ^{
        if (![weakself checkTel:_recommendView.phoneTF.textfield.text] ) {
            [weakself showContent:@"请输入正确的电话号码"];
        }
        else{
        NSDictionary *dic = @{@"client_id":_client_id,
                              @"store_id":[NSString stringWithFormat:@"%ld",sender.tag],
                              @"type":_type,
                              @"name":_recommendView.nameTF.textfield.text,
                              @"tel":_recommendView.phoneTF.textfield.text,
                              @"sex":_recommendView.sexBtn->str,
                              @"comment":_recommendView.markTV.text
                              };
        
        [BaseRequest POST:SCReconment_URL parameters:dic success:^(id resposeObject) {
            if ([resposeObject[@"code"] integerValue]==200) {
                SHRecomenSucessView *view =[[SHRecomenSucessView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
                view.codeL.text = [NSString stringWithFormat:@"推荐编号：%@",resposeObject[@"data"][@"recommend_code"]];
                view.nameL.text = [NSString stringWithFormat:@"客户名称：%@",resposeObject[@"data"][@"client_name"]];
                view.phoneL.text = [NSString stringWithFormat:@"联系电话：%@",resposeObject[@"data"][@"client_tel"]];
                view.timeL.text = resposeObject[@"data"][@"recommend_time"];
                [self.view addSubview:view];
            }
        } failure:^(NSError *error) {
            
        }];
        }
    };
    
}

-(void)action_sex
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"性别" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *male = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        _recommendView.sexBtn.content.text = @"男";
        _recommendView.sexBtn->str = @"1";
    }];
    
    UIAlertAction *female = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        _recommendView.sexBtn.content.text = @"女";
        _recommendView.sexBtn->str =@"2";
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:male];
    [alert addAction:female];
    [alert addAction:cancel];
    [self.navigationController presentViewController:alert animated:YES completion:^{
        
    }];
}


#pragma mark --coll代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SelectStoreCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SelectStoreCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[SelectStoreCollCell alloc] initWithFrame:CGRectMake(0, 0, 120 *SIZE, 40 *SIZE)];
    }
    cell.typeL.text = _titleArr[indexPath.item];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.item == 0) {
        
        //        WS(weakSelf);
        //        SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.frame WithData:[self getDetailConfigArrByConfigState:12]];
        //        view.selectedBlock = ^(NSString *MC, NSString *ID) {
        //
        //        };
        //        [self.view addSubview:view];
        StoreAddressView *view = [[StoreAddressView alloc] initWithFrame:self.view.frame withdata:_AddressArr];
        view.storeAddressViewBlock = ^(NSString * _Nonnull code, NSString * _Nonnull name, NSArray * _Nonnull nextArr) {
            
            _isSearch = NO;
            _area = @"";
            _city = @"";
            _province = code;
            [_titleArr replaceObjectAtIndex:0 withObject:name];
            [_titleArr replaceObjectAtIndex:1 withObject:@"不限"];
            [_titleArr replaceObjectAtIndex:2 withObject:@"不限"];
            [collectionView reloadData];
            _cityArr = [NSMutableArray arrayWithArray:nextArr];
            [self RequestMethod];
        };
        [self.view addSubview:view];
    }else if (indexPath.item == 1){
        
        if (!_cityArr.count) {
            
            if (_province.length) {
                
                for (int i = 0; i < _AddressArr.count; i++) {
                    
                    if ([_province integerValue] == [_AddressArr[i][@"code"] integerValue]) {
                        
                        _cityArr = [NSMutableArray arrayWithArray:_AddressArr[i][@"city"]];
                        break;
                    }
                }
            }
        }
        
        StoreAddressView *view = [[StoreAddressView alloc] initWithFrame:self.view.frame withdata:_cityArr];
        view.storeAddressViewBlock = ^(NSString * _Nonnull code, NSString * _Nonnull name, NSArray * _Nonnull nextArr) {
            
            _isSearch = NO;
            _area = @"";
            _city = code;
            [_titleArr replaceObjectAtIndex:1 withObject:name];
            [_titleArr replaceObjectAtIndex:2 withObject:@"不限"];
            _areaArr = [NSMutableArray arrayWithArray:nextArr];
            [collectionView reloadData];
            [self RequestMethod];
        };
        [self.view addSubview:view];
    }else{
        
        StoreAddressView *view = [[StoreAddressView alloc] initWithFrame:self.view.frame withdata:_areaArr];
        view.storeAddressViewBlock = ^(NSString * _Nonnull code, NSString * _Nonnull name, NSArray * _Nonnull nextArr) {
            
            _isSearch = NO;
            _area = code;
            [_titleArr replaceObjectAtIndex:2 withObject:name];
            //            _areaArr = [NSMutableArray arrayWithArray:nextArr];
            [collectionView reloadData];
            [self RequestMethod];
        };
        [self.view addSubview:view];
    }
}

#pragma mark --table代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    return 100 *SIZE;
//}

//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 110;
//}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString * Identifier = @"StoreListCell";
    StoreListCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (!cell) {
        
        cell = [[StoreListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    [cell setDataBydata:_dataArr[indexPath.row] type:_type];
    [cell.recomentBtn addTarget:self action:@selector(action_recoment:) forControlEvents:UIControlEventTouchUpInside];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
 
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    StoreDetailVC *vc = [[StoreDetailVC alloc]init];
    vc.store_id = _dataArr[indexPath.row][@"store_id"];
    vc.client_id = _client_id;
    vc.type = _type;
    vc.name = _name;
    vc.tel =_tel;
    vc.sex =_sex;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)initUI{
    
    
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 160 *SIZE)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiteView];
    
    [whiteView addSubview:self.leftButton];
    [whiteView addSubview:self.maskButton];
    
    UILabel *titleL = [[UILabel alloc] init];
    titleL.center = CGPointMake(SCREEN_Width / 2, STATUS_BAR_HEIGHT+20 );
    titleL.bounds = CGRectMake(0, 0, 180 * SIZE, 30 * SIZE);
    titleL.textAlignment = NSTextAlignmentCenter;
    titleL.textColor = [UIColor blackColor];
    titleL.font = [UIFont systemFontOfSize:17 * SIZE];
    titleL.text = @"全部门店";
    [whiteView addSubview:titleL];
    
    _searchBar = [[UITextField alloc] initWithFrame:CGRectMake(10 *SIZE, 84 *SIZE, 340 *SIZE, 33 *SIZE)];
    _searchBar.backgroundColor = YJBackColor;
    _searchBar.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 11 *SIZE, 0)];
    //设置显示模式为永远显示(默认不显示)
    _searchBar.leftViewMode = UITextFieldViewModeAlways;
    _searchBar.placeholder = @"请输入门店名称";
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
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.minimumLineSpacing = 0;
    _flowLayout.minimumInteritemSpacing = 0;
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _flowLayout.itemSize = CGSizeMake(120 *SIZE, 40 *SIZE);
    
    _selectColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 120 *SIZE, SCREEN_Width, 40 *SIZE) collectionViewLayout:_flowLayout];
    _selectColl.backgroundColor = [UIColor whiteColor];
    _selectColl.delegate = self;
    _selectColl.dataSource = self;
    _selectColl.bounces = NO;
    [_selectColl registerClass:[SelectStoreCollCell class] forCellWithReuseIdentifier:@"SelectStoreCollCell"];
    [whiteView addSubview:_selectColl];
    
    _selecTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 161 *SIZE, SCREEN_Width, SCREEN_Height -161 *SIZE) style:UITableViewStylePlain];
    _selecTable.estimatedRowHeight = 180 *SIZE;
    _selecTable.rowHeight = UITableViewAutomaticDimension;
    _selecTable.backgroundColor = self.view.backgroundColor;
    _selecTable.delegate = self;
    _selecTable.dataSource = self;
    _selecTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_selecTable];
    _selecTable.mj_header = [GZQGifHeader headerWithRefreshingBlock:^{
        
        _page = 1;
        if (_isSearch) {
        
            [self SearchRequest];
        }else{
            
            [self RequestMethod];
        }
    }];
    
    _selecTable.mj_footer = [GZQGifFooter footerWithRefreshingBlock:^{
        
        _page += 1;
        if (_isSearch) {
        
            [self SearchRequest];
        }else{
            
            [self RequestAddMethod];
        }
    }];
    

}


- (FailView *)failView{
    
    if (!_failView) {
        
        _failView = [[FailView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    }
    return _failView;
}

- (SHRecommenView *)recommendView{
    
    if (!_recommendView) {
        
        _recommendView = [[SHRecommenView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];

    }
    return _recommendView;
}



@end

