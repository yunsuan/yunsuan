//
//  StoreListVC.h
//  云渠道
//
//  Created by xiaoq on 2019/1/24.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface StoreListVC : BaseViewController
@property (nonatomic , strong) NSString *type;//1为二手房，2为租房
@property (nonatomic , strong) NSString *client_id;
@property (nonatomic , strong) NSString *name;
@property (nonatomic , strong) NSString *tel;
@property (nonatomic , strong) NSString *sex;

@end

NS_ASSUME_NONNULL_END
