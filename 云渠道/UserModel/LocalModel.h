//
//  LocalModel.h
//  云渠道
//
//  Created by 谷治墙 on 2018/9/23.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LocalModel : NSObject

@property (nonatomic , strong) NSString *cityCode;

@property (nonatomic , strong) NSString *cityName;

+ (LocalModel *)defaultModel;

@end

NS_ASSUME_NONNULL_END
