//
//  CustomMatchListVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/8.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "CustomMatchListVC.h"
#import "RoomDetailTableCell5.h"

@interface CustomMatchListVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>{
    
    NSMutableArray *_dataArr;
    NSMutableArray *_tempArr;
    NSString *_projectId;
}

@property (nonatomic , strong) UITableView *matchTable;

@property (nonatomic, strong) UITextField *searchBar;

@end

@implementation CustomMatchListVC

- (instancetype)initWithDataArr:(NSArray *)dataArr projectId:(NSString *)projectId
{
    self = [super init];
    if (self) {
        
        _projectId = projectId;
        _dataArr = [NSMutableArray arrayWithArray:dataArr];
        _tempArr = [NSMutableArray arrayWithArray:dataArr];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _tempArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RoomDetailTableCell5 *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomDetailTableCell5"];
    if (!cell) {
        
        cell = [[RoomDetailTableCell5 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomDetailTableCell5"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = _tempArr[indexPath.row];
    cell.recommendBtn.tag = indexPath.row;
    cell.recommendBtnBlock5 = ^(NSInteger index) {
        
        CustomMatchModel *model = _tempArr[index];
        [BaseRequest POST:RecommendClient_URL parameters:@{@"project_id":_projectId,@"client_need_id":model.need_id,@"client_id":model.client_id} success:^(id resposeObject) {
                      
            if ([resposeObject[@"code"] integerValue] == 200) {
                
                [self alertControllerWithNsstring:@"推荐成功" And:nil WithDefaultBlack:^{
                   
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"matchReload" object:nil];
                    [self.navigationController popViewControllerAnimated:YES];
                }];
            }
            else{
                [self showContent:resposeObject[@"msg"]];
            }
        } failure:^(NSError *error) {
            
            [self showContent:@"网络错误"];
        }];
    };
    return cell;
}

- (void)textFieldDidChange:(NSNotification *)notification{
    
    [_tempArr removeAllObjects];
    UITextField *sender = (UITextField *)[notification object];
    if (sender.text.length) {

        for (CustomMatchModel *model in _dataArr) {

            if ([model.name containsString:sender.text] ||[model.tel containsString:sender.text]) {

                [_tempArr addObject:model];
            }
        }
    }else{

        _tempArr = [NSMutableArray arrayWithArray:_dataArr];
    }
    
    [_matchTable reloadData];
}

- (void)initUI{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:_searchBar];
    
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 62 *SIZE + STATUS_BAR_HEIGHT)];
    whiteView.backgroundColor = CH_COLOR_white;
    [self.view addSubview:whiteView];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT + 61 *SIZE, SCREEN_Width, SIZE)];
    line.backgroundColor = YJBackColor;
    [whiteView addSubview:line];
    
    self.leftButton.center = CGPointMake(25 * sIZE, STATUS_BAR_HEIGHT + 30 *SIZE);
    self.leftButton.bounds = CGRectMake(0, 0, 80 * sIZE, 33 * sIZE);
    self.maskButton.frame = CGRectMake(0, STATUS_BAR_HEIGHT, 60 * sIZE, 44 *SIZE);
    
    [whiteView addSubview:self.leftButton];
    [whiteView addSubview:self.maskButton];
    
    _searchBar = [[UITextField alloc] initWithFrame:CGRectMake(38 *SIZE, STATUS_BAR_HEIGHT + 14  *SIZE, 283 *SIZE, 33 *SIZE)];
    _searchBar.backgroundColor = YJBackColor;
    _searchBar.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 11 *SIZE, 0)];
    //设置显示模式为永远显示(默认不显示)
    _searchBar.leftViewMode = UITextFieldViewModeAlways;
    _searchBar.placeholder = @"客户姓名/电话";
    _searchBar.font = [UIFont systemFontOfSize:11 *SIZE];
    _searchBar.returnKeyType = UIReturnKeySearch;
    UIImageView *rightImg = [[UIImageView alloc] initWithFrame:CGRectMake(0 *SIZE, 8 *SIZE, 17 *SIZE, 17 *SIZE)];
//    rightImg.backgroundColor = YJGreenColor;
    rightImg.image = [UIImage imageNamed:@"search_2"];
    _searchBar.rightView = rightImg;
    _searchBar.rightViewMode = UITextFieldViewModeUnlessEditing;
    _searchBar.clearButtonMode = UITextFieldViewModeWhileEditing;
    _searchBar.delegate = self;
    [whiteView addSubview:_searchBar];
    
    _matchTable = [[UITableView alloc] initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT + 62 *SIZE , SCREEN_Width, SCREEN_Height - STATUS_BAR_HEIGHT - 62 *SIZE  - TAB_BAR_MORE) style:UITableViewStylePlain];;
    _matchTable.backgroundColor = self.view.backgroundColor;
    _matchTable.delegate = self;
    _matchTable.dataSource = self;
    _matchTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_matchTable];
}

@end
