//
//  RecommendTransmitView.h
//  云渠道
//
//  Created by 谷治墙 on 2018/12/29.
//  Copyright © 2018 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^RecommendTransmitTagBtnBlock)(NSInteger index);

NS_ASSUME_NONNULL_BEGIN

@interface RecommendTransmitView : UIView

@property (nonatomic, copy) RecommendTransmitTagBtnBlock recommendTransmitTagBtnBlock;

@end

NS_ASSUME_NONNULL_END
