//
//  RecommendVC.m
//  云渠道
//
//  Created by xiaoq on 2018/3/28.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RecommendVC.h"
#import "RecommendCell.h"
#import "RecommendCell3.h"
#import "RecommendCell5.h"
#import "RecommendCollCell.h"
#import "UnconfirmDetailVC.h"
#import "InvalidVC.h"
#import "ValidVC.h"
//#import "ComplaintVC.h"
#import "ComplaintUnCompleteVC.h"
#import "ComplaintCompleteVC.h"
//#import "confirmDetailVC.h"
#import "CompleteCustomVC1.h"
#import "InvalidView.h"
#import "QuickAddAndRecommendVC.h"


@interface RecommendVC ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
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

@property (nonatomic, strong) UICollectionView *recommendColl;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

//@property (nonatomic, strong) InvalidView *invalidView;

-(void)initUI;
-(void)initDateSouce;

@end

@implementation RecommendVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ActionRecommendReload) name:@"recommendReload" object:nil];
    self.view.backgroundColor = YJBackColor;
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"新房推荐";
    [self initDateSouce];
    [self initUI];
    [self UnComfirmRequest];
}

- (void)ActionRecommendReload{
    
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(InValidRequest) name:@"inValidReload" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ApealRequest) name:@"appealReload" object:nil];
    _titleArr = @[@"确认中",@"有效",@"无效",@"申诉"];
    _unComfirmArr = [@[] mutableCopy];
    _validArr = [@[] mutableCopy];
    _inValidArr = [@[] mutableCopy];
    _appealArr = [@[] mutableCopy];
}

- (void)UnComfirmRequest{
    
    if ([[UserModel defaultModel].agent_identity integerValue] == 1) {
        
        _isLast1 = NO;
        _MainTableView.mj_footer.state = MJRefreshStateIdle;
        [BaseRequest GET:BrokerWaitConfirm_URL parameters:nil success:^(id resposeObject) {
            
            [_MainTableView.mj_header endRefreshing];
            
            _page1 = 1;
            
            if ([resposeObject[@"code"] integerValue] == 200) {
                
                [_unComfirmArr removeAllObjects];
                [self SetUnComfirmArr:resposeObject[@"data"][@"data"]];
                if (_page1 >= [resposeObject[@"data"][@"last_page"] integerValue]) {
                    
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
    }else{
        
        _isLast1 = NO;
        _MainTableView.mj_footer.state = MJRefreshStateIdle;
        [BaseRequest GET:ButterWaitConfirm_URL parameters:nil success:^(id resposeObject) {
            
            [_MainTableView.mj_header endRefreshing];
            
            _page1 = 1;
            
            if ([resposeObject[@"code"] integerValue] == 200) {
                
                [_unComfirmArr removeAllObjects];
                [self SetUnComfirmArr:resposeObject[@"data"][@"data"]];
                if (_page1 >= [resposeObject[@"data"][@"last_page"] integerValue]) {
                    
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
}

- (void)UnComfirmRequestAdd{
    
    if ([[UserModel defaultModel].agent_identity integerValue] == 1) {
        
        _page1 += 1;
        [BaseRequest GET:BrokerWaitConfirm_URL parameters:@{@"page":@(_page1)} success:^(id resposeObject) {
            
            [_MainTableView.mj_footer endRefreshing];
            
            
            if ([resposeObject[@"code"] integerValue] == 200) {
                
                [self SetUnComfirmArr:resposeObject[@"data"][@"data"]];
                if (_page1 >= [resposeObject[@"data"][@"last_page"] integerValue]) {
                    
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
    }else{
        
        _page1 += 1;
        [BaseRequest GET:ButterWaitConfirm_URL parameters:@{@"page":@(_page1)} success:^(id resposeObject) {
            
            [_MainTableView.mj_footer endRefreshing];
            
            
            if ([resposeObject[@"code"] integerValue] == 200) {
                
                [self SetUnComfirmArr:resposeObject[@"data"][@"data"]];
                if (_page1 >= [resposeObject[@"data"][@"last_page"] integerValue]) {
                    
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
    
    if ([[UserModel defaultModel].agent_identity integerValue] == 1) {
        
        _isLast2 = NO;
        _MainTableView.mj_footer.state = MJRefreshStateIdle;
        [BaseRequest GET:BrokerValue_URL parameters:nil success:^(id resposeObject) {
            
            [_MainTableView.mj_header endRefreshing];
            
            _page2 = 1;
            if ([resposeObject[@"code"] integerValue] == 200) {
                
                [_validArr removeAllObjects];
                [self SetValidArr:resposeObject[@"data"][@"data"]];
                if (_page2 >= [resposeObject[@"data"][@"last_page"] integerValue]) {
                    
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
    }else{
        
        _isLast2 = NO;
        _MainTableView.mj_footer.state = MJRefreshStateIdle;
        [BaseRequest GET:ButterValue_URL parameters:nil success:^(id resposeObject) {
            
            [_MainTableView.mj_header endRefreshing];
            
            _page2 = 1;
            if ([resposeObject[@"code"] integerValue] == 200) {
                
                [_validArr removeAllObjects];
                [self SetValidArr:resposeObject[@"data"][@"data"]];
                if (_page2 >= [resposeObject[@"data"][@"last_page"] integerValue]) {
                    
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
}

- (void)ValidRequestAdd{
    
    if ([[UserModel defaultModel].agent_identity integerValue] == 1) {
        
        _page2 += 1;
        [BaseRequest GET:BrokerValue_URL parameters:@{@"page":@(_page2)} success:^(id resposeObject) {
            
            [_MainTableView.mj_footer endRefreshing];
            
            
            if ([resposeObject[@"code"] integerValue] == 200) {
                
                [self SetValidArr:resposeObject[@"data"][@"data"]];
                if (_page2 >= [resposeObject[@"data"][@"last_page"] integerValue]) {
                    
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
    }else{
        
        _page2 += 1;
        [BaseRequest GET:ButterValue_URL parameters:@{@"page":@(_page2)} success:^(id resposeObject) {
            
            [_MainTableView.mj_footer endRefreshing];
            
            
            if ([resposeObject[@"code"] integerValue] == 200) {
                
                [self SetValidArr:resposeObject[@"data"][@"data"]];
                if (_page2 >= [resposeObject[@"data"][@"last_page"] integerValue]) {
                    
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
    
    if ([[UserModel defaultModel].agent_identity integerValue] == 1) {
        
        _isLast3 = NO;
        _MainTableView.mj_footer.state = MJRefreshStateIdle;
        [BaseRequest GET:BrokerDisabled_URL parameters:nil success:^(id resposeObject) {
            
            [_MainTableView.mj_header endRefreshing];
            
            _page3 = 1;
            if ([resposeObject[@"code"] integerValue] == 200) {
                
                [_inValidArr removeAllObjects];
                [self SetInValidArr:resposeObject[@"data"][@"data"]];
                if (_page3 >= [resposeObject[@"data"][@"last_page"] integerValue]) {
                    
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
    }else{
        
        _isLast3 = NO;
        _MainTableView.mj_footer.state = MJRefreshStateIdle;
        [BaseRequest GET:ButterDisabled_URL parameters:nil success:^(id resposeObject) {
            
            [_MainTableView.mj_header endRefreshing];
            
            _page3 = 1;
            if ([resposeObject[@"code"] integerValue] == 200) {
                
                [_inValidArr removeAllObjects];
                [self SetInValidArr:resposeObject[@"data"][@"data"]];
                if (_page3 >= [resposeObject[@"data"][@"last_page"] integerValue]) {
                    
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
}

- (void)InValidRequestAdd{
    
    if ([[UserModel defaultModel].agent_identity integerValue] == 1) {
        
        _page3 += 1;
        [BaseRequest GET:BrokerDisabled_URL parameters:@{@"page":@(_page3)} success:^(id resposeObject) {
            
            [_MainTableView.mj_footer endRefreshing];
            
            
            if ([resposeObject[@"code"] integerValue] == 200) {
                
                [self SetInValidArr:resposeObject[@"data"][@"data"]];
                if (_page3 >= [resposeObject[@"data"][@"last_page"] integerValue]) {
                    
                    if (_index == 2) {
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                            _MainTableView.mj_footer.state = MJRefreshStateNoMoreData;
                            _isLast3 = YES;
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
    }else{
        
        _page3 += 1;
        [BaseRequest GET:ButterDisabled_URL parameters:@{@"page":@(_page3)} success:^(id resposeObject) {
            
            [_MainTableView.mj_footer endRefreshing];
            
            
            if ([resposeObject[@"code"] integerValue] == 200) {
                
                [self SetInValidArr:resposeObject[@"data"][@"data"]];
                if (_page3 >= [resposeObject[@"data"][@"last_page"] integerValue]) {
                    
                    if (_index == 2) {
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                            _MainTableView.mj_footer.state = MJRefreshStateNoMoreData;
                            _isLast3 = YES;
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
    
    if ([[UserModel defaultModel].agent_identity integerValue] == 1) {
        
        _isLast4 = NO;
        _MainTableView.mj_footer.state = MJRefreshStateIdle;
        [BaseRequest GET:BrokerAppeal_URL parameters:nil success:^(id resposeObject) {
            
            [_MainTableView.mj_header endRefreshing];
            
            _page4 = 1;
            if ([resposeObject[@"code"] integerValue] == 200) {
                
                [_appealArr removeAllObjects];
                [self SetApealArr:resposeObject[@"data"][@"data"]];
                if (_page4 >= [resposeObject[@"data"][@"last_page"] integerValue]) {
                    
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
    }else{
        
        [_appealArr removeAllObjects];
        [_MainTableView.mj_header endRefreshing];
        [_MainTableView reloadData];
    }
}

- (void)ApealRequestAdd{
    
    if ([[UserModel defaultModel].agent_identity integerValue] == 1) {
        
        _page4 += 1;
        [BaseRequest GET:BrokerAppeal_URL parameters:@{@"page":@(_page4)} success:^(id resposeObject) {
            
            [_MainTableView.mj_footer endRefreshing];
            
            
            if ([resposeObject[@"code"] integerValue] == 200) {
                
                [self SetApealArr:resposeObject[@"data"][@"data"]];
                if (_page4 >= [resposeObject[@"data"][@"last_page"] integerValue]) {
                    
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
    }else{
        
        [_appealArr removeAllObjects];
        _MainTableView.mj_footer.state = MJRefreshStateNoMoreData;
        _isLast4 = YES;
        [_MainTableView reloadData];
    }
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

-(void)action_add
{
    
    QuickAddAndRecommendVC *nextVC = [[QuickAddAndRecommendVC alloc] init];
    [self.navigationController pushViewController:nextVC animated:YES];
}


-(void)initUI
{
    
    if ([[UserModel defaultModel].agent_identity integerValue] ==1) {
        self.rightBtn.hidden = NO;
    }else{
        self.rightBtn.hidden = YES;
    }
  
    [self.rightBtn setImage:[UIImage imageNamed:@"add_3"] forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(action_add) forControlEvents:UIControlEventTouchUpInside];
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.minimumLineSpacing = 0;
    _flowLayout.minimumInteritemSpacing = 0;
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _flowLayout.itemSize = CGSizeMake(SCREEN_Width / 4, 40 *SIZE);
    
    _recommendColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, 40 *SIZE) collectionViewLayout:_flowLayout];
    _recommendColl.backgroundColor = [UIColor whiteColor];
    _recommendColl.delegate = self;
    _recommendColl.dataSource = self;
    _recommendColl.bounces = NO;
    [_recommendColl registerClass:[RecommendCollCell class] forCellWithReuseIdentifier:@"RecommendCollCell"];
    [self.view addSubview:_recommendColl];
    [_recommendColl selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:YES scrollPosition:0];
    
    [self.view addSubview:self.MainTableView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    RecommendCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RecommendCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[RecommendCollCell alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width /4, 40 *SIZE)];
    }
    cell.titleL.text = _titleArr[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    _index = indexPath.item;
    [self.MainTableView reloadData];
    if (_index == 0) {
        
        self.rightBtn.hidden = NO;
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
        
        self.rightBtn.hidden = YES;
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
        
        self.rightBtn.hidden = YES;
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
        
        self.rightBtn.hidden = YES;
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

//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    if (_index == 0) {
//
//        return 132 *SIZE;
//
//    }else if (_index < 3){
//
//        return 107 *SIZE;
//    }else{
//
//        return 103 *SIZE;
//    }
//}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_index == 0) {
        
        static NSString *CellIdentifier = @"RecommendCell";
        
        RecommendCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[RecommendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.dataDic = _unComfirmArr[indexPath.row];
        
        cell.tag = indexPath.row;
        
        cell.confirmBtnBlock = ^(NSInteger index) {
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认到访" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
            
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            UIAlertAction *valid = [UIAlertAction actionWithTitle:@"已到访" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                NSDictionary *dic = _unComfirmArr[index];
                CompleteCustomVC1 *nextVC = [[CompleteCustomVC1 alloc] initWithClientID:dic[@"client_id"] name:dic[@"name"] dataDic:dic];
                [self.navigationController pushViewController:nextVC animated:YES];
            }];
            
            UIAlertAction *invalid = [UIAlertAction actionWithTitle:@"未到访" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                InvalidView * invalidView = [[InvalidView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
                invalidView.client_id = _unComfirmArr[indexPath.row][@"client_id"];
                invalidView.invalidViewBlock = ^(NSDictionary *dic) {
                    
                    [BaseRequest POST:ConfirmDisabled_URL parameters:dic success:^(id resposeObject) {
                        
                        if ([resposeObject[@"code"] integerValue] == 200) {
                            
                            [self alertControllerWithNsstring:@"失效确认成功" And:nil];
                            [[NSNotificationCenter defaultCenter] postNotificationName:@"recommendReload" object:nil];
                            
                        }else{
                            
                            [self alertControllerWithNsstring:@"温馨提示" And:resposeObject[@"msg"]];
                        }
                    } failure:^(NSError *error) {
                        
                        [self alertControllerWithNsstring:@"温馨提示" And:@"操作失败" WithDefaultBlack:^{
                            
                        }];
                    }];
                };
                
                invalidView.invalidViewBlockFail = ^(NSString *str) {
                    
                    [self alertControllerWithNsstring:@"温馨提示" And:str];
                };
                [[UIApplication sharedApplication].keyWindow addSubview:invalidView];
            }];
            
            [alert addAction:valid];
            [alert addAction:invalid];
            [alert addAction:cancel];
            [self.navigationController presentViewController:alert animated:YES completion:^{
                
            }];
        };
        
        return cell;
    }else if (_index < 3){
        
        static NSString *CellIdentifier = @"RecommendCell3";
        
        RecommendCell3 *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[RecommendCell3 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (_index == 1) {
            
            cell.dataDic = _validArr[indexPath.row];
            cell.tag = indexPath.row;
            cell.phoneBtnBlock = ^(NSInteger index) {
                
                if ([_validArr[index][@"tel_complete_state"] integerValue] <= 2) {
                    
                    NSString *phone = [_validArr[index][@"tel"] componentsSeparatedByString:@","][0];
                    if (phone.length) {
                        
                        //获取目标号码字符串,转换成URL
                        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phone]];
                        //调用系统方法拨号
                        [[UIApplication sharedApplication] openURL:url];
                    }else{
                        
                        [self alertControllerWithNsstring:@"温馨提示" And:@"暂时未获取到联系电话"];
                    }
                }else{
                    
                    
                }
            };
        }else{
            
            cell.inValidDic = _inValidArr[indexPath.row];
            cell.tag = indexPath.row;
            cell.phoneBtnBlock = ^(NSInteger index) {
                
                if ([_inValidArr[index][@"tel_complete_state"] integerValue] <= 2) {
                    
                    NSString *phone = [_inValidArr[index][@"tel"] componentsSeparatedByString:@","][0];
                    if (phone.length) {
                        
                        //获取目标号码字符串,转换成URL
                        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phone]];
                        //调用系统方法拨号
                        [[UIApplication sharedApplication] openURL:url];
                    }else{
                        
                        [self alertControllerWithNsstring:@"温馨提示" And:@"暂时未获取到联系电话"];
                    }
                }else{
                    
                    
                }
            };
        }
        
        
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
        
        UnconfirmDetailVC *nextVC = [[UnconfirmDetailVC alloc] initWithString:_unComfirmArr[indexPath.row][@"client_id"]];
        
        [self.navigationController pushViewController:nextVC animated:YES];
    }
    
    if (_index == 1) {
        
        ValidVC *nextVC = [[ValidVC alloc] initWithClientId:_validArr[indexPath.row][@"client_id"]];
        [self.navigationController pushViewController:nextVC animated:YES];
    }
    if (_index == 2) {
        
        
        InvalidVC *nextVC = [[InvalidVC alloc] initWithClientId:_inValidArr[indexPath.row][@"client_id"]];
        [self.navigationController pushViewController:nextVC animated:YES];
    }
    if (_index == 3) {
        
        if ([_appealArr[indexPath.row][@"state"] isEqualToString:@"处理完成"]) {
            
            ComplaintCompleteVC *nextVC = [[ComplaintCompleteVC alloc] initWithAppealId:_appealArr[indexPath.row][@"appeal_id"]];
            [self.navigationController pushViewController:nextVC animated:YES];
        }else{
            
            ComplaintUnCompleteVC *nextVC = [[ComplaintUnCompleteVC alloc] initWithAppealId:_appealArr[indexPath.row][@"appeal_id"]];
            [self.navigationController pushViewController:nextVC animated:YES];
        }
    }
}



#pragma mark  ---  懒加载   ---
-(UITableView *)MainTableView
{
    if(!_MainTableView)
    {
        _MainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT + 41 *SIZE, 360*SIZE, SCREEN_Height-NAVIGATION_BAR_HEIGHT - 41 *SIZE) style:UITableViewStylePlain];
        _MainTableView.backgroundColor = YJBackColor;
        _MainTableView.rowHeight = UITableViewAutomaticDimension;
        _MainTableView.estimatedRowHeight = 130 *SIZE;
        _MainTableView.delegate = self;
        _MainTableView.dataSource = self;
        [_MainTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        
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
    return _MainTableView;
}


//- (InvalidView *)invalidView{
//
//    if (!_invalidView) {
//
//        _invalidView = [[InvalidView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
//    }
//    return _invalidView;
//}


@end
