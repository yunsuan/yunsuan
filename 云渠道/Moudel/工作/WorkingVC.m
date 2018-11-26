//
//  WorkingVC.m
//  云渠道
//
//  Created by xiaoq on 2018/3/13.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "WorkingVC.h"
//新房
#import "RecommendVC.h"
#import "NomineeVC.h"
#import "BarginVC.h"
//二手房
#import "RoomReportVC.h"
#import "RoomSurveyVC.h"
#import "RoomAgencyVC.h"
#import "RoomMaintainVC.h"

//租房
#import "RentingReportVC.h"
#import "RentingSurveyVC.h"
#import "RentingRoomMaintainVC.h"
#import "RentingRoomAgencyVC.h"


#import "WorkingCell.h"
#import "BaseHeader.h"

@interface WorkingVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_namelist;
    NSArray *_imglist;
    NSArray *_countdata;
    NSArray *_secondArr;
    NSArray *_secondImgArr;
    NSArray *_secCountData;
}

@property (nonatomic , strong) UITableView *MainTableView;

-(void)initUI;
-(void)initDateSouce;
@end

@implementation WorkingVC

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self postWithidentify:[UserModelArchiver unarchive].agent_identity];
    [self refresh];

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = YJBackColor;
    self.navBackgroundView.hidden = NO;
    self.leftButton.hidden = YES;
    self.titleLabel.text = @"工作";
    self.leftButton.hidden = YES;
    [self initDateSouce];
    [self initUI];

}

-(void)refresh{
    [BaseRequest GET:FlushDate_URL parameters:nil success:^(id resposeObject) {
        
    } failure:^(NSError *error) {
      
    }];
}

-(void)postWithidentify:(NSString *)identify
{
    switch ([identify integerValue]) {
        case 1:
        {
            _namelist = @[@"新房推荐",@"客户报备",@"成交客户"];
            _imglist = @[@"recommended",@"client",@"Clinchadeal"];
             _countdata  = @[@"",@"",@""];
            [BaseRequest GET:AgentInfoCount_URL parameters:nil success:^(id resposeObject) {
                
                [_MainTableView.mj_header endRefreshing];
                if ([resposeObject[@"code"]integerValue] ==200) {
                    
                    _countdata = @[[NSString stringWithFormat:@"累计推荐%@，有效%@，无效%@",resposeObject[@"data"][@"recommend"][@"total"],resposeObject[@"data"][@"recommend"][@"value"],resposeObject[@"data"][@"recommend"][@"disabled"]],[NSString stringWithFormat:@"累计报备%@，有效%@，无效%@",resposeObject[@"data"][@"preparation"][@"total"],resposeObject[@"data"][@"preparation"][@"value"],resposeObject[@"data"][@"preparation"][@"disabled"]],[NSString stringWithFormat:@"累计笔数%@，成交%@，未成交%@",resposeObject[@"data"][@"deal"][@"total"],resposeObject[@"data"][@"deal"][@"value"],resposeObject[@"data"][@"deal"][@"disabled"]]];
                    
                    _secCountData = @[[NSString stringWithFormat:@"报备有效%@，报备无效%@，累计%@",resposeObject[@"data"][@"house_record"][@"value"],resposeObject[@"data"][@"house_record"][@"disabled"],resposeObject[@"data"][@"house_record"][@"total"]],[NSString stringWithFormat:@"有效房源%@，无效%@，房源累计%@套",resposeObject[@"data"][@"house_survey"][@"value"],resposeObject[@"data"][@"house_survey"][@"disabled"],resposeObject[@"data"][@"house_survey"][@"total"]],[NSString stringWithFormat:@"维护房源%@套",resposeObject[@"data"][@"house_maintain"][@"total"]],[NSString stringWithFormat:@"今日新增%@，累计%@，变更%@套",resposeObject[@"data"][@"house_sub"][@"today"],resposeObject[@"data"][@"house_sub"][@"total"],resposeObject[@"data"][@"house_sub"][@"change"]],[NSString stringWithFormat:@"今日新增%@，累计%@",resposeObject[@"data"][@"house_contract"][@"today"],resposeObject[@"data"][@"house_contract"][@"total"]]];
                }
           
                [_MainTableView reloadData];
            } failure:^(NSError *error) {
                
                [_MainTableView.mj_header endRefreshing];
            }];
        }
            break;
        case 2:{
            _namelist = @[@"新房推荐"];
            _imglist = @[@"recommended"];
            _countdata  = @[@""];
            [BaseRequest GET:Butterinfocount_URL parameters:nil success:^(id resposeObject) {
                
                [_MainTableView.mj_header endRefreshing];
                if ([resposeObject[@"code"] integerValue] ==200) {
                
                    
                _countdata = @[[NSString stringWithFormat:@"累计推荐%@，有效%@，无效%@",resposeObject[@"data"][@"recommend_count"],resposeObject[@"data"][@"value"],resposeObject[@"data"][@"valueDisabled"]]];
                }

                _secCountData = @[[NSString stringWithFormat:@"报备有效%@，报备无效%@，累计%@",resposeObject[@"data"][@"house_record"][@"value"],resposeObject[@"data"][@"house_record"][@"disabled"],resposeObject[@"data"][@"house_record"][@"total"]],[NSString stringWithFormat:@"有效房源%@，无效%@，房源累计%@套",resposeObject[@"data"][@"house_survey"][@"value"],resposeObject[@"data"][@"house_survey"][@"disabled"],resposeObject[@"data"][@"house_survey"][@"total"]],[NSString stringWithFormat:@"维护房源%@套",resposeObject[@"data"][@"house_maintain"][@"total"]],[NSString stringWithFormat:@"今日新增%@，累计%@，变更%@套",resposeObject[@"data"][@"house_sub"][@"today"],resposeObject[@"data"][@"house_sub"][@"total"],resposeObject[@"data"][@"house_sub"][@"change"]],[NSString stringWithFormat:@"今日新增%@，累计%@",resposeObject[@"data"][@"house_contract"][@"today"],resposeObject[@"data"][@"house_contract"][@"total"]]];
                [_MainTableView reloadData];
            } failure:^(NSError *error) {

                [_MainTableView.mj_header endRefreshing];
            }];
        }
            break;
        
        default:{
            break;
        }
            
    }

    
}

-(void)initDateSouce
{
   
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadType) name:@"reloadType" object:nil];
    _secondArr = @[@"房源报备",@"房源勘察",@"勘察维护",@"代购合同",@"合同签订"];
    _secondImgArr = @[@"reported",@"investigate",@"maintenance",@"contract",@"signing"];
}

- (void)reloadType{
    
    [self postWithidentify:[UserModelArchiver unarchive].agent_identity];
}

-(void)initUI
{
    [self.view addSubview:self.MainTableView];
    self.MainTableView.mj_header = [GZQGifHeader headerWithRefreshingBlock:^{
        
        [self reloadType];
    }];
}



#pragma mark  ---  delegate   ---

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
    
        if ([[UserModelArchiver unarchive].agent_identity integerValue]==1) {

            return 3;
        }
        else{

            return 1;
        }
    }else{

        return 5;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40 *SIZE;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 84*SIZE;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [[UIView alloc] init];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    BaseHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BaseHeader"];
    if (!header) {
        
        header = [[BaseHeader alloc] initWithReuseIdentifier:@"BaseHeader"];
    }
    if (section == 0) {
        
        header.titleL.text = @"新房";
    }else if (section == 1){
        
        header.titleL.text = @"二手房";
    }else{
        
        header.titleL.text = @"租房";
    }
    return header;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        
        static NSString *CellIdentifier = @"WorkingCell";

        WorkingCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[WorkingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [cell setTitle:_namelist[indexPath.row] content:_countdata[indexPath.row] img:_imglist[indexPath.row]];
        return cell;
    }else if (indexPath.section == 1){
        
        static NSString *CellIdentifier = @"WorkingCell";
        
        WorkingCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[WorkingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        [cell setTitle:_secondArr[indexPath.row] content:_secCountData[indexPath.row] img:_secondImgArr[indexPath.row]];

        return cell;
    }else{
        
        static NSString *CellIdentifier = @"WorkingCell";
        
        WorkingCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[WorkingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        //        cell.titlelab.text = _secondArr[indexPath.row];
        //        cell.headimg.image = [UIImage imageNamed:_secondImgArr[indexPath.row]];
        switch (indexPath.row) {
            case 0:
            {
                
                [cell setTitle:_secondArr[indexPath.row] content:@"报备有效12，报备无效0，累计11" img:_secondImgArr[indexPath.row]];
                break;
            }
            case 1:
            {
                [cell setTitle:_secondArr[indexPath.row] content:@"有效房源12，无效0，房源累计11套" img:_secondImgArr[indexPath.row]];
                break;
            }
            case 2:
            {
                [cell setTitle:_secondArr[indexPath.row] content:@"维护房源12套" img:_secondImgArr[indexPath.row]];
                break;
            }
            case 3:
            case 4:
            {
                [cell setTitle:_secondArr[indexPath.row] content:@"今日新增12，累计20，变更11套" img:_secondImgArr[indexPath.row]];
                break;
            }
            default:
                break;
        }
        return cell;
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (indexPath.section == 0) {

        if ([[UserModelArchiver unarchive].agent_identity integerValue]==2) {
            if (indexPath.row == 0) {

                RecommendVC *nextVC = [[RecommendVC alloc] init];
                [self.navigationController pushViewController:nextVC animated:YES];
            }
        }
        else{
            if (indexPath.row == 0) {

                RecommendVC *nextVC = [[RecommendVC alloc] init];
                [self.navigationController pushViewController:nextVC animated:YES];
            }else if(indexPath.row == 1){

                NomineeVC *nextVC = [[NomineeVC alloc] init];
                [self.navigationController pushViewController:nextVC animated:YES];
            }else{

                BarginVC *nextVC = [[BarginVC alloc] init];
                [self.navigationController pushViewController:nextVC animated:YES];
            }
        }
    }else if(indexPath.section == 2){
    
        if (indexPath.row == 0) {

            RentingReportVC *nextVC = [[RentingReportVC alloc] init];
            [self.navigationController pushViewController:nextVC animated:YES];
        }else if (indexPath.row == 1){

            RentingSurveyVC *nextVC = [[RentingSurveyVC alloc] init];
            [self.navigationController pushViewController:nextVC animated:YES];
        }else if (indexPath.row == 2){

            RentingRoomMaintainVC *nextVC = [[RentingRoomMaintainVC alloc] init];
            [self.navigationController pushViewController:nextVC animated:YES];
        }else{

            RentingRoomAgencyVC *nextVC = [[RentingRoomAgencyVC alloc] init];
            [self.navigationController pushViewController:nextVC animated:YES];
        }
    }else{

        if (indexPath.row == 0) {

            RoomReportVC *nextVC = [[RoomReportVC alloc] init];
            [self.navigationController pushViewController:nextVC animated:YES];
        }else if (indexPath.row == 1){

            RoomSurveyVC *nextVC = [[RoomSurveyVC alloc] init];
            [self.navigationController pushViewController:nextVC animated:YES];
        }else if (indexPath.row == 3){

            RoomAgencyVC *nextVC = [[RoomAgencyVC alloc] init];
            [self.navigationController pushViewController:nextVC animated:YES];
        }else if (indexPath.row == 2){

            RoomMaintainVC *nextVC = [[RoomMaintainVC alloc] init];
            [self.navigationController pushViewController:nextVC animated:YES];
        }
    }
}



#pragma mark  ---  懒加载   ---
-(UITableView *)MainTableView
{
    if(!_MainTableView)
    {
        _MainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT+1*SIZE, 360*SIZE, SCREEN_Height-NAVIGATION_BAR_HEIGHT-1*SIZE - TAB_BAR_HEIGHT) style:UITableViewStyleGrouped];
        _MainTableView.backgroundColor = YJBackColor;
        _MainTableView.delegate = self;
        _MainTableView.dataSource = self;
        [_MainTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }
    return _MainTableView;
}



@end
