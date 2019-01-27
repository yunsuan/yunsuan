//
//  SHRecommenView.h
//  云渠道
//
//  Created by xiaoq on 2019/1/27.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BorderTF.h"
#import "DropDownBtn.h"

NS_ASSUME_NONNULL_BEGIN


@class SHRecommenView;

//typedef void(^tranmitBtnBlock)(void);

typedef void(^RecommendViewConfirmBlock)(void);

@interface SHRecommenView : UIView

//@property (nonatomic, copy) tranmitBtnBlock tranmitBtnBlock;

@property (nonatomic, copy) RecommendViewConfirmBlock recommendViewConfirmBlock;

@property (nonatomic, strong) UIView *whiteView;
//

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UILabel *phoneL;

@property (nonatomic, strong) UILabel *sexL;

@property (nonatomic, strong) UILabel *markL;

//
@property (nonatomic, strong) BorderTF *nameTF;
@property (nonatomic, strong) BorderTF *phoneTF;
@property (nonatomic , strong) DropDownBtn *sexBtn;
@property (nonatomic , strong) UITextView *markTV;




@property (nonatomic, strong) UIButton *tranmitBtn;

@property (nonatomic, strong) UIButton *confirmBtn;







//




@end





NS_ASSUME_NONNULL_END
