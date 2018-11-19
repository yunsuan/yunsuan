//
//  ReleaseSenceVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/6/12.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

#import "KyoRowIndexView.h"
#import "KyoCenterLineView.h"

#import "SMCinameSeatScrollViewDelegate.h"

typedef void(^ReleaseSenceAddHouseBlock)(NSDictionary *dic);

@interface ReleaseSenceVC : BaseViewController

@property (weak, nonatomic) id<SMCinameSeatScrollViewDelegate> SMCinameSeatScrollViewDelegate;

@property (nonatomic, copy) ReleaseSenceAddHouseBlock releaseSenceAddHouseBlock;

@property (nonatomic , strong)NSMutableArray *myarr;
@property (nonatomic , strong)NSMutableArray *LDinfo;
@property (nonatomic , strong)NSString *project_id;
@property (nonatomic , strong)NSString *build_id;
@property (nonatomic , strong)NSString *unit_id;
@property (nonatomic , strong)NSDictionary *LDdic;
@property (nonatomic , strong)NSString *titleinfo;
@property (nonatomic, strong) NSString *comName;
@property (nonatomic, strong) NSString *type;

//status 0 有返回按钮
@property(nonatomic,strong)NSString * statusStr;

@property (nonatomic, strong) NSString *status;

@end
