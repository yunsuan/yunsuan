//
//  SecAllRoomProjectModel.h
//  云渠道
//
//  Created by 谷治墙 on 2018/8/13.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseModel.h"

@interface SecAllRoomProjectModel : BaseModel

@property (nonatomic, copy) NSString *build_area;

@property (nonatomic, copy) NSString *check_in_time;

@property (nonatomic, copy) NSString *check_way;

@property (nonatomic, copy) NSString *comment;

@property (nonatomic, copy) NSString *core_selling;

@property (nonatomic, copy) NSString *decoration;

@property (nonatomic, copy) NSString *decoration_standard;

@property (nonatomic, copy) NSString *floor_type;

@property (nonatomic, copy) NSString *house_code;

@property (nonatomic, copy) NSString *house_id;

@property (nonatomic, strong) NSMutableArray *house_tags;

@property (nonatomic, copy) NSString *house_type;

@property (nonatomic, copy) NSString *info_id;

@property (nonatomic, copy) NSString *intent;

@property (nonatomic, copy) NSString *orientation;

@property (nonatomic, copy) NSString *permit_time;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *price_change;

@property (nonatomic, copy) NSString *project_average_price;

@property (nonatomic, copy) NSString *project_id;

@property (nonatomic, copy) NSString *project_img_url;

@property (nonatomic, copy) NSString *project_name;

@property (nonatomic, strong) NSMutableArray *project_tags;

@property (nonatomic, copy) NSString *project_total_build;

@property (nonatomic, copy) NSString *property_limit;

@property (nonatomic, copy) NSString *property_type;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *unit_price;

@property (nonatomic, copy) NSString *urgency;

@property (nonatomic, copy) NSString *latitude;

@property (nonatomic, copy) NSString *longitude;

@property (nonatomic, copy) NSString *contact_tel;
@end
