//
//  SelectView.m
//  云渠道
//
//  Created by xiaoq on 2018/4/27.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "SelectView.h"

@implementation SelectView

-(void)SetNumberOfItem:(NSInteger)num
{
    self.frame = CGRectMake(0, 0, 212*SIZE, 49*SIZE*num+49*SIZE);
}


@end
