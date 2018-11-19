//
//  MaintainAddFollowHeader.h
//  云渠道
//
//  Created by 谷治墙 on 2018/6/20.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MaintainAddFollowHeader;

typedef void(^MaintainAddFollowHeaderBlock)(void);

@interface MaintainAddFollowHeader : UITableViewHeaderFooterView

@property (nonatomic, strong) MaintainAddFollowHeaderBlock maintainAddFollowHeaderBlock;

@property (nonatomic, strong) UIButton *addBtn;

@end
