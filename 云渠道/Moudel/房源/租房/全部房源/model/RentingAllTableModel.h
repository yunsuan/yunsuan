//
//  RentingAllTableModel.h
//  云渠道
//
//  Created by 谷治墙 on 2018/12/10.
//  Copyright © 2018 xiaoq. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface RentingAllTableModel : BaseModel

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *describe;

@property (nonatomic, copy) NSString *house_id;

@property (nonatomic, strong) NSMutableArray *house_tags;

@property (nonatomic, copy) NSString *img_url;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *price_change;

@property (nonatomic, strong) NSMutableArray *project_tags;

@property (nonatomic, copy) NSString *property_type;

@property (nonatomic, copy) NSString *store_name;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *unit_price;

@property (nonatomic, copy) NSString *info_id;

@end

NS_ASSUME_NONNULL_END
