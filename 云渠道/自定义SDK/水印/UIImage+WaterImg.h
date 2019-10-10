//
//  UIImage+WaterImg.h
//  云渠道
//
//  Created by 谷治墙 on 2019/8/9.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (WaterImg)

+ (UIImage *)getWaterMarkImage: (UIImage *)originalImage andTitle: (NSString *)title andMarkFont: (UIFont *)markFont andMarkColor: (UIColor *)markColor;

+ (UIImage *)getAgentWaterImage: (UIImage *)originalImage andTitle: (NSString *)title agent:(NSString *)agent andMarkFont: (UIFont *)markFont andMarkColor: (UIColor *)markColor;

@end

NS_ASSUME_NONNULL_END
