//
//  RecommendWaitDetailVC.m
//  云渠道
//
//  Created by 谷治墙 on 2019/1/21.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "RecommendWaitDetailVC.h"

#import "BaseHeader.h"
#import "SingleContentCell.h"

@interface RecommendWaitDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSString *_recommendId;
    NSArray *_dataArr;
}

@property (nonatomic, strong) UITableView *table;

@end

@implementation RecommendWaitDetailVC

- (instancetype)initWithRecommendId:(NSString *)recommendId;
{
    self = [super init];
    if (self) {
        
        _recommendId = recommendId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
    [self requestMethod];
}

- (void)initDataSource{
    
//    _dataArr = [@[] mutableCopy];
}

- (void)requestMethod{
    
    [BaseRequest GET:RecommendBrokerWaitDetail_URL parameters:@{@"recommend_id":_recommendId} success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [self SetData:resposeObject[@"data"]];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [self showContent:@"网络错误"];
    }];
}

- (void)SetData:(NSDictionary *)data{
    
//    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:data];
    
//    [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
//
//        if (obj isKindOfClass:[NSNull class]) {
//            <#statements#>
//        }
//    }];
    
    _dataArr = @[[NSString stringWithFormat:@"客源编号：%@",data[@"recommend_code"]],[NSString stringWithFormat:@"客户姓名：%@",data[@"client_name"]],[NSString stringWithFormat:@"客户性别：%@",[data[@"client_sex"] integerValue] == 1? @"男":@"女"],[NSString stringWithFormat:@"联系方式：%@",data[@"client_tel"]],[NSString stringWithFormat:@"推荐时间：%@",data[@"recommend_time"]],[NSString stringWithFormat:@"备注：%@",data[@"comment"]]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
     BaseHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BaseHeader"];
    if (!header) {
        
        header = [[BaseHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
    }
    
    header.titleL.text = @"推荐信息";
    
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SingleContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SingleContentCell"];
    if (!cell) {
        
        cell = [[SingleContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SingleContentCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.contentL.text = _dataArr[indexPath.row];
    
    return cell;
}

- (void)initUI{

    self.titleLabel.text = @"待确认详情";
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    _table.backgroundColor = self.view.backgroundColor;
    _table.delegate = self;
    _table.dataSource = self;
    
    [self.view addSubview:_table];
}

@end
