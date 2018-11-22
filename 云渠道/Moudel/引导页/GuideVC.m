
//
//  GuideVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/10.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "GuideVC.h"

@interface GuideVC ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) UIButton *inBtn;

@end

@implementation GuideVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
 
    [self initUI];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    // 设置页码
    _pageControl.currentPage = page;
    
    if (page == 3) {
        
        [UIView animateWithDuration:1.5 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            
            _inBtn.hidden = NO;
        } completion:^(BOOL finished) {
            
        }];
    }else{
        
        [UIView animateWithDuration:1.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            
            _inBtn.hidden = YES;
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (void)ActionInBtn:(UIButton *)btn{
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"goLoginVC" object:nil];
}


- (void)initUI{
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    _scrollView.delegate = self;
    _scrollView.showsVerticalScrollIndicator= NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    [_scrollView setContentSize:CGSizeMake(SCREEN_Width * 4, SCREEN_Height)];
    [self.view addSubview:_scrollView];
    
    NSArray *imgArr = @[@"guidepage_1@3x",@"guidepage_2@3x",@"guidepage_3@3x",@"guidepage_4@3x"];
    for (int i = 0; i < 4; i++) {
        
        UIImageView *guideImg = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_Width * i, 0, SCREEN_Width, SCREEN_Height)];

        NSString *path = [[NSBundle mainBundle] pathForResource:imgArr[i] ofType:@"png"];
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        guideImg.image = image;
        guideImg.contentMode = UIViewContentModeScaleAspectFill;
        [_scrollView addSubview:guideImg];
    }
    
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.frame = CGRectMake(140 *SIZE, SCREEN_Height - 24 *SIZE - TAB_BAR_MORE, 80 *SIZE, 10 *SIZE);//指定位置大小
    _pageControl.numberOfPages = 4;//指定页面个数
    _pageControl.currentPage = 0;//指定pagecontroll的值，默认选中的小白点（第一个）
    //添加委托方法，当点击小白点就执行此方法
    
    _pageControl.pageIndicatorTintColor = COLOR(220, 220, 220, 1);// 设置非选中页的圆点颜色
    
    _pageControl.currentPageIndicatorTintColor = YJBlueBtnColor; // 设置选中页的圆点颜色
    [self.view addSubview:_pageControl];
    
    _inBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _inBtn.frame = CGRectMake(120 *SIZE, SCREEN_Height - 47 *SIZE - TAB_BAR_MORE, 120 *SIZE, 33 *SIZE);
    _inBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    _inBtn.layer.cornerRadius = 5 *SIZE;
    _inBtn.clipsToBounds = YES;
    [_inBtn addTarget:self action:@selector(ActionInBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_inBtn setTitle:@"开启渠道" forState:UIControlStateNormal];
    [_inBtn setBackgroundColor:YJBlueBtnColor];
    _inBtn.hidden = YES;
    [_inBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:_inBtn];
}

@end
