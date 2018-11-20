//
//  ReportCustomSuccessView.h
//  云渠道
//
//  Created by 谷治墙 on 2018/9/7.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DashesLineView.h"

typedef void(^ReportCustomSuccessViewBlock)(void);

@interface ReportCustomSuccessView : UIView

@property (nonatomic, copy) ReportCustomSuccessViewBlock reportCustomSuccessViewBlock;

@property (nonatomic, assign) NSInteger state;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@property (nonatomic, strong) DashesLineView *lineView;

@property (nonatomic, strong) UIImageView *backImg1;

@property (nonatomic, strong) UIImageView *backImg2;

@property (nonatomic, strong) UIView *whiteView;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UILabel *projectL;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UIImageView *sexImg;

@property (nonatomic, strong) UILabel *phoneL;

@property (nonatomic, strong) UILabel *phone1;

@property (nonatomic, strong) UILabel *phone2;

@property (nonatomic, strong) UILabel *phone3;

@property (nonatomic, strong) UILabel *phone4;

@property (nonatomic, strong) UILabel *phone5;

@property (nonatomic, strong) UILabel *phone6;

@property (nonatomic, strong) UILabel *phone7;

@property (nonatomic, strong) UILabel *phone8;

@property (nonatomic, strong) UILabel *phone9;

@property (nonatomic, strong) UILabel *phone10;

@property (nonatomic, strong) UILabel *phone11;

@property (nonatomic, strong) UILabel *hideL;

@property (nonatomic, strong) UIImageView *hideReportImg;

@property (nonatomic, strong) UILabel *hideReportL;

@property (nonatomic, strong) UIButton *cancenBtn;

@end
