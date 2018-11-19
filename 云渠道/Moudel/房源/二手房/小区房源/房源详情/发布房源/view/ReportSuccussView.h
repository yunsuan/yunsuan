//
//  ReportSuccussView.h
//  云渠道
//
//  Created by 谷治墙 on 2018/9/4.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ReportSuccussViewBackBlock)(void);

typedef void(^ReportSuccussViewconfirmBlock)(void);

@interface ReportSuccussView : UIView

@property (nonatomic, copy) ReportSuccussViewBackBlock reportSuccussViewBackBlock;

@property (nonatomic, copy) ReportSuccussViewconfirmBlock reportSuccussViewconfirmBlock;

@property (nonatomic, strong) UIView *whiteView;

@property (nonatomic, strong) UILabel *comName;

@property (nonatomic, strong) UILabel *houseL;

@property (nonatomic, strong) UILabel *contactL;

@property (nonatomic, strong) UILabel *phoneL;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UIButton *backBtn;

@property (nonatomic, strong) UIButton *confirmBtn;

@end
