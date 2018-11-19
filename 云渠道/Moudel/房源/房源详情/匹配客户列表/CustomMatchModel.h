//
//  CustomMatchModel.h
//  云渠道
//
//  Created by 谷治墙 on 2018/4/27.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseModel.h"

@interface CustomMatchModel : BaseModel

@property (nonatomic, strong) NSString *area;

@property (nonatomic, strong) NSString *client_id;

@property (nonatomic, strong) NSString *is_recommend;

@property (nonatomic, strong) NSString *decorate;

@property (nonatomic, strong) NSString *house_type;

@property (nonatomic, strong) NSString *intent;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *need_id;

@property (nonatomic, strong) NSString *need_tags;

@property (nonatomic, strong) NSString *price;

@property (nonatomic, strong) NSString *property_type;

@property (nonatomic, strong) NSMutableArray *region;

@property (nonatomic, strong) NSString *score;

@property (nonatomic, strong) NSString *urgency;

@property (nonatomic, strong) NSString *tel;

@property (nonatomic, strong) NSString *sex;

@end
