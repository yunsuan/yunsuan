//
//  RentingCancelAgencyProtocolVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/12/28.
//  Copyright © 2018 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^RentingCancelAgencyProtocolVCBlock)(void);

NS_ASSUME_NONNULL_BEGIN

@interface RentingCancelAgencyProtocolVC : BaseViewController

@property (nonatomic, copy) RentingCancelAgencyProtocolVCBlock rentingCancelAgencyProtocolVCBlock;

@property (nonatomic , strong) NSString *sub_id;

@property (nonatomic , strong) NSArray *infoArr;

@property (nonatomic , strong) NSString *broker;//违约金

@end

NS_ASSUME_NONNULL_END
