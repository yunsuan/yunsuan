//
//  RentingRoomAgencyDoneVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/7/30.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^RentingRoomAgencyDoneVCBlock)(void);

@interface RentingRoomAgencyDoneVC : BaseViewController

@property (nonatomic, strong) NSString *search;

@property (nonatomic, copy) RentingRoomAgencyDoneVCBlock rentingRoomAgencyDoneVCBlock;

-(void)postWithpage:(NSString *)page;

@end
