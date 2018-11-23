//
//  CountDownCell2.h
//  云渠道
//
//  Created by 谷治墙 on 2018/7/18.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CountDownCell2;

typedef void(^countdown2)(void);

typedef void(^CountDownMoreBlock)(void);

@interface CountDownCell2 : UITableViewCell

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UIButton *moreBtn;

@property (nonatomic , strong) countdown2 countdown2block;

@property (nonatomic , copy) CountDownMoreBlock countDownMoreBlock;

//-(void)setcountdownbyday:(NSInteger )day
//                   hours:(NSInteger )hours
//                     min:(NSInteger )min
//                     sec:(NSInteger )sec;

-(void)setcountdownbyendtime:(NSString *)endtime;
@end
