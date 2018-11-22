//
//  GetAgencyProtocolVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/6/21.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "GetAgencyProtocolVC.h"

#import "RoomAgencyDoneVC.h"
#import "RoomAgencyVC.h"

#import "BaseFrameHeader.h"

#import "DropDownBtn.h"
#import "BorderTF.h"
#import "SinglePickView.h"
#import "DateChooseView.h"

@interface GetAgencyProtocolVC ()
{
    
    NSArray *_titleArr;
    NSString *_typeid;
//    NSArray *_contentArr;
}

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIView *tradeView;

@property (nonatomic, strong) BaseFrameHeader *tradeHeader;

@property (nonatomic, strong) UILabel *tradeL;

@property (nonatomic, strong) UIView *customView;

@property (nonatomic, strong) BaseFrameHeader *customHeader;

@property (nonatomic, strong) UILabel *recommendL;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UILabel *phoneL;

@property (nonatomic, strong) UIView *roomView;

@property (nonatomic, strong) BaseFrameHeader *roomHeader;

@property (nonatomic, strong) UILabel *roomCodeL;

@property (nonatomic, strong) UILabel *communityL;

@property (nonatomic, strong) UILabel *numL;

@property (nonatomic, strong) UIView *protocolView;

@property (nonatomic, strong) BaseFrameHeader *protocolHeader;

@property (nonatomic, strong) UILabel *typeL;

@property (nonatomic, strong) DropDownBtn *typeBtn;

@property (nonatomic, strong) UILabel *breachL;

@property (nonatomic, strong) BorderTF *breachTF;

@property (nonatomic, strong) UILabel *reasonL;

@property (nonatomic, strong) UITextView *reasonTV;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) DropDownBtn *timeBtn;

@property (nonatomic, strong) UIButton *confirmBtn;

@end

@implementation GetAgencyProtocolVC

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
    _titleArr = @[@"交易信息",@"客户信息",@"房源信息",@"挞定信息"];
//    _contentArr = @[@"交易编号：TJBHNO1",@"推荐编号：TJBHNO1",@"客户名称：张三",@"联系电话：15201234567",@"房源编号：TJBHNO1",@"成都市 - 郫都区 - 大禹东路198号 云算公馆小区",@"批次：1批次 - 1栋 - 1单元 - 102",@"挞定类型:",@"违约金:",@"挞定描述:",@"登记时间:"];
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"挞定详情";
    
    _scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:_scrollView];
    
    for (int i = 0; i < 4; i++) {
        
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        
        BaseFrameHeader *header = [[BaseFrameHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
        header.titleL.text = _titleArr[i];
        header.backgroundColor = [UIColor whiteColor];
        
        switch (i) {
            case 0:
            {
                _tradeView = view;
                _tradeHeader = header;
                _tradeHeader.lineView.hidden = YES;
                [_tradeView addSubview:_tradeHeader];
                [_scrollView addSubview:_tradeView];
                break;
            }
            case 1:
            {
                _customView = view;
                _customHeader = header;
                [_customView addSubview:_customHeader];
                [_scrollView addSubview:_customView];
                break;
            }
            case 2:
            {
                _roomView = view;
                _roomHeader = header;
                [_roomView addSubview:_roomHeader];
                [_scrollView addSubview:_roomView];
                break;
            }
            case 3:
            {
                _protocolView = view;
                _protocolHeader = header;
                [_protocolView addSubview:_protocolHeader];
                [_scrollView addSubview:_protocolView];
                break;
            }
            default:
                break;
        }
    }
    
    for (int i = 0; i < 11; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = YJContentLabColor;
        label.numberOfLines = 0;
        label.lineBreakMode = NSLineBreakByCharWrapping;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        label.text = _infoArr[i];
        switch (i) {
            case 0:
            {
                _tradeL = label;
                [_tradeView addSubview:_tradeL];
                break;
            }
            case 1:
            {
                _recommendL = label;
                [_customView addSubview:_recommendL];
                break;
            }
            case 2:
            {
                _nameL = label;
                [_customView addSubview:_nameL];
                break;
            }
            case 3:
            {
                _phoneL = label;
                [_customView addSubview:_phoneL];
                break;
            }
            case 4:
            {
                _roomCodeL = label;
                [_roomView addSubview:_roomCodeL];
                break;
            }
            case 5:
            {
                _communityL = label;
                [_roomView addSubview:_communityL];
                break;
            }
            case 6:
            {
                _numL = label;
                [_roomView addSubview:_numL];
                break;
            }
            case 7:
            {
                _typeL = label;
                [_protocolView addSubview:_typeL];
                break;
            }
            case 8:
            {
                _breachL = label;
                [_protocolView addSubview:_breachL];
                break;
            }
            case 9:
            {
                _reasonL = label;
                [_protocolView addSubview:_reasonL];
                break;
            }
            case 10:
            {
                _timeL = label;
                [_protocolView addSubview:_timeL];
                break;
            }
            default:
                break;
        }
    }
    
    _typeBtn = [[DropDownBtn alloc] initWithFrame:CGRectMake(81 *SIZE, 50 *SIZE, 257 *SIZE, 33 *SIZE)];
    [_typeBtn addTarget:self action:@selector(action_type) forControlEvents:UIControlEventTouchUpInside];
    [_protocolView addSubview:_typeBtn];
    
    _breachTF = [[BorderTF alloc] initWithFrame:CGRectMake(81 *SIZE, 108 *SIZE, 257 *SIZE, 33 *SIZE)];
    _breachTF.textfield.text = _broker;
    [_protocolView addSubview:_breachTF];
    
    _reasonTV = [[UITextView alloc] initWithFrame:CGRectMake(81 *SIZE, 165 *SIZE, 257 *SIZE, 77 *SIZE)];
    _reasonTV.layer.cornerRadius = 5 *SIZE;
    _reasonTV.layer.borderColor = COLOR(219, 219, 219, 1).CGColor;
    _reasonTV.layer.borderWidth = SIZE;
    _reasonTV.clipsToBounds = YES;
    [_protocolView addSubview:_reasonTV];
    
    _timeBtn = [[DropDownBtn alloc] initWithFrame:CGRectMake(81 *SIZE, 266 *SIZE, 257 *SIZE, 33 *SIZE)];
    _timeBtn.content.text = [self gettime:[NSDate date]];
    [_timeBtn addTarget:self action:@selector(action_time) forControlEvents:UIControlEventTouchUpInside];
    [_protocolView addSubview:_timeBtn];
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [_confirmBtn addTarget:self action:@selector(action_confirm) forControlEvents:UIControlEventTouchUpInside];
    [_confirmBtn setBackgroundColor:YJBlueBtnColor];
    [_scrollView addSubview:_confirmBtn];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.view).offset(0 *SIZE);
        make.top.equalTo(self.view).offset(NAVIGATION_BAR_HEIGHT);
        make.right.equalTo(self.view).offset(0 *SIZE);
        make.bottom.equalTo(self.view).offset(0);
    }];
    
    [_tradeView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrollView).offset(0 *SIZE);
        make.top.equalTo(_scrollView).offset(0);
        make.width.mas_equalTo(SCREEN_Width);
        make.right.equalTo(_scrollView).offset(0 *SIZE);
    }];
    
    [_tradeHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_tradeView).offset(0 *SIZE);
        make.top.equalTo(_tradeView).offset(0);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(40 *SIZE);
    }];
    
    [_tradeHeader ReMasonryUI];
    
    [_tradeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_tradeView).offset(28 *SIZE);
        make.top.equalTo(_tradeHeader.mas_bottom).offset(12 *SIZE);
        make.right.equalTo(_tradeView).offset(-28 *SIZE);
        make.bottom.equalTo(_tradeView).offset(-19 *SIZE);
    }];
    
    [_customView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrollView).offset(0 *SIZE);
        make.top.equalTo(_tradeView.mas_bottom).offset(4 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.right.equalTo(_scrollView).offset(0 *SIZE);
    }];
    
    [_customHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_customView).offset(0 *SIZE);
        make.top.equalTo(_customView).offset(0);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(40 *SIZE);
    }];
    
    [_customHeader ReMasonryUI];
    
    [_recommendL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_customView).offset(28 *SIZE);
        make.top.equalTo(_customHeader.mas_bottom).offset(12 *SIZE);
        make.right.equalTo(_customView).offset(-28 *SIZE);
        //        make.bottom.equalTo(_tradeView).offset(-19 *SIZE);
    }];
    
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_customView).offset(28 *SIZE);
        make.top.equalTo(_recommendL.mas_bottom).offset(17 *SIZE);
        make.right.equalTo(_customView).offset(-28 *SIZE);
        //        make.bottom.equalTo(_tradeView).offset(-19 *SIZE);
    }];
    
    [_phoneL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_customView).offset(28 *SIZE);
        make.top.equalTo(_nameL.mas_bottom).offset(17 *SIZE);
        make.right.equalTo(_customView).offset(-28 *SIZE);
        make.bottom.equalTo(_customView).offset(-19 *SIZE);
    }];
    
    [_roomView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrollView).offset(0 *SIZE);
        make.top.equalTo(_customView.mas_bottom).offset(4 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.right.equalTo(_scrollView).offset(0 *SIZE);
    }];
    
    [_roomHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_roomView).offset(0 *SIZE);
        make.top.equalTo(_roomView).offset(0);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(40 *SIZE);
    }];
    
    [_roomHeader ReMasonryUI];
    
    [_roomCodeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_roomView).offset(28 *SIZE);
        make.top.equalTo(_roomHeader.mas_bottom).offset(12 *SIZE);
        make.right.equalTo(_roomView).offset(-28 *SIZE);
//        make.bottom.equalTo(_tradeView).offset(-19 *SIZE);
    }];
    
    [_communityL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_roomView).offset(28 *SIZE);
        make.top.equalTo(_roomCodeL.mas_bottom).offset(17 *SIZE);
        make.right.equalTo(_roomView).offset(-28 *SIZE);
//        make.bottom.equalTo(_tradeView).offset(-19 *SIZE);
    }];
    
    [_numL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_roomView).offset(28 *SIZE);
        make.top.equalTo(_communityL.mas_bottom).offset(17 *SIZE);
        make.right.equalTo(_roomView).offset(-28 *SIZE);
        make.bottom.equalTo(_roomView).offset(-19 *SIZE);
    }];
    
    [_protocolView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrollView).offset(0 *SIZE);
        make.top.equalTo(_roomView.mas_bottom).offset(4 *SIZE);
        make.right.equalTo(_scrollView).offset(0 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
    }];
    
    [_protocolHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_protocolView).offset(0 *SIZE);
        make.top.equalTo(_protocolView).offset(0);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(40 *SIZE);
    }];
    
    [_protocolHeader ReMasonryUI];
    
    [_typeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_protocolView).offset(10 *SIZE);
        make.top.equalTo(_protocolHeader.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_typeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_protocolView).offset(80 *SIZE);
        make.top.equalTo(_protocolHeader.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_breachL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_protocolView).offset(10 *SIZE);
        make.top.equalTo(_typeBtn.mas_bottom).offset(35 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_breachTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_protocolView).offset(80 *SIZE);
        make.top.equalTo(_typeBtn.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_reasonL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_protocolView).offset(10 *SIZE);
        make.top.equalTo(_breachTF.mas_bottom).offset(35 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_reasonTV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_protocolView).offset(80 *SIZE);
        make.top.equalTo(_breachTF.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(77 *SIZE);
    }];
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_protocolView).offset(10 *SIZE);
        make.top.equalTo(_reasonTV.mas_bottom).offset(35 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_timeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_protocolView).offset(80 *SIZE);
        make.top.equalTo(_reasonTV.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
        make.bottom.equalTo(_protocolView).offset(-24 *SIZE);
    }];
    
    [_confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrollView).offset(22 *SIZE);
        make.top.equalTo(_protocolView.mas_bottom).offset(28 *SIZE);
        make.width.equalTo(@(317 *SIZE));
        make.height.equalTo(@(40 *SIZE));
        make.bottom.equalTo(_scrollView.mas_bottom).offset(-19 *SIZE);
    }];
}

#pragma mark ----action----
-(void)action_type
{
    SinglePickView *view = [[SinglePickView alloc]initWithFrame:self.view.frame WithData:[self getDetailConfigArrByConfigState:BREACH_TYPE]];
    [self.view addSubview:view];
    view.selectedBlock = ^(NSString *MC, NSString *ID) {
        _typeBtn.content.text = MC;
        _typeid = ID;
        
    };
}

-(void)action_time
{
    DateChooseView *view = [[DateChooseView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    view.dateblock = ^(NSDate *date) {
        //        NSLog(@"%@",[self gettime:date]);
        _timeBtn.content.text = [self gettime:date];
    };
    [self.view addSubview:view];
}

-(void)action_confirm
{
//    if (_typeid.length!=0) {
//        [self showContent:@"请选择挞定类型"];
//    }
    
        NSDictionary *dic = @{
                              @"sub_id":_sub_id,
                              @"disabled_state":_typeid,
                              @"broker_num":_breachTF.textfield.text,
                              @"disabled_reason":_reasonTV.text
                              };
        [BaseRequest POST:Breach_URL parameters:dic success:^(id resposeObject) {
            NSLog(@"%@",resposeObject);
            if ([resposeObject[@"code"] integerValue] == 200) {
                
                for (UIViewController *vc in self.navigationController.viewControllers) {
                    
                    if ([vc isKindOfClass:[RoomAgencyVC class]]) {
                        
                        if (self.getAgencyProtocolVCBlock) {
                            
                            self.getAgencyProtocolVCBlock();
                        }
                        [self.navigationController popToViewController:vc animated:YES];
                    }
                }
            }else{
                
                [self showContent:resposeObject[@"msg"]];
            }
        } failure:^(NSError *error) {
            
            [self showContent:@"网络错误"];
            NSLog(@"%@",error);
        }];
    
}

-(NSString * _Nonnull)gettime:(NSDate * _Nonnull)date//nsdate转字符转
{
    NSDateFormatter*dateFormatter = [[NSDateFormatter  alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString*currentDateStr = [dateFormatter stringFromDate:date];
    return currentDateStr;
}
@end
