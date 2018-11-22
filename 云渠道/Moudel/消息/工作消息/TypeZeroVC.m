//
//  TypeZeroVC.m
//  云渠道
//
//  Created by xiaoq on 2018/5/7.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "TypeZeroVC.h"
#import "ComplaintVC.h"

#import "BaseHeader.h"
#import "CountDownCell.h"
#import "InfoDetailCell.h"

#import "RecommendView.h"
#import "TransmitView.h"
#import "FailView.h"

@interface TypeZeroVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSArray *_data;
    NSArray *_titleArr;
    NSMutableDictionary *_dataDic;
    NSString *_endtime;
    NSString *_name;
}

@property (nonatomic , strong) UITableView *invalidTable;

@property (nonatomic , strong) UIButton *recommendBtn;

@property (nonatomic , strong) UIButton *complaintBtn;

@property (nonatomic, strong) RecommendView *recommendView;

@property (nonatomic, strong) FailView *failView;

@property (nonatomic, strong) TransmitView *transmitView;

@property (nonatomic, strong) NSDateFormatter *formatter;

@end

@implementation TypeZeroVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDateSouce];
    [self initUI];
}

-(void)initDateSouce
{
    _formatter = [[NSDateFormatter alloc] init];
    [_formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    _titleArr = @[@"无效信息",@"推荐信息"];
    _dataDic = [@{} mutableCopy];
    [self InValidRequestMethod];
}

- (void)InValidRequestMethod{
    
    [BaseRequest GET:Disabledinfo_URL parameters:@{@"client_id":_client_id,
                                                     @"message_id":_message_id
                                                     } success:^(id resposeObject) {
        
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            _dataDic = [NSMutableDictionary dictionaryWithDictionary:resposeObject[@"data"]];
            [_dataDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                
                if ([obj isKindOfClass:[NSNull class]]) {
                    
                    [_dataDic setObject:@"" forKey:key];
                }
            }];
            
            NSString *sex = @"客户性别：";
            if ([_dataDic[@"sex"] integerValue] == 1) {
                sex = @"客户性别：男";
            }
            if([_dataDic[@"sex"] integerValue] == 2)
            {
                sex =@"客户性别：女";
            }
            _name = _dataDic[@"name"];
            NSString *tel = _dataDic[@"tel"];
            NSArray *arr = [tel componentsSeparatedByString:@","];
            if (arr.count>0) {
                tel = [NSString stringWithFormat:@"联系方式：%@",arr[0]];
            }
            else{
                tel = @"联系方式：";
            }
            NSString *adress = _dataDic[@"absolute_address"];
            adress = [NSString stringWithFormat:@"项目地址：%@-%@-%@ %@",_dataDic[@"province_name"],_dataDic[@"city_name"],_dataDic[@"district_name"],adress];
            
            _data = @[@[[NSString stringWithFormat:@"无效类型：%@",_dataDic[@"disabled_state"]],[NSString stringWithFormat:@"无效描述：%@",_dataDic[@"disabled_reason"]],[NSString stringWithFormat:@"无效时间：%@",_dataDic[@"disabled_time"]]],@[[NSString stringWithFormat:@"推荐编号：%@",_dataDic[@"client_id"]],[NSString stringWithFormat:@"推荐时间：%@",_dataDic[@"create_time"]],[NSString stringWithFormat:@"推荐人：%@",_dataDic[@"broker_name"]],[NSString stringWithFormat:@"联系方式：%@",_dataDic[@"broker_tel"]],[NSString stringWithFormat:@"项目名称：%@",_dataDic[@"project_name"]],adress,[NSString stringWithFormat:@"客户姓名：%@",_dataDic[@"name"]],sex,tel]];
            
            [_invalidTable reloadData];
        }
        else
        {
            _complaintBtn.hidden = YES;
            _recommendBtn.hidden = YES;
            [self showContent:resposeObject[@"msg"]];
        }
                                                         
    } failure:^(NSError *error) {
        
        _complaintBtn.hidden = YES;
        _recommendBtn.hidden = YES;
        [self showContent:@"网络错误"];
    }];
}

- (void)ActionComplaintBtn:(UIButton *)btn{
    
    ComplaintVC *nextVC = [[ComplaintVC alloc] initWithProjectId:_client_id];
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (void)ActionRecommendBtn:(UIButton *)btn{
    
    [BaseRequest POST:RecommendClient_URL parameters:@{@"project_id":_dataDic[@"project_id"],@"client_need_id":_dataDic[@"client_need_id"],@"client_id":_dataDic[@"client_info_id"]} success:^(id resposeObject) {

        if ([resposeObject[@"code"] integerValue] == 200) {
            self.recommendView.codeL.text = [NSString stringWithFormat:@"推荐编号:%@",resposeObject[@"data"][@"client_id"]];
            self.recommendView.nameL.text = [NSString stringWithFormat:@"客户：%@",_dataDic[@"name"]];
            self.recommendView.projectL.text = [NSString stringWithFormat:@"项目名称：%@",_dataDic[@"project_name"]];
            self.recommendView.addressL.text = [NSString stringWithFormat:@"项目地址：%@-%@-%@-%@",_dataDic[@"province_name"],_dataDic[@"city_name"],_dataDic[@"district_name"],_dataDic[@"absolute_address"]];
//            self.recommendView.contactL.text = [NSString stringWithFormat:@"到访确认人：%@",_dataDic[@"butter_name"]];
//            self.recommendView.phoneL.text = [NSString stringWithFormat:@"联系方式：%@",_dataDic[@"butter_tel"]];
            NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"失效时间:%@",resposeObject[@"data"][@"end_time"]]];
            [attr addAttribute:NSForegroundColorAttributeName value:YJContentLabColor range:NSMakeRange(0, 5)];
            self.recommendView.timeL.attributedText = attr;
            [[UIApplication sharedApplication].keyWindow addSubview:self.recommendView];
        }else{
            
            self.failView.reasonL.text = resposeObject[@"msg"];
            self.failView.timeL.text = [_formatter stringFromDate:[NSDate date]];
            [[UIApplication sharedApplication].keyWindow addSubview:self.failView];
        }
    } failure:^(NSError *error) {
        
        self.failView.reasonL.text = @"网络错误";
        self.failView.timeL.text = [_formatter stringFromDate:[NSDate date]];
        [[UIApplication sharedApplication].keyWindow addSubview:self.failView];
    }];
}

#pragma mark    -----  delegate   ------

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [_data[section] count];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    BaseHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BaseHeader"];
    if (!header) {
        
        header = [[BaseHeader alloc] initWithReuseIdentifier:@"BaseHeader"];
    }
    header.lineView.hidden = YES;
    header.titleL.text = _titleArr[section];
    
    return header;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40 *SIZE;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 5 *SIZE;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 5 *SIZE)];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    if (_dataDic.count) {
        
        return 2;
    }else{
        
        return 0;
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"InfoDetailCell";
    InfoDetailCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[InfoDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    [cell SetCellContentbystring:_data[indexPath.section][indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}

-(void)initUI
{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = _titleinfo;
    
    if ([[UserModelArchiver unarchive].agent_identity integerValue]==2) {
        _invalidTable = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, 360*SIZE, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStyleGrouped];
    }
    else
    {
        _invalidTable = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, 360*SIZE, SCREEN_Height - NAVIGATION_BAR_HEIGHT - 47 *SIZE - TAB_BAR_MORE) style:UITableViewStyleGrouped];
    }
    _invalidTable.rowHeight = UITableViewAutomaticDimension;
    _invalidTable.estimatedRowHeight = 150 *SIZE;
    _invalidTable.backgroundColor = YJBackColor;
    _invalidTable.delegate = self;
    _invalidTable.dataSource = self;
    [_invalidTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:_invalidTable];
    
    _complaintBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _complaintBtn.frame = CGRectMake(0, SCREEN_Height - 47 *SIZE - TAB_BAR_MORE, 120 *SIZE, 47 *SIZE + TAB_BAR_MORE);
    _complaintBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_complaintBtn addTarget:self action:@selector(ActionComplaintBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_complaintBtn setTitle:@"申诉" forState:UIControlStateNormal];
    [_complaintBtn setBackgroundColor:COLOR(191, 191, 191, 1)];
    [_complaintBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [self.view addSubview:_complaintBtn];
    
    _recommendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _recommendBtn.frame = CGRectMake(120 *SIZE, SCREEN_Height - 47 *SIZE - TAB_BAR_MORE, 240 *SIZE, 47 *SIZE + TAB_BAR_MORE);
    _recommendBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_recommendBtn addTarget:self action:@selector(ActionRecommendBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_recommendBtn setTitle:@"重新推荐" forState:UIControlStateNormal];
    [_recommendBtn setBackgroundColor:YJBlueBtnColor];
    [_recommendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [self.view addSubview:_recommendBtn];
    if ([[UserModelArchiver unarchive].agent_identity integerValue] == 2) {
        
    }
    else
    {
        [self.view addSubview:_complaintBtn];
        [self.view addSubview:_recommendBtn];
    }
}

- (FailView *)failView{
    
    if (!_failView) {
        
        _failView = [[FailView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    }
    return _failView;
}

- (RecommendView *)recommendView{
    
    if (!_recommendView) {
        
        _recommendView = [[RecommendView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
        WS(weakSelf)
        _recommendView.tranmitBtnBlock = ^{
            
            [[UIApplication sharedApplication].keyWindow addSubview:weakSelf.transmitView];
        };
        
        _recommendView.recommendViewConfirmBlock = ^{
            
            [weakSelf.navigationController popToRootViewControllerAnimated:YES];
        };
    }
    return _recommendView;
}

- (TransmitView *)transmitView{
    
    if (!_transmitView) {
        
        _transmitView = [[TransmitView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
        WS(weakSelf);
        _transmitView.transmitTagBtnBlock = ^(NSInteger index) {
            
            if (index == 0) {
                
                [weakSelf shareWebPageToPlatformType:UMSocialPlatformType_QQ];
            }else if (index == 1){
                
                [weakSelf shareWebPageToPlatformType:UMSocialPlatformType_WechatSession];
            }else if (index == 2){
                
                [weakSelf shareWebPageToPlatformType:UMSocialPlatformType_WechatTimeLine];
            }else{
                
                [weakSelf alertControllerWithNsstring:@"温馨提示" And:@"暂时不支持发送短信"];
            }
        };
    }
    return _transmitView;
}

//
- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"云渠道" descr:@"房产渠道专业平台" thumImage:[UIImage imageNamed:@"shareimg"]];
    //设置网页地址
    shareObject.webpageUrl =@"http://itunes.apple.com/app/id1371978352?mt=8";
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {

            [self alertControllerWithNsstring:@"分享失败" And:@"" WithDefaultBlack:^{
                
                [self.transmitView removeFromSuperview];
                [self.recommendView removeFromSuperview];
            }];
        }else{

            [self alertControllerWithNsstring:@"分享成功" And:@"" WithDefaultBlack:^{
                
                [self.transmitView removeFromSuperview];
                [self.recommendView removeFromSuperview];
            }];
            
        }
    }];
}
@end
