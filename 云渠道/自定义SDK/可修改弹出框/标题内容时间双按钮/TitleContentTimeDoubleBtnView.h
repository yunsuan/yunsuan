//
//  TitleContentTimeDoubleBtnView.h
//  云渠道
//
//  Created by 谷治墙 on 2018/6/20.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TitleContentTimeDoubleBtnView;

typedef void(^TitleContentTimeBtnCancelBlock)(void);

typedef void(^TitleContentTimeBtnConfirmBlock)(void);

@interface TitleContentTimeDoubleBtnView : UIView

@property (nonatomic, copy) TitleContentTimeBtnCancelBlock titleContentTimeBtnCancelBlock;

@property (nonatomic, copy) TitleContentTimeBtnConfirmBlock titleContentTimeBtnConfirmBlock;

@property (nonatomic, strong) UIView *whiteView;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UILabel *contentL;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UIButton *cancelBtn;

@property (nonatomic, strong) UIButton *confirmBtn;

@end
