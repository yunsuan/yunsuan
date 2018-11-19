//
//  DashesLineView.m
//  云渠道
//
//  Created by 谷治墙 on 2018/7/19.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "DashesLineView.h"

#define kInterval 3 *SIZE                                // 全局间距

@implementation DashesLineView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        _lineColor = COLOR(112, 112, 112, 1);
        _startPoint = CGPointMake(0, 1);
        _endPoint = CGPointMake(SCREEN_Width , 1);
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextBeginPath(context);
    
    CGContextSetLineWidth(context,SIZE);//线宽度
    CGContextSetStrokeColorWithColor(context,self.lineColor.CGColor);
    
    CGFloat lengths[] = {4,2};//先画4个点再画2个点
    
    CGContextSetLineDash(context,0, lengths,2);//注意2(count)的值等于lengths数组的长度
    
    CGContextMoveToPoint(context,self.startPoint.x,self.startPoint.y);
    
    CGContextAddLineToPoint(context,self.endPoint.x,self.endPoint.y);
    
    CGContextStrokePath(context);
    
    CGContextClosePath(context);
    
}
        
@end
