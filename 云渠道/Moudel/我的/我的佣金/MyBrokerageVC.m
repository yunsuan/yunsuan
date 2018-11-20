//
//  MyBrokerageVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/3/29.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "MyBrokerageVC.h"
#import "BankCardListVC.h"
#import "UnpaidBrokerageVC.h"
#import "BrokerageRecordVC.h"
#import "IDcardAuthenticationVC.h"
#import "IdentifyingVC.h"
#import "BrokerageAwardVC.h"

#import "BrokerageTableCell.h"




@interface MyBrokerageVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSArray *_imageArr;
    NSArray *_titleArr;
    NSArray *_brokerCount;
}
@property (nonatomic, strong) UITableView *brokerTable;

@property (nonatomic, strong) UIImageView *awardView;

@property (nonatomic, strong) UILabel *titleL1;

@property (nonatomic, strong) UILabel *priceL1;

@property (nonatomic, strong) UIButton *awardBtn1;

@property (nonatomic, strong) UIImageView *awardView1;

@property (nonatomic, strong) UILabel *titleL2;

@property (nonatomic, strong) UILabel *priceL2;

@property (nonatomic, strong) UIButton *awardBtn2;

@property (nonatomic, strong) UILabel *priceL;

@property (nonatomic, strong) UILabel *declareL;

@end

@implementation MyBrokerageVC

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self post];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
   
}

- (void)initDataSource{
    
    _imageArr = @[@"id",@"totalcommission",@"bankcard"];
    _titleArr = @[@"身份证认证",@"累计佣金",@"银行卡"];
    _brokerCount = @[@[@"0",@"￥0"],@[@"0",@"￥0"]];
}


-(void)post{
    [BaseRequest GET:BrokerInfo_URL parameters:nil success:^(id resposeObject) {
//        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue]==200) {
            _priceL.text = [NSString stringWithFormat:@"￥%@",resposeObject[@"data"][@"total"]];
            _brokerCount = @[@[[NSString stringWithFormat:@"%@",resposeObject[@"data"][@"un_pay"][@"total"]],[NSString stringWithFormat:@"￥%@",resposeObject[@"data"][@"un_pay"][@"count"]]],@[[NSString stringWithFormat:@"%@",resposeObject[@"data"][@"is_pay"][@"total"]],[NSString stringWithFormat:@"￥%@",resposeObject[@"data"][@"is_pay"][@"count"]]]];
            [_brokerTable reloadData];
        }
        
    } failure:^(NSError *error) {

    }];
}

#pragma mark -- action

- (void)ActionTagBtn:(UIButton *)btn{
    
    switch (btn.tag) {
        case 0:
        {
            
            [BaseRequest GET:GetAgentAuthInfo_URL parameters:nil success:^(id resposeObject) {
                
//                NSLog(@"%@",resposeObject);
                if ([resposeObject[@"code"] integerValue] == 200) {
                    
                    if ([resposeObject[@"data"] isKindOfClass:[NSDictionary class]]) {
                        
                        NSDictionary *dic = resposeObject[@"data"];
                        IdentifyingVC *nextVC = [[IdentifyingVC alloc] initWithData:dic];
                        [self.navigationController pushViewController:nextVC animated:YES];
                    }else{
                        
                        IDcardAuthenticationVC *nextVC = [[IDcardAuthenticationVC alloc] init];
                        [self.navigationController pushViewController:nextVC animated:YES];
                    }
                }else{
                    
                    IDcardAuthenticationVC *nextVC = [[IDcardAuthenticationVC alloc] init];
                    [self.navigationController pushViewController:nextVC animated:YES];
                }
            } failure:^(NSError *error) {
                
                IDcardAuthenticationVC *nextVC = [[IDcardAuthenticationVC alloc] init];
                [self.navigationController pushViewController:nextVC animated:YES];
//                NSLog(@"%@",error);
            }];
            break;
        }
        case 1:
        {
//            IdentifyingVC *nextVC = [[IdentifyingVC alloc] init];
//            [self.navigationController pushViewController:nextVC animated:YES];
            break;
        }
        case 2:
        {
            BankCardListVC *nextVC = [[BankCardListVC alloc] init];
            [self.navigationController pushViewController:nextVC animated:YES];
            break;
        }
        default:
            break;
    }
}


- (void)ActionAwardBtn:(UIButton *)btn{
    
    if (btn.tag == 0) {
        
        BrokerageAwardVC *nextVC = [[BrokerageAwardVC alloc] initWithTitle:@"邀请奖励"];
        [self.navigationController pushViewController:nextVC animated:YES];
    }else{
        
        BrokerageAwardVC *nextVC = [[BrokerageAwardVC alloc] initWithTitle:@"其他奖励"];
        [self.navigationController pushViewController:nextVC animated:YES];
    }
    
}

#pragma mark -- tableview

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 91 *SIZE;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BrokerageTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BrokerageTableCell"];
    if (!cell) {
        
        cell = [[BrokerageTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BrokerageTableCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row == 0) {
        
        cell.titleL.text = @"未结佣金";
    }else{
        
        cell.titleL.text = @"已结佣金";
    }
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"条数%@",_brokerCount[indexPath.row][0]]];
    [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12 *SIZE] range:NSMakeRange(0, 2)];
    cell.numL.attributedText = attr;
    cell.priceL.text = [NSString stringWithFormat:@"%@",_brokerCount[indexPath.row][1]];

    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        UnpaidBrokerageVC *nextVC = [[UnpaidBrokerageVC alloc] init];
        [self.navigationController pushViewController:nextVC animated:YES];
    }else{
        
        BrokerageRecordVC *nextVC = [[BrokerageRecordVC alloc] init];
        [self.navigationController pushViewController:nextVC animated:YES];
    }
}


#pragma mark -- UI
- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"我的佣金";
    
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width , 133 *SIZE)];
    whiteView.backgroundColor = CH_COLOR_white;
    [self.view addSubview:whiteView];
    
    for (int i = 0; i < 3; i++) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(34 *SIZE + i * 120 *SIZE, 17 *SIZE, 53 *SIZE, 53 *SIZE)];
        imageView.image = [UIImage imageNamed:_imageArr[i]];
        [whiteView addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(120 *SIZE * i, 88 *SIZE, 120 *SIZE, 11 *SIZE)];
        label.textColor = YJTitleLabColor;
        label.font = [UIFont systemFontOfSize:12 *SIZE];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = _titleArr[i];
        [whiteView addSubview:label];
        
        if (i == 1) {
            
            _priceL = [[UILabel alloc] init];
            _priceL.frame = CGRectMake(120 *SIZE, 108 *SIZE, 120 *SIZE, 10 *SIZE);
            _priceL.font = [UIFont systemFontOfSize:12 *SIZE];
            _priceL.textColor = YJBlueBtnColor;
            _priceL.text = @"￥2300";
            _priceL.textAlignment = NSTextAlignmentCenter;
            [whiteView addSubview:_priceL];
        }
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(120 *SIZE * i, 0, 120 *SIZE, 120 *SIZE);
        btn.tag = i;
        [btn addTarget:self action:@selector(ActionTagBtn:) forControlEvents:UIControlEventTouchUpInside];
        [whiteView addSubview:btn];
    }
    
    for (int i = 0; i < 2; i++) {
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(10 *SIZE + SCREEN_Width / 2 * i, 144 *SIZE + NAVIGATION_BAR_HEIGHT, 167 *SIZE, 83 *SIZE)];
        img.userInteractionEnabled = YES;
        if (i == 0) {
            
            img.image = [UIImage imageNamed:@"blue"];
        }else{
            
            img.image = [UIImage imageNamed:@"orange"];
        }
//        img.backgroundColor = YJBlueBtnColor;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 18 *SIZE, 167 *SIZE, 13 *SIZE)];
        label.textColor = CH_COLOR_white;
        if (i == 0) {
            
            label.text = @"邀请奖励";
        }else{
            
            label.text = @"其他奖励";
        }
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        label.textAlignment = NSTextAlignmentCenter;
        
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 47 *SIZE, 167 *SIZE, 13 *SIZE)];
        label1.textColor = CH_COLOR_white;
        label1.font = [UIFont systemFontOfSize:13 *SIZE];
        label1.text = @"￥0";
        label1.textAlignment = NSTextAlignmentCenter;
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = img.bounds;
        btn.tag = 0;
        [btn addTarget:self action:@selector(ActionAwardBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i == 0) {
            
            _awardView = img;
            [self.view addSubview:_awardView];
            _titleL1 = label;
            [_awardView addSubview:_titleL1];
            _priceL1 = label1;
            [_awardView addSubview:_priceL1];
            [_awardView addSubview:btn];
        }else{
            
            _awardView1 = img;
            [self.view addSubview:_awardView1];
            _titleL2 = label;
            [_awardView1 addSubview:_titleL2];
            _priceL2 = label1;
            [_awardView1 addSubview:_priceL2];
            [_awardView1 addSubview:btn];
        }
    }
    
    _brokerTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT + 133 *SIZE + 105 *SIZE, SCREEN_Width, SCREEN_Height - 133 *SIZE - 105 *SIZE - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    _brokerTable.backgroundColor = self.view.backgroundColor;
    _brokerTable.delegate = self;
    _brokerTable.dataSource = self;
    _brokerTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    _brokerTable.bounces = NO;
    [self.view addSubview:_brokerTable];
    
    _declareL = [[UILabel alloc] initWithFrame:CGRectMake(11 *SIZE, SCREEN_Height - 20 *SIZE, 300 *SIZE, 15 *SIZE)];
    _declareL.textColor = YJContentLabColor;
    _declareL.font = [UIFont systemFontOfSize:11 *SIZE];
    _declareL.text = @"免责声明：佣金数据仅供参考，不作为财务结算依据。";
    [self.view addSubview:_declareL];
}

@end
