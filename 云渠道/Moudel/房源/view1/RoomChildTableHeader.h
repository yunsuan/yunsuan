//
//  RoomChildTableHeader.h
//  云渠道
//
//  Created by 谷治墙 on 2018/9/13.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^RoomChildTableHeaderRoomBlock)(void);

typedef void(^RoomChildTableHeaderComBlock)(void);

@interface RoomChildTableHeader : UITableViewHeaderFooterView

@property (nonatomic, copy) RoomChildTableHeaderRoomBlock roomChildTableHeaderRoomBlock;

@property (nonatomic, copy) RoomChildTableHeaderComBlock roomChildTableHeaderComBlock;

@property (nonatomic, strong) UIView *whiteView;

@property (nonatomic, strong) UIButton *roomListBtn;

@property (nonatomic, strong) UIButton *comListBtn;

@end
