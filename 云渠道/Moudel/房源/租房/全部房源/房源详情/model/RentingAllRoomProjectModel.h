//
//  RentingAllRoomProjectModel.h
//  云渠道
//
//  Created by 谷治墙 on 2018/12/10.
//  Copyright © 2018 xiaoq. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface RentingAllRoomProjectModel : BaseModel

@property (nonatomic, copy) NSString *build_area;

@property (nonatomic, copy) NSString *check_in_time;

@property (nonatomic, copy) NSString *check_way;

@property (nonatomic, copy) NSString *comment;

@property (nonatomic, copy) NSString *contact_tel;

@property (nonatomic, copy) NSString *core_selling;

@property (nonatomic, copy) NSString *decoration;

@property (nonatomic, copy) NSString *decoration_standard;

@property (nonatomic, copy) NSString *deposit;

@property (nonatomic, copy) NSString *floor_type;

@property (nonatomic, copy) NSString *house_code;

@property (nonatomic, copy) NSString *house_id;

@property (nonatomic, strong) NSMutableArray *house_tags;

@property (nonatomic, copy) NSString *house_type;

@property (nonatomic, copy) NSString *info_id;

@property (nonatomic, copy) NSString *intent;

@property (nonatomic, copy) NSString *latitude;

@property (nonatomic, copy) NSString *level;

@property (nonatomic, copy) NSString *longitude;

@property (nonatomic, strong) NSMutableArray *match_tags;

@property (nonatomic, copy) NSString *orientation;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *price_change;

@property (nonatomic, copy) NSString *project_average_price;

@property (nonatomic, copy) NSString *project_id;

@property (nonatomic, copy) NSString *project_img_url;

@property (nonatomic, copy) NSString *project_name;

@property (nonatomic, strong) NSMutableArray *project_tags;

@property (nonatomic, copy) NSString *project_total_build;

@property (nonatomic, copy) NSString *property_type;

@property (nonatomic, strong) NSMutableArray *receive_way;

@property (nonatomic, copy) NSString *rent_max_comment;

@property (nonatomic, copy) NSString *rent_min_comment;

@property (nonatomic, copy) NSString *rent_type;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *unit_price;

@property (nonatomic, copy) NSString *urgency;



@end

NS_ASSUME_NONNULL_END
