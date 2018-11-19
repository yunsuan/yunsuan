//
//  CustomerModel.h
//  云渠道
//
//  Created by 谷治墙 on 2018/4/11.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "CustomerInfoModel.h"

@interface CustomerModel : CustomerInfoModel

@property (nonatomic, strong) NSString *client_id;

- (NSMutableDictionary *)modeltodic;
- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end
