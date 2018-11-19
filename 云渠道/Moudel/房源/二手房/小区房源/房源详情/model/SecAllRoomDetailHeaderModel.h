//
//  SecAllRoomDetailHeaderModel.h
//  云渠道
//
//  Created by 谷治墙 on 2018/8/9.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseModel.h"

@interface SecAllRoomDetailHeaderModel : BaseModel

@property (nonatomic, copy) NSString *project_id;

@property (nonatomic, copy) NSString *project_name;

@property (nonatomic, copy) NSString *absolute_address;

@property (nonatomic, copy) NSString *sale_state;

@property (nonatomic, copy) NSString *average_price;

@property (nonatomic, copy) NSArray *project_tags;

@property (nonatomic, copy) NSString *developer_name;

@property (nonatomic, copy) NSString *total_float_url;

@property (nonatomic, copy) NSString *total_float_url_phone;

@property (nonatomic, copy) NSString *total_float_url_panorama;

@property (nonatomic, copy) NSString *longitude;

@property (nonatomic, copy) NSString *latitude;

@property (nonatomic, copy) NSString *yunsuan_url;

@property (nonatomic, copy) NSString *yunsuan_id;

@property (nonatomic, copy) NSArray *property_type;
@end
