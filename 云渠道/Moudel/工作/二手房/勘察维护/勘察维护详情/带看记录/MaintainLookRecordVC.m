//
//  MaintainLookRecordVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/6/21.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "MaintainLookRecordVC.h"

#import "MaintainLookCell.h"
#import "MaintainLookHeader.h"

@interface MaintainLookRecordVC ()<UITableViewDataSource,UITableViewDelegate>
{

    NSMutableArray *_dataArr;
    NSDictionary *_dataDic;
}
@property (nonatomic, strong) UITableView *table;

@end

@implementation MaintainLookRecordVC

- (instancetype)initWithDataDic:(NSDictionary *)dataDic
{
    self = [super init];
    if (self) {
        
        _dataDic = dataDic;
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
    
    [BaseRequest GET:HouseSurveyTakeHisList_URL parameters:@{@"house_id":self.houseId,@"type":@"1"} success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            _dataArr = [NSMutableArray arrayWithArray:resposeObject[@"data"]];
        }
        [_table reloadData];
    } failure:^(NSError *error) {
       
        [self showContent:@"网络错误"];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    
//    return UITableViewAutomaticDimension;
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    MaintainLookHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"MaintainLookHeader"];
    if (!header) {
        
        header = [[MaintainLookHeader alloc] initWithReuseIdentifier:@"MaintainLookHeader"];
    }
    
    header.numL.text = [NSString stringWithFormat:@"%@",_dataDic[@"range_take"]];
    header.allL.text = [NSString stringWithFormat:@"%@",_dataDic[@"total_take"]];
    
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MaintainLookCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MaintainLookCell"];
    if (!cell) {
        
        cell = [[MaintainLookCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MaintainLookCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.timeL.text = [NSString stringWithFormat:@"%@",[_dataArr[indexPath.row][@"take_time"] componentsSeparatedByString:@" "][0]];
    cell.priceL.text = [NSString stringWithFormat:@"%@万",_dataArr[indexPath.row][@"price"]];
    cell.agentL.text = [NSString stringWithFormat:@"%@",_dataArr[indexPath.row][@"agent_name"]];
    cell.tag = indexPath.row;
    
    cell.maintainLookBlock = ^(NSInteger index) {
        
        NSString *phone = [NSString stringWithFormat:@"%@",_dataArr[index][@"agent_tel"]];//[_dataArr[index][@"agent_tel"] componentsSeparatedByString:@","][0];
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
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"带看记录";
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 40 *SIZE;
    _table.sectionHeaderHeight = UITableViewAutomaticDimension;
    _table.estimatedSectionHeaderHeight = 107 *SIZE;
    _table.backgroundColor = self.view.backgroundColor;
    _table.delegate = self;
    _table.dataSource = self;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_table];
}

@end
