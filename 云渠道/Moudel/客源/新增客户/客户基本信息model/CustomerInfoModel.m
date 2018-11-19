//
//  CustomerInfoModel.m
//  云渠道
//
//  Created by xiaoq on 2018/4/10.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "CustomerInfoModel.h"

@implementation CustomerInfoModel

-(NSMutableDictionary *)modeltodic
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    Class c = self.class;
    // 截取类和父类的成员变量
    while (c && c != [NSObject class]) {
        unsigned int count = 0;
        Ivar *ivars;
        ivars = class_copyIvarList(c, &count);
        for (int i = 0; i < count; i++) {
            
            NSString *key = [NSString stringWithUTF8String:ivar_getName(ivars[i])];
            key = [key substringFromIndex:1];
            id value = [self valueForKey:key];
        
            if (value) {
                
                [dic setValue:value forKey:key];
            }
            
        }
        // 获得c的父类
        c = [c superclass];
        free(ivars);}
    return dic;
    
}

@end
