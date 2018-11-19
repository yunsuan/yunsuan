//
//  SelectStoreVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/9/28.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "SelectStoreVC.h"

//#import "SinglePickView.h"
#import "StoreAddressView.h"

#import "SelectStoreCollCell.h"
#import "SelectStoreCell.h"

@interface SelectStoreVC ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

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
    NSString *_cityCode;
}

@property (nonatomic, strong) UITableView *selecTable;

@property (nonatomic, strong) UITextField *searchBar;

@property (nonatomic, strong) UICollectionView *selectColl;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) UIButton *confirmBtn;
@end

@implementation SelectStoreVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
    [self RequestMethod];
}

- (void)initDataSource{
    
    _cityCode = @"110101";
    _dataArr = [@[] mutableCopy];
    _selectArr = [@[] mutableCopy];
    
    _titleArr = [[NSMutableArray alloc] initWithArray:@[@"北京市",@"不限",@"不限"]];
    _cityArr = [@[] mutableCopy];
    _areaArr = [@[] mutableCopy];
    NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"region" ofType:@"json"]];
    
    NSError *err;
    _AddressArr = [NSJSONSerialization JSONObjectWithData:JSONData
                                                  options:NSJSONReadingMutableContainers
                                                    error:&err];
    _cityArr = [NSMutableArray arrayWithArray:_AddressArr[0][@"city"]];
    _areaArr = [NSMutableArray arrayWithArray:_cityArr[0][@"district"]];
}

- (void)RequestMethod{
    

    [BaseRequest GET:StoreAuthStoreList_URL parameters:@{@"province":_cityCode} success:^(id resposeObject) {
        
        [_dataArr removeAllObjects];
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [self SetData:resposeObject[@"data"][@"data"]];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
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


#pragma mark -- Method

- (void)ActionConfirmBtn:(UIButton *)btn{
    
    if (self.selectStoreVCBlock) {
        
        if (_id.length) {
            
            self.selectStoreVCBlock(_id, _name);
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            
            [self alertControllerWithNsstring:@"温馨提示" And:@"请选择门店"];
        }
    }
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
          
            _cityCode = code;
            [_titleArr replaceObjectAtIndex:0 withObject:name];
            [_titleArr replaceObjectAtIndex:1 withObject:@"不限"];
            [_titleArr replaceObjectAtIndex:2 withObject:@"不限"];
            [collectionView reloadData];
            _cityArr = [NSMutableArray arrayWithArray:nextArr];
            [self RequestMethod];
        };
        [self.view addSubview:view];
    }else if (indexPath.item == 1){
    
        StoreAddressView *view = [[StoreAddressView alloc] initWithFrame:self.view.frame withdata:_cityArr];
        view.storeAddressViewBlock = ^(NSString * _Nonnull code, NSString * _Nonnull name, NSArray * _Nonnull nextArr) {
            
            _cityCode = code;
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
            
            _cityCode = code;
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString * Identifier = @"SelectStoreCell";
    SelectStoreCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (!cell) {
        
        cell = [[SelectStoreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if ([_selectArr[indexPath.row] integerValue] == 1) {
        
        cell.selectImg.image = [UIImage imageNamed:@"selected"];
    }else{
        
        cell.selectImg.image = [UIImage imageNamed:@"default"];
    }
    cell.dataDic = _dataArr[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [_selectArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        [_selectArr replaceObjectAtIndex:idx withObject:@(0)];
    }];
    
    [_selectArr replaceObjectAtIndex:indexPath.row withObject:@(1)];
    
    _name = _dataArr[indexPath.row][@"store_name"];
    _id = [NSString stringWithFormat:@"%@",_dataArr[indexPath.row][@"store_id"]];
    
    [tableView reloadData];
}

- (void)initUI{
    
    
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 160 *SIZE)];
    whiteView.backgroundColor = CH_COLOR_white;
    [self.view addSubview:whiteView];
    
    [whiteView addSubview:self.leftButton];
    [whiteView addSubview:self.maskButton];
    
    UILabel *titleL = [[UILabel alloc] init];
    titleL.center = CGPointMake(SCREEN_Width / 2, STATUS_BAR_HEIGHT+20 );
    titleL.bounds = CGRectMake(0, 0, 180 * sIZE, 30 * sIZE);
    titleL.textAlignment = NSTextAlignmentCenter;
    titleL.textColor = [UIColor blackColor];
    titleL.font = [UIFont systemFontOfSize:17 * sIZE];
    titleL.text = @"选择店铺";
    [whiteView addSubview:titleL];
    
    _searchBar = [[UITextField alloc] initWithFrame:CGRectMake(10 *SIZE, 84 *SIZE, 340 *SIZE, 33 *SIZE)];
    _searchBar.backgroundColor = YJBackColor;
    _searchBar.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 11 *SIZE, 0)];
    //设置显示模式为永远显示(默认不显示)
    _searchBar.leftViewMode = UITextFieldViewModeAlways;
    _searchBar.placeholder = @"请输入公司名称/营业执照号查询";
    _searchBar.font = [UIFont systemFontOfSize:12 *SIZE];
    _searchBar.layer.cornerRadius = 2 *SIZE;
    _searchBar.returnKeyType = UIReturnKeySearch;
    
    UIImageView *rightImg = [[UIImageView alloc] initWithFrame:CGRectMake(0 *SIZE, 8 *SIZE, 17 *SIZE, 17 *SIZE)];
    //    rightImg.backgroundColor = [UIColor whiteColor];
    rightImg.image = [UIImage imageNamed:@"search"];
    _searchBar.rightView = rightImg;
    _searchBar.rightViewMode = UITextFieldViewModeUnlessEditing;
    _searchBar.clearButtonMode = UITextFieldViewModeWhileEditing;
//    _searchBar.delegate = self;
    [whiteView addSubview:_searchBar];
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.minimumLineSpacing = 0;
    _flowLayout.minimumInteritemSpacing = 0;
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _flowLayout.itemSize = CGSizeMake(120 *SIZE, 40 *SIZE);

    _selectColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 120 *SIZE, SCREEN_Width, 40 *SIZE) collectionViewLayout:_flowLayout];
    _selectColl.backgroundColor = CH_COLOR_white;
    _selectColl.delegate = self;
    _selectColl.dataSource = self;
    _selectColl.bounces = NO;
    [_selectColl registerClass:[SelectStoreCollCell class] forCellWithReuseIdentifier:@"SelectStoreCollCell"];
    [whiteView addSubview:_selectColl];
    
    _selecTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 161 *SIZE, SCREEN_Width, SCREEN_Height - 161 *SIZE - 40 *SIZE - TAB_BAR_MORE) style:UITableViewStylePlain];
    
    _selecTable.rowHeight = UITableViewAutomaticDimension;
    _selecTable.estimatedRowHeight = 120 *SIZE;
    _selecTable.backgroundColor = self.view.backgroundColor;
    _selecTable.delegate = self;
    _selecTable.dataSource = self;
    _selecTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_selecTable];
//    _selecTable.mj_header = [GZQGifHeader headerWithRefreshingBlock:^{
//
//        [self RequestMethod];
//    }];
//
//    _selecTable.mj_footer = [GZQGifFooter footerWithRefreshingBlock:^{
//
//        if (_isSearch) {
//
//            [self RequestMethodAdd];
//        }else{
//
//            [self SearchRequest];
//        }
//    }];
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirmBtn.frame = CGRectMake(0, SCREEN_Height - 40 *SIZE - TAB_BAR_MORE, SCREEN_Width, 40 *SIZE + TAB_BAR_MORE);
    _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:14 *sIZE];
    [_confirmBtn addTarget:self action:@selector(ActionConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [_confirmBtn setBackgroundColor:YJBlueBtnColor];
    [self.view addSubview:_confirmBtn];
}


@end
