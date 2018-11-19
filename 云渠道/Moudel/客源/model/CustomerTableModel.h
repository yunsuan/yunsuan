//
//  CustomerTableModel.h
//  云渠道
//
//  Created by 谷治墙 on 2018/3/20.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomerTableModel : NSObject

@property (nonatomic, copy) NSString *address;

@property (nonatomic, copy) NSString *card_id;

@property (nonatomic, copy) NSString *card_type;

@property (nonatomic, copy) NSString *client_type;

@property (nonatomic, copy) NSString *client_property_type;

@property (nonatomic, copy) NSString *house_type;

@property (nonatomic, copy) NSString *client_id;

@property (nonatomic, copy) NSString *intent;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *total_price;

@property (nonatomic, copy) NSString *property_type;

@property (nonatomic, copy) NSArray *region;

@property (nonatomic, copy) NSString *sex;

@property (nonatomic, copy) NSString *tel;

@property (nonatomic, copy) NSString *urgency;

- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSMutableDictionary *)modeltodic;

@end

