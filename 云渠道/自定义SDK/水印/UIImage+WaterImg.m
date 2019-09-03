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
    
    [mark drawInRect:CGRectMake(0, 0, CGRectGetWidth(rect), 20 *SIZE * proportion) withAttributes:attr];         //左上角
    
    [mark drawInRect:CGRectMake(w - CGRectGetWidth(rect), 0, CGRectGetWidth(rect), 20 *SIZE * proportion) withAttributes:attr];      //右上角
    
    [mark drawInRect:CGRectMake(w - CGRectGetWidth(rect), h - 20 *SIZE * proportion, CGRectGetWidth(rect), 20 *SIZE * proportion) withAttributes:attr];  //右下角
    
    [mark drawInRect:CGRectMake(0, h - 20 *SIZE * proportion, CGRectGetWidth(rect), 20 *SIZE * proportion) withAttributes:attr];    //左下角
    [mark drawInRect:CGRectMake((w - CGRectGetWidth(rect)) / 2 , (h - 20 *SIZE *proportion) / 2 ,CGRectGetWidth(rect), 20 *SIZE * proportion) withAttributes:attr];
    
    UIImage *aimg = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return aimg;
//
//    UIFont *font = markFont;
//    if (font == nil) {
//        font = [UIFont systemFontOfSize:15 *SIZE * proportion];
//    }
//    UIColor *color = markColor;
//    if (color == nil) {
//
//        color = COLOR(255, 255, 255, 0.4);//[UIColor lightGrayColor];
//    }
//    //原始image的宽高
//    CGFloat viewWidth = originalImage.size.width;
//    CGFloat viewHeight = originalImage.size.height;
//    //为了防止图片失真，绘制区域宽高和原始图片宽高一样
//    UIGraphicsBeginImageContext(CGSizeMake(viewWidth, viewHeight));
//    //先将原始image绘制上
//    [originalImage drawInRect:CGRectMake(0, 0, viewWidth, viewHeight)];
//    //sqrtLength：原始image的对角线length。在水印旋转矩阵中只要矩阵的宽高是原始image的对角线长度，无论旋转多少度都不会有空白。
//    CGFloat sqrtLength = sqrt(viewWidth * viewWidth + viewHeight * viewHeight);
//    //文字的属性
//    NSDictionary *attr = @{
//                           //设置字体大小
//                           NSFontAttributeName: font,
//                           //设置文字颜色
//                           NSForegroundColorAttributeName :color,
//                           };
//    NSString* mark = title;
//    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:mark attributes:attr];
//    //绘制文字的宽高
//    CGFloat strWidth = attrStr.size.width * proportion;
//    CGFloat strHeight = attrStr.size.height * proportion;
//
//    //开始旋转上下文矩阵，绘制水印文字
//    CGContextRef context = UIGraphicsGetCurrentContext();
//
//    //将绘制原点（0，0）调整到源image的中心
//    CGContextConcatCTM(context, CGAffineTransformMakeTranslation(viewWidth / 2, viewHeight / 2));
//    //以绘制原点为中心旋转
//    CGContextConcatCTM(context, CGAffineTransformMakeRotation(CG_TRANSFORM_ROTATION));
//    //将绘制原点恢复初始值，保证当前context中心和源image的中心处在一个点(当前context已经旋转，所以绘制出的任何layer都是倾斜的)
//    CGContextConcatCTM(context, CGAffineTransformMakeTranslation(-viewWidth / 2, -viewHeight / 2));
//
//    //计算需要绘制的列数和行数
//    int horCount = sqrtLength / (strWidth + HORIZONTAL_SPACE) + 1;
//    int verCount = sqrtLength / (strHeight + VERTICAL_SPACE) + 1;
//
//    //此处计算出需要绘制水印文字的起始点，由于水印区域要大于图片区域所以起点在原有基础上移
//    CGFloat orignX = -(sqrtLength-viewWidth)/2;
//    CGFloat orignY = -(sqrtLength-viewHeight)/2;
//
//    //在每列绘制时X坐标叠加
//    CGFloat tempOrignX = orignX;
//    //在每行绘制时Y坐标叠加
//    CGFloat tempOrignY = orignY;
//    for (int i = 0; i < horCount * verCount; i++) {
//        [mark drawInRect:CGRectMake(tempOrignX, tempOrignY, strWidth, strHeight) withAttributes:attr];
//        if (i % horCount == 0 && i != 0) {
//            tempOrignX = orignX;
//            tempOrignY += (strHeight + VERTICAL_SPACE);
//        }else{
//            tempOrignX += (strWidth + HORIZONTAL_SPACE);
//        }
//    }
//    //根据上下文制作成图片
//    UIImage *finalImg = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    CGContextRestoreGState(context);
//    return finalImg;
}

@end
