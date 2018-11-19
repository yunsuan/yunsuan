//
//  NomineeVC.m
//  云渠道
//
//  Created by xiaoq on 2018/3/28.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "NomineeVC.h"
#import "RecommendCollCell.h"
#import "NomineeCell.h"
#import "NomineeCell2.h"
#import "NomineeCell3.h"
#import "RecommendCell5.h"
#import "confirmDetailVC.h"
#import "CompleteCustomVC1.h"
#import "InvalidView.h"
#import "NoInvalidVC.h"
#import "NoValidVC.h"
#import "AppealComplaintingVC.h"
#import "AppealComplaintedVC.h"

@interface NomineeVC ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    
    NSInteger _index;
    NSArray *_titleArr;
    NSMutableArray *_unComfirmArr;
    NSMutableArray *_validArr;
    NSMutableArray *_inValidArr;
    NSMutableArray *_appealArr;
    NSInteger _page1;
    NSInteger _page2;
    NSInteger _page3;
    NSInteger _page4;
    BOOL _isLast1;
    BOOL _isLast2;
    BOOL _isLast3;
    BOOL _isLast4;
}
@property (nonatomic , strong) UITableView *MainTableView;

@property (nonatomic, strong) UICollectionView *nomineeColl;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) InvalidView *invalidView;

-(void)initUI;
-(void)initDateSouce;
@end

@implementation NomineeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ActionNomineeReload) name:@"recommendReload" object:nil];
    
    [self initDateSouce];
    [self initUI];
    [self UnComfirmRequest];
}

- (void)ActionNomineeReload{
    
    dispatch_queue_t queue1 = dispatch_queue_create("com.test.gcg.group", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_async(group, queue1, ^{
        
        [self UnComfirmRequest];
        
    });
    dispatch_group_async(group, queue1, ^{
        
        [self ValidRequest];
        
    });
    dispatch_group_async(group, queue1, ^{
        
        [self InValidRequest];
        
    });
    dispatch_group_async(group, queue1, ^{
        
        [self ApealRequest];
        
    });
}

-(void)initDateSouce
{
    
    _page1 = 1;
    _page2 = 1;
    _page3 = 1;
    _page4 = 1;
    _titleArr = @[@"待确认",@"有效",@"无效",@"申诉"];
    _unComfirmArr = [@[] mutableCopy];
    _validArr = [@[] mutableCopy];
    _inValidArr = [@[] mutableCopy];
    _appealArr = [@[] mutableCopy];
}

-(void)UnComfirmRequest{
    
    _isLast1 = NO;
    _MainTableView.mj_footer.state = MJRefreshStateIdle;
    [BaseRequest GET:ProjectWaitConfirm_URL parameters:nil success:^(id resposeObject) {

        [_MainTableView.mj_header endRefreshing];
        
        _page1 = 1;
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [_unComfirmArr removeAllObjects];
            [self SetUnComfirmArr:resposeObject[@"data"][@"data"]];
            if (_page1 == [resposeObject[@"data"][@"last_page"] integerValue]) {
                
                if (_index == 0) {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        _MainTableView.mj_footer.state = MJRefreshStateNoMoreData;
                        _isLast1 = YES;
                    });
                }
            }
        }
        else{
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [_MainTableView.mj_header endRefreshing];
        [self showContent:@"网络错误"];
    }];
}

- (void)UnComfirmRequestAdd{
    
    _page1 += 1;
    [BaseRequest GET:ProjectWaitConfirm_URL parameters:@{@"page":@(_page1)} success:^(id resposeObject) {

        [_MainTableView.mj_footer endRefreshing];
        
       
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [self SetUnComfirmArr:resposeObject[@"data"][@"data"]];
            if (_page1 == [resposeObject[@"data"][@"last_page"] integerValue]) {
                
                if (_index == 0) {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        _MainTableView.mj_footer.state = MJRefreshStateNoMoreData;
                        _isLast1 = YES;
                    });
                }
            }else{
            
                [_MainTableView.mj_footer endRefreshing];
            }
        }
        else{
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [_MainTableView.mj_footer endRefreshing];
        [self showContent:@"网络错误"];
    }];
}

- (void)SetUnComfirmArr:(NSArray *)data{
    
    for (int i = 0; i < data.count; i++) {
        
        NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:data[i]];
        [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            
            if ([obj isKindOfClass:[NSNull class]]) {
                
                [tempDic setObject:@"" forKey:key];
            }
        }];
        
        [_unComfirmArr addObject:tempDic];
    }
    
    [_MainTableView reloadData];
}


- (void)ValidRequest{
    
    _isLast2 = NO;
    _MainTableView.mj_footer.state = MJRefreshStateIdle;
    [BaseRequest GET:ProjectValue_URL parameters:nil success:^(id resposeObject) {

        [_MainTableView.mj_header endRefreshing];
        
        _page2 = 1;
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [_validArr removeAllObjects];
            [self SetValidArr:resposeObject[@"data"][@"data"]];
            if (_page2 == [resposeObject[@"data"][@"last_page"] integerValue]) {
                
                if (_index == 1) {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        _MainTableView.mj_footer.state = MJRefreshStateNoMoreData;
                        _isLast2 = YES;
                    });
                }
            }
        }
        else{
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [_MainTableView.mj_header endRefreshing];
        [self showContent:@"网络错误"];
    }];
}

- (void)ValidRequestAdd{
    
    _page2 += 1;
    [BaseRequest GET:BrokerValue_URL parameters:@{@"page":@(_page2)} success:^(id resposeObject) {

        [_MainTableView.mj_footer endRefreshing];
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [self SetValidArr:resposeObject[@"data"][@"data"]];
            if (_page2 == [resposeObject[@"data"][@"last_page"] integerValue]) {
                
                if (_index == 1) {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        _MainTableView.mj_footer.state = MJRefreshStateNoMoreData;
                        _isLast2 = YES;
                    });
                }
            }else{
              
              [_MainTableView.mj_footer endRefreshing];
            }
        }
        else{
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [_MainTableView.mj_footer endRefreshing];
        [self showContent:@"网络错误"];
    }];
}

- (void)SetValidArr:(NSArray *)data{
    
    for (int i = 0; i < data.count; i++) {
        
        NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:data[i]];
        [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            
            if ([obj isKindOfClass:[NSNull class]]) {
                
                [tempDic setObject:@"" forKey:key];
            }
        }];
        
        [_validArr addObject:tempDic];
    }
    
    [_MainTableView reloadData];
}


- (void)InValidRequest{
    
    _isLast3 = NO;
    _MainTableView.mj_footer.state = MJRefreshStateIdle;
    [BaseRequest GET:ProjectDisabled_URL parameters:nil success:^(id resposeObject) {

        [_MainTableView.mj_header endRefreshing];
        
        _page3 = 1;
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [_inValidArr removeAllObjects];
            [self SetInValidArr:resposeObject[@"data"][@"data"]];
            if (_page3 == [resposeObject[@"data"][@"last_page"] integerValue]) {
                
                if (_index == 2) {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        _MainTableView.mj_footer.state = MJRefreshStateNoMoreData;
                        _isLast3 = YES;
                    });
                }
            }
        }
        else{
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [_MainTableView.mj_header endRefreshing];
        [self showContent:@"网络错误"];
    }];
}

- (void)InValidRequestAdd{
    
    _page3 += 1;
    [BaseRequest GET:BrokerDisabled_URL parameters:@{@"page":@(_page3)} success:^(id resposeObject) {

        [_MainTableView.mj_footer endRefreshing];
        
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [self SetInValidArr:resposeObject[@"data"][@"data"]];
            if (_page3 == [resposeObject[@"data"][@"last_page"] integerValue]) {
                
                if (_index == 2) {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        _MainTableView.mj_footer.state = MJRefreshStateNoMoreData;
                        _isLast3 = YES;
                    });
                }
            }else{
              
                [self showContent:resposeObject[@"msg"]];               
                [_MainTableView.mj_footer endRefreshing];
            }
        }
    } failure:^(NSError *error) {
        
        [_MainTableView.mj_footer endRefreshing];
        [self showContent:@"网络错误"];
    }];
}

- (void)SetInValidArr:(NSArray *)data{
    
    for (int i = 0; i < data.count; i++) {
        
        NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:data[i]];
        [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            
            if ([obj isKindOfClass:[NSNull class]]) {
                
                [tempDic setObject:@"" forKey:key];
            }
        }];
        
        [_inValidArr addObject:tempDic];
    }
    
    [_MainTableView reloadData];
}


- (void)ApealRequest{
    
    _isLast4 = NO;
    _MainTableView.mj_footer.state = MJRefreshStateIdle;
    [BaseRequest GET:ProjectAppealList_URL parameters:nil success:^(id resposeObject) {

        [_MainTableView.mj_header endRefreshing];
        
        _page4 = 1;
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [_appealArr removeAllObjects];
            [self SetApealArr:resposeObject[@"data"][@"data"]];
            if (_page4 == [resposeObject[@"data"][@"last_page"] integerValue]) {
                
                if (_index == 3) {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        _MainTableView.mj_footer.state = MJRefreshStateNoMoreData;
                        _isLast4 = YES;
                    });
                }
            }
        }
        else{
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [_MainTableView.mj_header endRefreshing];
        [self showContent:@"网络错误"];
    }];
}

- (void)ApealRequestAdd{
    
    _page4 += 1;
    [BaseRequest GET:BrokerAppeal_URL parameters:@{@"page":@(_page4)} success:^(id resposeObject) {

        [_MainTableView.mj_footer endRefreshing];
    
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [self SetApealArr:resposeObject[@"data"][@"data"]];
            if (_page4 == [resposeObject[@"data"][@"last_page"] integerValue]) {
                
                if (_index == 3) {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        _MainTableView.mj_footer.state = MJRefreshStateNoMoreData;
                        _isLast4 = YES;
                    });
                }
            }else{
                
                [_MainTableView.mj_footer endRefreshing];
            }
        }
        else{
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [_MainTableView.mj_footer endRefreshing];
        [self showContent:@"网络错误"];
    }];
}

- (void)SetApealArr:(NSArray *)data{
    
    for (int i = 0; i < data.count; i++) {
        
        NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:data[i]];
        [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            
            if ([obj isKindOfClass:[NSNull class]]) {
                
                [tempDic setObject:@"" forKey:key];
            }
        }];
        
        [_appealArr addObject:tempDic];
    }
    
    [_MainTableView reloadData];
}

-(void)initUI
{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"报备的客户";
    self.line.hidden = YES;
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.minimumLineSpacing = 0;
    _flowLayout.minimumInteritemSpacing = 0;
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _flowLayout.itemSize = CGSizeMake(SCREEN_Width / 4, 40 *SIZE);
    
    _nomineeColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, 40 *SIZE) collectionViewLayout:_flowLayout];
    _nomineeColl.backgroundColor = CH_COLOR_white;
    _nomineeColl.delegate = self;
    _nomineeColl.dataSource = self;
    _nomineeColl.bounces = NO;
    [_nomineeColl registerClass:[RecommendCollCell class] forCellWithReuseIdentifier:@"RecommendCollCell"];
    [self.view addSubview:_nomineeColl];
    [_nomineeColl selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:YES scrollPosition:0];
    
    _MainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT + 41 *SIZE, 360*SIZE, SCREEN_Height-NAVIGATION_BAR_HEIGHT - 41 *SIZE) style:UITableViewStylePlain];
    _MainTableView.backgroundColor = YJBackColor;
    _MainTableView.delegate = self;
    _MainTableView.dataSource = self;
    [_MainTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:_MainTableView];
    _MainTableView.mj_header = [GZQGifHeader headerWithRefreshingBlock:^{
        
        if (_index == 0) {
            
            [self UnComfirmRequest];
            
        }else if (_index == 1){
            
            [self ValidRequest];
            
        }else if (_index == 2){
            
            [self InValidRequest];
        }else{
            
            [self ApealRequest];
        }
    }];
    
    _MainTableView.mj_footer = [GZQGifFooter footerWithRefreshingBlock:^{
        
        if (_index == 0) {
            
            [self UnComfirmRequestAdd];
            
        }else if (_index == 1){
            
            [self ValidRequestAdd];
            
        }else if (_index == 2){
            
            [self InValidRequestAdd];
        }else{
            
            [self ApealRequestAdd];
        }
    }];
}




#pragma mark  ---  delegate   ---

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    RecommendCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RecommendCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[RecommendCollCell alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width / 4, 40 *SIZE)];
    }
    cell.titleL.text = _titleArr[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    _index = indexPath.item;
    [self.MainTableView reloadData];
    if (_index == 0) {
        
        if (_unComfirmArr.count) {
            
            [_MainTableView reloadData];
            if (_isLast1) {
                
                _MainTableView.mj_footer.state = MJRefreshStateNoMoreData;
            }else{
                
                _MainTableView.mj_footer.state = MJRefreshStateIdle;
            }
        }else{
            
            [self UnComfirmRequest];
        }
        
    }else if (_index == 1){
        
        if (_validArr.count) {
            
            [_MainTableView reloadData];
            if (_isLast2) {
                
                _MainTableView.mj_footer.state = MJRefreshStateNoMoreData;
            }else{
                
                _MainTableView.mj_footer.state = MJRefreshStateIdle;
            }
        }else{
            
            [self ValidRequest];
        }
    }else if (_index == 2){
        
        if (_inValidArr.count) {
            
            [_MainTableView reloadData];
            if (_isLast3) {
                
                _MainTableView.mj_footer.state = MJRefreshStateNoMoreData;
            }else{
                
                _MainTableView.mj_footer.state = MJRefreshStateIdle;
            }
        }else{
            
            [self InValidRequest];
        }
    }else{
        
        if (_appealArr.count) {
            
            [_MainTableView reloadData];
            if (_isLast4) {
                
                _MainTableView.mj_footer.state = MJRefreshStateNoMoreData;
            }else{
                
                _MainTableView.mj_footer.state = MJRefreshStateIdle;
            }
        }else{
            
            [self ApealRequest];
        }
    }
}


#pragma mark  ---  delegate   ---

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_index == 0) {
        
        return _unComfirmArr.count;
    }else if (_index == 1){
        
        return _validArr.count;
    }else if (_index == 2){
        
        return _inValidArr.count;
    }else{
        
        return _appealArr.count;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_index == 2) {
        
        return 133 *SIZE;
    }else if (_index == 3){
        
        return 103 *SIZE;
    }
    return 128 *SIZE;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        
    if (_index == 0) {
        
        static NSString *CellIdentifier = @"NomineeCell";
        
        NomineeCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[NomineeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.dataDic = _unComfirmArr[indexPath.row];
        cell.tag = indexPath.row;
        cell.phoneBtnBlock = ^(NSInteger index) {
            
            NSString *phone = [_unComfirmArr[index][@"tel"] componentsSeparatedByString:@","][0];
            if (phone.length) {
                
                //获取目标号码字符串,转换成URL
                NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phone]];
                //调用系统方法拨号
                [[UIApplication sharedApplication] openURL:url];
            }else{
                
                [self alertControllerWithNsstring:@"温馨提示" And:@"暂时未获取到联系电话"];
            }
        };
        
       
        return cell;
    }else if (_index == 1){
        
        static NSString *CellIdentifier = @"NomineeCell2";
        
        NomineeCell2 *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[NomineeCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.dataDic = _validArr[indexPath.row];
        cell.tag = indexPath.row;
        cell.phoneBtnBlock = ^(NSInteger index) {
            
            NSString *phone = [_validArr[index][@"tel"] componentsSeparatedByString:@","][0];
            if (phone.length) {
                
                //获取目标号码字符串,转换成URL
                NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phone]];
                //调用系统方法拨号
                [[UIApplication sharedApplication] openURL:url];
            }else{
                
                [self alertControllerWithNsstring:@"温馨提示" And:@"暂时未获取到联系电话"];
            }
        };
        
        return cell;
    }else if(_index == 2){
        
        static NSString *CellIdentifier = @"NomineeCell3";
        
        NomineeCell3 *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[NomineeCell3 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.dataDic = _inValidArr[indexPath.row];
        cell.tag = indexPath.row;
        cell.phoneBtnBlock = ^(NSInteger index) {
            
            NSString *phone = [_inValidArr[index][@"tel"] componentsSeparatedByString:@","][0];
            if (phone.length) {
                
                //获取目标号码字符串,转换成URL
                NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phone]];
                //调用系统方法拨号
                [[UIApplication sharedApplication] openURL:url];
            }else{
                
                [self alertControllerWithNsstring:@"温馨提示" And:@"暂时未获取到联系电话"];
            }
        };
        return cell;
    }else{
        
        static NSString *CellIdentifier = @"RecommendCell5";
        
        RecommendCell5 *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[RecommendCell5 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.dataDic = _appealArr[indexPath.row];
        
        return cell;
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (_index == 0) {
        
        confirmDetailVC *nextVC = [[confirmDetailVC alloc] initWithClientId:_unComfirmArr[indexPath.row][@"client_id"]];
        [self.navigationController pushViewController:nextVC animated:YES];
    }else if(_index == 1) {
        
        NoValidVC *nextVC = [[NoValidVC alloc] initWithClientId:_validArr[indexPath.row][@"client_id"]];
        [self.navigationController pushViewController:nextVC animated:YES];
    }else if(_index == 2){
        
        NoInvalidVC *nextVC = [[NoInvalidVC alloc] initWithClientId:_inValidArr[indexPath.row][@"client_id"]];
        [self.navigationController pushViewController:nextVC animated:YES];
    }else{
        
        if ([_appealArr[indexPath.row][@"state"] isEqualToString:@"处理完成"]) {
            
            AppealComplaintedVC *nextVC = [[AppealComplaintedVC alloc] initWithAppealId:_appealArr[indexPath.row][@"appeal_id"]];
            [self.navigationController pushViewController:nextVC animated:YES];
        }else{
            
            AppealComplaintingVC *nextVC = [[AppealComplaintingVC alloc] initWithAppealId:_appealArr[indexPath.row][@"appeal_id"]];
            [self.navigationController pushViewController:nextVC animated:YES];
        }
    }
}

- (InvalidView *)invalidView{
    
    if (!_invalidView) {
        
        _invalidView = [[InvalidView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    }
    return _invalidView;
}




@end
