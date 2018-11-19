//
//  ReportVew2.h
//  云渠道
//
//  Created by 谷治墙 on 2018/6/12.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DropDownBtn.h"

@class ReportVew2;

typedef void(^ReportTimeBlock)(void);

@interface ReportVew2 : UIView

@property (nonatomic, copy) ReportTimeBlock reportTimeBlock;

@property (nonatomic, strong) UIButton *otherBtn;

@property (nonatomic, strong) UIButton *selfBtn;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) DropDownBtn *timeBtn;

@end
