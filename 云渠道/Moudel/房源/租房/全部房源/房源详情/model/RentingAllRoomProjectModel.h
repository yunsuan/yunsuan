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

@property (nonatomic, copy) NSString *<#class#>;

@property (nonatomic, copy) NSString *project_id;

@property (nonatomic, copy) NSString *info_id;

@property (nonatomic, copy) NSString *house_code;

@property (nonatomic, copy) NSString *latitude;

@property (nonatomic, copy) NSString *longitude;

@property (nonatomic, copy) NSString *project_name;

@property (nonatomic, strong) NSMutableArray *house_tags;

@property (nonatomic, strong) NSMutableArray *project_tags;

@end

NS_ASSUME_NONNULL_END
