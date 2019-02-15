//
//  ContractDetailVC.m
//  云渠道
//
//  Created by xiaoq on 2019/1/23.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "ContractDetailVC.h"

#import "ContractHeader1.h"
#import "ContractHeader2.h"

#import "AddContractCell7.h"
#import "AddContractCell4.h"
#import "AddContractCell5.h"
#import "AddPeopleVC.h"
#import "roominfoCell.h"
#import "ContractHeader3.h"

#import "ContractAgentCell.h"


@interface ContractDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger _index;
    NSMutableArray *_agent_info;
    NSMutableArray *_buy_info;
    NSMutableDictionary *_deal_info;
    NSMutableDictionary *_house_info;
    NSMutableArray *_img;
    NSMutableArray *_sell_info;
}
@property (nonatomic , strong) UITableView *mainTable;

-(void)InitInterFace;
-(void)InitDataSouce;
@end

@implementation ContractDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self InitDataSouce];
    [self InitInterFace];
}

-(void)InitInterFace
{
    self.titleLabel.text = @"合同详情";
    self.navBackgroundView.hidden = NO;
    self.rightBtn.hidden = NO;
    [self.rightBtn setTitleColor:YJ86Color forState:UIControlStateNormal];
    self.rightBtn.titleLabel.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.rightBtn addTarget:self action:@selector(ActionRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightBtn setImage:[UIImage imageNamed:@"add_1"] forState:UIControlStateNormal];
    [self.view addSubview:self.mainTable];
}

-(void)InitDataSouce
{
    _index = 0;
    _agent_info =[NSMutableArray array];
    _buy_info = [NSMutableArray array];
    _deal_info = [NSMutableDictionary dictionary];
    _house_info = [NSMutableDictionary dictionary];
    _img = [NSMutableArray array];
    _sell_info = [NSMutableArray array];
    [self Post];
}

-(void)Post{
    [BaseRequest GET:ContractDetail_URL parameters:@{@"deal_id":_deal_id} success:^(id resposeObject) {
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue]==200) {
            _agent_info = resposeObject[@"data"][@"agent_info"];
            _buy_info = resposeObject[@"data"][@"buy_info"];
            _deal_info = resposeObject[@"data"][@"deal_info"];
            _house_info = resposeObject[@"data"][@"house_info"];
            _img = resposeObject[@"data"][@"img"];
            _sell_info = resposeObject[@"data"][@"sale_info"];
            [_mainTable reloadData];
        }
        
    } failure:^(NSError *error) {
        [self showContent:@"网络错误"];
    }];
}


#pragma mark ---  action ----

- (void)ActionRightBtn:(UIButton *)btn{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"操作" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *buy = [UIAlertAction actionWithTitle:@"买方违约" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
    }];
    
    UIAlertAction *sell = [UIAlertAction actionWithTitle:@"卖方违约" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
    }];
    
    UIAlertAction *soldout = [UIAlertAction actionWithTitle:@"审核合同" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:buy];
    [alert addAction:sell];
    [alert addAction:soldout];
    [alert addAction:cancel];
    
    [self.navigationController presentViewController:alert animated:YES completion:^{
        
        
    }];
}


-(void)action_addbuyer
{
    AddPeopleVC *vc = [[AddPeopleVC alloc]init];
    vc.AddPeopleblock = ^(NSMutableDictionary * _Nonnull dic) {
        [_buy_info addObject:dic];
        [_mainTable reloadData];
    };
    [self.navigationController pushViewController:vc animated:YES];
    
}



-(void)action_addseller
{
    AddPeopleVC *vc = [[AddPeopleVC alloc]init];
    vc.AddPeopleblock = ^(NSMutableDictionary * _Nonnull dic) {
        [_sell_info addObject:dic];
        [_mainTable reloadData];
    };
    [self.navigationController pushViewController:vc animated:YES];
}



#pragma mark ---  delegeta ----


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    

    if (section == 2) {
        if (_index==0) {
            return _buy_info.count+2;
        }else if (_index ==1)
        {
            return _sell_info.count+2;
        }else{
            return 1;
        }
    }else if (section == 1){
        
        return _agent_info.count;
    }

     return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section==0) {
        
        return 191*SIZE;
    }
    else{
        return 47*SIZE;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [[UIView alloc] init];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 2) {
        ContractHeader2 *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"ContractHeader2"];
        if (!header) {
            
            header = [[ContractHeader2 alloc] initWithReuseIdentifier:@"ContractHeader2"];
        }
        
        [header.buyBtn setBackgroundColor:COLOR(219, 219, 219, 1)];
        [header.buyBtn setTitleColor:YJ86Color forState:UIControlStateNormal];
        [header.sellBtn setBackgroundColor:COLOR(219, 219, 219, 1)];
        [header.sellBtn setTitleColor:YJ86Color forState:UIControlStateNormal];
        [header.infoBtn setBackgroundColor:COLOR(219, 219, 219, 1)];
        [header.infoBtn setTitleColor:YJ86Color forState:UIControlStateNormal];
    
        [header.buyBtn setTitle:@"买方信息" forState:UIControlStateNormal];
        [header.sellBtn setTitle:@"卖方信息" forState:UIControlStateNormal];
        [header.infoBtn setTitle:@"交易信息" forState:UIControlStateNormal];
        if (_index == 0) {
            
            [header.buyBtn setBackgroundColor:YJBlueBtnColor];
            [header.buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }else if (_index == 1){
            
            [header.sellBtn setBackgroundColor:YJBlueBtnColor];
            [header.sellBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }else{
            
            [header.infoBtn setBackgroundColor:YJBlueBtnColor];
            [header.infoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
        
        header.contractHeaderBlock  = ^(NSInteger index) {
            
            _index = index;
            [tableView reloadData];
        };
        
        return header;
    }else if (section == 1){
     
        ContractHeader3 *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"ContractHeader3"];
        if (!header) {
            
            header = [[ContractHeader3 alloc] initWithReuseIdentifier:@"ContractHeader3"];
        }
        
        return header;
    }else{
        ContractHeader1 *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"ContractHeader1"];
        if (!header) {
            
            header = [[ContractHeader1 alloc] initWithReuseIdentifier:@"ContractHeader1"];
        }
        header.numLab.text = [NSString stringWithFormat:@"交易编号：%@",_deal_info[@"deal_code"]];
        header.creattimeLab.text =[NSString stringWithFormat:@"创建时间：%@",_deal_info[@"create_time"]];
        if (![_deal_info[@"check_time"] isEqual: [NSNull null]]) {
        header.passtimeLab.text = [NSString stringWithFormat:@"签约时间：%@",_deal_info[@"check_time"]];
        }
        else{
            header.passtimeLab.text = @"";
        }
        header.peopleLab.text =[NSString stringWithFormat:@"签约人员：%@-%@",_deal_info[@"sub_agent"],_deal_info[@"store_name"]];
        header.moneyLab.text =[NSString stringWithFormat:@"%@万",_deal_info[@"deal_money"]];
        header.adressLab.text = [NSString stringWithFormat:@"%@ %@",_house_info[@"project_name"],_house_info[@"address"]];
        header.roomLab.text = [NSString stringWithFormat:@"房间信息:%@-%@-%@",_house_info[@"build_name"],_house_info[@"unit_name"],_house_info[@"house_name"]];
        header.buyLab.text = [NSString stringWithFormat:@"买房原因：%@",_deal_info[@"buy_reason"]];
        header.sellLab.text = [NSString stringWithFormat:@"卖房原因：%@",_deal_info[@"sale_reason"]];
        [header.imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,_house_info[@"img_url"]]] placeholderImage:[UIImage imageNamed:@"default_3"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if (error) {
                image = [UIImage imageNamed:@"default_3"];
            }
        }];

        return header;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    

    if (indexPath.section == 2) {
        //买方信息
        if (_index == 0) {
            if (indexPath.row ==0) {
                AddContractCell7 *cell = [tableView dequeueReusableCellWithIdentifier:@"AddContractCell7"];
                if (!cell) {
                    
                    cell = [[AddContractCell7 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AddContractCell7"];
                    
                }
                [cell setDataDic:_deal_info];
                cell.choosebtn.hidden = YES;
                cell.numL.font = [UIFont systemFontOfSize:15*SIZE];
                cell.numL.textColor = YJTitleLabColor;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }
            else if(indexPath.row == _buy_info.count+1)
            {
                AddContractCell5 *cell = [tableView dequeueReusableCellWithIdentifier:@"AddContractCell5"];
                if (!cell) {
                    cell = [[AddContractCell5 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AddContractCell5"];
                }
                [cell.addBtn addTarget:self action:@selector(action_addbuyer) forControlEvents:UIControlEventTouchUpInside];
                return cell;
            }
            else{
                
                AddContractCell4 *cell = [tableView dequeueReusableCellWithIdentifier:@"AddContractCell4"];
                if (!cell) {
                    
                    cell = [[AddContractCell4 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AddContractCell4"];
                    
                }
                NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithDictionary:_sell_info[indexPath.row-1]];
                [cell setData:dic];
                if (indexPath.row ==1) {
                    cell.stickieBtn.hidden = YES;
                    cell.titelL.text = @"主权益人";
                }
                else{
                    cell.stickieBtn.hidden = NO;
                    cell.titelL.text = @"附权益人";
                }
                cell.indexpath = indexPath;
                cell.stickieBlock = ^(NSIndexPath * _Nonnull indexpath) {
                    
                    
                };
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                return cell;
            }
                    
        }else if (_index == 1)
        {
            if (indexPath.row == 0) {
                
                
            }
            else if (indexPath.row == _sell_info.count+1)
            {
                AddContractCell5 *cell = [tableView dequeueReusableCellWithIdentifier:@"AddContractCell5"];
                if (!cell) {
                    cell = [[AddContractCell5 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AddContractCell5"];
                }
                [cell.addBtn addTarget:self action:@selector(action_addbuyer) forControlEvents:UIControlEventTouchUpInside];
                return cell;
            }else
            {
                AddContractCell4 *cell = [tableView dequeueReusableCellWithIdentifier:@"AddContractCell4"];
                if (!cell) {
                    
                    cell = [[AddContractCell4 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AddContractCell4"];
                    
                }
                NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithDictionary:_sell_info[indexPath.row-1]];
                [cell setData:dic];
                if (indexPath.row ==1) {
                    cell.stickieBtn.hidden = YES;
                    cell.titelL.text = @"主权益人";
                }
                else{
                    cell.stickieBtn.hidden = NO;
                    cell.titelL.text = @"附权益人";
                }
                cell.indexpath = indexPath;
                cell.stickieBlock = ^(NSIndexPath * _Nonnull indexpath) {
                    
                    
                };
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                return cell;
            }
        }
        else{
            ContractAgentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ContractAgentCell"];
            if (!cell) {
                
                cell = [[ContractAgentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ContractAgentCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.dataDic = _agent_info[indexPath.row];
            return cell;
        }
    }else if (indexPath.section == 1){
        
        ContractAgentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ContractAgentCell"];
        if (!cell) {
            
            cell = [[ContractAgentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ContractAgentCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.dataDic = _agent_info[indexPath.row];
        return cell;
    }
    

    UITableViewCell *cell = [[UITableViewCell alloc]init];
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
   
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self alertControllerWithNsstring:@"温馨提示" And:@"你确定要删除联系人?" WithCancelBlack:^{
        
        
    } WithDefaultBlack:^{
        

    }];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

-(UITableView *)mainTable{
    if (!_mainTable) {
        _mainTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStyleGrouped];
        _mainTable.rowHeight = UITableViewAutomaticDimension;
        _mainTable.estimatedRowHeight = 260 *SIZE;
        _mainTable.estimatedSectionHeaderHeight = 476 *SIZE;
        _mainTable.backgroundColor = self.view.backgroundColor;
        _mainTable.delegate = self;
        _mainTable.dataSource = self;
        _mainTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _mainTable;
}



@end
