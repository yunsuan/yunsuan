
//
//  RecommendMoreInfoVC.m
//  云渠道
//
//  Created by 谷治墙 on 2019/3/29.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "RecommendMoreInfoVC.h"

#import "RecommendNewInfoVC.h"
#import "RecommendMoreInfoChildVC.h"

@interface RecommendMoreInfoVC ()<WMPageControllerDataSource,WMPageControllerDelegate>
{
    
    NSString *_applyFocusId;
    NSMutableArray *_titlearr;
    NSMutableDictionary *_dataDic;
    NSString *_titleStr;
    NSString *_isApplyFollow;
    NSString *_applyId;
}

@property (nonatomic, strong) UIImageView *companyImg;

@property (nonatomic, strong) UILabel *fansL;

@property (nonatomic, strong) UILabel *fansTL;

@property (nonatomic, strong) UILabel *commentL;

@property (nonatomic, strong) UILabel *commentTL;

@property (nonatomic, strong) UILabel *praiseL;

@property (nonatomic, strong) UILabel *praiseTL;

@property (nonatomic, strong) UILabel *forwardL;

@property (nonatomic, strong) UILabel *forwardTL;

@property (nonatomic, strong) UILabel *identityL;

//@property (nonatomic, strong) UILabel *identityTL;

@property (nonatomic, strong) UILabel *introL;

@end

@implementation RecommendMoreInfoVC

- (instancetype)initWithApplyFocusId:(NSString *)applyFocusId titleStr:(NSString *)titleStr applyId:(NSString *)applyId
{
    self = [super init];
    if (self) {
        
        _applyFocusId = applyFocusId;
        _titleStr = titleStr;
        _applyId = applyId;
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
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ActionGoto:) name:@"goto" object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ReloadType) name:@"reloadType" object:nil];
    
//    _isApplyFollow = @"1";
    _titlearr = [@[] mutableCopy];
    _dataDic = [@{} mutableCopy];
}

- (void)RequestMethod{
    
    [BaseRequest GET:ApplyFollowGetCompany_URL parameters:@{@"company_id":_applyFocusId} success:^(id resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            _dataDic = [NSMutableDictionary dictionaryWithDictionary:resposeObject[@"data"]];
            [_companyImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,_dataDic[@"logo"]]] placeholderImage:[UIImage imageNamed:@"default_3"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
               
                if (error) {
                    
                    _companyImg.image = [UIImage imageNamed:@"default_3"];
                }
            }];
            _isApplyFollow = resposeObject[@"data"][@"is_apply_follow"];
            if ([_isApplyFollow integerValue] == 1) {
                
                [self.rightBtn setTitle:@"已关注" forState:UIControlStateNormal];
            }else{
                
                [self.rightBtn setTitle:@"关注" forState:UIControlStateNormal];
            }
            _titlearr = [NSMutableArray arrayWithArray:_dataDic[@"count"]];
            _fansL.text = [NSString stringWithFormat:@"%@",_dataDic[@"follow_number"]];
            _commentL.text = [NSString stringWithFormat:@"%@",_dataDic[@"comment_number"]];
            _praiseL.text = [NSString stringWithFormat:@"%@",_dataDic[@"praise_number"]];
            _forwardL.text = [NSString stringWithFormat:@"%@",_dataDic[@"forward_number"]];
            _identityL.text = [NSString stringWithFormat:@"认证：%@",_dataDic[@"name"]];
            _introL.text = [NSString stringWithFormat:@"简介：%@",_dataDic[@"desc"]];
            [self reloadData];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [self showContent:@"网络错误"];
    }];
}

- (void)ActionAttentBtn:(UIButton *)btn{
    
    if (![_isApplyFollow integerValue]) {
        
        [BaseRequest POST:ApplyFollow_URL parameters:@{@"apply_id":_applyId} success:^(id resposeObject) {
            
            if ([resposeObject[@"code"] integerValue] == 200) {
                
                [self showContent:@"关注成功"];
                _isApplyFollow = @"1";
                [self RequestMethod];
                [self.rightBtn setTitle:@"已关注" forState:UIControlStateNormal];
            }else{
                
                [self showContent:resposeObject[@"msg"]];
            }
        } failure:^(NSError *error) {
            
            [self showContent:@"网络错误"];
            
        }];
    }else{
        
        [BaseRequest POST:ApplyFollowCancel_URL parameters:@{@"apply_id":_applyId} success:^(id resposeObject) {
            
            if ([resposeObject[@"code"] integerValue] == 200) {
                
                [self showContent:@"取关成功"];
                _isApplyFollow = @"0";
                [self RequestMethod];
                [self.rightBtn setTitle:@"关注" forState:UIControlStateNormal];
            }else{
                
                [self showContent:resposeObject[@"msg"]];
            }
        } failure:^(NSError *error) {
            
            [self showContent:@"网络错误"];
            
        }];
    }
}

- (void)initUI{
    
    self.delegate = self;
    self.dataSource = self;
    self.automaticallyCalculatesItemWidths = YES;
    self.itemMargin = 10;
    self.titleColorSelected = [UIColor colorWithRed:27.0/255.0 green:155.0/255.0 blue:255.0/255.0 alpha:1];
    self.menuView.backgroundColor   = [UIColor colorWithRed:244.0/255.0 green:244.0/255.0 blue:244.0/255.0 alpha:1.0];
    
    //    self.menuViewContentMargin = 20*SIZE;
    [self reloadData];
    
    self.navBackgroundView.hidden = NO;
//    self.line.hidden = YES;
    
    self.titleLabel.text = _titleStr;
    self.rightBtn.hidden = NO;
    self.rightBtn.center = CGPointMake(SCREEN_Width - 35 * SIZE, STATUS_BAR_HEIGHT+20);
    self.rightBtn.bounds = CGRectMake(0, 0, 60 * SIZE, 33 * SIZE);
    self.rightBtn.titleLabel.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.rightBtn addTarget:self action:@selector(ActionAttentBtn:) forControlEvents:UIControlEventTouchUpInside];
//    [self.rightBtn setTitle:@"已关注" forState:UIControlStateNormal];
    self.rightBtn.layer.cornerRadius = 5 *SIZE;
    self.rightBtn.clipsToBounds = YES;
    [self.rightBtn setBackgroundColor:YJBlueBtnColor];
//    self.rightBtn setTitle:@"" forState:<#(UIControlState)#>
    
    _companyImg = [[UIImageView alloc] initWithFrame:CGRectMake(10 *SIZE, 10 *SIZE + NAVIGATION_BAR_HEIGHT, 70 *SIZE, 70 *SIZE)];
    _companyImg.contentMode = UIViewContentModeScaleAspectFill;
    _companyImg.clipsToBounds = YES;
    _companyImg.layer.masksToBounds = YES;
    _companyImg.layer.cornerRadius = 35*SIZE;
    _companyImg.image = [UIImage imageNamed:@"default_3"];
    [self.view addSubview:_companyImg];
    
    _fansL = [[UILabel alloc] initWithFrame:CGRectMake(100 *SIZE, 14 *SIZE + NAVIGATION_BAR_HEIGHT, 60 *SIZE, 20 *SIZE)];
    _fansL.textColor = YJTitleLabColor;
    _fansL.font = [UIFont systemFontOfSize:13 *SIZE];
    _fansL.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_fansL];
    
    _fansTL = [[UILabel alloc] initWithFrame:CGRectMake(100 *SIZE, 40 *SIZE + NAVIGATION_BAR_HEIGHT, 60 *SIZE, 20 *SIZE)];
    _fansTL.textColor = YJ86Color;
    _fansTL.text = @"粉丝";
    _fansTL.font = [UIFont systemFontOfSize:12 *SIZE];
    _fansTL.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_fansTL];
    
    _commentL = [[UILabel alloc] initWithFrame:CGRectMake(160 *SIZE, 14 *SIZE + NAVIGATION_BAR_HEIGHT, 60 *SIZE, 20 *SIZE)];
    _commentL.textColor = YJTitleLabColor;
    _commentL.font = [UIFont systemFontOfSize:13 *SIZE];
    _commentL.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_commentL];
    
    _commentTL = [[UILabel alloc] initWithFrame:CGRectMake(160 *SIZE, 40 *SIZE + NAVIGATION_BAR_HEIGHT, 60 *SIZE, 20 *SIZE)];
    _commentTL.textColor = YJ86Color;
    _commentTL.text = @"评论";
    _commentTL.font = [UIFont systemFontOfSize:12 *SIZE];
    _commentTL.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_commentTL];
    
    _praiseL = [[UILabel alloc] initWithFrame:CGRectMake(220 *SIZE, 14 *SIZE + NAVIGATION_BAR_HEIGHT, 60 *SIZE, 20 *SIZE)];
    _praiseL.textColor = YJTitleLabColor;
    _praiseL.font = [UIFont systemFontOfSize:13 *SIZE];
    _praiseL.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_praiseL];
    
    _praiseTL = [[UILabel alloc] initWithFrame:CGRectMake(220 *SIZE, 40 *SIZE + NAVIGATION_BAR_HEIGHT, 60 *SIZE, 20 *SIZE)];
    _praiseTL.textColor = YJ86Color;
    _praiseTL.text = @"点赞";
    _praiseTL.font = [UIFont systemFontOfSize:12 *SIZE];
    _praiseTL.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_praiseTL];
    
    _forwardL = [[UILabel alloc] initWithFrame:CGRectMake(280 *SIZE, 14 *SIZE + NAVIGATION_BAR_HEIGHT, 60 *SIZE, 20 *SIZE)];
    _forwardL.textColor = YJTitleLabColor;
    _forwardL.font = [UIFont systemFontOfSize:13 *SIZE];
    _forwardL.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_forwardL];
    
    _forwardTL = [[UILabel alloc] initWithFrame:CGRectMake(280 *SIZE, 40 *SIZE + NAVIGATION_BAR_HEIGHT, 60 *SIZE, 20 *SIZE)];
    _forwardTL.textColor = YJ86Color;
    _forwardTL.text = @"转发";
    _forwardTL.font = [UIFont systemFontOfSize:12 *SIZE];
    _forwardTL.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_forwardTL];
    
    _identityL = [[UILabel alloc] init];//WithFrame:CGRectMake(100 *SIZE, 14 *SIZE, 60 *SIZE, 20 *SIZE)];
    _identityL.textColor = YJTitleLabColor;
    _identityL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.view addSubview:_identityL];
    
    _introL = [[UILabel alloc] init];//WithFrame:CGRectMake(100 *SIZE, 14 *SIZE, 60 *SIZE, 20 *SIZE)];
    _introL.textColor = YJTitleLabColor;
    _introL.font = [UIFont systemFontOfSize:13 *SIZE];
    _introL.numberOfLines = 0;
//    _fansL.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_introL];
    
    [_identityL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.view).offset(100 *SIZE);
        make.top.equalTo(self.view).offset(70 *SIZE + NAVIGATION_BAR_HEIGHT);
        make.right.equalTo(self.view).offset(-10 *SIZE);
    }];
    
    [_introL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.view).offset(100 *SIZE);
        make.top.equalTo(_identityL.mas_bottom).offset(10 *SIZE);
        make.right.equalTo(self.view).offset(-10 *SIZE);
    }];
}

- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    
    if (_titlearr.count == 0) {
        
        return 0;
    }else{
        
        return _titlearr.count;
    }
    
}

- (void)pageController:(WMPageController *)pageController willEnterViewController:(__kindof UIViewController *)viewController withInfo:(NSDictionary *)info{
    
    if ([viewController isKindOfClass:[RecommendMoreInfoChildVC class]]) {
        NSLog(@"%@",viewController);
//        if ([((RoomChildVC *)viewController).city isEqualToString:_city]) {
//
//
//        }else{
//
//            ((RoomChildVC *)viewController).city = _city;
//
//            [(RoomChildVC *) viewController RequestMethod];
//        }
    }
    else{
        
        
    }
}


- (__kindof UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    
    
//    NSString *tempStr = _titlearr[index][@"title"];
//    NSDictionary *dic;
    RecommendMoreInfoChildVC *vc;
    vc = [[RecommendMoreInfoChildVC alloc] initWithType:[_titlearr[index][@"recommend_type"] integerValue] companyId:_dataDic[@"company_id"]];
    vc.recommendMoreInfoChildVCBlock = ^(NSDictionary * _Nonnull dataDic) {
        
        RecommendNewInfoVC *vc = [[RecommendNewInfoVC alloc] initWithUrlStr:dataDic[@"content_url"] titleStr:dataDic[@"nick_name"] imageUrl:dataDic[@"img_url"] briefStr:dataDic[@"desc"] recommendId:dataDic[@"recommend_id"]];
        [self.navigationController pushViewController:vc animated:YES];
    };
    return vc;
    
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    
    return [NSString stringWithFormat:@"%@(%@)",_titlearr[index][@"title"],_titlearr[index][@"count"]];
}


#pragma mark - WMPageControllerDataSource

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    
    return CGRectMake(0, NAVIGATION_BAR_HEIGHT + 100 *SIZE + 20 *SIZE, 360*SIZE, 40*SIZE);
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    
    return CGRectMake(0, NAVIGATION_BAR_HEIGHT + 100 *SIZE + 60 *SIZE, 360*SIZE, SCREEN_Height - NAVIGATION_BAR_HEIGHT - 60*SIZE - 100 *SIZE);
    
}

@end
