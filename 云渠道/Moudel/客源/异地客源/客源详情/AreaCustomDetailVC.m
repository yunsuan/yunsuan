//
//  AreaCustomDetailVC.m
//  云渠道
//
//  Created by 谷治墙 on 2019/12/5.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "AreaCustomDetailVC.h"

#import "LookMaintainDetailLookRecordVC.h"

#import "AreaUncomfirmVC.h"
#import "AreaValidVC.h"
#import "AreaInvalidVC.h"
#import "AreaDealVC.h"

#import "AreaCustomRuleView.h"

#import "BlueTitleMoreHeader.h"
#import "AreaCustomDetailHeader.h"

#import "AreaCustomCollCell.h"
#import "AreaCustomDetailProjectCell.h"
#import "LookMaintainDetailRoomCell.h"
#import "SingleContentCell.h"
#import "InfoDetailCell.h"

@interface AreaCustomDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
 
    NSInteger _idx;
    
    NSString *_recommend_id;
    
    NSString *_disabledReason;
    
    NSMutableArray *_contentArr;
    NSMutableArray *_dataArr;
    NSMutableArray *_projectArr;
    NSMutableArray *_rentArr;
    NSMutableArray *_secondArr;
    
    NSMutableDictionary *_dataDic;
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
    _projectArr = [@[] mutableCopy];
    _rentArr = [@[] mutableCopy];
    _secondArr = [@[] mutableCopy];
}

- (void)RequestMethod{
    
    [BaseRequest GET:ClientOtherBuyDetail_URL parameters:@{@"recommend_id":_recommend_id} success:^(id resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            _dataDic = [[NSMutableDictionary alloc] initWithDictionary:resposeObject[@"data"]];
            
            NSDateFormatter *fortmatter = [[NSDateFormatter alloc] init];
            [fortmatter setDateFormat:@"YYYY-MM-dd"];
            
            _contentArr = [NSMutableArray arrayWithArray:@[[NSString stringWithFormat:@"名称：%@",resposeObject[@"data"][@"client"][@"name"]],[NSString stringWithFormat:@"性别：%@",[resposeObject[@"data"][@"client"][@"sex"] integerValue] == 1?@"男":[resposeObject[@"data"][@"client"][@"sex"] integerValue] == 2?@"女":@""],[NSString stringWithFormat:@"出生年月：%@",(resposeObject[@"data"][@"client"][@"birth"] && ![resposeObject[@"data"][@"client"][@"birth"] isKindOfClass:[NSNull class]])?resposeObject[@"data"][@"client"][@"birth"]:@""],[NSString stringWithFormat:@"联系电话：%@",resposeObject[@"data"][@"client"][@"tel"]],[NSString stringWithFormat:@"证件类型：%@",resposeObject[@"data"][@"client"][@"card_type"]],[NSString stringWithFormat:@"证件号：%@",resposeObject[@"data"][@"client"][@"card_id"]],[NSString stringWithFormat:@"地址：%@%@%@",resposeObject[@"data"][@"client"][@"province_name"],resposeObject[@"data"][@"client"][@"city_name"],resposeObject[@"data"][@"client"][@"district_name"]]]];
            if ([resposeObject[@"data"][@"client"][@"card_img"] length]) {
                
                NSArray *arr = [resposeObject[@"data"][@"client"][@"card_img"] componentsSeparatedByString:@","];
                if (arr.count == 3) {
                    
                    [_contentArr addObject:[NSString stringWithFormat:@"身份证正面,%@",[resposeObject[@"data"][@"client"][@"card_img"] componentsSeparatedByString:@","][0]]];
                    [_contentArr addObject:[NSString stringWithFormat:@"身份证背面,%@",[resposeObject[@"data"][@"client"][@"card_img"] componentsSeparatedByString:@","][1]]];
                    [_contentArr addObject:[NSString stringWithFormat:@"其他证明,%@",[resposeObject[@"data"][@"client"][@"card_img"] componentsSeparatedByString:@","][2]]];
                }else if (arr.count == 2){
                    
                    [_contentArr addObject:[NSString stringWithFormat:@"身份证正面,%@",[resposeObject[@"data"][@"client"][@"card_img"] componentsSeparatedByString:@","][0]]];
                    [_contentArr addObject:[NSString stringWithFormat:@"身份证背面,%@",[resposeObject[@"data"][@"client"][@"card_img"] componentsSeparatedByString:@","][1]]];
                    [_contentArr addObject:[NSString stringWithFormat:@"其他证明,%@",@" "]];
                }else if (arr.count == 1){
                    
                    [_contentArr addObject:[NSString stringWithFormat:@"身份证正面,%@",[resposeObject[@"data"][@"client"][@"card_img"] componentsSeparatedByString:@","][0]]];
                    [_contentArr addObject:[NSString stringWithFormat:@"身份证背面,%@",@" "]];
                    [_contentArr addObject:[NSString stringWithFormat:@"其他证明,%@",@" "]];
                }else{
                    
                    [_contentArr addObject:[NSString stringWithFormat:@"身份证正面,%@",@" "]];
                    [_contentArr addObject:[NSString stringWithFormat:@"身份证背面,%@",@" "]];
                    [_contentArr addObject:[NSString stringWithFormat:@"其他证明,%@",@" "]];
                }
            }else{
                
                [_contentArr addObject:[NSString stringWithFormat:@"身份证正面,%@",@" "]];
                [_contentArr addObject:[NSString stringWithFormat:@"身份证背面,%@",@" "]];
                [_contentArr addObject:[NSString stringWithFormat:@"其他证明,%@",@" "]];
            }
            _projectArr = [NSMutableArray arrayWithArray:resposeObject[@"data"][@"recommend"][@"project"]];
            _dataArr = [NSMutableArray arrayWithArray:@[[NSString stringWithFormat:@"接待区域：%@",resposeObject[@"data"][@"butter"][@"recommend_district"]],[NSString stringWithFormat:@"接待公司名称：%@",resposeObject[@"data"][@"butter"][@"butter_company_name"]]]];
            _disabledReason = resposeObject[@"data"][@"client"][@"disabled_state"];
            if (_disabledReason.length) {
                
                [_dataArr addObject:[NSString stringWithFormat:@"失效原因：%@",resposeObject[@"data"][@"client"][@"disabled_reason"]]];
            }
            _secondArr = [NSMutableArray arrayWithArray:resposeObject[@"data"][@"recommend"][@"house"][@"take_follow"]];
            [_table reloadData];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [self showContent:@"网络错误"];
    }];
}

- (void)RuleRequest{
    
    [BaseRequest GET:DistrictRuleDetail_URL parameters:@{@"district":_dataDic[@"butter"][@"district_code"]} success:^(id resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if ([resposeObject[@"data"] count]) {
            
                NSString *str = @"";
                NSArray *arr = resposeObject[@"data"];//[resposeObject[@"data"] componentsSeparatedByString:@","];
                for (int i = 0; i < arr.count; i++) {
                    
                    if (i == 0) {
                        
                        str = [NSString stringWithFormat:@"%@",arr[i]];
                    }else{
                     
                        str = [NSString stringWithFormat:@"%@\n%@",str,arr[i]];
                    }
                }
                AreaCustomRuleView *view = [[AreaCustomRuleView alloc] initWithFrame:self.view.bounds];
                view.ruleL.text = str;
                [self.view addSubview:view];
            }
        }else{
            
//            _ruleL.text = @" ";
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
//        _ruleL.text = @" ";
        [self showContent:@"网络错误"];
    }];
}
- (NSInteger)getYearFromDate:(NSDate *)date1 withDate2:(NSDate *)date2{
    
    //创建两个日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];

    //利用NSCalendar比较日期的差异
    NSCalendar *calendar = [NSCalendar currentCalendar];
    /**
     * 要比较的时间单位,常用如下,可以同时传：
     *    NSCalendarUnitDay : 天
     *    NSCalendarUnitYear : 年
     *    NSCalendarUnitMonth : 月
     *    NSCalendarUnitHour : 时
     *    NSCalendarUnitMinute : 分
     *    NSCalendarUnitSecond : 秒
     */
    NSCalendarUnit unit = NSCalendarUnitMonth;//只比较天数差异
    //比较的结果是NSDateComponents类对象
    NSDateComponents *delta = [calendar components:unit fromDate:date1 toDate:date2 options:0];
    //打印
    NSLog(@"%@",delta);
    //获取其中的"天"
//    NSLog(@"%ld",delta.day);
    return delta.month;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return _contentArr.count - 2;
    }else if (section == 1){
        
        return _dataArr.count;
    }else{
        
        if (_idx == 0) {
            
            return _projectArr.count;
        }else if (_idx == 1){
            
            return _rentArr.count;
        }else{
            
            return _secondArr.count;
        }
    }
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section < 2) {

        BlueTitleMoreHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BlueTitleMoreHeader"];
        if (!header) {
            
            header = [[BlueTitleMoreHeader alloc] initWithReuseIdentifier:@"BaseHeader"];
        }
        
        if (section == 0) {
            
            header.titleL.text = @"基本信息";
            header.moreBtn.hidden = YES;
        }else{
            
            header.titleL.text = @"接待信息";
            header.moreBtn.hidden = NO;
        }
        
        header.moreBtn.frame = CGRectMake(250 *SIZE, 5 *SIZE, 100 *SIZE, 30 *SIZE);
        [header.moreBtn setTitle:@"区域规则" forState:UIControlStateNormal];
        [header.moreBtn setBackgroundColor:YJBlueBtnColor];
        header.moreBtn.titleLabel.font = [UIFont systemFontOfSize:13 *SIZE];
        [header.moreBtn setTitleColor:CLWhiteColor forState:UIControlStateNormal];
        header.moreBtn.layer.cornerRadius = 3 *SIZE;
        header.moreBtn.clipsToBounds = YES;
        
        header.blueTitleMoreHeaderBlock = ^{
            
            [self RuleRequest];
        };
        
        return header;
    }
    AreaCustomDetailHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"AreaCustomDetailHeader"];
    if (!header) {
        
        header = [[AreaCustomDetailHeader alloc] initWithReuseIdentifier:@"AreaCustomDetailHeader"];
    }
    
    [header.projectBtn setBackgroundColor:COLOR(219, 219, 219, 1)];
    [header.projectBtn setTitleColor:YJ86Color forState:UIControlStateNormal];
    [header.rentBtn setBackgroundColor:COLOR(219, 219, 219, 1)];
    [header.rentBtn setTitleColor:YJ86Color forState:UIControlStateNormal];
    [header.secondBtn setBackgroundColor:COLOR(219, 219, 219, 1)];
    [header.secondBtn setTitleColor:YJ86Color forState:UIControlStateNormal];
    
    [header.projectBtn setTitle:[NSString stringWithFormat:@"新房 %lu",(unsigned long)_projectArr.count] forState:UIControlStateNormal];
    [header.secondBtn setTitle:[NSString stringWithFormat:@"二手房 %lu",(unsigned long)_secondArr.count] forState:UIControlStateNormal];
    
    if (_idx == 0) {
        
        [header.projectBtn setBackgroundColor:YJBlueBtnColor];
        [header.projectBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else if (_idx == 1){
        
        [header.rentBtn setBackgroundColor:YJBlueBtnColor];
        [header.rentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else{
        
        [header.secondBtn setBackgroundColor:YJBlueBtnColor];
        [header.secondBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    
    header.areaCustomDetailHeaderTagBlock = ^(NSInteger index) {
      
        _idx = index;
        [tableView setScrollsToTop:YES];
        [tableView reloadData];
    };
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section == 0) {
        
        if (indexPath.row < _contentArr.count - 3) {
            
            SingleContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SingleContentCell"];
            if (!cell) {
                
                cell = [[SingleContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SingleContentCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.contentL.text = _contentArr[indexPath.row];
            
            cell.lineView.hidden = YES;
            return cell;
        }else{
            
            AreaCustomCollCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AreaCustomCollCell"];
            if (!cell) {
                
                cell = [[AreaCustomCollCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AreaCustomCollCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.dataArr = _contentArr;
            return cell;
        }
    }else if (indexPath.section == 1){
        
        InfoDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InfoDetailCell"];
        if (!cell) {
            
            cell = [[InfoDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"InfoDetailCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.contentlab.text = _dataArr[indexPath.row];
        
        [cell.moreBtn setTitle:@"重新推荐" forState:UIControlStateNormal];
        [cell.contentlab mas_remakeConstraints:^(MASConstraintMaker *make) {

            make.left.equalTo(cell.contentView).offset(28 *SIZE);
            make.top.equalTo(cell.contentView).offset(10 *SIZE);
            make.width.mas_lessThanOrEqualTo(200 *SIZE);
            make.bottom.equalTo(cell.contentView).offset(-10 *SIZE);
        }];
        cell.infoDetailCellBlock = ^{
            
            NSMutableDictionary *tempDic = [@{} mutableCopy];
            [tempDic setValue:_dataDic[@"butter"][@"city_code"] forKey:@"recommend_city"];
            [tempDic setValue:_dataDic[@"butter"][@"district_code"] forKey:@"recommend_district"];
//            [tempDic setValue:_dataDic[@"butter"][@"city_code"] forKey:@"recommend_city_name"];
//            [tempDic setValue:_dataDic[@"butter"][@"city_code"] forKey:@"recommend_district_name"];
            [tempDic setValue:_dataDic[@"client"][@"name"] forKey:@"name"];
            [tempDic setValue:_dataDic[@"client"][@"tel"] forKey:@"tel"];
            [tempDic setValue:_dataDic[@"client"][@"sex"] forKey:@"sex"];
            [tempDic setValue:_dataDic[@"client"][@"card_type"] forKey:@"card_type"];
            [tempDic setValue:_dataDic[@"client"][@"card_id"] forKey:@"card_id"];
            if ((_dataDic[@"client"][@"birth"] && ![_dataDic[@"client"][@"birth"] isKindOfClass:[NSNull class]])) {
                
                [tempDic setValue:_dataDic[@"client"][@"birth"] forKey:@"birth"];
            }else{
                
                [tempDic setValue:@" " forKey:@"birth"];
            }
            
            [tempDic setValue:_dataDic[@"client"][@"province"] forKey:@"province"];
            [tempDic setValue:_dataDic[@"client"][@"city"] forKey:@"city"];
            [tempDic setValue:_dataDic[@"client"][@"district"] forKey:@"district"];
            [tempDic setValue:_dataDic[@"client"][@"address"] forKey:@"address"];
            [tempDic setValue:_dataDic[@"client"][@"card_img"] forKey:@"card_img"];
            [tempDic setValue:_dataDic[@"need"][@"property_type"] forKey:@"property_type"];
            [tempDic setValue:_dataDic[@"need"][@"price_min"] forKey:@"price_min"];
            [tempDic setValue:_dataDic[@"need"][@"price_max"] forKey:@"price_max"];
            [tempDic setValue:_dataDic[@"need"][@"area_min"] forKey:@"area_min"];
            [tempDic setValue:_dataDic[@"need"][@"area_max"] forKey:@"area_max"];
            [tempDic setValue:_dataDic[@"need"][@"comment"] forKey:@"comment"];
            [tempDic setValue:_dataDic[@"need"][@"house_type"] forKey:@"house_type"];
            
            [BaseRequest POST:ClientOtherBuyAdd_URL parameters:tempDic success:^(id resposeObject) {
                
                if ([resposeObject[@"code"] integerValue] == 200) {
                    
                    [self RequestMethod];
                }else{
                    
                    [self showContent:resposeObject[@"msg"]];
                }
            } failure:^(NSError *error) {
               
                [self showContent:@"网络错误"];
            }];
        };
        if (indexPath.row == 0) {
            
            if (_disabledReason.length) {
                
                cell.moreBtn.hidden = NO;
            }else{
                
                cell.moreBtn.hidden = YES;
            }
        }else{
            
            cell.moreBtn.hidden = YES;
        }
        return cell;
    }else{
        
        if (_idx == 0) {
            
            AreaCustomDetailProjectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AreaCustomDetailProjectCell"];
            if (!cell) {
                
                cell = [[AreaCustomDetailProjectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AreaCustomDetailProjectCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            [cell settagviewWithdata:@[_projectArr[indexPath.row][@"project_tags"],@[]]];
            if (_projectArr[indexPath.row][@"property_tags"]) {
                
                [cell settagviewWithdata:@[_projectArr[indexPath.row][@"project_tags"],_projectArr[indexPath.row][@"property_tags"]]];
            }
            [cell setDataDic:_projectArr[indexPath.row]];
            
            return cell;
        }else{
            
            LookMaintainDetailRoomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LookMaintainDetailRoomCell"];
            if (!cell) {
                
                cell = [[LookMaintainDetailRoomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LookMaintainDetailRoomCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.dataDic = _secondArr[indexPath.row];
            
            return cell;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section == 2) {
        
        if (_idx == 0) {
            
            if ([_projectArr[indexPath.row][@"disabled_state"] integerValue] == 0) {
                
                if ([_projectArr[indexPath.row][@"current_state"] integerValue] == 0 || [_projectArr[indexPath.row][@"current_state"] integerValue] == 1) {

                    AreaUncomfirmVC *nextVC = [[AreaUncomfirmVC alloc] initWithString:_projectArr[indexPath.row][@"client_id"]];
                    [self.navigationController pushViewController:nextVC animated:YES];
                }else if ([_projectArr[indexPath.row][@"current_state"] integerValue] == 2 || [_projectArr[indexPath.row][@"current_state"] integerValue] == 3){

                    AreaValidVC *nextVC = [[AreaValidVC alloc] initWithClientId:_projectArr[indexPath.row][@"client_id"]];
                    [self.navigationController pushViewController:nextVC animated:YES];
                }else if ([_projectArr[indexPath.row][@"current_state"] integerValue] == 4 || [_projectArr[indexPath.row][@"current_state"] integerValue] == 5 || [_projectArr[indexPath.row][@"current_state"] integerValue] == 6){

                    AreaDealVC *nextVC = [[AreaDealVC alloc] initWithClientId:_projectArr[indexPath.row][@"client_id"]];
                    [self.navigationController pushViewController:nextVC animated:YES];
                }else{

                    AreaInvalidVC *nextVC = [[AreaInvalidVC alloc] initWithClientId:_projectArr[indexPath.row][@"client_id"]];
                    [self.navigationController pushViewController:nextVC animated:YES];
                }
            }else{

                AreaInvalidVC *nextVC = [[AreaInvalidVC alloc] initWithClientId:_projectArr[indexPath.row][@"client_id"]];
                [self.navigationController pushViewController:nextVC animated:YES];
            }
        }else{
            
            LookMaintainDetailLookRecordVC *nextVC = [[LookMaintainDetailLookRecordVC alloc] initWithData:_secondArr[indexPath.row]];
            [self.navigationController pushViewController:nextVC animated:YES];
        }
    }
}

- (void)initUI{

    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"客户详情";
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - TAB_BAR_MORE) style:UITableViewStylePlain];
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
