//
//  PriceSetView.h
//  云渠道
//
//  Created by 谷治墙 on 2019/1/31.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BorderTF.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^PriceSetViewConfirmBtnBlock)(NSString *min,NSString *max);

typedef void(^PriceSetViewCancelBtnBlock)(void);

@interface PriceSetView : UIView

@property (nonatomic, strong) BorderTF *minTF;

@property (nonatomic, strong) BorderTF *maxTF;

@property (nonatomic, copy) PriceSetViewConfirmBtnBlock priceSetViewConfirmBtnBlock;

@property (nonatomic, copy) PriceSetViewCancelBtnBlock priceSetViewCancelBtnBlock;

@end

NS_ASSUME_NONNULL_END
