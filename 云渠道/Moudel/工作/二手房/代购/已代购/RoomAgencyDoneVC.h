//
//  RoomAgencyDoneVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/6/20.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^RoomAgencyDoneVCBlock)(void);

@interface RoomAgencyDoneVC : BaseViewController

@property (nonatomic, strong) NSString *search;

@property (nonatomic, copy) RoomAgencyDoneVCBlock roomAgencyDoneVCBlock;

-(void)postWithpage:(NSString *)page;

@end
