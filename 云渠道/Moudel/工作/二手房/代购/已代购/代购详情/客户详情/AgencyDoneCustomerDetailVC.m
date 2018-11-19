//
//  AgencyDoneCustomerDetailVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/7/18.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "AgencyDoneCustomerDetailVC.h"

#import "AgencyEditCustomerDetailVC.h"

#import "SingleContentCell.h"

@interface AgencyDoneCustomerDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_contentArr;
    NSMutableArray *_customerArr;
}
@property (nonatomic, strong) UITableView *table;

@end

@implementation AgencyDoneCustomerDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
//    _contentArr = @[@"推荐编号：JDN5262631256",@"姓名：张三",@"性别：男",@"联系号码1：18745561223",@"联系号码2：18745561223",@"证件类型：身份证",@"证件号：513029199412535",@"通讯地址：成都市郫都区大禹东路94号"];
    _customerArr = [[NSMutableArray alloc]init];
    [_customerArr addObject:[NSString stringWithFormat:@"推荐编号："]];
    [_customerArr addObject:[NSString stringWithFormat:@"姓名：%@",_customerDic[@"name"]]];
    if ([_customerDic[@"sex"] integerValue]==0) {
         [_customerArr addObject:@"性别："];
    }
    else if([_customerDic[@"sex"] integerValue]==1)
    {
        [_customerArr addObject:@"性别：男"];
    }else{
        [_customerArr addObject:@"性别：女"];
    }
    [_customerArr addObject:[NSString stringWithFormat:@"类型：%@",_customerDic[@"report_type"]]];
    NSString *tel = _customerDic[@"tel"];
    NSArray *array = [tel componentsSeparatedByString:@","];
    for (int i =0; i<array.count; i++) {
        [_customerArr addObject:[NSString stringWithFormat:@"电话号码%d：%@",i+1,array[i]]];
    }
    [_customerArr addObject:[NSString stringWithFormat:@"证件类型：%@",_customerDic[@"card_type"]]];
    [_customerArr addObject:[NSString stringWithFormat:@"证件号：%@",_customerDic[@"card_id"]]];
    [_customerArr addObject:[NSString stringWithFormat:@"通讯地址：%@",_customerDic[@"address"]]];
    
}

- (void)ActionRightBtn:(UIButton *)btn{
    
 
    AgencyEditCustomerDetailVC *nextVC = [[AgencyEditCustomerDetailVC alloc] initWithData:_customerDic];
    nextVC.agencyEditCustomerDetailVCBlock = ^(NSDictionary * _Nonnull dic) {
      
        [_customerArr removeAllObjects];
        [_customerArr addObject:[NSString stringWithFormat:@"推荐编号：？？？？？"]];
        [_customerArr addObject:[NSString stringWithFormat:@"姓名：%@",dic[@"name"]]];
        if ([dic[@"sex"] integerValue]==0) {
            [_customerArr addObject:@"性别："];
        }
        else if([dic[@"sex"] integerValue]==1)
        {
            [_customerArr addObject:@"性别：男"];
        }else{
            [_customerArr addObject:@"性别：女"];
        }
        [_customerArr addObject:[NSString stringWithFormat:@"类型：%@",dic[@"report_type"]]];
        NSString *tel = dic[@"tel"];
        NSArray *array = [tel componentsSeparatedByString:@","];
        for (int i =0; i < array.count; i++) {
            [_customerArr addObject:[NSString stringWithFormat:@"电话号码%d：%@",i+1,array[i]]];
        }
        [_customerArr addObject:[NSString stringWithFormat:@"证件类型：%@",dic[@"card_type"]]];
        [_customerArr addObject:[NSString stringWithFormat:@"证件号：%@",dic[@"card_id"]]];
        [_customerArr addObject:[NSString stringWithFormat:@"通讯地址：%@",dic[@"address"]]];
        [_table reloadData];
        if (self.agencyDoneCustomerDetailVCBlock) {
            
            self.agencyDoneCustomerDetailVCBlock();
        }
    };
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _customerArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SingleContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SingleContentCell"];
    if (!cell) {
        
        cell = [[SingleContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SingleContentCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.contentL.text = _customerArr[indexPath.row];
    cell.lineView.hidden = YES;
    return cell;
}

- (void)initUI{
    
    self.titleLabel.text = @"客户资料详情";
    self.navBackgroundView.hidden = NO;
    
    if ([self.status integerValue] == 1) {
        
        self.rightBtn.hidden = YES;
    }else{
        
        self.rightBtn.hidden = NO;
    }
    
    [self.rightBtn setImage:[UIImage imageNamed:@"edit"] forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(ActionRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.backgroundColor = self.view.backgroundColor;
    _table.delegate = self;
    _table.dataSource = self;
    [self.view addSubview:_table];
}

@end
