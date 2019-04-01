
//
//  RecommendMoreInfoVC.m
//  云渠道
//
//  Created by 谷治墙 on 2019/3/29.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "RecommendMoreInfoVC.h"

#import "RecommendNewInfoVC.h"

@interface RecommendMoreInfoVC ()<WMPageControllerDataSource,WMPageControllerDelegate>
{
    
    NSMutableArray *_titlearr;
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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ActionGoto:) name:@"goto" object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ReloadType) name:@"reloadType" object:nil];
    
//    _titlearr = [UserModel defaultModel].tagSelectArr;
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
    
    self.titleLabel.text = @"";
    self.rightBtn.hidden = NO;
//    self.rightBtn setTitle:@"" forState:<#(UIControlState)#>
    
    _companyImg = [[UIImageView alloc] initWithFrame:CGRectMake(10 *SIZE, 10 *SIZE, 67 *SIZE, 67 *SIZE)];
    _companyImg.contentMode = UIViewContentModeScaleAspectFill;
    _companyImg.clipsToBounds = YES;
    [self.view addSubview:_companyImg];
    
    _fansL = [[UILabel alloc] initWithFrame:CGRectMake(100 *SIZE, 14 *SIZE, 60 *SIZE, 20 *SIZE)];
    _fansL.textColor = YJTitleLabColor;
    _fansL.font = [UIFont systemFontOfSize:13 *SIZE];
    _fansL.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_fansL];
    
    _fansTL = [[UILabel alloc] initWithFrame:CGRectMake(100 *SIZE, 40 *SIZE, 60 *SIZE, 20 *SIZE)];
    _fansTL.textColor = YJ86Color;
    _fansTL.text = @"粉丝";
    _fansTL.font = [UIFont systemFontOfSize:12 *SIZE];
    _fansTL.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_fansTL];
    
    _commentL = [[UILabel alloc] initWithFrame:CGRectMake(160 *SIZE, 14 *SIZE, 60 *SIZE, 20 *SIZE)];
    _commentL.textColor = YJTitleLabColor;
    _commentL.font = [UIFont systemFontOfSize:13 *SIZE];
    _commentL.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_commentL];
    
    _commentTL = [[UILabel alloc] initWithFrame:CGRectMake(160 *SIZE, 40 *SIZE, 60 *SIZE, 20 *SIZE)];
    _commentTL.textColor = YJ86Color;
    _commentTL.text = @"评论";
    _commentTL.font = [UIFont systemFontOfSize:12 *SIZE];
    _commentTL.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_commentTL];
    
    _praiseL = [[UILabel alloc] initWithFrame:CGRectMake(220 *SIZE, 14 *SIZE, 60 *SIZE, 20 *SIZE)];
    _praiseL.textColor = YJTitleLabColor;
    _praiseL.font = [UIFont systemFontOfSize:13 *SIZE];
    _praiseL.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_praiseL];
    
    _praiseTL = [[UILabel alloc] initWithFrame:CGRectMake(220 *SIZE, 40 *SIZE, 60 *SIZE, 20 *SIZE)];
    _praiseTL.textColor = YJ86Color;
    _praiseTL.text = @"点赞";
    _praiseTL.font = [UIFont systemFontOfSize:12 *SIZE];
    _praiseTL.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_praiseTL];
    
    _forwardL = [[UILabel alloc] initWithFrame:CGRectMake(280 *SIZE, 14 *SIZE, 60 *SIZE, 20 *SIZE)];
    _forwardL.textColor = YJTitleLabColor;
    _forwardL.font = [UIFont systemFontOfSize:13 *SIZE];
    _forwardL.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_forwardL];
    
    _forwardTL = [[UILabel alloc] initWithFrame:CGRectMake(280 *SIZE, 40 *SIZE, 60 *SIZE, 20 *SIZE)];
    _forwardTL.textColor = YJ86Color;
    _forwardTL.text = @"转发";
    _forwardTL.font = [UIFont systemFontOfSize:12 *SIZE];
    _forwardTL.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_forwardTL];
    
    _identityL = [[UILabel alloc] init];//WithFrame:CGRectMake(100 *SIZE, 14 *SIZE, 60 *SIZE, 20 *SIZE)];
    _identityL.textColor = YJTitleLabColor;
    _identityL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.view addSubview:_fansL];
    
    _introL = [[UILabel alloc] init];//WithFrame:CGRectMake(100 *SIZE, 14 *SIZE, 60 *SIZE, 20 *SIZE)];
    _introL.textColor = YJTitleLabColor;
    _introL.font = [UIFont systemFontOfSize:13 *SIZE];
    _introL.numberOfLines = 0;
//    _fansL.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_introL];
    
    [_identityL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.view).offset(100 *SIZE);
        make.top.equalTo(self.view).offset(70 *SIZE);
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
    }
    else{
        return _titlearr.count;
    }
    
}

- (void)pageController:(WMPageController *)pageController willEnterViewController:(__kindof UIViewController *)viewController withInfo:(NSDictionary *)info{
    
    if ([viewController isKindOfClass:[RecommendNewInfoVC class]]) {
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
    
    
    NSString *tempStr = _titlearr[index];
    NSDictionary *dic;
    dic = [UserModel defaultModel].tagDic[tempStr];
    RecommendNewInfoVC *vc;
    vc = [[RecommendNewInfoVC alloc] init];
    
    return vc;
    
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    
    return _titlearr[index];
}


#pragma mark - WMPageControllerDataSource

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    
    return CGRectMake(0, NAVIGATION_BAR_HEIGHT + CGRectGetMaxY(_introL.frame) + 20 *SIZE, 320*SIZE, 40*SIZE);
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    
    return CGRectMake(0, NAVIGATION_BAR_HEIGHT + CGRectGetMaxY(_introL.frame) + 60 *SIZE, 360*SIZE, SCREEN_Height-NAVIGATION_BAR_HEIGHT-60*SIZE);
    
}

@end
