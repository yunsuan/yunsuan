//
//  MyAttentionModel.h
//  云渠道
//
//  Created by 谷治墙 on 2018/4/17.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RoomListModel.h"

@interface MyAttentionModel : RoomListModel

@property (nonatomic, strong) NSString *focus_id;

@property (nonatomic, strong) NSMutableArray *project_tags_name;

@end
