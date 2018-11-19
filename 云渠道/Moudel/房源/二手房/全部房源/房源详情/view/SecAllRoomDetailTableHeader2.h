//
//  SecAllRoomDetailTableHeader2.h
//  云渠道
//
//  Created by 谷治墙 on 2018/6/11.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SecAllRoomDetailTableHeader2;

typedef void(^SecAllRoomDetailMoreBlock)(void);

@interface SecAllRoomDetailTableHeader2 : UITableViewHeaderFooterView

@property (nonatomic, copy) SecAllRoomDetailMoreBlock secAllRoomDetailMoreBlock;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UIButton *addBtn;

@property (nonatomic, strong) UIButton *moreBtn;

@property (nonatomic, strong) UIView *line;

@end
