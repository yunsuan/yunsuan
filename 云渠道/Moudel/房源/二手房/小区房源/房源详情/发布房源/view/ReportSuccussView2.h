//
//  ReportSuccussView2.h
//  云渠道
//
//  Created by 谷治墙 on 2018/9/4.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ReportSuccussView2BackBlock)(void);

@interface ReportSuccussView2 : UIView

@property (nonatomic, copy) ReportSuccussView2BackBlock reportSuccussView2BackBlock;

@property (nonatomic, strong) UIView *whiteView;

@property (nonatomic, strong) UILabel *comName;

@property (nonatomic, strong) UILabel *houseL;

@property (nonatomic, strong) UILabel *contactL;

@property (nonatomic, strong) UILabel *phoneL;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UIButton *backBtn;

@end
