//
//  ReportView.h
//  云渠道
//
//  Created by 谷治墙 on 2018/6/12.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BorderTF.h"
#import "DropDownBtn.h"

@class ReportView;

typedef void(^ReportViewAddBlock)(void);

typedef void(^ReportViewSexBlock)(void);

typedef void(^ReportViewRelationshipBlock)(void);

typedef void(^ReportViewTypeBlock)(void);

typedef void(^ReportViewAddressBlock)(void);

@interface ReportView : UIView

@property (nonatomic, copy) ReportViewAddBlock reportViewAddBlock;

@property (nonatomic, copy) ReportViewSexBlock reportViewSexBlock;

@property (nonatomic, copy) ReportViewTypeBlock reportViewTypeBlock;

@property (nonatomic, copy) ReportViewAddressBlock reportViewAddressBlock;

@property (nonatomic, copy) ReportViewRelationshipBlock reportViewRelationshipBlock;

@property (nonatomic, assign) NSInteger num;

@property (nonatomic, strong) UILabel *comL;

@property (nonatomic, strong) UILabel *roomL;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) BorderTF *nameTF;

@property (nonatomic, strong) UILabel *sexL;

@property (nonatomic, strong) DropDownBtn *sexBtn;

@property (nonatomic, strong) UILabel *telL;

@property (nonatomic, strong) BorderTF *tel1;

@property (nonatomic, strong) UIButton *addBtn;

@property (nonatomic, strong) BorderTF *tel2;

@property (nonatomic, strong) BorderTF *tel3;

@property (nonatomic, strong) UILabel *typeL;

@property (nonatomic, strong) DropDownBtn *typeBtn;

@property (nonatomic, strong) UILabel *numL;

@property (nonatomic, strong) BorderTF *numTF;

@property (nonatomic, strong) UILabel *relationL;

@property (nonatomic, strong) DropDownBtn *relationBtn;

@property (nonatomic, strong) UILabel *addressL;

@property (nonatomic, strong) DropDownBtn *addressBtn;

@property (nonatomic, strong) UITextView *addressTV;

@end
