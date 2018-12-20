//
//  RentingMaintainModifyCustomVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/12/20.
//  Copyright © 2018 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^RentingMaintainModifyCustomVCBlock)(NSDictionary *dic);

@interface RentingMaintainModifyCustomVC : BaseViewController

@property (nonatomic, copy) RentingMaintainModifyCustomVCBlock rentingMaintainModifyCustomVCBlock;

@property (nonatomic, strong) NSString *status;

@property (nonatomic, strong) NSDictionary *dataDic;

@property (nonatomic, strong) NSString *houseId;

@property (nonatomic, strong) NSString *contactId;

@end

NS_ASSUME_NONNULL_END
