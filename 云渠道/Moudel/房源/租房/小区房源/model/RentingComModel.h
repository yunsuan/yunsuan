//
//  RentingComModel.h
//  云渠道
//
//  Created by 谷治墙 on 2018/12/10.
//  Copyright © 2018 xiaoq. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface RentingComModel : BaseModel

@property (nonatomic, copy) NSString *img_url;

@property (nonatomic, copy) NSString *project_name;

@property (nonatomic, copy) NSString *project_id;

@property (nonatomic, copy) NSString *absolute_address;

@property (nonatomic, copy) NSString *build_type;

@property (nonatomic, copy) NSString *average_price;

@property (nonatomic, copy) NSString *info_id;

@property (nonatomic, copy) NSString *project_code;

@property (nonatomic, copy) NSString *on_rent;

@property (nonatomic, copy) NSString *subs_num;


@end

NS_ASSUME_NONNULL_END
