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
#import "RecommendVC1.h"
#import "NomineeVC.h"
#import "NomineeVC1.h"
#import "BarginVC.h"
#import "BarginVC1.h"
#import "ConfirmPhoneVC.h"
//二手房
#import "RoomReportVC.h"
#import "RoomSurveyVC.h"
#import "RoomAgencyVC.h"
#import "RoomMaintainVC.h"
#import "CustomLookVC.h"
#import "CustomRecommendVC.h"
#import "LookMaintainVC.h"
#import "ContractSignVC.h"

//租房
#import "RentingReportVC.h"
#import "RentingSurveyVC.h"
#import "RentingRoomMaintainVC.h"
#import "RentingRoomAgencyVC.h"


#import "WorkingCell.h"
#import "BaseHeader.h"
#import "WorkSelectView.h"

@interface WorkingVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_namelist;
    NSArray *_imglist;
    NSArray *_countdata;
    NSArray *_secondArr;
    NSArray *_rentArr;
    NSArray *_secondImgArr;
    NSArray *_secCountData;
    NSArray *_rentCountData;
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

                    _rentCountData = @[[NSString stringWithFormat:@"报备有效%@，报备无效%@，累计%@",resposeObject[@"data"][@"rent_record"][@"value"],resposeObject[@"data"][@"rent_record"][@"disabled"],resposeObject[@"data"][@"rent_record"][@"total"]],[NSString stringWithFormat:@"有效房源%@，无效%@，房源累计%@套",resposeObject[@"data"][@"rent_survey"][@"value"],resposeObject[@"data"][@"rent_survey"][@"disabled"],resposeObject[@"data"][@"rent_survey"][@"total"]],[NSString stringWithFormat:@"维护房源%@套",resposeObject[@"data"][@"rent_maintain"][@"total"]],[NSString stringWithFormat:@"今日新增%@，累计%@，变更%@套",resposeObject[@"data"][@"rent_sub"][@"today"],resposeObject[@"data"][@"rent_sub"][@"total"],resposeObject[@"data"][@"rent_sub"][@"change"]],[NSString stringWithFormat:@"今日新增%@，累计%@",resposeObject[@"data"][@"rent_contract"][@"today"],resposeObject[@"data"][@"rent_contract"][@"total"]]];

                    _secCountData = @[//1房源报备
                                      [NSString stringWithFormat:@"报备有效%@，报备无效%@，累计%@",resposeObject[@"data"][@"house_record"][@"value"],resposeObject[@"data"][@"house_record"][@"disabled"],resposeObject[@"data"][@"house_record"][@"total"]],
                                      //2勘察
                                      [NSString stringWithFormat:@"有效房源%@，无效%@，房源累计%@套",resposeObject[@"data"][@"house_survey"][@"value"],resposeObject[@"data"][@"house_survey"][@"disabled"],resposeObject[@"data"][@"house_survey"][@"total"]],
                                      //3勘察维护
                                      [NSString stringWithFormat:@"维护房源%@套",resposeObject[@"data"][@"house_maintain"][@"total"]],
                                      //4客源推荐
                                    [NSString stringWithFormat:@"推荐有效%@，推荐无效%@，累计%@",resposeObject[@"data"][@"house_take_recommend"][@"value"],resposeObject[@"data"][@"house_take_recommend"][@"disabled"],resposeObject[@"data"][@"house_take_recommend"][@"total"]],
                                      //5带看
                                    [NSString stringWithFormat:@"带看有效%@，带看无效%@，累计%@",resposeObject[@"data"][@"house_take"][@"value"],resposeObject[@"data"][@"house_take"][@"disabled"],resposeObject[@"data"][@"house_take"][@"total"]],
                                      //6带看维护
                                      [NSString stringWithFormat:@"累计%@条",resposeObject[@"data"][@"house_take_maintain"][@"total"]],
                              
                                    //代购
                                    [NSString stringWithFormat:@"今日新增%@，累计%@，变更%@套",resposeObject[@"data"][@"house_sub"][@"today"],resposeObject[@"data"][@"house_sub"][@"total"],resposeObject[@"data"][@"house_sub"][@"change"]],
                                      //8合同
                                      [NSString stringWithFormat:@"今日新增%@，累计%@",resposeObject[@"data"][@"house_contract"][@"today"],resposeObject[@"data"][@"house_contract"][@"total"]]];

                }

                [_MainTableView reloadData];
            } failure:^(NSError *error) {

                [_MainTableView.mj_header endRefreshing];
            }];
        }
            break;
        case 2:{
            _namelist = @[@"号码判重",@"新房推荐"];
            _imglist = @[@"ys_find",@"recommended"];
            _countdata  = @[@"",@""];
            [BaseRequest GET:Butterinfocount_URL parameters:nil success:^(id resposeObject) {

                [_MainTableView.mj_header endRefreshing];
                if ([resposeObject[@"code"] integerValue] ==200) {
                    
                    _countdata = @[[NSString stringWithFormat:@"累计推荐%@，有效%@，无效%@",resposeObject[@"data"][@"tel_check"][@"total"],resposeObject[@"data"][@"tel_check"][@"value"],resposeObject[@"data"][@"tel_check"][@"disabled"]],[NSString stringWithFormat:@"累计推荐%@，有效%@，无效%@",resposeObject[@"data"][@"recommend_count"],resposeObject[@"data"][@"value"],resposeObject[@"data"][@"valueDisabled"]]];
                }

                _secCountData = @[//1房源报备
                                  [NSString stringWithFormat:@"报备有效%@，报备无效%@，累计%@",resposeObject[@"data"][@"house_record"][@"value"],resposeObject[@"data"][@"house_record"][@"disabled"],resposeObject[@"data"][@"house_record"][@"total"]],
                                  //2勘察
                                  [NSString stringWithFormat:@"有效房源%@，无效%@，房源累计%@套",resposeObject[@"data"][@"house_survey"][@"value"],resposeObject[@"data"][@"house_survey"][@"disabled"],resposeObject[@"data"][@"house_survey"][@"total"]],
                                  //3勘察维护
                                  [NSString stringWithFormat:@"维护房源%@套",resposeObject[@"data"][@"house_maintain"][@"total"]],
                                  //4客源推荐
                                  [NSString stringWithFormat:@"推荐有效%@，推荐无效%@，累计%@",resposeObject[@"data"][@"house_take_recommend"][@"value"],resposeObject[@"data"][@"house_take_recommend"][@"disabled"],resposeObject[@"data"][@"house_take_recommend"][@"total"]],
                                  //5带看
                                  [NSString stringWithFormat:@"带看有效%@，带看无效%@，累计%@",resposeObject[@"data"][@"house_take"][@"value"],resposeObject[@"data"][@"house_take"][@"disabled"],resposeObject[@"data"][@"house_take"][@"total"]],
                                  //6带看维护
                                  [NSString stringWithFormat:@"累计%@条",resposeObject[@"data"][@"house_take_maintain"][@"total"]],
                                  
                                  //代购
                                  [NSString stringWithFormat:@"今日新增%@，累计%@，变更%@套",resposeObject[@"data"][@"house_sub"][@"today"],resposeObject[@"data"][@"house_sub"][@"total"],resposeObject[@"data"][@"house_sub"][@"change"]],
                                  //8合同
                                  [NSString stringWithFormat:@"今日新增%@，累计%@",resposeObject[@"data"][@"house_contract"][@"today"],resposeObject[@"data"][@"house_contract"][@"total"]]];


                _rentCountData = @[[NSString stringWithFormat:@"报备有效%@，报备无效%@，累计%@",resposeObject[@"data"][@"rent_record"][@"value"],resposeObject[@"data"][@"rent_record"][@"disabled"],resposeObject[@"data"][@"rent_record"][@"total"]],[NSString stringWithFormat:@"有效房源%@，无效%@，房源累计%@套",resposeObject[@"data"][@"rent_survey"][@"value"],resposeObject[@"data"][@"rent_survey"][@"disabled"],resposeObject[@"data"][@"rent_survey"][@"total"]],[NSString stringWithFormat:@"维护房源%@套",resposeObject[@"data"][@"rent_maintain"][@"total"]],[NSString stringWithFormat:@"今日新增%@，累计%@，变更%@套",resposeObject[@"data"][@"rent_sub"][@"today"],resposeObject[@"data"][@"rent_sub"][@"total"],resposeObject[@"data"][@"rent_sub"][@"change"]],[NSString stringWithFormat:@"今日新增%@，累计%@",resposeObject[@"data"][@"rent_contract"][@"today"],resposeObject[@"data"][@"rent_contract"][@"total"]]];

                [_MainTableView reloadData];
            } failure:^(NSError *error) {

                [_MainTableView.mj_header endRefreshing];
            }];
        }
            break;
        case 3:{
            
            _namelist = @[@"新房推荐"];
            _imglist = @[@"recommended"];
            _countdata  = @[@""];
            [BaseRequest GET:Butterinfocount_URL parameters:nil success:^(id resposeObject) {
                
                [_MainTableView.mj_header endRefreshing];
                if ([resposeObject[@"code"] integerValue] ==200) {
                    
                    _countdata = @[[NSString stringWithFormat:@"累计推荐%@，有效%@，无效%@",resposeObject[@"data"][@"recommend_count"],resposeObject[@"data"][@"value"],resposeObject[@"data"][@"valueDisabled"]]];
                }
                
                _secCountData = @[//1房源报备
                                  [NSString stringWithFormat:@"报备有效%@，报备无效%@，累计%@",resposeObject[@"data"][@"house_record"][@"value"],resposeObject[@"data"][@"house_record"][@"disabled"],resposeObject[@"data"][@"house_record"][@"total"]],
                                  //2勘察
                                  [NSString stringWithFormat:@"有效房源%@，无效%@，房源累计%@套",resposeObject[@"data"][@"house_survey"][@"value"],resposeObject[@"data"][@"house_survey"][@"disabled"],resposeObject[@"data"][@"house_survey"][@"total"]],
                                  //3勘察维护
                                  [NSString stringWithFormat:@"维护房源%@套",resposeObject[@"data"][@"house_maintain"][@"total"]],
                                  //4客源推荐
                                  [NSString stringWithFormat:@"推荐有效%@，推荐无效%@，累计%@",resposeObject[@"data"][@"house_take_recommend"][@"value"],resposeObject[@"data"][@"house_take_recommend"][@"disabled"],resposeObject[@"data"][@"house_take_recommend"][@"total"]],
                                  //5带看
                                  [NSString stringWithFormat:@"带看有效%@，带看无效%@，累计%@",resposeObject[@"data"][@"house_take"][@"value"],resposeObject[@"data"][@"house_take"][@"disabled"],resposeObject[@"data"][@"house_take"][@"total"]],
                                  //6带看维护
                                  [NSString stringWithFormat:@"累计%@条",resposeObject[@"data"][@"house_take_maintain"][@"total"]],
                                  
                                  //代购
                                  [NSString stringWithFormat:@"今日新增%@，累计%@，变更%@套",resposeObject[@"data"][@"house_sub"][@"today"],resposeObject[@"data"][@"house_sub"][@"total"],resposeObject[@"data"][@"house_sub"][@"change"]],
                                  //8合同
                                  [NSString stringWithFormat:@"今日新增%@，累计%@",resposeObject[@"data"][@"house_contract"][@"today"],resposeObject[@"data"][@"house_contract"][@"total"]]];
                
                
                _rentCountData = @[[NSString stringWithFormat:@"报备有效%@，报备无效%@，累计%@",resposeObject[@"data"][@"rent_record"][@"value"],resposeObject[@"data"][@"rent_record"][@"disabled"],resposeObject[@"data"][@"rent_record"][@"total"]],[NSString stringWithFormat:@"有效房源%@，无效%@，房源累计%@套",resposeObject[@"data"][@"rent_survey"][@"value"],resposeObject[@"data"][@"rent_survey"][@"disabled"],resposeObject[@"data"][@"rent_survey"][@"total"]],[NSString stringWithFormat:@"维护房源%@套",resposeObject[@"data"][@"rent_maintain"][@"total"]],[NSString stringWithFormat:@"今日新增%@，累计%@，变更%@套",resposeObject[@"data"][@"rent_sub"][@"today"],resposeObject[@"data"][@"rent_sub"][@"total"],resposeObject[@"data"][@"rent_sub"][@"change"]],[NSString stringWithFormat:@"今日新增%@，累计%@",resposeObject[@"data"][@"rent_contract"][@"today"],resposeObject[@"data"][@"rent_contract"][@"total"]]];
                
                [_MainTableView reloadData];
            } failure:^(NSError *error) {
                
                [_MainTableView.mj_header endRefreshing];
            }];
            break;
        }
        default:{
            break;
        }

    }


}

-(void)initDateSouce
{

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ReloadType) name:@"reloadType" object:nil];
    if (![UserModel defaultModel].workArr.count) {

        [UserModel defaultModel].workArr = [NSMutableArray arrayWithArray:@[@"新房",@"二手房",@"租房"]];
        [UserModelArchiver archive];
    }
    _secondArr = @[@"房源报备",@"房源勘察",@"勘察维护",@"客源推荐",@"客源带看",@"带看维护",@"代购合同",@"合同签订"];
    _rentArr = @[@"房源报备",@"房源勘察",@"勘察维护",@"定租合同"];//,@"合同签订"];
    _secondImgArr = @[@"reported",@"investigate",@"maintenance",@"kehutuijian",@"takelook",@"daikanweihu",@"contract",@"signing"];
}

-(void)initUI
{
    self.rightBtn.hidden = NO;
    [self.rightBtn addTarget:self action:@selector(ActionMoreBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightBtn setImage:[UIImage imageNamed:@"add_50"] forState:UIControlStateNormal];
    [self.view addSubview:self.MainTableView];
}

- (void)ReloadType{
    
    [self postWithidentify:[UserModelArchiver unarchive].agent_identity];
}

- (void)ActionMoreBtn:(UIButton *)btn{


    WorkSelectView *view = [[WorkSelectView alloc] initWithFrame:CGRectMake(0, SCREEN_Height, SCREEN_Width, SCREEN_Height -STATUS_BAR_HEIGHT)];

    view.clickblook = ^(int selctnum) {

        
    };

    view.hideblook = ^{

        [_MainTableView reloadData];
    };
    [[UIApplication sharedApplication].keyWindow addSubview:view];
    [view show];
}


#pragma mark  ---  delegate   ---

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([[UserModel defaultModel].workArr[section] isEqualToString:@"新房"]) {

        if ([[UserModelArchiver unarchive].agent_identity integerValue]==1) {

            return 3;
        }else if ([[UserModelArchiver unarchive].agent_identity integerValue]==3){
            
            return 1;
        }
        else{

            return 2;
        }
    }else if ([[UserModel defaultModel].workArr[section] isEqualToString:@"二手房"]){

        return 8;
    }else{

        return 4;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return [UserModel defaultModel].workArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 40 *SIZE;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 84 *SIZE;
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

    header.titleL.text = [UserModel defaultModel].workArr[section];
    return header;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if ([[UserModel defaultModel].workArr[indexPath.section] isEqualToString:@"新房"]) {

        static NSString *CellIdentifier = @"WorkingCell";

        WorkingCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[WorkingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if ([[UserModelArchiver unarchive].agent_identity integerValue] == 2) {
            
            [cell setTitle:_namelist[indexPath.row] content:_countdata[indexPath.row] img:_imglist[indexPath.row]];
        }else{
            
            [cell setTitle:_namelist[indexPath.row] content:_countdata[indexPath.row] img:_imglist[indexPath.row]];
        }
        return cell;
    }else if ([[UserModel defaultModel].workArr[indexPath.section] isEqualToString:@"二手房"]){

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

        [cell setTitle:_rentArr[indexPath.row] content:_rentCountData[indexPath.row] img:_secondImgArr[indexPath.row]];

        return cell;
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if ([[UserModel defaultModel].workArr[indexPath.section] isEqualToString:@"新房"]) {

        if ([[UserModelArchiver unarchive].agent_identity integerValue] == 2) {
            if (indexPath.row == 0) {

                ConfirmPhoneVC *nextVC = [[ConfirmPhoneVC alloc] init];
                [self.navigationController pushViewController:nextVC animated:YES];
              
            }else{
                
                RecommendVC1 *nextVC = [[RecommendVC1 alloc] init];
                [self.navigationController pushViewController:nextVC animated:YES];
            }
        }else if ([[UserModelArchiver unarchive].agent_identity integerValue] == 2) {
            
            RecommendVC1 *nextVC = [[RecommendVC1 alloc] init];
            [self.navigationController pushViewController:nextVC animated:YES];
        }else{

            if (indexPath.row == 0) {

                RecommendVC1 *nextVC = [[RecommendVC1 alloc] init];
                [self.navigationController pushViewController:nextVC animated:YES];
            }else if(indexPath.row == 1){

                NomineeVC1 *nextVC = [[NomineeVC1 alloc] init];
                [self.navigationController pushViewController:nextVC animated:YES];
            }else{

                BarginVC1 *nextVC = [[BarginVC1 alloc] init];
                [self.navigationController pushViewController:nextVC animated:YES];
            }
        }
    }else if([[UserModel defaultModel].workArr[indexPath.section] isEqualToString:@"租房"]){

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
            
            CustomRecommendVC *nextVC = [[CustomRecommendVC alloc] init];
            [self.navigationController pushViewController:nextVC animated:YES];
        }else if (indexPath.row == 2){
            
            RoomMaintainVC *nextVC = [[RoomMaintainVC alloc] init];
            [self.navigationController pushViewController:nextVC animated:YES];
        }else if (indexPath.row == 4){
            
            CustomLookVC *nextVC = [[CustomLookVC alloc] init];
            [self.navigationController pushViewController:nextVC animated:YES];
        }else if (indexPath.row == 5){

            LookMaintainVC *nextVC = [[LookMaintainVC alloc] init];
            [self.navigationController pushViewController:nextVC animated:YES];
        }else if (indexPath.row == 6){
            
            RoomAgencyVC *nextVC = [[RoomAgencyVC alloc] init];
            [self.navigationController pushViewController:nextVC animated:YES];
        }else{
            
            ContractSignVC *nextVC = [[ContractSignVC alloc] init];
            [self.navigationController pushViewController:nextVC animated:YES];
        }
    }
}



#pragma mark  ---  懒加载   ---
-(UITableView *)MainTableView
{
    if(!_MainTableView){
        
        _MainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT + SIZE, 360 *SIZE, SCREEN_Height - NAVIGATION_BAR_HEIGHT - SIZE - TAB_BAR_HEIGHT) style:UITableViewStyleGrouped];
        _MainTableView.backgroundColor = YJBackColor;
        _MainTableView.delegate = self;
        _MainTableView.dataSource = self;
        _MainTableView.mj_header = [GZQGifHeader headerWithRefreshingBlock:^{
            
            _MainTableView.mj_header.state = MJRefreshStateIdle;
            [self postWithidentify:[UserModelArchiver unarchive].agent_identity];
        }];
        [_MainTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }
    return _MainTableView;
}

@end
