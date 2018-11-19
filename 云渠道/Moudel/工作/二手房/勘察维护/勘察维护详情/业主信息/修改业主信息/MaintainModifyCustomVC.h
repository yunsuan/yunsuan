//
//  MaintainModifyCustomVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/7/20.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^MaintainModifyCustomVCBlock)(NSDictionary *dic);

@interface MaintainModifyCustomVC : BaseViewController

@property (nonatomic, copy) MaintainModifyCustomVCBlock maintainModifyCustomVCBlock;

@property (nonatomic, strong) NSString *status;

@property (nonatomic, strong) NSDictionary *dataDic;

@property (nonatomic, strong) NSString *houseId;

@property (nonatomic, strong) NSString *contactId;

@end
