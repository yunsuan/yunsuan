//
//  MyCollageVC.m
//  云渠道
//
//  Created by 谷治墙 on 2019/4/2.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "MyCollageVC.h"

#import "RecommendNewInfoVC.h"

//推荐cell
#import "RecommendInfoCell.h"
#import "RecommendThreeImageCell.h"
#import "RecommendBigImageCell.h"
#import "RecommendRightImageCell.h"
#import "RecommendContentCell.h"

@interface MyCollageVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableArray *_dataArr;
}

@property (nonatomic, strong) UITableView *table;

@end

@implementation MyCollageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    [self RequestMethod];
}

- (void)initDataSource{
    
    _dataArr = [@[] mutableCopy];
}

- (void)RequestMethod{
    
    
}

- (void)SetData:(NSArray *)data{
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch ([_dataArr[indexPath.row][@"item_type"] integerValue]) {
        case 1:
        {
            RecommendThreeImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecommendThreeImageCell"];
            if (!cell) {
                
                cell = [[RecommendThreeImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RecommendThreeImageCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.dataDic = _dataArr[indexPath.row];
            return cell;
            
            break;
        }
        case 2:
        {
            RecommendBigImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecommendBigImageCell"];
            if (!cell) {
                
                cell = [[RecommendBigImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RecommendBigImageCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.dataDic = _dataArr[indexPath.row];
            return cell;
            
            break;
        }
        case 3:
        {
            RecommendInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecommendInfoCell"];
            if (!cell) {
                
                cell = [[RecommendInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RecommendInfoCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.dataDic = _dataArr[indexPath.row];
            return cell;
            
            break;
        }
        case 4:
        {
            RecommendRightImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecommendRightImageCell"];
            if (!cell) {
                
                cell = [[RecommendRightImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RecommendRightImageCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.dataDic = _dataArr[indexPath.row];
            return cell;
            
            break;
        }
        case 5:
        {
            RecommendContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecommendContentCell"];
            if (!cell) {
                
                cell = [[RecommendContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RecommendContentCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.dataDic = _dataArr[indexPath.row];
            return cell;
            
            break;
        }
        default:
        {
            RecommendInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecommendInfoCell"];
            if (!cell) {
                
                cell = [[RecommendInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RecommendInfoCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.model = _dataArr[indexPath.row];
            return cell;
        }
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    RecommendNewInfoVC *vc = [[RecommendNewInfoVC alloc] initWithUrlStr:_dataArr[indexPath.row][@"content_url"] titleStr:_dataArr[indexPath.row][@"nick_name"] imageUrl:_dataArr[indexPath.row][@"img_url"] briefStr:_dataArr[indexPath.row][@"desc"] recommendId:_dataArr[indexPath.row][@"recommend_id"] companyStr:_dataArr[indexPath.row][@"title"]];
    [self.navigationController pushViewController:vc animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewCellEditingStyleDelete;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"我关注的云算号";
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    _table.backgroundColor = self.view.backgroundColor;
    _table.delegate = self;
    _table.dataSource = self;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_table];
}

@end
