//
//  RoomDetailTableHeader5.h
//  云渠道
//
//  Created by 谷治墙 on 2018/3/28.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RoomDetailTableHeader5;

typedef void(^moreBtnBlock)(void);

@interface RoomDetailTableHeader5 : UITableViewHeaderFooterView

@property (nonatomic, strong) moreBtnBlock moreBtnBlock;

@property (nonatomic, strong) UILabel *numL;

@property (nonatomic, strong) UIButton *moreBtn;

@end
