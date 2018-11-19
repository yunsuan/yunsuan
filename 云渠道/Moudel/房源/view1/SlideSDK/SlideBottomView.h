//
//  SlideBottomView.h
//  SlideDemo
//
//  Created by 钟兴文 on 2017/5/16.
//  Copyright © 2017年 钟兴文. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoomChildVC.h"
#import "SecdaryAllTableModel.h"
#import "RoomListModel.h"
//#import "SlideBaseViewController.h"

@protocol SlideViewDelegate <NSObject>

/**
 已经获得焦点，滑入视图

 @param viewController viewcontroller
 @param index 所在位置
 */
-(void)slideViewWillAppearWithController:(RoomChildVC *)viewController withIndex:(NSInteger)index;

/**
 已经失去焦点，滑出视图

 @param viewController viewcontroller
 @param index 所在位置
 */
-(void)slideViewWillDisappearWithController:(RoomChildVC*)viewController withIndex:(NSInteger)index;

/**
 点击已经选中的焦点，用于刷新数据

 @param viewController viewcontroller
 @param index 所在位置
 */
-(void)clickSelectedController:(RoomChildVC*)viewController withIndex:(NSInteger)index;


@end

@interface SlideBottomView : UIView

@property (nonatomic,weak) id<SlideViewDelegate> delegate;//代理

//初始化方法
-(instancetype)initWithFrame:(CGRect)frame WithTitleArray:(NSArray*)titleArray WithControllerArray:(NSArray*)ctlArray;

@end
