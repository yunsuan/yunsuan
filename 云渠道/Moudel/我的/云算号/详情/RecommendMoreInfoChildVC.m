//
//  RecommendMoreInfoChildVC.m
//  云渠道
//
//  Created by 谷治墙 on 2019/4/2.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "RecommendMoreInfoChildVC.h"

#import "RecommendInfoCell.h"
#import "RecommendThreeImageCell.h"
#import "RecommendBigImageCell.h"
#import "RecommendRightImageCell.h"
#import "RecommendContentCell.h"

@interface RecommendMoreInfoChildVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableArray *_dataArr;
    NSInteger _AllType;
    
    NSInteger _page;
    NSString *_companyId;
}

@property (nonatomic , strong) UITableView *MainTableView;

@end

@implementation RecommendMoreInfoChildVC

- (instancetype)initWithType:(NSInteger)type companyId:(NSString *)companyId
{
    self = [super init];
    if (self) {
        
        _AllType = type;
        _companyId = companyId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
    if (_companyId) {
        
        [self RequestMethod];
    }
}

- (void)initDataSource{
    
    _dataArr = [@[] mutableCopy];
}

- (void)RequestMethod{
    
    _page = 1;
    NSDictionary *dic = @{@"apply_id":_companyId,
                          @"recommend_type":@(_AllType)
                          };
    
    if (_page == 1) {
        
        _MainTableView.mj_footer.state = MJRefreshStateIdle;
    }
    [BaseRequest GET:ApplyFollowgetCompanyRecommend_URL parameters:dic success:^(id resposeObject) {
        
        [self.MainTableView.mj_header endRefreshing];
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [_dataArr removeAllObjects];
            [_MainTableView reloadData];
            
            if ([resposeObject[@"data"][@"data"] count]) {
                
                self.MainTableView.mj_footer.state = MJRefreshStateIdle;
                [self SetData:resposeObject[@"data"][@"data"]];
            }else{
                
                self.MainTableView.mj_footer.state = MJRefreshStateNoMoreData;
            }
            
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [self.MainTableView.mj_header endRefreshing];
        [self showContent:@"网络错误"];
    }];
}

- (void)RequestAddMethod{
    
    NSDictionary *dic = @{@"apply_id":_companyId,
                          @"recommend_type":@(_AllType),
                          @"page":@(_page)
                          };
    
    [BaseRequest GET:ApplyFollowgetCompanyRecommend_URL parameters:dic success:^(id resposeObject) {
        
        [self.MainTableView.mj_header endRefreshing];
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if ([resposeObject[@"data"][@"data"] count]) {
                
                self.MainTableView.mj_footer.state = MJRefreshStateIdle;
                [self SetData:resposeObject[@"data"][@"data"]];
            }else{
                
                self.MainTableView.mj_footer.state = MJRefreshStateNoMoreData;
            }
            
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [self.MainTableView.mj_header endRefreshing];
        [self showContent:@"网络错误"];
    }];
}

- (void)SetData:(NSArray *)data{
    
    [self.MainTableView.mj_footer endRefreshing];
    
    for (int i = 0; i < data.count; i++) {
        
        NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:data[i]];
        [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            
            if ([obj isKindOfClass:[NSNull class]]) {
                
                [tempDic setObject:@"" forKey:key];
            }
        }];
        [_dataArr addObject:tempDic];
    }
    [_MainTableView reloadData];
}

#pragma mark -- Table

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewAutomaticDimension;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch ([_dataArr[indexPath.row][@"item_type"] integerValue]) {
        case 1:
        {
            RecommendThreeImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecommendThreeImageCell"];
            if (!cell) {
                
                cell = [[RecommendThreeImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RecommendThreeImageCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.dataDic = _dataArr[indexPath.row];
            return cell;
            
            break;
        }
        case 2:
        {
            RecommendBigImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecommendBigImageCell"];
            if (!cell) {
                
                cell = [[RecommendBigImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RecommendBigImageCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.dataDic = _dataArr[indexPath.row];
            return cell;
            
            break;
        }
        case 3:
        {
            RecommendInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecommendInfoCell"];
            if (!cell) {
                
                cell = [[RecommendInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RecommendInfoCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.dataDic = _dataArr[indexPath.row];
            return cell;
            
            break;
        }
        case 4:
        {
            RecommendRightImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecommendRightImageCell"];
            if (!cell) {
                
                cell = [[RecommendRightImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RecommendRightImageCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.dataDic = _dataArr[indexPath.row];
            return cell;
            
            break;
        }
        case 5:
        {
            RecommendContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecommendContentCell"];
            if (!cell) {
                
                cell = [[RecommendContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RecommendContentCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.dataDic = _dataArr[indexPath.row];
            return cell;
            
            break;
        }
        default:
        {
            RecommendInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecommendInfoCell"];
            if (!cell) {
                
                cell = [[RecommendInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RecommendInfoCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.model = _dataArr[indexPath.row];
            return cell;
        }
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.recommendMoreInfoChildVCBlock) {
        
        self.recommendMoreInfoChildVCBlock(_dataArr[indexPath.row]);
    }
}

- (void)initUI{
    
    _MainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 1, SCREEN_Width, SCREEN_Height - 160 *SIZE - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    
    _MainTableView.rowHeight = UITableViewAutomaticDimension;
    _MainTableView.estimatedRowHeight = 120 *SIZE;
    
    _MainTableView.backgroundColor = self.view.backgroundColor;
    _MainTableView.delegate = self;
    _MainTableView.dataSource = self;
    _MainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_MainTableView];
    
    _MainTableView.mj_header = [GZQGifHeader headerWithRefreshingBlock:^{

        _page = 1;
        [self RequestMethod];
    }];

    _MainTableView.mj_footer = [GZQGifFooter footerWithRefreshingBlock:^{

        _page += 1;
        [self RequestAddMethod];
    }];
}

@end
