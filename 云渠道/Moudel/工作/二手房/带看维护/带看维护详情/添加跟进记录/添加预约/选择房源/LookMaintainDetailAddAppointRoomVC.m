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

#import "RoomReportCollCell.h"

#import "LookMaintainDetailAddAppointRoomCell.h"

@interface LookMaintainDetailAddAppointRoomVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableArray *_arr;
    NSMutableArray *_dataArr;
    NSString *_takeId;
    NSInteger _page;
}
@property (nonatomic, strong) UITextField *searchBar;

@property (nonatomic, strong) UICollectionView *segmentColl;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

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
}

- (void)RequestMethod{
    
    NSMutableDictionary *dic = [@{} mutableCopy];
    [dic setObject:_takeId forKey:@"take_id"];
    [dic setObject:@"1" forKey:@"type"];
    [dic setObject:@(_page) forKey:@"page"];
    
    _table.mj_footer.state = MJRefreshStateIdle;
    [BaseRequest GET:TakeMaintainFollowHouseList_URL parameters:dic success:^(id resposeObject) {
        
        [_table.mj_header endRefreshing];
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue]) {
            
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
    [dic setObject:_takeId forKey:@"take_id"];
    [dic setObject:@"1" forKey:@"type"];
    [dic setObject:@(_page) forKey:@"page"];
    
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
    
    if (data.count < 15) {
        
        _table.mj_footer.state = MJRefreshStateNoMoreData;
    }
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

#pragma mark -- collectionview
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    RoomReportCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RoomReportCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[RoomReportCollCell alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width / 3, 40 *SIZE)];
    }
    cell.titleL.frame = CGRectMake(0, 14 *SIZE, SCREEN_Width / 3, 11 *SIZE);
    cell.line.hidden = YES;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
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
        
        LookMaintainAddLookVC *nextVC = [[LookMaintainAddLookVC alloc] init];
        nextVC.dataDic = self.dataDic;
        [self.navigationController pushViewController:nextVC animated:YES];
    }
}



- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"选择房源";
    
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, 40 *SIZE)];
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
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.itemSize = CGSizeMake(SCREEN_Width / 3, 40 *SIZE);
    _flowLayout.minimumLineSpacing = 0;
    _flowLayout.minimumInteritemSpacing = 0;
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    
    _segmentColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT + 40 *SIZE, SCREEN_Width, 40 *SIZE) collectionViewLayout:_flowLayout];
    _segmentColl.backgroundColor = [UIColor whiteColor];
    _segmentColl.delegate = self;
    _segmentColl.dataSource = self;
    _segmentColl.showsHorizontalScrollIndicator = NO;
    _segmentColl.bounces = NO;
    [_segmentColl registerClass:[RoomReportCollCell class] forCellWithReuseIdentifier:@"RoomReportCollCell"];
    [self.view addSubview:_segmentColl];
    
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

@end
