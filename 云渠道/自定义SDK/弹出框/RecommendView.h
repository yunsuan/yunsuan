//
//  RecommendView.h
//  云渠道
//
//  Created by 谷治墙 on 2018/4/10.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RecommendView;

typedef void(^tranmitBtnBlock)(void);

typedef void(^RecommendViewConfirmBlock)(void);

@interface RecommendView : UIView

@property (nonatomic, copy) tranmitBtnBlock tranmitBtnBlock;

@property (nonatomic, copy) RecommendViewConfirmBlock recommendViewConfirmBlock;

@property (nonatomic, strong) UIView *whiteView;

@property (nonatomic, strong) UILabel *codeL;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UILabel *projectL;

@property (nonatomic, strong) UILabel *addressL;

//@property (nonatomic, strong) UILabel *contactL;
//
//@property (nonatomic, strong) UILabel *phoneL;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UIButton *tranmitBtn;

@property (nonatomic, strong) UIButton *confirmBtn;

@end
