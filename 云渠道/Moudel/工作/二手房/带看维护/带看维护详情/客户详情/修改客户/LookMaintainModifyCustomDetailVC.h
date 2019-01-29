//
//  LookMaintainModifyCustomDetailVC.h
//  云渠道
//
//  Created by 谷治墙 on 2019/1/29.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^LookMaintainModifyCustomDetailVCBlock)(NSDictionary *dic);

@interface LookMaintainModifyCustomDetailVC : BaseViewController

@property (nonatomic, copy) LookMaintainModifyCustomDetailVCBlock lookMaintainModifyCustomDetailVCBlock;

@property (nonatomic, strong) NSString *status;

@property (nonatomic, strong) NSDictionary *dataDic;

@property (nonatomic, strong) NSString *houseId;

@property (nonatomic, strong) NSString *contactId;

@end

NS_ASSUME_NONNULL_END
