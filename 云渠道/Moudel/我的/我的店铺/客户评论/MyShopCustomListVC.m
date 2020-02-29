//
//  MyShopCustomListVC.m
//  云渠道
//
//  Created by 谷治墙 on 2020/2/27.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "MyShopCustomListVC.h"

#import "MyShopRecommendDetailVC.h"

#import "MyShopCommentCell.h"

#import "STCommentEditView.h"

@interface MyShopCustomListVC ()<UITableViewDelegate,UITableViewDataSource, NFCommentEditViewDelegate>
{
    
    NSInteger _idx;
    
    NSString *_comment_id;
    
    NSInteger _page;
    
    NSMutableArray *_dataArr;
}
@property (nonatomic, strong) STCommentEditView *editView;

@property (nonatomic , strong) UITableView *MainTableView;

@end

@implementation MyShopCustomListVC

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    self.editView.delegate = self;
    [self.view addSubview:self.editView];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
    [self RequestMethod];
}

- (void)initDataSource{
    
    _page = 1;
    _dataArr = [@[] mutableCopy];
}

- (void)RequestMethod{
    
    if (_page == 1) {
        
        self.MainTableView.mj_footer.state = MJRefreshStateIdle;
    }
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"page":@(_page)}];
    
    [BaseRequest GET:GetCommentList_URL parameters:dic success:^(id resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [_dataArr removeAllObjects];
            [self->_MainTableView reloadData];
            [_MainTableView.mj_header endRefreshing];
            if ([resposeObject[@"data"][@"data"] count]) {
                
                [self SetData:resposeObject[@"data"][@"data"]];
                
            }else{
                
                [_dataArr removeAllObjects];
                _MainTableView.mj_footer.state = MJRefreshStateNoMoreData;
            }
        }else{
            
            [_MainTableView.mj_header endRefreshing];
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [_MainTableView.mj_header endRefreshing];
        [self showContent:@"网络错误"];
    }];
}

- (void)RequestAddMethod{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"page":@(_page)}];
    
    [BaseRequest GET:GetCommentList_URL parameters:dic success:^(id resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if ([resposeObject[@"data"][@"data"] count]) {
                
                [_MainTableView.mj_footer endRefreshing];
                [self SetData:resposeObject[@"data"][@"data"]];
                
            }else{
                
                _MainTableView.mj_footer.state = MJRefreshStateNoMoreData;
            }
        }else{
            
            _page -= 1;
            [_MainTableView.mj_footer endRefreshing];
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        _page -= 1;
        [_MainTableView.mj_footer endRefreshing];
        [self showContent:@"网络错误"];
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
        
        [_dataArr addObject:tempDic];
    }
    
    [self.MainTableView reloadData];
}


#pragma mark - NFCommentToolViewDelegate

- (void)commentToolViewContentButtonClicked {
    NSLog(@"写评论...");
    
//    [self.editView updatePlaceholder:@"优质内容将会优先展示"];
    self.editView.hidden = NO;
    [self.editView show];
}

- (void)commentToolViewShareButtonClicked {
    NSLog(@"点击了分享");
}

- (void)commentToolViewArticleButtonClicked {
    NSLog(@"点击了文章");
}

#pragma mark - NFCommentEditViewDelegate

- (void)commentEditView:(STCommentEditView *)commentEditView didRequsetStatus:(BOOL)success {
    if (success) {
        NSLog(@"发送成功！");
        
        [BaseRequest POST:AddRelyComment_URL parameters:@{@"reply_comment":commentEditView.inputView.text,@"comment_id":_comment_id} success:^(id resposeObject) {
                
            if ([resposeObject[@"code"] integerValue]) {
                        
                NSDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:_dataArr[_idx]];
                NSMutableArray *arr = [[NSMutableArray alloc] initWithArray:dic[@"replyList"]];
                [arr addObject:@{@"agent_name":[UserInfoModel defaultModel].name,@"nick_name":dic[@"nick_name"],@"reply_comment":commentEditView.inputView.text}];
                [dic setValue:arr forKey:@"replyList"];
                [_dataArr replaceObjectAtIndex:_idx withObject:dic];
                [_MainTableView reloadData];
            }else{
                        
                [self showContent:resposeObject[@"msg"]];
            
            }
        } failure:^(NSError *error) {
            
            [self showContent:@"网络错误"];
        }];
    
    } else {
        NSLog(@"发送失败");
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    MyShopCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyShopCommentCell"];
    if (!cell) {
        
        cell = [[MyShopCommentCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"MyShopCommentCell"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.dataDic = _dataArr[indexPath.row];
    
    cell.myShopCommentCellLabelBlock = ^{
        
        self.editView.delegate = nil;
        [self.editView removeFromSuperview];
        MyShopRecommendDetailVC *nextVC = [[MyShopRecommendDetailVC alloc] initWithHouseId:[NSString stringWithFormat:@"%@",_dataArr[indexPath.row][@"house_id"]] info_id:@""];
        nextVC.projectName = [NSString stringWithFormat:@"%@",_dataArr[indexPath.row][@"project_name"]];
        nextVC.config_id = [NSString stringWithFormat:@"%@",_dataArr[indexPath.row][@"config_id"]];
        nextVC.myShopRecommendDetailVCBlock = ^{
            
            [self RequestMethod];
        };
        [self.navigationController pushViewController:nextVC animated:YES];
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    _idx = indexPath.row;
    _comment_id = [NSString stringWithFormat:@"%@",_dataArr[indexPath.row][@"comment_id"]];
    [self.editView updatePlaceholder:[NSString stringWithFormat:@"回复%@：",_dataArr[indexPath.row][@"nick_name"]]];
    self.editView.hidden = NO;
    [self.editView show];
}

    
- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"客户评论";
    
    _MainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, 360 *SIZE, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    _MainTableView.backgroundColor = YJBackColor;
    _MainTableView.delegate = self;
    _MainTableView.dataSource = self;
    [_MainTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    _MainTableView.mj_header = [GZQGifHeader headerWithRefreshingBlock:^{

        _page = 1;
        [self RequestMethod];
    }];

    _MainTableView.mj_footer = [GZQGifFooter footerWithRefreshingBlock:^{

        _page += 1;
        [self RequestAddMethod];
    }];
    [self.view addSubview:_MainTableView];
    
    
    self.editView = [[STCommentEditView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    self.editView.delegate = self;
    [self.view addSubview:self.editView];
    self.editView.hidden = YES;
}

@end
