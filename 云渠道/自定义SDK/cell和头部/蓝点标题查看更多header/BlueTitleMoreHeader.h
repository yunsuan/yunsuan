//
//  BlueTitleMoreHeader.h
//  云渠道
//
//  Created by 谷治墙 on 2018/6/19.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseHeader.h"

@class BlueTitleMoreHeader;

typedef void(^BlueTitleMoreHeaderBlock)(void);

@interface BlueTitleMoreHeader : BaseHeader

@property (nonatomic, copy) BlueTitleMoreHeaderBlock blueTitleMoreHeaderBlock;

@property (nonatomic, strong) UIButton *moreBtn;

@end
