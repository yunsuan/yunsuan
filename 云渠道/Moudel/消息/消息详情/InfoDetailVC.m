//
//  InfoDetailVC.m
//  云渠道
//
//  Created by xiaoq on 2018/3/26.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "InfoDetailVC.h"
#import "InfoDetailCell.h"
#import "CountDownCell.h"

@interface InfoDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_data;
}
@property (nonatomic , strong) UITableView *Maintableview;
@property (nonatomic , strong) UIView *toolview;

-(void)initUI;
-(void)initDataSouce;
@end

@implementation InfoDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"消息详情";
    
    [self initDataSouce];
    [self initUI];
    [self post];
}

-(void)initUI
{
    [self.view addSubview:self.Maintableview];
    [self.view addSubview:self.toolview];
}

-(void)post{
    
    [BaseRequest GET:_url parameters:_extra_param success:^(id resposeObject) {

    } failure:^(NSError *error) {
        
    }];
}

-(void)initDataSouce
{
    _data = @[@"项目名称：凤凰国际",@"项目地址：dafdsfasdfasdfsadfasfasfasdf高新区-天府三街-000号",@"推荐时间：2017-10-23  19:00:00"];
}

#pragma mark    -----  delegate   ------

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *backview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 360*SIZE, 53*SIZE)];
    backview.backgroundColor = [UIColor whiteColor];
    UIView * header = [[UIView alloc]initWithFrame:CGRectMake(10*SIZE , 19*SIZE, 6.7*SIZE, 13.3*SIZE)];
    header.backgroundColor = YJBlueBtnColor;
    [backview addSubview:header];
    UILabel * title = [[UILabel alloc]initWithFrame:CGRectMake(27.3*SIZE, 19*SIZE, 300*SIZE, 16*SIZE)];
    title.font = [UIFont systemFontOfSize:15.3*SIZE];
    title.textColor = YJTitleLabColor;
    title.text = @"客户信息";
    [backview addSubview:title];
    return backview;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 53*SIZE;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section ==0&&indexPath.row ==2) {
        static NSString *CellIdentifier = @"CountDownCell";
        CountDownCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[CountDownCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        [cell setcountdownbyday:0 hours:0 min:0 sec:30];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        static NSString *CellIdentifier = @"InfoDetailCell";
        InfoDetailCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[InfoDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        [cell SetCellContentbystring:_data[indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    
}


#pragma mark    -----  懒加载    ------

-(UITableView *)Maintableview
{
    if (!_Maintableview) {

        _Maintableview = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, 360*SIZE, SCREEN_Height-NAVIGATION_BAR_HEIGHT-46.3*SIZE) style:UITableViewStyleGrouped];
        _Maintableview.rowHeight = UITableViewAutomaticDimension;
        _Maintableview.estimatedRowHeight = 150 *SIZE;
        _Maintableview.backgroundColor = YJBackColor;
        _Maintableview.delegate = self;
        _Maintableview.dataSource = self;
        [_Maintableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }
    return _Maintableview;
}


-(UIView *)toolview
{
    if (!_toolview) {
        _toolview  = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_Height-TAB_BAR_HEIGHT, 360*SIZE, TAB_BAR_HEIGHT)];
        _toolview.backgroundColor = YJLoginBtnColor;
    }
    return _toolview;
}


@end
