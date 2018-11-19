//
//  CountDownCell.h
//  云渠道
//
//  Created by xiaoq on 2018/3/27.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>


@class CountDownCell;

typedef void(^countdown)(void);


@interface CountDownCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic , strong) countdown countdownblock;

-(void)setcountdownbyday:(NSInteger )day
                   hours:(NSInteger )hours
                     min:(NSInteger )min
                     sec:(NSInteger )sec;

-(void)setcountdownbyendtime:(NSString *)endtime;


@end
