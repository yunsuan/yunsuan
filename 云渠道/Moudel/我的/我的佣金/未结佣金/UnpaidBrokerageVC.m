//
//  UnpaidBrokerageVC.m
//  云渠道
//
//  Created by xiaoq on 2018/3/21.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "UnpaidBrokerageVC.h"
#import "UnpaidCell.h"
#import "BrokerageDetailVC.h"

@interface UnpaidBrokerageVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *_data;
    int page;
}
@property (nonatomic , strong) UITableView *MainTableView;




-(void)initUI;
-(void)initDateSouce;
@end

@implementation UnpaidBrokerageVC

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    page= 1;
    [self postWithPage:@"1"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = YJBackColor;
    self.navBackgroundView.hidden = NO;
    [self.leftButton addTarget:self action:@selector(action_back) forControlEvents:UIControlEventTouchUpInside];
    self.titleLabel.text = @"未结列表";
    [self initDateSouce];
    [self initUI];    
}

-(void)postWithPage:(NSString *)page{

    [BaseRequest GET:UnPayList_URL parameters:@{
                                                      @"page":page
                                                      }
             success:^(id resposeObject) {
                 if ([resposeObject[@"code"] integerValue]==200) {
                     if ([page isEqualToString:@"1"]) {
                         
                         [_MainTableView.mj_footer endRefreshing];
                         _data = [resposeObject[@"data"][@"data"] mutableCopy];
                         if (_data.count < 15) {
                             
                             _MainTableView.mj_footer.state = MJRefreshStateNoMoreData;
                         }
                         [_MainTableView reloadData];
                     }
                     else{
                         NSArray *arr =resposeObject[@"data"][@"data"];
                         if (arr.count ==0) {
                             [_MainTableView.mj_footer setState:MJRefreshStateNoMoreData];
                         }
                         else{
                             [_data addObjectsFromArray:[arr mutableCopy]];
                             [_MainTableView reloadData];
                             [_MainTableView.mj_footer endRefreshing];
                         }
                     }
                     [_MainTableView.mj_header endRefreshing];
                 }
             } failure:^(NSError *error) {
                 [self showContent:@"网络错误"];
                 [_MainTableView.mj_footer endRefreshing];
                 [_MainTableView.mj_header endRefreshing];
             }];
}

-(void)initDateSouce
{
    _data = [NSMutableArray array];
}

-(void)initUI
{
    [self.view addSubview:self.MainTableView];
}

-(void)action_back
{
    
}

#pragma mark  ---  delegate   ---

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _data.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 134*SIZE;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *CellIdentifier = @"UnpaidCell";
    
    UnpaidCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UnpaidCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    cell.nameL.text = _data[indexPath.row][@"name"];
    cell.phoneL.text = _data[indexPath.row][@"tel"];
    cell.unitL.text =  _data[indexPath.row][@"project_name"];
    cell.codeL.text = [NSString stringWithFormat:@"推荐编号：%@",_data[indexPath.row][@"client_id"]];
    cell.typeL.text =  [NSString stringWithFormat:@"类型：%@",_data[indexPath.row][@"broker_type"]];
    cell.timeL.text = [NSString stringWithFormat:@"推荐时间：%@",_data[indexPath.row][@"create_time"]];
    cell.expediteBtn.tag = indexPath.row;
    if ([_data[indexPath.row][@"type"] integerValue]==1) {
        cell.priceL.text = @"";
        cell.expediteBtn.hidden = YES;
    }
    else{
    cell.priceL.text = [NSString stringWithFormat:@"%@",_data[indexPath.row][@"broker_num"]];
        cell.expediteBtn.hidden = NO;
    }
//    WS(weakself);
    
    if ([_data[indexPath.row][@"is_urge"] integerValue]==1) {
        [cell.expediteBtn setTitle:@"已催佣" forState:UIControlStateNormal];
        cell.expediteBtn.userInteractionEnabled = NO;
    }
 
    __weak __typeof(&*cell)weakcell = cell;
    cell.moneybtnBlook = ^(NSInteger index) {
        [BaseRequest POST:Urge_URL parameters:@{
                                    @"broker_id":_data[indexPath.row][@"broker_id"]
                                                }
                  success:^(id resposeObject) {
//                      NSLog(@"%@",resposeObject);
                      if ([resposeObject[@"code"] integerValue]==200) {
                          [weakcell.expediteBtn setTitle:@"已催佣" forState:UIControlStateNormal];
                          weakcell.expediteBtn.userInteractionEnabled = NO;
                      }
                      else
                      {
                          [self showContent:resposeObject[@"msg"]];
                      }
                                                }
                  failure:^(NSError *error) {
//                      NSLog(@"%@",error.description);
                                                }];
//        NSLog(@"%ld",index);
        
    };
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BrokerageDetailVC *nextVC = [[BrokerageDetailVC alloc] init];
    nextVC.broker_id = _data[indexPath.row][@"broker_id"];
    nextVC.type = @"0";
    nextVC.is_urge =_data[indexPath.row][@"is_urge"];
    nextVC.iscompany = _data[indexPath.row][@"type"];
    [self.navigationController pushViewController:nextVC animated:YES];
}



#pragma mark  ---  懒加载   ---
-(UITableView *)MainTableView
{
    if(!_MainTableView)
    {
        _MainTableView =   [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, 360*SIZE, SCREEN_Height-NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
        _MainTableView.backgroundColor = YJBackColor;
        _MainTableView.delegate = self;
        _MainTableView.dataSource = self;
        _MainTableView.mj_header = [GZQGifHeader headerWithRefreshingBlock:^{
            page = 1;
            [self postWithPage:@"1"];
        }];
        _MainTableView.mj_footer = [GZQGifFooter footerWithRefreshingBlock:^{
            page++;
            [self postWithPage:[NSString stringWithFormat:@"%d",page]];
        }];
//        _MainTableView.
        [_MainTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }
    return _MainTableView;
}



@end
