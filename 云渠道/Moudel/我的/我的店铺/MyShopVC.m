//
//  MyShopVC.m
//  云渠道
//
//  Created by 谷治墙 on 2020/2/25.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "MyShopVC.h"

#import "BlueTitleMoreHeader.h"
#import "MyShopHeader.h"

#import "MyShopRoomCell.h"
#import "MyShopCommentCell.h"

@interface MyShopVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableArray *_roomArr;
    NSMutableArray *_commentArr;
}

@property (nonatomic, strong) UITableView *table;

@end

@implementation MyShopVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 0;
    }else if (section == 1){
        
        return 1;
    }else{
        
        return 1;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        MyShopHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"MyShopHeader"];
        if (!header) {
            
            header = [[MyShopHeader alloc] initWithReuseIdentifier:@"MyShopHeader"];
        }
        
        return header;
    }else{
        
        BlueTitleMoreHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BlueTitleMoreHeader"];
        if (!header) {
            
            header = [[BlueTitleMoreHeader alloc] initWithReuseIdentifier:@"BlueTitleMoreHeader"];
        }
        
        if (section == 1) {
            
            header.titleL.text = @"新房推荐";
        }else{
            
            header.titleL.text = @"客户评论";
        }
        return header;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        return nil;
    }else if (indexPath.section == 1){
        
        MyShopRoomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyShopRoomCell"];
        if (!cell) {
            
            cell = [[MyShopRoomCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"MyShopRoomCell"];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.dataDic = @{};
        return cell;
    }else{
        
        MyShopCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyShopCommentCell"];
        if (!cell) {
            
            cell = [[MyShopCommentCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"MyShopCommentCell"];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.dataDic = @{};
        return cell;
    }
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"我的店铺";
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    _table.backgroundColor = CLBackColor;
    _table.delegate = self;
    _table.dataSource = self;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 100 *SIZE;
    [self.view addSubview:_table];
}

@end
