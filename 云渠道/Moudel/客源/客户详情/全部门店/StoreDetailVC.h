//
//  StoreDetailVC.h
//  云渠道
//
//  Created by xiaoq on 2019/1/24.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface StoreDetailVC : BaseViewController
@property (nonatomic , strong) NSString *type;//1为二手房，2为租房
@property (nonatomic , strong) NSString *client_id;
@end

NS_ASSUME_NONNULL_END
