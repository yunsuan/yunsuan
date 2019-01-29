//
//  LookMaintainAddRoomVC.m
//  云渠道
//
//  Created by 谷治墙 on 2019/1/25.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "LookMaintainAddRoomVC.h"

#import "LookMaintainAddRoomCell.h"

@interface LookMaintainAddRoomVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableArray *_dataArr;
    
}
@property (nonatomic, strong) UITableView *roomTable;

@end

@implementation LookMaintainAddRoomVC



- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self initDataSource];
    [self initUI];
    
}

- (void)initDataSource{
    
    _dataArr = [@[] mutableCopy];
}



- (void)ActionRightBtn:(UIButton *)btn{
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LookMaintainAddRoomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LookMaintainAddRoomCell"];
    if (!cell) {
        
        cell = [[LookMaintainAddRoomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LookMaintainAddRoomCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.dicData = _dataArr[indexPath.row];
    
    return cell;
}

- (void)initUI{
    
    self.rightBtn.hidden = NO;
    [self.rightBtn setImage:[UIImage imageNamed:@"add_3"] forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(ActionRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    self.titleLabel.text = @"添加带看房源";
    
    _roomTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    _roomTable.backgroundColor = self.view.backgroundColor;
    _roomTable.delegate = self;
    _roomTable.dataSource = self;
    
    [self.view addSubview:_roomTable];
}

@end
