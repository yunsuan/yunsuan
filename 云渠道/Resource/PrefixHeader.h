//
//  PrefixHeader.h
//  易家
//
//  Created by xiaoq on 2017/11/8.
//  Copyright © 2017年 xiaoq. All rights reserved.
//

#ifndef PrefixHeader_pch
#define PrefixHeader_pch
#import <Availability.h>

#ifdef __OBJC__
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#endif

#import "MJRefresh.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Radar/BMKRadarOption.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import <BaiduMapAPI_Base/BMKMapManager.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import "NetConfig.h"
//#import <BaiduMapAPI_Map/BMKMapView.h>

#import <UITableView+FDTemplateLayoutCell.h>
#import <Masonry.h>
#import "UIImageView+WebCache.h"
#import "MBProgressHUD.h"
#import "UserModel.h"
#import "UserInfoModel.h"
#import "UserModelArchiver.h"
#import "BaseRequest.h"
#import "GZQGifHeader.h"
#import "GZQGifFooter.h"
#import "WaitAnimation.h"
#import <UMShare/UMShare.h>
#import "TransmitView.h"



#ifndef deviceVersion
//#define deviceVersion [[[UIDevice currentDevice] systemVersion] floatValue]
#endif
#define sIZE [UIScreen mainScreen].bounds.size.width/360
#define screenWidth [UIScreen mainScreen].bounds.size.width
#define SCREEN_Width [UIScreen mainScreen].bounds.size.width
#define SCREEN_Height [UIScreen mainScreen].bounds.size.height
#define IMAGE_WITH_NAME(x) [UIImage imageNamed:[NSString stringWithFormat:@"%@",x]]



#define JpushAppKey @"9c68e106ec6a106956e5d700"
#define YQDversion @"1.0"
#define ACCESSROLE @"agent"

//判断是否是ipad
#define isPad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
//判断iPhoneX
#define IS_IPHONE_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPHoneXr
#define IS_IPHONE_Xr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhoneXs
#define IS_IPHONE_Xs ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1624), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhoneXs Max
#define IS_IPHONE_Xs_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)

// 状态栏高度
#define STATUS_BAR_HEIGHT ((IS_IPHONE_X==YES || IS_IPHONE_Xr ==YES || IS_IPHONE_Xs== YES || IS_IPHONE_Xs_Max== YES) ? 44.0 : 20.0)
// 导航栏高度
#define NAVIGATION_BAR_HEIGHT ((IS_IPHONE_X==YES || IS_IPHONE_Xr ==YES || IS_IPHONE_Xs== YES || IS_IPHONE_Xs_Max== YES) ? 88.0 : 64.0)
// tabBar高度
#define TAB_BAR_HEIGHT ((IS_IPHONE_X==YES || IS_IPHONE_Xr ==YES || IS_IPHONE_Xs== YES || IS_IPHONE_Xs_Max== YES) ? 83.0 : 49.0)
#define TAB_BAR_MORE ((IS_IPHONE_X==YES || IS_IPHONE_Xr ==YES || IS_IPHONE_Xs== YES || IS_IPHONE_Xs_Max== YES) ? 34.0 : 0)
// home indicator
//#define HOME_INDICATOR_HEIGHT (iPhoneX ? 34.f : 0.f)

#define LOGINENTIFIER @"logIndentifier"
#define LOGINSUCCESS @"logInSuccessdentifier"
//#define HUANPASSWORD @"1111"

#define UmengAppkey @"5ac9debcb27b0a2147000050"
#define QQAPPID @"1106811849"
//#define QQAppkey @"Yik2oC5WcDQ5IOrpc"
#define WechatAppId @"wx3e34d92e8b8cb53e"
#define WechatSecret @"200ee15186843d67c0d9ba6a66f3a6ba"
#define redirectUrl @"http://www.ccsoft.com.cn/"
//百度sdk
#define BaiduKey @"h7fphBWBFsYPImk01SmFvMr5k4ELf7ae"




#define TABBAR_Height [[UIScreen mainScreen] bounds].size.width * 30/320.0

#define COLOR(_R,_G,_B,_A) [UIColor colorWithRed:_R / 255.0f green: _G / 255.0f blue:_B / 255.0f alpha:_A]


#define YJBackColor  COLOR(240, 240, 240, 1)
#define YJTitleLabColor  COLOR(51, 51, 51, 1)
#define YJContentLabColor  COLOR(115, 115, 115, 1)
#define YJ86Color   COLOR(86, 86, 86, 1)
#define YJ170Color   COLOR(170, 170, 170, 1)

#define YJLoginBtnColor   COLOR(0x1b, 0x80, 0xfe, 1)
#define YJBlueBtnColor   COLOR(27, 152, 255, 1)
#define YJRedColor   COLOR(255, 70, 70, 1)


#define CH_COLOR_white [UIColor whiteColor]

/**
 *  第二部分,关于屏幕尺寸
 */
#define SIZE [UIScreen mainScreen].bounds.size.width/360

/**
 *新增
 */

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
#define SS(strongSelf)  __strong __typeof(&*self)strongSelf = self;

#endif /* Header_h */
