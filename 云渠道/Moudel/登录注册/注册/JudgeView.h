//
//  JudgeView.h
//  云渠道
//
//  Created by 谷治墙 on 2018/6/1.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^JudgeViewExitBlock)(void);

typedef void(^JudgeViewNewBlock)(void);

@interface JudgeView : UIView

@property (nonatomic, copy) JudgeViewExitBlock judgeExitBlock;

@property (nonatomic, copy) JudgeViewNewBlock judgeNewBlock;

@property (nonatomic, strong) UIButton *existBtn;

@property (nonatomic, strong) UIButton *unExistBtn;

@end
