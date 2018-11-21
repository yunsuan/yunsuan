//
//  BuildingAlbumVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/4/4.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

@class BuildingAlbumVC;

typedef void(^BuildBackBlock)(void);

@interface BuildingAlbumVC : BaseViewController

@property (nonatomic, copy) BuildBackBlock buildBackBlock;

@property (nonatomic , strong) NSString *weburl;

@end
