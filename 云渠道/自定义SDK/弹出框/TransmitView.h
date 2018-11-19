//
//  TransmitView.h
//  云渠道
//
//  Created by 谷治墙 on 2018/4/10.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TransmitView;

typedef void(^TransmitTagBtnBlock)(NSInteger index);

@interface TransmitView : UIView

@property (nonatomic, copy) TransmitTagBtnBlock transmitTagBtnBlock;

@end
