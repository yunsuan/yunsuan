//
//  AddAreaCustomView.h
//  云渠道
//
//  Created by 谷治墙 on 2019/12/2.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DropDownBtn.h"
#import "BorderTF.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^AddAreaCustomViewTagBlock)(NSInteger idx);

typedef void(^AddAreaCustomViewImgBlock)(NSInteger idx);

typedef void(^AddAreaCustomViewStrBlock)(NSString *str);

@interface AddAreaCustomView : UIView

@property (nonatomic, copy) AddAreaCustomViewTagBlock addAreaCustomViewTagBlock;

@property (nonatomic, copy) AddAreaCustomViewImgBlock addAreaCustomViewImgBlock;

@property (nonatomic, copy) AddAreaCustomViewStrBlock addAreaCustomViewStrBlock;

@property (nonatomic, strong) UILabel *regionL;

@property (nonatomic, strong) DropDownBtn *regionBtn;

@property (nonatomic, strong) DropDownBtn *regionBtn1;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) BorderTF *nameTF;

@property (nonatomic, strong) UILabel *genderL;

@property (nonatomic, strong) DropDownBtn *genderBtn;

@property (nonatomic, strong) UILabel *phoneL;

@property (nonatomic, strong) UIButton *addBtn;

@property (nonatomic, strong) BorderTF *phoneTF1;

@property (nonatomic, strong) BorderTF *phoneTF2;

@property (nonatomic, strong) BorderTF *phoneTF3;

@property (nonatomic, strong) UILabel *cardTypeL;

@property (nonatomic, strong) DropDownBtn *cardTypeBtn;

@property (nonatomic, strong) UILabel *cardNumL;

@property (nonatomic, strong) BorderTF *cardNumTF;

@property (nonatomic, strong) UILabel *birthL;

@property (nonatomic, strong) DropDownBtn *birthBtn;

@property (nonatomic, strong) UILabel *addressL;

@property (nonatomic, strong) DropDownBtn *addressBtn;

@property (nonatomic, strong) BorderTF *addressTF;

@property (nonatomic, strong) UILabel *positiveL;

@property (nonatomic, strong) UIImageView *positiveImg;

@property (nonatomic, strong) UILabel *backL;

@property (nonatomic, strong) UIImageView *backImg;

@property (nonatomic, strong) UILabel *otherL;

@property (nonatomic, strong) UIImageView *otherImg;
@end

NS_ASSUME_NONNULL_END
