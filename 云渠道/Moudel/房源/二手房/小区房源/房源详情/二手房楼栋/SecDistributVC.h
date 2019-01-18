//
//  SecDistributVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/10/26.
//  Copyright © 2018 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^SecDistributAddHouseBlock)(NSDictionary *dic);

NS_ASSUME_NONNULL_BEGIN

@interface SecDistributVC : BaseViewController

@property (nonatomic, copy) SecDistributAddHouseBlock secDistributAddHouseBlock;

@property (nonatomic , strong) NSString *urlfor3d;

@property (nonatomic, strong) NSString *comName;

@property (nonatomic , strong) NSString *img_name;

@property (nonatomic , strong) NSString *projiect_id;

@property (nonatomic, strong) NSString *status;

@end

NS_ASSUME_NONNULL_END
