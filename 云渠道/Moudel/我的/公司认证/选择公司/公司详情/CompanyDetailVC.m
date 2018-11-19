//
//  CompanyDetailVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/3/28.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "CompanyDetailVC.h"
#import "AuthenticationVC.h"

@interface CompanyDetailVC ()
{
    
    CompanyModel *_model;
}
@property (nonatomic, strong) UILabel *briefL;

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UIButton *selectBtn;

@end

@implementation CompanyDetailVC

- (instancetype)initWithModel:(CompanyModel *)model
{
    self = [super init];
    if (self) {
        
        _model = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self initUI];
}

- (void)ActionSelectBtn:(UIButton *)btn{
    
    for (UIViewController *vc in self.navigationController.viewControllers) {
        
        if ([vc isKindOfClass:[AuthenticationVC class]]) {
            
            if (self.companyDetailVCBlock) {
                
                self.companyDetailVCBlock(_model.company_id, _model.company_name);
                [self.navigationController popToViewController:vc animated:YES];
            }
            
        }
    }
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"公司详情";
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - 47 *SIZE)];
    scrollView.backgroundColor = self.view.backgroundColor;
    [self.view addSubview:scrollView];
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 2 *SIZE, SCREEN_Width, 100 *SIZE)];
    topView.backgroundColor = CH_COLOR_white;
    [scrollView addSubview:topView];
    
    UIImageView *headImg = [[UIImageView alloc] initWithFrame:CGRectMake(10 *SIZE, 17 *SIZE, 67 *SIZE, 67 *SIZE)];
    [topView addSubview:headImg];
    if (_model.logo.length>0) {
        [headImg sd_setImageWithURL:[NSURL URLWithString:_model.logo] placeholderImage:[UIImage imageNamed:@"default_3"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            
            if (error) {
                
                headImg.image = [UIImage imageNamed:@"default_3"];
            }
        }];
    }else
    {
        headImg.image = [UIImage imageNamed:@"default_3"];
    }
    
    
    UILabel *nameL = [[UILabel alloc] initWithFrame:CGRectMake(88 *SIZE, 12 *SIZE, 300 *SIZE, 13 *SIZE)];
    nameL.textColor = YJTitleLabColor;
    nameL.font = [UIFont systemFontOfSize:13 *SIZE];
    nameL.text = _model.company_name;
    [topView addSubview:nameL];
    
    UILabel *contactL = [[UILabel alloc] initWithFrame:CGRectMake(89 *SIZE, 35 *SIZE, 300 *SIZE, 10 *SIZE)];
    contactL.textColor = YJContentLabColor;
    contactL.font = [UIFont systemFontOfSize:11 *SIZE];
    contactL.text = [NSString stringWithFormat:@"负责人：%@",_model.contact];
    [topView addSubview:contactL];
    
    UILabel *phoneL = [[UILabel alloc] initWithFrame:CGRectMake(220 *SIZE, 12 *SIZE, 130 *SIZE, 10 *SIZE)];
    phoneL.textColor = YJContentLabColor;
    phoneL.font = [UIFont systemFontOfSize:11 *SIZE];
    phoneL.textAlignment = NSTextAlignmentRight;
    phoneL.text = [NSString stringWithFormat:@"联系电话：%@",_model.contact_tel];
    [topView addSubview:phoneL];
    
    UILabel *codeL = [[UILabel alloc] initWithFrame:CGRectMake(88 *SIZE, 57 *SIZE, 300 *SIZE, 10 *SIZE)];
    codeL.textColor = YJContentLabColor;
    codeL.font = [UIFont systemFontOfSize:11 *SIZE];
//    codeL.text = [NSString stringWithFormat:@"营业执照号：%@",_model.code];
    [topView addSubview:codeL];
    
    UILabel *addressL = [[UILabel alloc] initWithFrame:CGRectMake(88 *SIZE, 78 *SIZE, 300 *SIZE, 10 *SIZE)];
    addressL.textColor = YJTitleLabColor;
    addressL.font = [UIFont systemFontOfSize:11 *SIZE];
    addressL.text = [NSString stringWithFormat:@"地址：%@",_model.absolute_address];
    [topView addSubview:addressL];
    
    _contentView = [[UIView alloc] init];
    _contentView.backgroundColor = CH_COLOR_white;
    [scrollView addSubview:_contentView];
    
    for (int i = 0; i < 2; i++) {
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(124 *SIZE + i * 93 *SIZE, 24 *SIZE, 17 *SIZE, 2 *SIZE)];
        line.backgroundColor = COLOR(27, 152, 255, 1);
        [_contentView addSubview:line];
    }
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(141 *SIZE, 17 *SIZE, 76 *SIZE, 14 *SIZE)];
    label.textColor = YJTitleLabColor;
    label.font = [UIFont systemFontOfSize:15 *SIZE];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"公司简介";
    [_contentView addSubview:label];
    
    _briefL = [[UILabel alloc] init];
    _briefL.textColor = YJTitleLabColor;
    _briefL.font = [UIFont systemFontOfSize:12 *SIZE];
    _briefL.numberOfLines = 0;
    [_contentView addSubview:_briefL];
    
//    _briefL.text = @"房产云算软件专门为房产经纪人研发的房地产软件，能够帮助房产经纪人更好的管理手上的房源信息，并且批量的将房源群发到当地的各大房产网站，省去了大量发布房源的时间，并且能够第一时间从各大房产网上获取最新的房源信息让房产经纪人能够及时的获取第一手资料，并且迅速完成配对，促进交易的完成。";
    _briefL.text = _model.comment;
    UIFont *font=[UIFont systemFontOfSize:12 *SIZE];
    NSDictionary *attr = @{NSFontAttributeName:font};
    CGFloat height = [_briefL.text boundingRectWithSize:CGSizeMake(335 *SIZE, SCREEN_Height * 3) options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size.height;
    _contentView.frame = CGRectMake(0, 108 *SIZE, SCREEN_Width, height + 105 *SIZE);
    _briefL.frame = CGRectMake(10 *SIZE, 57 *SIZE, 335 *SIZE, height);
    
    [scrollView setContentSize:CGSizeMake(SCREEN_Width, height + 105 *SIZE + 108 *SIZE)];

    
    _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _selectBtn.frame = CGRectMake(0, SCREEN_Height - 43 *SIZE - TAB_BAR_MORE, SCREEN_Width, 43 *SIZE + TAB_BAR_MORE);
    _selectBtn.titleLabel.font = [UIFont systemFontOfSize:14 *sIZE];
    [_selectBtn addTarget:self action:@selector(ActionSelectBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_selectBtn setTitle:@"选择该公司" forState:UIControlStateNormal];
    [_selectBtn setBackgroundColor:COLOR(27, 152, 255, 1)];
    [_selectBtn setTitleColor:CH_COLOR_white forState:UIControlStateNormal];
    [self.view addSubview:_selectBtn];
}

@end
