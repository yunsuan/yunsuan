//
//  ConfirmPhoneUseVC.m
//  云渠道
//
//  Created by 谷治墙 on 2019/2/22.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "ConfirmPhoneUseVC.h"

#import "RecommendCell3.h"

@interface ConfirmPhoneUseVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_dataArr;
    NSString *_page;
}

@property (nonatomic, strong) UITableView *table;

@end

@implementation ConfirmPhoneUseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSouce];
    [self initUI];
}

-(void)initDataSouce
{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SearchMethod:) name:@"protocolSearch" object:nil];
    _dataArr = @[];
    _page =@"1";
}

- (void)SearchMethod:(NSNotification *)noti{
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RecommendCell3 *cell = [tableView dequeueReusableCellWithIdentifier:@"RecommendCell3"];
    if (!cell) {
        
        cell = [[RecommendCell3 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RecommendCell3"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

- (void)initUI{
    
    _table = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 120 *SIZE;
    _table.backgroundColor = self.view.backgroundColor;
    _table.delegate = self;
    _table.dataSource = self;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.mj_header= [GZQGifHeader headerWithRefreshingBlock:^{
        
        _page = @"1";
    }];
    _table.mj_footer = [GZQGifFooter footerWithRefreshingBlock:^{
        
        NSInteger i = [_page integerValue];
        i++;
    }];
    [self.view addSubview:_table];
}

@end
