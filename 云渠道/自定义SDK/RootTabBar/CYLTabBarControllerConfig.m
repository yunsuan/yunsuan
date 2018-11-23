//
//  CYLTabBarControllerConfig.m
//  猪认养
//
//  Created by 赖星果 on 16/5/16.
//  Copyright © 2016年 赖星果. All rights reserved.
//

#import "CYLTabBarControllerConfig.h"

@import Foundation;
@import UIKit;
@interface CYLBaseNavigationController : UINavigationController

@end
@implementation CYLBaseNavigationController

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}


@end

#import "MessageVC.h"
#import "MineVC.h"
#import "WorkingVC.h"
#import "RoomVC.h"
//#import "RoomVC2.h"
#import "CustomerVC.h"

@interface CYLTabBarControllerConfig ()

@property (nonatomic, readwrite, strong)CYLTabBarController *tabBarController;

@end

@implementation CYLTabBarControllerConfig

/**
 *  lazy load tabBarController
 *
 *  @return CYLTabBarController
 */
- (CYLTabBarController *)tabBarController {
    if (_tabBarController == nil) {
        CYLTabBarController *tabBarController = [CYLTabBarController tabBarControllerWithViewControllers:self.viewControllers
                                                                                   tabBarItemsAttributes:self.tabBarItemsAttributesForController];
        //[_tabBarController.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -10)];
        [self customizeTabBarAppearance];
        _tabBarController = tabBarController;
    
    }
    return _tabBarController;
}

- (NSArray *)viewControllers {
    MessageVC *message_vc = [[MessageVC alloc] init];
    UIViewController *message_nav = [[CYLBaseNavigationController alloc] initWithRootViewController:message_vc];
    message_vc.navigationController.navigationBar.hidden = YES;
    //调整文字位置
    message_nav.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -4);
    
    
    RoomVC *room_vc = [[RoomVC alloc] init];
    UIViewController *room_nav = [[CYLBaseNavigationController alloc]
                                  initWithRootViewController:room_vc];
    room_vc.navigationController.navigationBar.hidden = YES;
    room_nav.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -4);
//    RoomVC1 *room_vc = [[RoomVC1 alloc] init];
//    UIViewController *room_nav = [[CYLBaseNavigationController alloc]
//                                     initWithRootViewController:room_vc];
//    room_vc.navigationController.navigationBar.hidden = YES;
//    room_nav.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -4);
    
    CustomerVC *customer_vc = [[CustomerVC alloc] init];
    UIViewController *customer_nav = [[CYLBaseNavigationController alloc]
                                          initWithRootViewController:customer_vc];
    customer_vc.navigationController.navigationBar.hidden = YES;
    customer_nav.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -4);

    
    WorkingVC *working_vc  =[[WorkingVC alloc]init];
    UIViewController *working_nav = [[CYLBaseNavigationController alloc]initWithRootViewController:working_vc];
    working_vc.navigationController.navigationBar.hidden = YES;
    working_nav.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -4);
   
    
    MineVC *mine_vc = [[MineVC alloc] init];
    UIViewController *mine_nav = [[CYLBaseNavigationController alloc]
                                  initWithRootViewController:mine_vc];
    mine_vc.navigationController.navigationBar.hidden = YES;
    mine_nav.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -4);

    /**
     * 以下两行代码目的在于手动设置让TabBarItem只显示图标，不显示文字，并让图标垂直居中。
     * 等效于在 `-tabBarItemsAttributesForController` 方法中不传 `CYLTabBarItemTitle` 字段。
     * 更推荐后一种做法。
     */
    //_tabBarController.imageInsets = UIEdgeInsetsMake(4.5, 0, -4.5, 0);
    //_tabBarController.titlePositionAdjustment = UIOffsetMake(0, MAXFLOAT);
    //[_tabBarController.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, MAXFLOAT)];
    
    NSArray *viewControllers = @[
                                 message_nav,
                                 room_nav,
                                 customer_nav,
                                 working_nav,
                                 mine_nav
                                 ];
    return viewControllers;
}

/**
 *  在`-setViewControllers:`之前设置TabBar的属性，设置TabBarItem的属性，包括 title、Image、selectedImage。
 */
- (NSArray *)tabBarItemsAttributesForController {
    
    NSDictionary *dict1 = @{
                            CYLTabBarItemTitle : @"消息",
                            CYLTabBarItemImage : @"message",
                            CYLTabBarItemSelectedImage : @"message_selected",
                            };
    NSDictionary *dict2 = @{
                            CYLTabBarItemTitle : @"房源",
                            CYLTabBarItemImage : @"housing",
                            CYLTabBarItemSelectedImage : @"housing_selected",
                            };
    NSDictionary *dict3 = @{
                            CYLTabBarItemTitle : @"客源",
                            CYLTabBarItemImage : @"customers",
                            CYLTabBarItemSelectedImage : @"customers_selected",
                            };
    NSDictionary *dict4 = @{
                            CYLTabBarItemTitle : @"工作",
                            CYLTabBarItemImage : @"work",
                            CYLTabBarItemSelectedImage : @"work_selected",
                            };
    NSDictionary *dict5 = @{
                            CYLTabBarItemTitle : @"我的",
                            CYLTabBarItemImage : @"me",
                            CYLTabBarItemSelectedImage : @"me_selected",
                            };

    NSArray *tabBarItemsAttributes;
    tabBarItemsAttributes = @[
                                       dict1,
                                       dict2,
                                       dict3,
                                       dict4,
                                       dict5
                                       ];
    return tabBarItemsAttributes;
}

/**
 *  更多TabBar自定义设置：比如：tabBarItem 的选中和不选中文字和背景图片属性、tabbar 背景图片属性等等
 */
- (void)customizeTabBarAppearance {
//warning CUSTOMIZE YOUR TABBAR APPEARANCE
    // Customize UITabBar height
    // 自定义 TabBar 高度
    //tabBarController.tabBarHeight = 40.f;
    
    // set the text color for unselected state
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = COLOR(68, 68, 68, 1);
    
    // set the text color for selected state
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = COLOR(39, 161, 217, 1);
    
    // set the text Attributes
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    // Set the dark color to selected tab (the dimmed background)
    // TabBarItem选中后的背景颜色
    [self customizeTabBarSelectionIndicatorImage];

    
    // update TabBar when TabBarItem width did update
    // If your app need support UIDeviceOrientationLandscapeLeft or UIDeviceOrientationLandscapeRight，
    // remove the comment '//'
    // 如果你的App需要支持横竖屏，请使用该方法移除注释 '//'
    // [self updateTabBarCustomizationWhenTabBarItemWidthDidUpdate];
    
    // set the bar shadow image
    // This shadow image attribute is ignored if the tab bar does not also have a custom background image.So at least set somthing.
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
    [[UITabBar appearance] setShadowImage:[UIImage imageNamed:@"tapbar_top_line"]];
    
    // set the bar background image
    // 设置背景图片
    // UITabBar *tabBarAppearance = [UITabBar appearance];
    // [tabBarAppearance setBackgroundImage:[UIImage imageNamed:@"tabbar_background"]];
    
    // remove the bar system shadow image
    // 去除 TabBar 自带的顶部阴影
    //[[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
}

- (void)updateTabBarCustomizationWhenTabBarItemWidthDidUpdate {
    void (^deviceOrientationDidChangeBlock)(NSNotification *) = ^(NSNotification *notification) {
        UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
        if ((orientation == UIDeviceOrientationLandscapeLeft) || (orientation == UIDeviceOrientationLandscapeRight)) {

        } else if (orientation == UIDeviceOrientationPortrait){

        }
        [self customizeTabBarSelectionIndicatorImage];
    };
    [[NSNotificationCenter defaultCenter] addObserverForName:CYLTabBarItemWidthDidChangeNotification
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:deviceOrientationDidChangeBlock];
}

- (void)customizeTabBarSelectionIndicatorImage {
    ///Get initialized TabBar Height if exists, otherwise get Default TabBar Height.
    UITabBarController *tabBarController = [self cyl_tabBarController] ?: (CYLTabBarController *) [[UITabBarController alloc] init];
    CGFloat tabBarHeight = tabBarController.tabBar.frame.size.height;
    CGSize selectionIndicatorImageSize = CGSizeMake(CYLTabBarItemWidth, tabBarHeight);
    //Get initialized TabBar if exists.
    UITabBar *tabBar = [self cyl_tabBarController].tabBar ?: [UITabBar appearance];
    [tabBar setSelectionIndicatorImage:
     [[self class] imageWithColor:[UIColor clearColor]
                             size:selectionIndicatorImageSize]];
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width + 1, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
