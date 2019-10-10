//
//  UIImage+WaterImg.m
//  云渠道
//
//  Created by 谷治墙 on 2019/8/9.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "UIImage+WaterImg.h"


#define HORIZONTAL_SPACE 30//水平间距
#define VERTICAL_SPACE 50//竖直间距
//#define HorizontalSize
#define CG_TRANSFORM_ROTATION (M_PI_2 / 3)//旋转角度(正旋45度 || 反旋45度)

@implementation UIImage (WaterImg)

+ (UIImage *)getWaterMarkImage: (UIImage *)originalImage andTitle: (NSString *)title andMarkFont: (UIFont *)markFont andMarkColor: (UIColor *)markColor{
    
    float proportion;

    proportion = originalImage.size.width / SCREEN_Width;
    
    NSString* mark = title;
    
    NSDictionary *dic = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:15 *SIZE * proportion]};

    CGRect rect = [mark boundingRectWithSize:CGSizeMake(SCREEN_Width, 20 *SIZE * proportion)/*计算宽度时要确定高度*/ options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil];
    
    int w = originalImage.size.width;
    
    int h = originalImage.size.height;
    
    
    UIGraphicsBeginImageContext(originalImage.size);
    
    [originalImage drawInRect:CGRectMake(0, 0, w, h)];
    
    NSDictionary *attr = @{
                           
                           NSFontAttributeName: [UIFont boldSystemFontOfSize:15 *SIZE * proportion],  //设置字体
                           
                           NSForegroundColorAttributeName : COLOR(255, 255, 255, 0.4) //设置字体颜色
                           
                           };
    
//    [mark drawInRect:CGRectMake(0, 0, CGRectGetWidth(rect), 20 *SIZE * proportion) withAttributes:attr];         //左上角
//    
//    [mark drawInRect:CGRectMake(w - CGRectGetWidth(rect), 0, CGRectGetWidth(rect), 20 *SIZE * proportion) withAttributes:attr];      //右上角
//    
//    [mark drawInRect:CGRectMake(w - CGRectGetWidth(rect), h - 20 *SIZE * proportion, CGRectGetWidth(rect), 20 *SIZE * proportion) withAttributes:attr];  //右下角
//    
//    [mark drawInRect:CGRectMake(0, h - 20 *SIZE * proportion, CGRectGetWidth(rect), 20 *SIZE * proportion) withAttributes:attr];    //左下角
    [mark drawInRect:CGRectMake((w - CGRectGetWidth(rect)) / 2 , (h - 20 *SIZE *proportion) / 2 ,CGRectGetWidth(rect), 20 *SIZE * proportion) withAttributes:attr];
    
    UIImage *aimg = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return aimg;
}

+ (UIImage *)getAgentWaterImage:(UIImage *)originalImage andTitle:(NSString *)title agent:(NSString *)agent andMarkFont:(UIFont *)markFont andMarkColor:(UIColor *)markColor{
    
    float proportion;

        proportion = originalImage.size.width / SCREEN_Width;
        
        NSString* mark = title;
        NSString* mark1 = agent;
        
        NSDictionary *dic = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:15 *SIZE * proportion]};

        CGRect rect = [mark boundingRectWithSize:CGSizeMake(SCREEN_Width, 20 *SIZE * proportion)/*计算宽度时要确定高度*/ options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil];
        CGRect rect1 = [mark1 boundingRectWithSize:CGSizeMake(SCREEN_Width, 20 *SIZE * proportion)/*计算宽度时要确定高度*/ options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil];
        
        int w = originalImage.size.width;
        
        int h = originalImage.size.height;
        
        
        UIGraphicsBeginImageContext(originalImage.size);
        
        [originalImage drawInRect:CGRectMake(0, 0, w, h)];
        
        NSDictionary *attr = @{
                               
                               NSFontAttributeName: [UIFont boldSystemFontOfSize:15 *SIZE * proportion],  //设置字体
                               
                               NSForegroundColorAttributeName : COLOR(255, 255, 255, 0.4) //设置字体颜色
                               
                               };
        
    //    [mark drawInRect:CGRectMake(0, 0, CGRectGetWidth(rect), 20 *SIZE * proportion) withAttributes:attr];         //左上角
    //
    //    [mark drawInRect:CGRectMake(w - CGRectGetWidth(rect), 0, CGRectGetWidth(rect), 20 *SIZE * proportion) withAttributes:attr];      //右上角
    //
        [mark1 drawInRect:CGRectMake(w - CGRectGetWidth(rect), h - 20 *SIZE * proportion, CGRectGetWidth(rect), 20 *SIZE * proportion) withAttributes:attr];  //右下角
    //
//        [mark1 drawInRect:CGRectMake(0, h - 20 *SIZE * proportion, CGRectGetWidth(rect), 20 *SIZE * proportion) withAttributes:attr];    //左下角
        [mark drawInRect:CGRectMake((w - CGRectGetWidth(rect)) / 2 , (h - 20 *SIZE *proportion) / 2 ,CGRectGetWidth(rect), 20 *SIZE * proportion) withAttributes:attr];
        
        UIImage *aimg = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
        return aimg;
}

@end
