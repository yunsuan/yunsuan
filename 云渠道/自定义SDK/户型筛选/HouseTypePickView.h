//
//  HouseTypePickView.h
//  云渠道
//
//  Created by 谷治墙 on 2019/3/21.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^HouseTypePickViewBlock)(NSString * room, NSString * hall, NSString *bath);

@interface HouseTypePickView : UIView

@property (nonatomic, copy) HouseTypePickViewBlock houseTypePickViewBlock;

@end

NS_ASSUME_NONNULL_END
