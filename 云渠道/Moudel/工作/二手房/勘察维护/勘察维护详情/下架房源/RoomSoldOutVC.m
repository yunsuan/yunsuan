//
//  RoomSoldOutVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/6/20.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RoomSoldOutVC.h"

#import "TitleContentTimeDoubleBtnView.h"
#import "SinglePickView.h"

#import "DropDownBtn.h"

@interface RoomSoldOutVC ()
{
    
    NSArray *_titleArr;
    NSArray *_contentArr;
    NSString *_houseId;
    NSString *_reasonId;
}

@property (nonatomic, strong) DropDownBtn *typeBtn;

@property (nonatomic, strong) UITextView *reasonTV;

@property (nonatomic, strong) UIButton *confirmBtn;

@end

@implementation RoomSoldOutVC

- (instancetype)initWithHouseId:(NSString *)houseId
{
    self = [super init];
    if (self) {
        
        _houseId = houseId;
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
    _contentArr = @[self.dataDic[@"house_code"],self.dataDic[@"absolute_address"]];
}

- (void)ActionTypeBtn:(UIButton *)btn{
    
    SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.frame WithData:[self getDetailConfigArrByConfigState:33]];
    
    SS(strongSelf);
    view.selectedBlock = ^(NSString *MC, NSString *ID) {
        
        strongSelf.typeBtn.content.text = [NSString stringWithFormat:@"%@",MC];
        strongSelf->_reasonId = [NSString stringWithFormat:@"%@",ID];
    };
    [self.view addSubview:view];
}

- (void)ActionConfirmBtn:(UIButton *)btn{
    
    if (!_reasonId.length) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请选择下架类型"];
        return;
    }
    
    if ([self isEmpty:_reasonTV.text]) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请输入下架原因"];
        return;
    }
 
    NSDictionary *dic = @{@"house_id":_houseId,
                          @"disabled_state":_reasonId,
                          @"disabled_reason":_reasonTV.text
                          };
    [BaseRequest POST:HouseSurveyCancelSale_URL parameters:dic success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
        
    } failure:^(NSError *error) {
        
        [self showContent:@"网络错误"];
        NSLog(@"%@",error);
    }];
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"下架房源";
    
    UIView *whiteView1 = [[UIView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, 87 *SIZE)];
    whiteView1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiteView1];
    
    for (int i = 0; i < 2; i++) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 16 *SIZE + i * 43 *SIZE, 70 *SIZE, 13 *SIZE)];
        label.textColor = YJContentLabColor;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        label.text = _titleArr[i];
        [whiteView1 addSubview:label];
        
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(80 *SIZE, 16 *SIZE + i * 43 *SIZE, 250 *SIZE, 13 *SIZE)];
        label1.textColor = YJ170Color;
        label1.font = [UIFont systemFontOfSize:13 *SIZE];
//        label1.text = @"自动生成";
        label1.text = _contentArr[i];
        [whiteView1 addSubview:label1];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(10 *SIZE, 43 *SIZE * i - SIZE, 340 *SIZE, SIZE)];
        line.backgroundColor = COLOR(202, 201, 201, 0.55);
        if (i != 0) {
            
            [whiteView1 addSubview:line];
        }
        
    }
    
    UIView *whiteView2 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(whiteView1.frame) + 5 *SIZE, SCREEN_Width, 183 *SIZE)];
    whiteView2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiteView2];
    
    for (int i = 0; i < 2; i++) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(9 *SIZE, 27 *SIZE + i * 57 *SIZE, 70 *SIZE, 13 *SIZE)];
        label.textColor = YJTitleLabColor;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        if (i == 0) {
            
            label.text = @"下架类型：";
        }else{
            
            label.text = @"下架描述：";
        }
        [whiteView2 addSubview:label];
    }
    
    _typeBtn = [[DropDownBtn alloc] initWithFrame:CGRectMake(81 *SIZE, 17 *SIZE, 257 *SIZE, 33 *SIZE)];
    [_typeBtn addTarget:self action:@selector(ActionTypeBtn:) forControlEvents:UIControlEventTouchUpInside];
    [whiteView2 addSubview:_typeBtn];
    
    _reasonTV = [[UITextView alloc] initWithFrame:CGRectMake(81 *SIZE, 74 *SIZE, 257 *SIZE, 77 *SIZE)];
    _reasonTV.layer.cornerRadius = 5 *SIZE;
    _reasonTV.clipsToBounds = YES;
    _reasonTV.layer.borderColor = COLOR(219, 219, 219, 1).CGColor;
    _reasonTV.layer.borderWidth = SIZE;
    [whiteView2 addSubview:_reasonTV];
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirmBtn.frame = CGRectMake(22 *SIZE, 494 *SIZE + NAVIGATION_BAR_HEIGHT, 317 *SIZE, 40 *SIZE);
    _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_confirmBtn addTarget:self action:@selector(ActionConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_confirmBtn setBackgroundColor:YJBlueBtnColor];
    [_confirmBtn setTitle:@"提交" forState:UIControlStateNormal];
    [self.view addSubview:_confirmBtn];
}

@end
