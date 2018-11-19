//
//  MySubscripModel.h
//  云渠道
//
//  Created by 谷治墙 on 2018/11/6.
//  Copyright © 2018 xiaoq. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MySubscripModel : BaseModel

@property (nonatomic, strong) NSString *absolute_address;

@property (nonatomic, strong) NSString *average_price;

@property (nonatomic, strong) NSString *img_url;

@property (nonatomic, strong) NSString *on_sale;

@property (nonatomic, strong) NSString *project_code;

@property (nonatomic, strong) NSString *project_id;

@property (nonatomic, strong) NSString *project_name;

@property (nonatomic, strong) NSString *sale_subs_num;

@property (nonatomic, strong) NSString *sub_id;

@property (nonatomic, strong) NSString *sub_type;

@property (nonatomic, strong) NSString *update_time;

@end

NS_ASSUME_NONNULL_END
