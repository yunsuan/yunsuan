//
//  LookMaintainDetailLookRecordVC.m
//  云渠道
//
//  Created by 谷治墙 on 2019/1/28.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "LookMaintainDetailLookRecordVC.h"

@interface LookMaintainDetailLookRecordVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableArray *_customArr;
    NSMutableArray *_lookArr;
}
@property (nonatomic, strong) UITableView *table;

@end

@implementation LookMaintainDetailLookRecordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
    _customArr = [@[] mutableCopy];
    _lookArr = [@[] mutableCopy];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (_customArr.count) {
        
        return 2;
    }else{
        
        return 0;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return _customArr.count;
    }else{
        
        return _lookArr.count + 1;
    }
}



- (void)initUI{
    
    
}

@end
