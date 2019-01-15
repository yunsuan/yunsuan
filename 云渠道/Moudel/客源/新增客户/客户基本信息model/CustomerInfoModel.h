//
//  CustomerInfoModel.h
//  云渠道
//
//  Created by xiaoq on 2018/4/10.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomerInfoModel : NSObject

@property (nonatomic, strong) NSString *client_type;
@property (nonatomic, strong) NSString *client_property_type;
@property (nonatomic, strong) NSString *is_hide_tel;
@property (nonatomic , strong) NSString *name;
@property (nonatomic , strong) NSString *sex;
@property (nonatomic , strong) NSString *tel;
@property (nonatomic , strong) NSString *card_type;
@property (nonatomic , strong) NSString *card_id;
@property (nonatomic , strong) NSString *province;
@property (nonatomic , strong) NSString *city;
@property (nonatomic , strong) NSString *district;
@property (nonatomic , strong) NSString *province_name;
@property (nonatomic , strong) NSString *city_name;
@property (nonatomic , strong) NSString *district_name;
@property (nonatomic , strong) NSString *address;
@property (nonatomic , strong) NSString *birth;


-(NSMutableDictionary *)modeltodic;
@end
