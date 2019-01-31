//
//  CustomRequireModel.h
//  云渠道
//
//  Created by 谷治墙 on 2018/4/11.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseModel.h"

@interface CustomRequireModel : BaseModel

@property (nonatomic, strong) NSString *agent_id;

@property (nonatomic, strong) NSString *area;

@property (nonatomic, strong) NSString *buy_purpose;

@property (nonatomic, strong) NSString *client_id;

@property (nonatomic, strong) NSString *comment;

@property (nonatomic, strong) NSString *create_time;

@property (nonatomic, strong) NSString *decorate;

@property (nonatomic, strong) NSString *floor_max;

@property (nonatomic, strong) NSString *floor_min;

@property (nonatomic, strong) NSString *house_type;

@property (nonatomic, strong) NSString *intent;

@property (nonatomic, strong) NSString *ladder_ratio;

@property (nonatomic, strong) NSString *need_id;

@property (nonatomic, strong) NSString *need_tags;

@property (nonatomic, strong) NSString *orientation;

@property (nonatomic, strong) NSMutableArray *pay_type;

@property (nonatomic, strong) NSMutableDictionary *fit_info;

@property (nonatomic, strong) NSString *property_type;

@property (nonatomic, strong) NSMutableArray *region;

@property (nonatomic, strong) NSMutableArray *match_tags;

@property (nonatomic, strong) NSString *state;

@property (nonatomic, strong) NSString *total_price;

@property (nonatomic, strong) NSString *update_time;

@property (nonatomic, strong) NSString *urgency;

@property (nonatomic, strong) NSString *buy_use;

@property (nonatomic, strong) NSString *used_years;

@property (nonatomic, strong) NSString *office_level;

@property (nonatomic, strong) NSMutableArray *shop_type;

@end
