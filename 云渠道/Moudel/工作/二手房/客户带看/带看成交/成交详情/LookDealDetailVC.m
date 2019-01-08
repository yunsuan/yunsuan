//
//  LookDealDetailVC.m
//  云渠道
//
//  Created by 谷治墙 on 2019/1/8.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "LookDealDetailVC.h"

#import "BaseHeader.h"
#import "RoomBrokerageTableHeader.h"

@interface LookDealDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSString *_lookId;
    NSMutableArray *_proArr;
}

@property (nonatomic, strong) UITableView *detailTable;
@end

@implementation LookDealDetailVC

- (instancetype)initWithLookId:(NSString *)lookId
{
    self = [super init];
    if (self) {
        
        _lookId = lookId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 4 + _proArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 3) {
        
        return 0;
    }else if (section > 3) {
        
        return [_proArr[section - 4] count];
    }else{
        
        return 1;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 1) {
        
        return nil;
    }else if (section > 3){
        
        RoomBrokerageTableHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"RoomBrokerageTableHeader"];
        if (!header) {
            
            header = [[RoomBrokerageTableHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 51 *SIZE)];
        }
        
        header.titleL.text = [NSString stringWithFormat:@"%@至%@",_model.dataarr[section][@"act_start"],_model.dataarr[section][@"act_end"]];
        header.dropBtn.tag = section;
        if ([_selectArr[section] integerValue]) {
            
            [header.dropBtn setImage:[UIImage imageNamed:@"uparrow"] forState:UIControlStateNormal];
        }else{
            
            [header.dropBtn setImage:[UIImage imageNamed:@"downarrow"] forState:UIControlStateNormal];
        }
        header.dropBtnBlock = ^(NSInteger index) {
            if ([_selectArr[index] integerValue]) {
                
                [_selectArr replaceObjectAtIndex:index withObject:@0];
            }else{
                _selectArr = [NSMutableArray arrayWithArray:@[@1,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0]];
                [_selectArr replaceObjectAtIndex:index withObject:@1];
            }
            [tableView reloadData];
        };
    }else{
        
        BaseHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BaseHeader"];
        if (!header) {
            
            header = [[BaseHeader alloc] initWithReuseIdentifier:@"BaseHeader"];
        }
        
        if (section == 0) {
            
            header.titleL.text = @"成交信息";
        }else if (section == 2){
            
            header.titleL.text = @"成交信息";
        }else{
            
            header.titleL.text = @"成交信息";
        }
        
        return header;
    }
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"成交详情";
    
    _detailTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    _detailTable.backgroundColor = self.view.backgroundColor;
    _detailTable.delegate = self;
    _detailTable.dataSource = self;
    
    [self.view addSubview:_detailTable];
}

@end
