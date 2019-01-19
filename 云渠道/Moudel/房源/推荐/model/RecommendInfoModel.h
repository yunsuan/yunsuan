//
//  RecommendInfoModel.h
//  云渠道
//
//  Created by 谷治墙 on 2018/12/27.
//  Copyright © 2018 xiaoq. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface RecommendInfoModel : BaseModel

@property (nonatomic, strong) NSString *content_url;

@property (nonatomic, strong) NSString *desc;

@property (nonatomic, strong) NSString *id;

@property (nonatomic, strong) NSString *img_url;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *update_time;

@property (nonatomic, strong) NSString *source;

@property (nonatomic, strong) NSString *source_comment;

@end

NS_ASSUME_NONNULL_END
