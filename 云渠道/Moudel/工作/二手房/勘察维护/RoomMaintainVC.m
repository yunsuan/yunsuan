//
//  RoomMaintainVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/6/20.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RoomMaintainVC.h"
#import "MaintainDetailVC.h"
#import "CompleteSurveyInfoVC.h"
#import "SecdaryCommunityRoomVC.h"
#import "RoomReportAddVC.h"

#import "RoomMaintainCell.h"

#import "RoomMaintainModel.h"

@interface RoomMaintainVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    
    NSMutableArray *_dataArr;
    NSString *_search;
    NSInteger _page;
}

@property (nonatomic, strong) UITextField *searchBar;

@property (nonatomic, strong) UITableView *table;

@end

@implementation RoomMaintainVC

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
    
    _table.mj_footer.state = MJRefreshStateIdle;
    _page = 1;
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"page":@(_page)}];
    if (![self isEmpty:_search]) {
        
        [dic setObject:_search forKey:@"search"];
    }
    [BaseRequest GET:HouseSurveyList_URL parameters:dic success:^(id resposeObject) {
        
        [_table.mj_header endRefreshing];
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [_dataArr removeAllObjects];
            [self SetData:resposeObject[@"data"][@"data"]];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [_table.mj_header endRefreshing];
        [self showContent:@"网络错误"];
        NSLog(@"%@",error);
    }];
}

- (void)RequestAddMethod{
    
    _page += 1;
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"page":@(_page)}];
    if (![self isEmpty:_search]) {
        
        [dic setObject:_search forKey:@"search"];
    }
    [BaseRequest GET:HouseSurveyList_URL parameters:dic success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            
            [self SetData:resposeObject[@"data"][@"data"]];
            if ([resposeObject[@"data"][@"data"] count] < 15) {
                
                _table.mj_footer.state = MJRefreshStateNoMoreData;
            }else{
                
                [_table.mj_footer endRefreshing];
            }
        }else{
            
            [_table.mj_footer endRefreshing];
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [_table.mj_footer endRefreshing];
        [self showContent:@"网络错误"];
        NSLog(@"%@",error);
    }];
}

- (void)SetData:(NSArray *)data{
    
    
    for (int i = 0; i < data.count; i++) {
        
        NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:data[i]];
        
        [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
           
            if ([obj isKindOfClass:[NSNull class]]) {
                
                [tempDic setObject:@"" forKey:key];
            }else{
                
                [tempDic setObject:[NSString stringWithFormat:@"%@",obj] forKey:key];
            }
        }];
        
        RoomMaintainModel *model = [[RoomMaintainModel alloc] initWithDictionary:tempDic];
        [_dataArr addObject:model];
    }
    
    [_table reloadData];
}

- (void)ActionAddBtn:(UIButton *)btn{
    
    RoomReportAddVC *nextVC = [[RoomReportAddVC alloc] init];
    nextVC.status = @"complete";
    nextVC.roomReportAddHouseBlock = ^(NSDictionary *dic) {
        
        [self RequestMethod];
    };
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    _search = textField.text;
    [self RequestMethod];
    return YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RoomMaintainCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomMaintainCell"];
    if (!cell) {
        
        cell = [[RoomMaintainCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomMaintainCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.tag = indexPath.row;
    
    RoomMaintainModel *model = _dataArr[indexPath.row];
    cell.model = model;
    
    
    cell.roomMaintainPhoneBlock = ^(NSInteger index) {

        NSString *phone = model.tel;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RoomMaintainModel *model = _dataArr[indexPath.row];
    MaintainDetailVC *nextVC = [[MaintainDetailVC alloc] initWithSurveyId:model.survey_id houseId:model.house_id type:[model.type integerValue]];
    nextVC.edit = YES;
    nextVC.maintainDetailVCBlock = ^{
      
        [self RequestMethod];
    };
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"勘察维护";
    
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, 40 *SIZE)];
    whiteView.backgroundColor = CH_COLOR_white;
    [self.view addSubview:whiteView];
    
    _searchBar = [[UITextField alloc] initWithFrame:CGRectMake(10 *SIZE, 3 *SIZE, 340 *SIZE, 33 *SIZE)];
    _searchBar.backgroundColor = YJBackColor;
    _searchBar.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 11 *SIZE, 0)];
    //设置显示模式为永远显示(默认不显示)
    _searchBar.leftViewMode = UITextFieldViewModeAlways;
    _searchBar.placeholder = @"输入电话/姓名";
    _searchBar.font = [UIFont systemFontOfSize:12 *SIZE];
    _searchBar.layer.cornerRadius = 2 *SIZE;
    _searchBar.delegate = self;
    _searchBar.returnKeyType = UIReturnKeySearch;
    
    UIImageView *rightImg = [[UIImageView alloc] initWithFrame:CGRectMake(0 *SIZE, 8 *SIZE, 17 *SIZE, 17 *SIZE)];
    //    rightImg.backgroundColor = [UIColor whiteColor];
    rightImg.image = [UIImage imageNamed:@"search"];
    _searchBar.rightView = rightImg;
    _searchBar.rightViewMode = UITextFieldViewModeUnlessEditing;
    _searchBar.clearButtonMode = UITextFieldViewModeWhileEditing;
    _searchBar.delegate = self;
    [whiteView addSubview:_searchBar];
    
    self.rightBtn.hidden = NO;
    [self.rightBtn setImage:[UIImage imageNamed:@"add_3"] forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(ActionAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT + 40 *SIZE, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - 40 *SIZE) style:UITableViewStylePlain];
    _table.estimatedRowHeight = 108 *sIZE;
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.backgroundColor = self.view.backgroundColor;
    _table.delegate = self;
    _table.dataSource = self;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_table];
    _table.mj_header = [GZQGifHeader headerWithRefreshingBlock:^{
       
        [self RequestMethod];
    }];
}

@end
