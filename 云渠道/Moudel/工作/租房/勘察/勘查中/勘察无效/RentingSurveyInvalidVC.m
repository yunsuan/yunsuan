//
//  RentingSurveyInvalidVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/7/26.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RentingSurveyInvalidVC.h"

//#import "RentingSurveyingVC.h"
#import "RentingSurveyVC.h"

#import "SinglePickView.h"

#import "DropDownBtn.h"

@interface RentingSurveyInvalidVC (){
    
    NSArray *_titleArr;
    //    NSArray *_contentArr;
    NSString *_type;
    NSDictionary *_dataDic;
}
@property (nonatomic, strong) DropDownBtn *timeBtn;

@property (nonatomic, strong) UITextView *reasonTV;

@property (nonatomic, strong) UIButton *confirmBtn;


@end

@implementation RentingSurveyInvalidVC

- (instancetype)initWithData:(NSDictionary *)data
{
    self = [super init];
    if (self) {
        
        _dataDic = data;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
    _titleArr = @[@"房源编号",@"勘察地址"];
}

- (void)ActionConfirmBtn:(UIButton *)btn{
    
    if (!_type.length) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请选择无效类型"];
        return;
    }

    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"survey_id":self.surveyId,
                                                                               @"disabled_state":_type
                                                                               }];
    if (![self isEmpty:_reasonTV.text]) {
        
        [dic setObject:_reasonTV.text forKey:@"disabled_reason"];
    }
    [BaseRequest GET:RentRecordDisabled_URL parameters:dic success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [self alertControllerWithNsstring:@"温馨提示" And:@"房源已失效" WithDefaultBlack:^{
                
                if (self.rentSurveyInvalidVCBlock) {
                    
                    self.rentSurveyInvalidVCBlock();
                }
                for (UIViewController *vc in self.navigationController.viewControllers) {
                    
                    if ([vc isKindOfClass:[RentingSurveyVC class]]) {
                        
                        [self.navigationController popToViewController:vc animated:YES];
                    }
                }
            }];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [self showContent:@"网络错误"];
        NSLog(@"%@",error);
    }];
}

- (void)ActionTypeBtn:(UIButton *)btn{
    
    SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.frame WithData:[self getDetailConfigArrByConfigState:RENT_DISABLED_TYPE]];
    
    SS(strongSelf);
    view.selectedBlock = ^(NSString *MC, NSString *ID) {
        
        strongSelf->_type = [NSString stringWithFormat:@"%@",ID];
        strongSelf.timeBtn.content.text = [NSString stringWithFormat:@"%@",MC];
    };
    [self.view addSubview:view];
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"勘察计划";
    
    UIView *whiteView1 = [[UIView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, 87 *SIZE)];
    whiteView1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiteView1];
    
    for (int i = 0; i < 2; i++) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 16 *SIZE + i * 43 *SIZE, 200 *SIZE, 13 *SIZE)];
        label.textColor = YJContentLabColor;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        label.text = _titleArr[i];
        [whiteView1 addSubview:label];
        
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(80 *SIZE, 16 *SIZE + i * 43 *SIZE, 200 *SIZE, 13 *SIZE)];
        label1.textColor = YJ170Color;
        label1.font = [UIFont systemFontOfSize:13 *SIZE];
        //        label1.text = @"自动生成";
        if (i == 0) {
            
            label1.text = _dataDic[@"house_code"];
        }else{
            
            label1.text = [NSString stringWithFormat:@"%@",_dataDic[@"house"]];
        }
        [whiteView1 addSubview:label1];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(10 *SIZE, 43 *SIZE * i - SIZE, 340 *SIZE, SIZE)];
        line.backgroundColor = COLOR(202, 201, 201, 0.55);
        if (i != 0) {
            
            [whiteView1 addSubview:line];
        }
    }
    
    UIView *whiteView2 = [[UIView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT + 93 *SIZE, SCREEN_Width, 183 *SIZE)];
    whiteView2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiteView2];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(9 *SIZE, 27 *SIZE, 80 *SIZE, 10 *SIZE)];
    label.textColor = YJTitleLabColor;
    label.font = [UIFont systemFontOfSize:11 *SIZE];
    label.text = @"失效类型:";
    [whiteView2 addSubview:label];
    
    _timeBtn = [[DropDownBtn alloc] initWithFrame:CGRectMake(80 *SIZE, 17 *SIZE, 258 *SIZE, 33 *SIZE)];
    [_timeBtn addTarget:self action:@selector(ActionTypeBtn:) forControlEvents:UIControlEventTouchUpInside];
    [whiteView2 addSubview:_timeBtn];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(9 *SIZE, 84 *SIZE, 80 *SIZE, 10 *SIZE)];
    label2.textColor = YJTitleLabColor;
    label2.font = [UIFont systemFontOfSize:11 *SIZE];
    label2.text = @"失效描述:";
    [whiteView2 addSubview:label2];
    
    _reasonTV = [[UITextView alloc] initWithFrame:CGRectMake(79 *SIZE, 74 *SIZE, 258 *SIZE, 77 *SIZE)];
    _reasonTV.layer.cornerRadius = 5 *SIZE;
    _reasonTV.clipsToBounds = YES;
    _reasonTV.layer.borderColor = COLOR(219, 219, 219, 1).CGColor;
    _reasonTV.layer.borderWidth = SIZE;
    [whiteView2 addSubview:_reasonTV];
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirmBtn.frame = CGRectMake(22 *SIZE, 493 *SIZE + NAVIGATION_BAR_HEIGHT, 317 *SIZE, 40 *SIZE);
    _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_confirmBtn addTarget:self action:@selector(ActionConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
    [_confirmBtn setBackgroundColor:YJBlueBtnColor];
    [self.view addSubview:_confirmBtn];
}

@end
