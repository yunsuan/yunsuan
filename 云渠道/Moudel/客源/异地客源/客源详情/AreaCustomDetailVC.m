//
//  AreaCustomDetailVC.m
//  云渠道
//
//  Created by 谷治墙 on 2019/12/5.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "AreaCustomDetailVC.h"

#import "BaseHeader.h"

#import "SingleContentCell.h"

@interface AreaCustomDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
 
    NSString *_recommend_id;
    
    NSMutableArray *_contentArr;
    NSMutableArray *_dataArr;
}

@property (nonatomic, strong) UITableView *table;

@end

@implementation AreaCustomDetailVC

- (instancetype)initWithRecommendId:(NSString *)recommend_id
{
    self = [super init];
    if (self) {
        
        _recommend_id = recommend_id;
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
    
    _contentArr = [@[] mutableCopy];
    _dataArr = [@[] mutableCopy];
}

- (void)RequestMethod{
    
    [BaseRequest GET:ClientOtherBuyDetail_URL parameters:@{@"recommend_id":_recommend_id} success:^(id resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [self showContent:@"网络错误"];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return _contentArr.count;
    }else if (section == 1){
        
        return 0;
    }else{
        
        return _dataArr.count;
    }
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//
//
//}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
//    if (section == 0) {
//
//    }
    BaseHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BaseHeader"];
    if (!header) {
        
        header = [[BaseHeader alloc] initWithReuseIdentifier:@"BaseHeader"];
    }
    
    if (section == 0) {
        
        header.titleL.text = @"基本信息";
    }else{
        
        header.titleL.text = @"接待信息";
    }
    
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SingleContentCell *cell;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section == 2) {
        
        
    }
}

- (void)initUI{

    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"客户详情";
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - TAB_BAR_MORE) style:UITableViewStyleGrouped];
    _table.estimatedRowHeight = 367 *SIZE;
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedSectionHeaderHeight = 320 *SIZE;
    _table.sectionHeaderHeight = UITableViewAutomaticDimension;
    _table.backgroundColor = YJBackColor;
    _table.delegate = self;
    _table.dataSource = self;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_table];
}

@end
