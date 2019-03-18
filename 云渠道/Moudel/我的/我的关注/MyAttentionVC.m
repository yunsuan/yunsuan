//
//  MyAttentionVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/3/29.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "MyAttentionVC.h"

#import "SecAllRoomDetailVC.h"
#import "RentingAllRoomDetailVC.h"

//#import "SecdaryAllTableModel.h"
#import "SecdaryAllTableCell.h"

@interface MyAttentionVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableArray *_dataArr;
    NSInteger _page;
}
@property (nonatomic, strong) UITableView *attentionTable;

@end

@implementation MyAttentionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataShource];
    [self initUI];

}

- (void)initDataShource{
    
    _dataArr = [@[] mutableCopy];
    [self RequestMethod];
}

- (void)RequestMethod{
    
    _attentionTable.mj_footer.state = MJRefreshStateIdle;
    _page = 1;
    [BaseRequest GET:PersonalGetSubList_URL parameters:nil success:^(id resposeObject) {

        [_attentionTable.mj_header endRefreshing];
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [self SetData:resposeObject[@"data"][@"data"]];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [_attentionTable.mj_header endRefreshing];
        [self showContent:@"网络错误"];
    }];
}

- (void)RequestAddMethod{
    
    _page += 1;
    [BaseRequest GET:PersonalGetSubList_URL parameters:@{@"page":@(_page)} success:^(id resposeObject) {
        
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if ([resposeObject[@"data"][@"data"] count]) {
                
                _attentionTable.mj_footer.state = MJRefreshStateIdle;
                [self SetData:resposeObject[@"data"][@"data"]];
            }else{
                
                _attentionTable.mj_footer.state = MJRefreshStateNoMoreData;
            }
        }else{
            
            [_attentionTable.mj_footer endRefreshing];
            _page -= 1;
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [_attentionTable.mj_footer endRefreshing];
        _page -= 1;
        [self showContent:@"网络错误"];
    }];
}

- (void)SetData:(NSArray *)data{
    
    for (int i = 0; i < data.count; i++) {
        
        NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:data[i]];

        [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            
            if ([obj isKindOfClass:[NSNull class]]) {
                
                if ([key isEqualToString:@"house_tags"] || [key isEqualToString:@"project_tags"]) {
                    
                    [tempDic setObject:@[] forKey:key];
                }else{
                    
                    [tempDic setObject:@"" forKey:key];
                }
            }else{
                
                if ([key isEqualToString:@"house_tags"] || [key isEqualToString:@"project_tags"]) {
                    
                    
                }else{
                    
                    [tempDic setObject:[NSString stringWithFormat:@"%@",obj] forKey:key];
                }
            }
        }];
        
        [_dataArr addObject:tempDic];
    }
    [_attentionTable reloadData];
}

#pragma table
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SecdaryAllTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SecdaryAllTableCell"];
    if (!cell) {
        
        cell = [[SecdaryAllTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SecdaryAllTableCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
//    SecdaryAllTableModel *model = _dataArr[indexPath.row];
//    cell.model = model;
    NSDictionary *dic = _dataArr[indexPath.row];
    
    [cell.headImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,dic[@"img_url"]]] placeholderImage:[UIImage imageNamed:@"default_3"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
        if (error) {
            
            cell.headImg.image = [UIImage imageNamed:@"default_3"];
        }
    }];
    
    cell.titleL.text = dic[@"title"];
    cell.contentL.text = dic[@"describe"];
    
    if ([dic[@"price"] length]) {
        
        cell.priceL.text = [NSString stringWithFormat:@"%@万",dic[@"price"]];
    }else{
        
        cell.priceL.text = @"暂无售价信息";
    }
    
    if ([dic[@"unit_price"] length]) {
        
        cell.averageL.text = [NSString stringWithFormat:@"%@元/㎡",dic[@"unit_price"]];
    }else{
        
        cell.averageL.text = @"暂无均价信息";
    }
    
    cell.typeL.text = [NSString stringWithFormat:@"物业类型：%@",dic[@"property_type"]];
    cell.storeL.text = [NSString stringWithFormat:@"所属门店：%@",dic[@"store_name"]];
    if ([dic[@"price_change"] integerValue] == 0) {
        
        cell.statusImg.image = [UIImage imageNamed:@""];
    }else if ([dic[@"price_change"] integerValue] == 1){
        
        cell.statusImg.image = [UIImage imageNamed:@"rising"];
    }else{
        
        cell.statusImg.image = [UIImage imageNamed:@"falling"];
    }
    
    [cell.tagView setData:dic[@"project_tags"]];
    [cell.tagView2 setData:dic[@"house_tags"]];
    [cell.priceL mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(cell.contentView).offset(123 *SIZE);
        make.top.equalTo(cell.contentL.mas_bottom).offset(8 *SIZE);
        make.width.equalTo(@(cell.priceL.mj_textWith + 5 *SIZE));
    }];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dic = @{@"focus_id":_dataArr[indexPath.row][@"focus_id"]};
    [BaseRequest GET:PersonalCancelFocusHouse_URL parameters:dic success:^(id resposeObject) {

        if ([resposeObject[@"code"] integerValue] == 200) {

            [_dataArr removeObjectAtIndex:indexPath.row];
            [tableView reloadData];
        }        else{
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {

        [self showContent:@"网络错误"];
    }];
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return @"取消关注";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *tempDic = _dataArr[indexPath.row];
    if ([tempDic[@"focus_type"] integerValue] == 2) {
        
        RentingAllRoomDetailVC *nextVC = [[RentingAllRoomDetailVC alloc] initWithHouseId:tempDic[@"house_id"] city:@""];
        nextVC.type = [tempDic[@"type"] integerValue];
        nextVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:nextVC animated:YES];
    }else{

        SecAllRoomDetailVC *nextVC = [[SecAllRoomDetailVC alloc] initWithHouseId:tempDic[@"house_id"] city:@""];
        nextVC.type = [tempDic[@"type"] integerValue];
        nextVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:nextVC animated:YES];
    }
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"我的关注";
    
    _attentionTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    _attentionTable.rowHeight = UITableViewAutomaticDimension;
    _attentionTable.estimatedRowHeight = 120 *SIZE;
    _attentionTable.backgroundColor = self.view.backgroundColor;
    _attentionTable.delegate = self;
    _attentionTable.dataSource = self;
    _attentionTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_attentionTable];
}
@end
