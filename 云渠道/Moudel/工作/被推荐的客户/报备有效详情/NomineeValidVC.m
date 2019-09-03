//
//  NomineeValidVC.m
//  云渠道
//
//  Created by 谷治墙 on 2019/1/18.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "NomineeValidVC.h"

#import "NoValidVC.h"
#import "NewDealVC.h"

#import "NomineeCell2.h"

@interface NomineeValidVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableArray *_dataArr;
    NSInteger _page;
}

@property (nonatomic , strong) UITableView *MainTableView;

@end

@implementation NomineeValidVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDateSouce];
    [self initUI];
    [self RequestMethod];
}

-(void)initDateSouce
{
    _page = 1;
    _dataArr = [@[] mutableCopy];
}

- (void)RequestMethod{
    
    _page = 1;
    _MainTableView.mj_footer.state = MJRefreshStateIdle;
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"page":@(_page)}];
    if (![self isEmpty:self.search]) {
        
        [dic setObject:self.search forKey:@"search"];
    }
    
    [BaseRequest GET:ProjectValue_URL parameters:dic success:^(id resposeObject) {
        
        [_MainTableView.mj_header endRefreshing];
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [_dataArr removeAllObjects];
            [_MainTableView reloadData];
            if ([resposeObject[@"data"][@"data"] count]) {
                
                [_MainTableView.mj_footer endRefreshing];
                [self SetUnComfirmArr:resposeObject[@"data"][@"data"]];
            }else{
                
                _MainTableView.mj_footer.state = MJRefreshStateNoMoreData;
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

- (void)RequestAddMethod{
    
    _page += 1;
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"page":@(_page)}];
    if (![self isEmpty:self.search]) {
        
        [dic setObject:self.search forKey:@"search"];
    }
    
    [BaseRequest GET:ProjectValue_URL parameters:dic success:^(id resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [self SetUnComfirmArr:resposeObject[@"data"][@"data"]];
            if ([resposeObject[@"data"][@"data"] count]) {
                
                [_MainTableView.mj_footer endRefreshing];
                [self SetUnComfirmArr:resposeObject[@"data"][@"data"]];
            }else{
                
                _MainTableView.mj_footer.state = MJRefreshStateNoMoreData;
            }
        }
        else{
            
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

- (void)SetUnComfirmArr:(NSArray *)data{
    
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

#pragma mark  ---  delegate   ---

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _dataArr.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"NomineeCell2";
    
    NomineeCell2 *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[NomineeCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.dataDic = _dataArr[indexPath.row];
    cell.tag = indexPath.row;
    cell.phoneBtnBlock = ^(NSInteger index) {
        
        if ([_dataArr[index][@"tel_complete_state"] integerValue] <= 2) {
            
            NSString *phone = [_dataArr[index][@"tel"] componentsSeparatedByString:@","][0];
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
    cell.nomineeCell2AddBlock = ^{
      
        NSDictionary *dataDic = _dataArr[indexPath.row];
        NewDealVC *nextVC = [[NewDealVC alloc] initWithDic:@{@"broker_name":dataDic[@"name"],@"tel":dataDic[@"tel"],@"agent_name":dataDic[@"broker_name"],@"project_name":dataDic[@"project_name"],@"client_id":dataDic[@"client_id"]}];
        nextVC.project_id = _dataArr[indexPath.row][@"project_id"];//self.project_id;
        nextVC.newDealVCBlock = ^{
            
            [self RequestMethod];
        };
        [self.navigationController pushViewController:nextVC animated:YES];
    };
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NoValidVC *nextVC = [[NoValidVC alloc] initWithClientId:_dataArr[indexPath.row][@"client_id"]];
    [self.navigationController pushViewController:nextVC animated:YES];
}

-(void)initUI
{
    
    if ([[UserModel defaultModel].agent_identity integerValue] ==1) {
        self.rightBtn.hidden = NO;
    }else{
        self.rightBtn.hidden = YES;
    }
    
    [self.view addSubview:self.MainTableView];
}


-(UITableView *)MainTableView
{
    if(!_MainTableView)
    {
        _MainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 360*SIZE, SCREEN_Height - NAVIGATION_BAR_HEIGHT - 81 *SIZE) style:UITableViewStylePlain];
        _MainTableView.backgroundColor = YJBackColor;
        _MainTableView.rowHeight = UITableViewAutomaticDimension;
        _MainTableView.estimatedRowHeight = 130 *SIZE;
        _MainTableView.delegate = self;
        _MainTableView.dataSource = self;
        [_MainTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        
        _MainTableView.mj_header = [GZQGifHeader headerWithRefreshingBlock:^{
            
            [self RequestMethod];
        }];
        
        _MainTableView.mj_footer = [GZQGifFooter footerWithRefreshingBlock:^{
            
            [self RequestAddMethod];
        }];
    }
    return _MainTableView;
}


@end
