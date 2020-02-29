//
//  MyShopTagView.h
//  云渠道
//
//  Created by 谷治墙 on 2020/3/1.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BorderTF.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^MyShopTagViewBlock)(void);

@interface MyShopTagView : UIView

@property (nonatomic, copy) MyShopTagViewBlock myShopTagViewBlock;

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) BorderTF *tagTF;

@property (nonatomic, strong) UIButton *confirmBtn;

@end

NS_ASSUME_NONNULL_END
