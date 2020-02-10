//
//  RentLookMaintainDetailVC.h
//  云渠道
//
//  Created by 谷治墙 on 2020/2/5.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^RentLookMaintainDetailVCBlock)(void);

@interface RentLookMaintainDetailVC : BaseViewController

@property (nonatomic, copy) RentLookMaintainDetailVCBlock rentLookMaintainDetailVCBlock;

@property (nonatomic, strong) NSString *edit;

- (instancetype)initWithTakeId:(NSString *)takeId;

@end

NS_ASSUME_NONNULL_END
