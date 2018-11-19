//
//  BaseFrameHeader.h
//  云渠道
//
//  Created by 谷治墙 on 2018/8/6.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseFrameHeader : UIView

@property (nonatomic, strong) UIView *colorView;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UIView *lineView;

- (void)ReMasonryUI;

@end
