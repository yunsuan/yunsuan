//
//  ComplaintVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/9.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "ComplaintVC.h"
#import "SinglePickView.h"
#import "RecommendVC.h"
#import "BarginVC.h"
#import "NomineeVC.h"

@interface ComplaintVC ()<UITextViewDelegate>
{
    
    NSString *_type;
    NSString *_projectId;
}
@property (nonatomic, strong) UIButton *confirmBtn;

@property (nonatomic, strong) UIButton *selectBtn;

@property (nonatomic, strong) UILabel *statusL;

@property (nonatomic, strong) UITextView *feedbackTV;

@property (nonatomic, strong) UILabel *placeL;

@property (nonatomic, strong) SinglePickView *typeView;

@end

@implementation ComplaintVC

- (instancetype)initWithProjectId:(NSString *)projectId
{
    self = [super init];
    if (self) {
        
        _projectId = projectId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)ActionComfirmBtn:(UIButton *)btn{
    
    if (!_type.length) {
        
        [self showContent:@"请选择申诉类型"];
        return;
    }
    
    if (!_feedbackTV.text.length) {
        
        [self showContent:@"请填写申诉内容"];
        return;
    }
    
    [BaseRequest POST:ClientAppeal_URL parameters:@{@"project_client_id":_projectId,@"type":_type,@"comment":_feedbackTV.text} success:^(id resposeObject) {

        if ([resposeObject[@"code"] integerValue] == 200) {
            
            for (UIViewController *vc in self.navigationController.viewControllers) {
                
                if ([vc isKindOfClass:[RecommendVC class]]) {
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"inValidReload" object:nil];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"appealReload" object:nil];
                    [self.navigationController popToViewController:vc animated:YES];
                }
                
                if ([vc isKindOfClass:[NomineeVC class]]) {
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"inValidReload" object:nil];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"appealReload" object:nil];
                    [self.navigationController popToViewController:vc animated:YES];
                }
                
                if ([vc isKindOfClass:[BarginVC class]]) {
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"inValidReload" object:nil];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"appealReload" object:nil];
                    [self.navigationController popToViewController:vc animated:YES];
                }
            }
        }
        else{
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [self showContent:@"网络错误"];
    }];
}

- (void)ActionSelectBtn:(UIButton *)btn{
    
    SinglePickView *view = [[SinglePickView alloc]initWithFrame:self.view.frame WithData:[self getDetailConfigArrByConfigState:APPEAL_TYPE]];
    
    view.selectedBlock = ^(NSString *MC, NSString *ID) {
        
        _statusL.text = MC;
        _type = [NSString stringWithFormat:@"%@",ID];
    };
    [self.view addSubview:view];
}

- (void)textViewDidChange:(UITextView *)textView{
    
    if (textView.text.length) {
        
        _placeL.hidden = YES;
    }else{
        
        _placeL.hidden = NO;
    }
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"申诉";
    
    UIView *whiteView1 = [[UIView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, 43 *SIZE)];
    whiteView1.backgroundColor = CH_COLOR_white;
    [self.view addSubview:whiteView1];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(11 *SIZE, 15 *SIZE, 60 *SIZE, 12 *SIZE)];
    label.textColor = YJContentLabColor;
    label.font = [UIFont systemFontOfSize:13 *SIZE];
    label.text = @"申诉类型";
    [whiteView1 addSubview:label];
    
    _statusL = [[UILabel alloc] initWithFrame:CGRectMake(150 *SIZE, 15 *SIZE, 167 *SIZE, 13 *SIZE)];
    _statusL.textColor = YJTitleLabColor;
    _statusL.font = [UIFont systemFontOfSize:13 *SIZE];
    _statusL.textAlignment = NSTextAlignmentRight;
    [whiteView1 addSubview:_statusL];
    
    UIImageView *dropImg = [[UIImageView alloc] initWithFrame:CGRectMake(336 *SIZE, 17 *SIZE, 12 *SIZE, 12 *SIZE)];
    dropImg.image = [UIImage imageNamed:@"downarrow"];
    [whiteView1 addSubview:dropImg];
    
    _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _selectBtn.frame = CGRectMake(0, 0, SCREEN_Width, 43 *SIZE);
    [_selectBtn addTarget:self action:@selector(ActionSelectBtn:) forControlEvents:UIControlEventTouchUpInside];
    [whiteView1 addSubview:_selectBtn];
    
    UIView *whiteView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 53 * SIZE +  NAVIGATION_BAR_HEIGHT, SCREEN_Width, 150 *SIZE)];
    whiteView2.backgroundColor = CH_COLOR_white;
    [self.view addSubview:whiteView2];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(11 *SIZE, 15 *SIZE, 60 *SIZE, 12 *SIZE)];
    label2.textColor = YJContentLabColor;
    label2.font = [UIFont systemFontOfSize:13 *SIZE];
    label2.text = @"申诉类型";
    [whiteView2 addSubview:label2];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 32 *SIZE, SCREEN_Width, SIZE)];
    line.backgroundColor = YJBackColor;
    [whiteView2 addSubview:line];
    
    _feedbackTV = [[UITextView alloc] initWithFrame:CGRectMake(5 *SIZE, 39 *SIZE, 340 *SIZE, 90 *SIZE)];
    _feedbackTV.delegate = self;
    [whiteView2 addSubview:_feedbackTV];
    
    _placeL = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 46 *SIZE, 340 *SIZE, 11 *SIZE)];
    _placeL.textColor = YJ170Color;
    _placeL.font = [UIFont systemFontOfSize:12 *SIZE];
    _placeL.text = @"请输入意见反馈...";
    [whiteView2 addSubview:_placeL];
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirmBtn.frame = CGRectMake(21 *SIZE, 486 *SIZE + NAVIGATION_BAR_HEIGHT, 317 *SIZE, 40 *SIZE);
    _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:14 *sIZE];
    [_confirmBtn addTarget:self action:@selector(ActionComfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_confirmBtn setTitle:@"提交" forState:UIControlStateNormal];
    [_confirmBtn setBackgroundColor:YJBlueBtnColor];
    [_confirmBtn setTitleColor:CH_COLOR_white forState:UIControlStateNormal];
    [self.view addSubview:_confirmBtn];

}

@end
